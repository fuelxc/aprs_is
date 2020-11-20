module AprsIs
  class Passcode
    attr_reader :call_sign

    def initialize(call_sign)
      @call_sign = call_sign
    end

    def to_s
      generate.to_s
    end

    def generate
      hash = 0x73e2
      flag = true
      call_sign_for_generation.split('').each do |c|
        hash = if flag
          (hash ^ (c.ord << 8))
        else
          (hash ^ c.ord)
        end
        flag = !flag
      end
      hash & 0x7fff
    end

    private

    def call_sign_for_generation
      call_sign.upcase.split('-').first
    end
  end
end