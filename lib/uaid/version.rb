module Uaid
  class Version
    attr_reader :major_string, :minor_string, :string

    def initialize(string)
      @string = string
      @major_string, @minor_string, = @string.split('.')
    end

    def major
      @major ||= major_string.to_i
    end

    def minor
      @minor ||= minor_string.to_i
    end

    alias :to_s :string
    alias :to_str :string
    alias :inspect :string

    include Comparable
    def <=>(other)
      case other
      when Version
        case
        when major > other.major
          1
        when major == other.major && minor > other.minor
          1
        when major == other.major && minor == other.minor
          0
        else
          -1
        end
      when String
        self <=> Version.new(other)
      when Integer
        major <=> other
      when Float
        Float([major, minor] * '.') <=> other
      else
        raise ArgumentError, "comparison of #{self.class} with #{other} failed"
      end
    end

    def =~(other)
      string =~ other
    end

    def match(other)
      string.match(other)
    end
  end
end
