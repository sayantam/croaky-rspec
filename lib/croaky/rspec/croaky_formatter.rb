# frozen_string_literal: true

RSpec::Support.require_rspec_core 'formatters/base_text_formatter'
RSpec::Support.require_rspec_core 'formatters/console_codes'

require 'croaky/builders'
require 'croaky/io/io_stream'

module Croaky
  module RSpec
    # Croaky formatter
    class CroakyFormatter < ::RSpec::Core::Formatters::BaseTextFormatter
      NOTIFICATIONS = %i[start example_started example_passed example_pending example_failed].freeze
      ::RSpec::Core::Formatters.register(self, *NOTIFICATIONS)

      COLORIZER = ::RSpec::Core::Formatters::ConsoleCodes

      attr_reader :io_stream

      def initialize(output, io_stream = ::Croaky::Builders.io_stream)
        super(output)

        @io_stream = io_stream
      end

      def example_started(_notification)
        io_stream.capture_io
      end

      def example_passed(_notification)
        io_stream.restore_io
        output.print COLORIZER.wrap('.', :success)
      end

      def example_pending(_notification)
        io_stream.restore_io
        output.print COLORIZER.wrap('*', :pending)
      end

      # @param [RSpec::Core::Notifications::FailedExampleNotification] notification
      def example_failed(notification)
        io_stream.restore_io

        class << notification.example
          attr_accessor :captured_io
        end

        notification.example.captured_io = io_stream.read_captured_io
        output.print COLORIZER.wrap('F', :failure)
      end

      # @param [RSpec::Core::Notifications::ExamplesNotification] notification
      def dump_failures(notification)
        return if notification.failure_notifications.empty?

        output.puts
        output.puts 'Failures:'
        notification.failure_notifications.each_with_index do |failure, index|
          output.puts failure.fully_formatted(index.next, COLORIZER)
          output.puts failure.example.captured_io
        end
      end
    end
  end
end
