# frozen_string_literal: true

class RedisBase
  # def connection
  # unless defined?(@@connection) && @@connection
  #   @@connection = Redis.new(url: ENV['CONTEXT_REDIS_URL'])
  # end
  # @@connection
  # end
  attr_accessor :connection

  def initialize
    self.reset
  end

  def reset
    self.connection = Redis.new(url: ENV['CONTEXT_REDIS_URL'])
  end
end
