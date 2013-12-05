module Jscon
  class Pipes
    class << self
      def create_set(name)
        in_pipe_name = File.join(Jscon::Dir.path, "#{name}_in.pipe")
        out_pipe_name = File.join(Jscon::Dir.path, "#{name}_out.pipe")
        `mkfifo #{in_pipe_name} #{out_pipe_name} 2> /dev/null`
        return in_pipe_name, out_pipe_name
      end
    end
  end
end
