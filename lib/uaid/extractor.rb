module Uaid
  def Uaid.extractor
    @extractor ||= Extractor.new
  end
  
  def Uaid.extractor=(e)
    @extractor = e
  end
  
  class Extractor
    def engines
      @engines ||= %w(ie webkit gecko)
    end
    
    def products
      @products ||= product_extractions.collect {|product,| product}
    end
    
    def extract(agent)
      product = extract_product(agent)
      engine = extract_engine(agent, product)
      version = extract_version(agent, product, engine)
      [engine, product, version]
    end
    
    protected
      def extract_product(agent)
        find_match_in_extractions(agent, product_extractions) || 'unknown'
      end
      
      def extract_engine(agent, product)
        case extractions = engine_extractions(product)
        when String: extractions
        when Array:  find_match_in_extractions(agent, extractions) || 'unknown'
        when nil:    'unknown'
        end
      end
      
      def extract_version(agent, product, engine)
        case extractions = version_extractions(product)
        when Array
          match = extractions.detect {|version, regexp| agent =~ regexp}
          match ? match[0] : 'x'
        when nil: 'x'
        end
      end
      
      def product_extractions
        @product_extractions ||= [
          ['ie',           [/MSIE/]],
          ['mobilesafari', [/iPhone.*?Version.*?Safari/]],
          ['safari',       [/Version.*?Safari/]],
          ['chrome',       [/Chrome.*?Safari/]],
          ['firefox',      [/Firefox|BonEcho|Shiretoko/]],
          ['android',      [/Android/]],
          ['bot',          [/googlebot|msnbot|ia_archiver/i]],
          ['noagent',      [/^$/]],
        ]
      end
      
      def engine_extractions(product)
        @engine_extractions ||= {
          'ie'           => 'ie',
          'safari'       => 'webkit',
          'mobilesafari' => 'webkit',
          'chrome'       => 'webkit',
          'firefox'      => 'gecko',
          'android'      => 'webkit',
        }
        @engine_extractions[product]
      end
      
      def version_extractions(product)
        @version_extractions ||= {
          'ie' => [
            ['7', /MSIE 7/],
            ['8', /MSIE 8/],
            ['6', /MSIE 6/],
          ],
          'firefox' => [
            ['3', /Firefox\/3|Shiretoko/],
            ['2', /Firefox\/2|BonEcho\/2/],
          ],
          'safari' => [
            ['3', /Version\/3/],
            ['4', /Version\/4/],
          ],
          'mobilesafari' => [
            ['3', /Version\/3/],
          ],
          'chrome' => [
            ['1', /Chrome\/[01]\./],
          ],
          'android' => [
            ['0', /Android 0\./],
          ]
        }
        @version_extractions[product]
      end
      
      # Answers the first matching extraction. Keep this in mind when adding
      # patterns!
      #
      def find_match_in_extractions(agent, extractions)
        match = nil
        extractions.each do |answer, patterns|
          matches = patterns.inject(true) {|m,pattern| m && agent =~ pattern}
          next unless matches
          match = answer
          break
        end
        match
      end
  end
end