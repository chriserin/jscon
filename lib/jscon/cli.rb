module Jscon
  class CLI < Thor
    default_task :repl

    option :coffee, :type => :boolean
    option :showjs, :type => :boolean
    desc 'repl', 'the one and only option'
    def repl
      phantom_options = options.keys.join(",")
      Jscon::Repl.new(phantom_options).start
    ensure
      Jscon::Dir.remove
    end
  end
end
