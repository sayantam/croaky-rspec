# frozen_string_literal: true

require 'croaky/io/io_stream'

module Croaky
  # Builds an IoStream based on the platform.
  class Builder
    def self.io_stream
      return @io_stream if @io_stream

      builder = self.new
      @io_stream = builder.io_stream
    end

    def io_stream
      jruby_platform = defined?(JRUBY_VERSION)
      stdout_stream = jruby_platform ? java_stdout_stream : ruby_stdout_stream
      stderr_stream = jruby_platform ? java_stderr_stream : ruby_stderr_stream
      Croaky::IO::IoStream.new(stdout_stream, stderr_stream)
    end

    private

    def ruby_stdout_stream
      require 'croaky/stream/std_out_stream'
      Stream::StdOutStream.new
    end

    def java_stdout_stream
      require 'croaky/stream/java_std_out_stream'
      Stream::JavaStdOutStream.new
    end

    def ruby_stderr_stream
      require 'croaky/stream/std_err_stream'
      Stream::StdErrStream.new
    end

    def java_stderr_stream
      require 'croaky/stream/java_std_err_stream'
      Stream::JavaStdErrStream.new
    end
  end
end
