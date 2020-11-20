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

    def login(call_sign)
      send_message("user #{call_sign} pass #{passcode_for(call_sign)} vers #{version}")
      return self
    end

    def read
      while line = socket.gets
        yield line
      end
    end

    def send_message(message)
      socket.puts message
    end

    private

    def passcode_for(call_sign)
      @passcode = AprsIs::Passcode.new(call_sign)
    end

    def socket
      @socket ||= TCPSocket.open(hostname, port)
    end
  end
end
