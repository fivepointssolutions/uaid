module Uaid
  class UserAgent
    SUPPORTED, UNSUPPORTED = true, false
    
    attr_reader :agent, :name, :version
    
    def initialize(agent)
      @agent = agent
      @name, @version, @supported = extract(@agent ? @agent.strip : '')
    end
    
    def supported?
      @supported
    end
    
    def unsupported?
      !supported?
    end
    
    def method_missing(method, *args)
      if method.to_s =~ /^(\w+)\?$/ && EXTRACTIONS.find {|patterns, values| values.first == $1}
        name == $1
      else
        super
      end
    end
    
    protected
      EXTRACTIONS = [
        [[/MSIE/, /MSIE 7/],                 ['ie', '7', SUPPORTED]],
        [[/MSIE/, /MSIE 8/],                 ['ie', '8', SUPPORTED]],
        [[/MSIE/, /MSIE 6/],                 ['ie', '6', UNSUPPORTED]],
        [[/iPhone/, /Version\/3/],           ['mobilesafari', '3', SUPPORTED]],
        [[/Safari/, /Version\/3/],           ['webkit', '3', SUPPORTED]],
        [[/AppleWebKit/, /525/],             ['webkit', '3', SUPPORTED]],
        [[/AppleWebKit/, /528/],             ['webkit', '4', SUPPORTED]],
        [[/Gecko/, /Firefox\/3/],            ['gecko', '3', SUPPORTED]],
        [[/Gecko/, /Firefox\/2|BonEcho\/2/], ['gecko', '2', SUPPORTED]],
        [[/Gecko/, /Shiretoko/],             ['gecko', '3.5', SUPPORTED]],
        [[/googlebot|msnbot|ia_archiver/i],  ['bot', 'x', SUPPORTED]],
        [[/^$/],                             ['noagent', 'x', UNSUPPORTED]],
        [[/.*/],                             ['unknown', 'x', UNSUPPORTED]]
      ]
      
      def extract(agent)
        EXTRACTIONS.detect {|patterns,| patterns.inject(true) {|m,pattern| m && agent =~ pattern} }.last
      end
  end
end