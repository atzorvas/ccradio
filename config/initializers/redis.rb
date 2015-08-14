$REDIS_URL = ENV["REDIS_URL"] || "redis://localhost:6379"
$redis = Redis.new(url: $REDIS_URL)
