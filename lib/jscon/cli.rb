module Jscon
  class CLI < Thor
    default_task :repl

    option :coffee, :type => :boolean
    option :showjs, :type => :boolean
    desc 'repl', 'the one and only option'
    def repl
      Jscon::Repl.new(options).start
    ensure
      Jscon::Dir.remove
    end
  end
end
