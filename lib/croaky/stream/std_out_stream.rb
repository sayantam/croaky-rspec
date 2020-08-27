# frozen_string_literal: true

require 'stringio'

require 'croaky/io/io_capturable'

module Croaky
  module Stream
    # Standard output stream
    class StdOutStream
      include ::Croaky::IO::IoCapturable

      attr_accessor :stdout_str_io

      def capture_io
        self.stdout_str_io = StringIO.new
        $stdout = stdout_str_io
      end

      def restore_io
        $stdout = STDOUT
      end

      def read_captured_io
        [stdout_str_io.string]
      end
    end
  end
end
