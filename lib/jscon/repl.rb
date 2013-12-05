module Jscon
  class Repl
    include EasyRepl::Repl

    class NoServer; end
    EasyRepl.history_file = ".jscon_history"

    def initialize(phantom_options)
      @phantom_options = phantom_options
      @asset_server = NoServer
    end

    def setup
      @pipe_in, @pipe_out = Jscon::Pipes.create_set("js_repl")
      puts "loading"
      @asset_server = Jscon::AssetServer.start
      @phantom_pid = Jscon::Phantom.run_exec(Jscon::Dir.path, @phantom_options)
    end

    def before_input
      @asset_server = Jscon::AssetServer.start if @asset_server == NoServer
    end

    def process_input(input)
      File.open(@pipe_in, "w+") do |pipe|
        pipe.write(input)
        pipe.flush
      end
      puts IO.read(@pipe_out)
    end

    def after_input
      @asset_server.close
      @asset_server = NoServer
    end

    def teardown
      Process.kill(term=15, @phantom_pid)
    end
  end
end
