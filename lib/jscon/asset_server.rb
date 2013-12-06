module Jscon
  class AssetServer
    def self.start
      new
    end

    def initialize
      if Jscon::Session.is_available?
        @request, @response = Jscon::Pipes.create_set("js_asset")
        @session = Jscon::Session.new
        @child_pid = fork {
          loop do
            js_url = IO.read(@request)
            js = get_javascript(js_url)
            IO.write(@response, js)
          end
        }
      end
    end
    private :initialize

    def is_started?
      !!@session
    end

    def close
      FileUtils.rm(@request) unless @request.nil?
      FileUtils.rm(@response) unless @response.nil?
      Process.kill("TERM", @child_pid) unless @child_pid.nil?
    end

    def get_javascript(js_url)
      if @session.nil?
        puts "session is unavailable to request #{js_url}"
      else
        @session.get(js_url.to_s)
        @session.response.body
      end
    end
  end
end
