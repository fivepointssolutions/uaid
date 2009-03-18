module Uaid
  def Uaid.supported_agents
    @supported ||= [
      /safari [34]/,
      /chrome/,
      /firefox/,
      /ie [678]/,
      /android/,
      /bot/
    ]
  end
  
  # Define the set of supported agents. You may also concat to the existing
  # list.
  #
  def Uaid.supported_agents=(s)
    @supported = s
  end
  
  class UserAgent
    attr_reader :agent, :engine, :product, :version, :supported
    
    def initialize(agent, extractor = Uaid.extractor)
      @agent, @extractor = agent, extractor
      @engine, @product, @version = @extractor.extract(@agent ? @agent.strip : '')
    end
    
    def identifier
      [engine, product, product + version].join(' ')
    end
    
    def supported?
      !!Uaid.supported_agents.detect do |agent_match|
        case agent_match
        when Array: agent_match == [engine, product, version]
        when Regexp: [engine, product, version].join(' ') =~ agent_match
        end
      end
    end
    
    def unknown?
      engine == 'unknown' || product == 'unknown' || version == 'x'
    end
    
    def unsupported?
      !supported?
    end
    
    def version?(e)
      version == e
    end
    
    def method_missing(method, *args)
      if method.to_s =~ /^(\w+)\?$/
        return true if (engine == $1 || product == $1)
        @extractor.engines.include?($1) || @extractor.products.include?($1)
      else
        super
      end
    end
  end
end