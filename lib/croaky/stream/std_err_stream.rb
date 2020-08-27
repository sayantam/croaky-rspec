# frozen_string_literal: true

require 'stringio'

require 'croaky/io/io_capturable'

module Croaky
  module Stream
    # Standard error stream
    class StdErrStream
      include ::Croaky::IO::IoCapturable

      attr_accessor :stderr_str_io

      def capture_io
        self.stderr_str_io = StringIO.new
        $stderr = stderr_str_io
      end

      def restore_io
        $stderr = STDERR
      end

      def read_captured_io
        [stderr_str_io.string]
      end
    end
  end
end
