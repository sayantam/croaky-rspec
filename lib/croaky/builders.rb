# frozen_string_literal: true

require 'croaky/io_stream_builder'

module Croaky
  # Object builders
  module Builders
    def self.io_stream
      return @io_stream if @io_stream

      builder = ::Croaky::IoStreamBuilder.new
      @io_stream = builder.build
    end
  end
end
