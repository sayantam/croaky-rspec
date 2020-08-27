# frozen_string_literal: true

require 'croaky/io/io_capturable'

module Croaky
  module IO
    # IO adapter
    class IoStream
      include IoCapturable

      attr_reader :stdout_stream, :stderr_stream

      def initialize(stdout_stream, stderr_stream)
        @stdout_stream = stdout_stream
        @stderr_stream = stderr_stream
      end

      def capture_io
        stdout_stream.capture_io
        stderr_stream.capture_io
      end

      def restore_io
        stdout_stream.restore_io
        stderr_stream.restore_io
      end

      def read_captured_io
        captured = [stdout_stream.read_captured_io, stderr_stream.read_captured_io]
        captured.flatten.reject { |s| s.to_s.empty? }.join($INPUT_RECORD_SEPARATOR)
      end
    end
  end
end
