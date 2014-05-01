module Jscon
  class Repl
    include EasyRepl::Repl

    class NoServer; end
    EasyRepl.history_file = ".jscon_history"

    def initialize(options)
      @options = options
      @asset_server = NoServer
      commands << Jscon::Commands::MultiLine
    end

    def repl_write(value)
      puts value
    end

    def setup
      @command_pipe, @result_pipe = Jscon::Pipes.create_set("js_repl")
      repl_write "loading"
      @asset_server = Jscon::AssetServer.start
      phantom_options = ""
      phantom_options = "application" if @asset_server.is_started?
      @phantom_pid = Jscon::Phantom.run_exec(Jscon::Dir.path, phantom_options)
    end

    def before_input
      @asset_server = Jscon::AssetServer.start if @asset_server == NoServer
    end

    def process_input(input)
      File.open(@command_pipe, "w+") do |pipe|
        input = compile(input)
        pipe.write(input)
        pipe.flush
      end
      result = IO.read(@result_pipe)
      repl_write result
    end

    def compile(input)
      input = input.gsub('\n', ?\n)
      begin
        input = CoffeeScript.compile(input, bare: true) if @options.coffee?
      rescue ExecJS::RuntimeError => runtime_error
        repl_write runtime_error.message
        throw :skip_process_input
      end
      repl_write input if @options.showjs?
      return input
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
