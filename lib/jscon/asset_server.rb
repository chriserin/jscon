module Jscon
  class AssetServer
    def self.start
      new
    end

    def initialize
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
    private :initialize

    def close
      FileUtils.rm(@request)
      FileUtils.rm(@response)
      Process.kill("TERM", @child_pid)
    end

    def get_javascript(js_url)
      @session.get(js_url.to_s)
      @session.response.body
    end
  end
end
