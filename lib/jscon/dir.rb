require 'tmpdir'
require 'fileutils'

module Jscon
  class Dir
    class << self
      def mkdir
        @dir = ::Dir.mktmpdir()
      end

      def remove
        FileUtils.remove_entry path
      end

      def path
        @dir ||= mkdir
      end
    end
  end
end
