return {
  fields = {
    bootstrap_servers = { type = "array", required = true },
    topic = { type = "string", required = true },
    producer_async = { type = "boolean", default = true },
    timeout = { type = "number", default = 10000 },
    keepalive = { type = "number", default = 60000 },
    producer_request_acks = { type = "number", default = 1, enum = { -1, 0, 1 } },
    producer_request_timeout = { type = "number", default = 2000 },
    producer_request_limits_messages_per_request = { type = "number", default = 200 },
    producer_request_limits_bytes_per_request = { type = "number", default = 1048576 },
    producer_request_retries_max_attempts = { type = "number", default = 10 },
    producer_request_retries_backoff_timeout = { type = "number", default = 100 },
    producer_async_flush_timeout = { type = "number", default = 1000 },
    producer_async_buffering_limits_messages_in_memory = { type = "number", default = 50000 },
  }
}
