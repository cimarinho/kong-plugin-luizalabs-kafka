local producer = require 'kong.plugins.luizalabs-kafka.producer'
local kafka_producer = require "resty.kafka.producer"
local ngx_log = spy.new(function(status, error)
    return status, error
end)
_G.ngx["log"] = ngx_log
describe("handler test call phase", function()
    local config, message = {}

    before_each(function()
        message = {
            age = 43,
            birthday = "1976-09-30",
            name = "Marcelo33"
        }
        config = {
                bootstrap_servers = { "localhost:9092" },
                keepalive = 60000,
                producer_async = true,
                producer_async_buffering_limits_messages_in_memory = 50000,
                producer_async_flush_timeout = 1000,
                producer_request_acks = 1,
                producer_request_limits_bytes_per_request = 1048576,
                producer_request_limits_messages_per_request = 200,
                producer_request_retries_backoff_timeout = 100,
                producer_request_retries_max_attempts = 10,
                producer_request_timeout = 2000,
                service_id = "6efeb675-24b3-4964-9d76-3273aec487ee",
                timeout = 10000,
                topic = "message.topic"
        }
    end)

    describe("execute ", function()
        it("calling execute success", function()
            kafka_producer.send = spy.new(function() return true  end)
            producer.execute(config, message)
            assert.spy(kafka_producer.send).was.called()
        end)

        it("calling execute error", function()
            kafka_producer.send = spy.new(function() return nil   end)
            producer.execute(config, message)
            assert.spy(kafka_producer.send).was.called()
            assert.spy(ngx.log).was.called()
        end)

    end)

end)




