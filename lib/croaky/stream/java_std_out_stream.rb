# frozen_string_literal: true

require 'croaky/stream/std_out_stream'

module Croaky
  module Stream
    JAVA_LANG = java.lang

    # Output stream for Java
    class JavaStdOutStream < StdOutStream
      attr_accessor :pw_out, :java_stdout

      def capture_io
        super

        self.java_stdout = JAVA_LANG.System.out
        pw_out&.close
        self.pw_out = out_stream
        JAVA_LANG.System.setOut(pw_out)
      end

      def restore_io
        super

        JAVA_LANG.System.setOut(java_stdout)
        pw_out.close
      end

      def read_captured_io
        captured = super

        captured << read_out_stream
      end

      private

      def out_stream
        @out_stream = java.io.ByteArrayOutputStream.new
        java.io.PrintStream.new(@out_stream)
      end

      def read_out_stream
        @out_stream.to_string('utf-8')
      end
    end
  end
end
