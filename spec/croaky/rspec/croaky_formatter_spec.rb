# frozen_string_literal: true

require 'croaky/rspec/croaky_formatter'

RSpec.describe Croaky::RSpec::CroakyFormatter do
  before do
    @stream = StringIO.new
    @formatter = Croaky::RSpec::CroakyFormatter.new('')
    allow(@formatter).to receive(:output).and_return(@stream)
  end

  context 'when a test fails' do
    before(:each) do
      mock_error = StandardError.new('mock error')
      @execution_result = instance_double(RSpec::Core::Example::ExecutionResult, status: :failed, exception: mock_error)
      allow(@execution_result).to receive(:pending_fixed?).and_return(false)
      @failed_example = instance_double(RSpec::Core::Example, execution_result: @execution_result,
                                                              full_description: 'desc')
      @notification = RSpec::Core::Notifications::FailedExampleNotification.new(@failed_example)
      @formatter.example_started(double('ExampleNotification'))
    end

    it 'should print a failed marker' do
      @formatter.example_failed(@notification)
      expect(@stream.string).to match(/F/)
    end

    context 'when failures are dumped' do
      before(:each) do
        @reporter = instance_double(RSpec::Core::Reporter, failed_examples: [@failed_example])
        allow(@execution_result).to receive(:example_skipped?).and_return(false)
        allow(@failed_example).to receive(:metadata).and_return({ shared_group_inclusion_backtrace: [] })
      end

      it 'should show output from Ruby code' do
        puts 'stdout'
        @formatter.example_failed(@notification)
        @formatter.dump_failures(RSpec::Core::Notifications::ExamplesNotification.new(@reporter))
        expect(@stream.string).to match(/stdout/)
      end

      it 'should show error from Ruby code' do
        warn 'stderr'
        @formatter.example_failed(@notification)
        @formatter.dump_failures(RSpec::Core::Notifications::ExamplesNotification.new(@reporter))
        expect(@stream.string).to match(/stderr/)
      end

      if defined?(JRUBY_VERSION)
        it 'should show output from Java code' do
          java.lang.System.out.println('stdout')
          @formatter.example_failed(@notification)
          @formatter.dump_failures(RSpec::Core::Notifications::ExamplesNotification.new(@reporter))
          expect(@stream.string).to match(/stdout/)
        end

        it 'should show error from Java code' do
          java.lang.System.err.println('stderr')
          @formatter.example_failed(@notification)
          @formatter.dump_failures(RSpec::Core::Notifications::ExamplesNotification.new(@reporter))
          expect(@stream.string).to match(/stderr/)
        end
      end
    end
  end

  context 'when a test passes' do
    it 'should print a pass marker' do
      @formatter.example_started(double('ExampleNotification'))
      @formatter.example_passed(double('ExampleNotification'))
      expect(@stream.string).to match(/\./)
    end
  end

  context 'when a test is pending' do
    it 'should print a pending marker' do
      @formatter.example_started(double('ExampleNotification'))
      @formatter.example_pending(double('ExampleNotification'))
      expect(@stream.string).to match(/\*/)
    end
  end
end
