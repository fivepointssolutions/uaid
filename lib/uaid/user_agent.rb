module Uaid
  def Uaid.supported_agents
    @supported ||= [
      /safari [345]/,
      /chrome/,
      /firefox [23]/,
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
    attr_reader :agent, :engine, :product, :supported
    
    def initialize(agent, extractor = Uaid.extractor)
      @agent, @extractor = agent, extractor
      @engine, @product, version = @extractor.extract(@agent ? @agent.strip : '')
      @version = Uaid::Version.new(version)
    end
    
    def identifier
      [engine, product, product + version.major.to_s, product + version.major.to_s + '-' + version.minor.to_s].join(' ')
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

    def version
      
    end
    
    def version?(e)
      version == e
    end
    
    def method_missing(method, *args)
      if method.to_s =~ /^(\w+)\?$/
        engine == $1 || product == $1
      else
        super
      end
    end
  end
end
