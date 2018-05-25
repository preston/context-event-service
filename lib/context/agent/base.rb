# frozen_string_literal: true

module Context
  module Agent
    class Base
      include Context::Session
      attr_accessor :channels

      def initialize(channels)
        raise 'Array of expressions is required.' unless channels.is_a?(Array)
        self.channels = channels
        puts "Initializing #{self.class.name}..."
      end

      def run(&block)
        sub = RedisSubscriber.new(channels)
        sub.process &block
      end
    end
  end
end
