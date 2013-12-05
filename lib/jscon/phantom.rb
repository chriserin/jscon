module Jscon
  module Phantom
    extend self

    COMMAND = "phantomjs"
    FILE = File.expand_path "../js/phantom.js", __FILE__
    def run_exec(reqDir, options="")
      cmd = construct_cmd(reqDir, options)
      return fork { exec(cmd) }
    end

    def construct_cmd(tmpDir, options)
      [
        COMMAND,
        FILE,
        keyval("tmpDir", tmpDir),
        keyval("options", options)
      ].join(" ")
    end

    def keyval(key, val)
      "#{key}=#{val}"
    end
  end
end
