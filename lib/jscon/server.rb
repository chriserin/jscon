module Jscon
  class Server
    attr_reader :socket, :fixed_port

    def initialize(fixed_port = nil)
      @fixed_port = fixed_port
    end

    def port
      @socket.port
    end

    def start
      @socket = WebSocketServer.new(fixed_port)
    end

    def stop
      @socket.close
    end

    def restart
      stop
      start
    end

    def send(message)
      @socket.send(message) or raise DeadClient.new(message)
    end
  end
end
