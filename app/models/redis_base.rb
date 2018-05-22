class RedisBase
  def connection
    unless defined?(@@connection) && @@connection
      @@connection = Redis.new(host: ENV['CONTEXT_REDIS_URL'])
    end
    @@connection
  end
end
