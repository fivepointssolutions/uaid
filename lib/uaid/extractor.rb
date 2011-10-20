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
          match = nil
          extractions.each do |version, regexp|
            if data = regexp.match(agent)
              match = substitutions(version, data)
              break
            end
          end
          match ? match : 'x'
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
            ['\1', /MSIE ([\d\.b]+)/],
          ],
          'firefox' => [
            ['\2', /(Firefox|BonEcho|Shiretoko)\/([a-z\d\.]+)/],
          ],
          'safari' => [
            ['\1', /Version\/([\d\.]+)/],
          ],
          'mobilesafari' => [
            ['\1', /Version\/([\d\.]+)/],
          ],
          'chrome' => [
            ['\1', /Chrome\/([\d\.A-Z]*)/],
          ],
          'android' => [
            ['0', /Android 0\./],
          ]
        }
        @version_extractions[product]
      end
      
      # Answers the first matching extraction. Keep this in mind when adding
      # patterns!
      def find_match_in_extractions(agent, extractions)
        match = nil
        extractions.each do |answer, patterns|
          patterns.each do |pattern|
            if data = pattern.match(agent)
              match = substitutions(answer, data)
              break
            end
          end
          break if match
        end
        match
      end

      def substitutions(string, data)
        string.gsub(/\\(\d)/) { data[$1.to_i] }
      end
  end
end
