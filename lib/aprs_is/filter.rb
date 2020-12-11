require 'aprs_is/filter/constants'

module AprsIs
  class Filter
    class InvalidTypeError < StandardError; end;
    class ValueArityError < StandardError; end;

    attr_reader :filter_type, :values

    def initialize(type:, values: )
      @filter_type = type
      @values = values || []

      validate_filter_type
      validate_arity
    end

    def to_s
      values.dup.unshift(prefix).compact.join("/")
    end

    private
    def validate_arity
      raise ValueArityError.new("Filter type '#{filter_type}' requires #{arity} values only #{values.length} given.") unless arity_matches?
    end
    
    def validate_filter_type
      raise InvalidTypeError.new("'#{filter_type}' is not a valid type.") unless type_exists?
    end

    def arity_matches?
      (arity == -1 && values.length > 0) || [arity].flatten.include?(values.length)
    end
    
    def type_exists?
      Constants::FILTER_TYPE_MAP.has_key?(filter_type)
    end

    def arity
      Constants::FILTER_TYPE_MAP[filter_type][:arity]
    end

    def prefix
      Constants::FILTER_TYPE_MAP[filter_type][:prefix]
    end
  end
end