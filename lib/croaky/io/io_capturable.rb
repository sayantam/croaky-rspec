# frozen_string_literal: true

require 'croaky'

module Croaky
  module IO
    # Capturable interface
    module IoCapturable
      def capture_io
        # :nocov:
        raise(NotImplementedError, "#{self.class.name}##{__method__}")
        # :nocov:
      end

      def restore_io
        # :nocov:
        raise(NotImplementedError, "#{self.class.name}##{__method__}")
        # :nocov:
      end

      def read_captured_io
        # :nocov:
        raise(NotImplementedError, "#{self.class.name}##{__method__}")
        # :nocov:
      end
    end
  end
end
