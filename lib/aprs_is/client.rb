require 'socket'

module AprsIs
  class Client
    attr_reader :hostname, :port, :version

    class Error < StandardError; end
    
    def initialize(hostname:, port:, version: "AprsIs::Client v#{VERSION}")
      @hostname = hostname
      @port = port
      @version = version
    end

    def login(call_sign, filters = [])
      send_message(login_message(call_sign, filters))
      return self
    end

    def apply_filter(filter)
      send_message(filter_message(filter))
    end

    def read(&block)
      while line = socket.gets
        yield line
      end
    end

    # :nocov:
    def stream(&block)
      loop do
        read(&block)
      end
    end
    # :nocov:

    def send_message(message)
      socket.puts message
    end

    private

    def login_message(call_sign, filters = [])
      filters.unshift('filter') if filters.any
      [
        "user #{call_sign} pass #{passcode_for(call_sign)} vers #{version}",
        filters.compact.collect(&:to_s)
      ].compact.join(" ")
    end

    def filter_message(filter)
      "filter #{filter}"
    end

    def passcode_for(call_sign)
      @passcode = AprsIs::Passcode.new(call_sign)
    end

    def socket
      @socket ||= TCPSocket.open(hostname, port)
    end
  end
end
