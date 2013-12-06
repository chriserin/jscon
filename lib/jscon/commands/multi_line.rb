module Jscon
  module Commands
    class MultiLine
      class << self
        def matches(input)
          if has_buffer?
            true
          else
            ends_with_underscore(input)
          end
        end

        def ends_with_underscore(input)
          input =~ /\s_$/
        end

        def run(input)
          if ends_with_underscore(input)
            input = input.gsub(/\s_$/, '')
            buffer.puts(input)
            throw :skip_process_input
          else
            buffer.puts(input)
            total_input = buffer.string
            clear_buffer
            return total_input
          end
        end

        def has_buffer?
          !!@buffer
        end

        def buffer
          @buffer ||= StringIO.new
        end

        def clear_buffer
          @buffer.close
          @buffer = nil
        end
      end
    end
  end
end
