# frozen_string_literal: true

require 'croaky/stream/std_err_stream'

module Croaky
  module Stream
    JAVA_LANG = java.lang

    # Error stream for Java
    class JavaStdErrStream < StdErrStream
      attr_accessor :pw_err, :java_stderr

      def capture_io
        super

        self.java_stderr = JAVA_LANG.System.err
        pw_err&.close
        self.pw_err = err_stream
        JAVA_LANG.System.setErr(pw_err)
      end

      def restore_io
        super

        JAVA_LANG.System.setErr(java_stderr)
        pw_err.close
      end

      def read_captured_io
        captured = super

        captured << read_err_stream
      end

      private

      def err_stream
        @err_stream = java.io.ByteArrayOutputStream.new
        java.io.PrintStream.new(@err_stream)
      end

      def read_err_stream
        @err_stream.to_string('utf-8')
      end
    end
  end
end
