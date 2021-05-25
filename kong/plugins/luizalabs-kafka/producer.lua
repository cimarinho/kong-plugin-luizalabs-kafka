local cjson = require "cjson"
local cjson_encode = cjson.encode
local kafka_producer = require "resty.kafka.producer"
local re_match = ngx.re.match
local ipairs = ipairs
local _M = {}

local function bootstrap_server(string)
    local bootstrap_server_regex = [[^([^:]+):(\d+)$]]
    local m = re_match(string, bootstrap_server_regex, "jo")
    if not m then
        return nil, "Invalid bootstrap server value: " .. string
    end
    return { host = m[1], port = m[2] }
end

local function broker_list(bootstrap_servers)
    local broker_list = {}
    for idx, value in ipairs(bootstrap_servers) do
        local server = bootstrap_server(value)
        if not server then
            return nil, "invalid bootstrap server value: " .. value
        end
        broker_list[idx] = server
    end
    return broker_list
end

local function create_producer(conf)
    local producer_config = {
        socket_timeout = conf.timeout,
        keepalive_timeout = conf.keepalive,
        required_acks = conf.producer_request_acks,
        request_timeout = conf.producer_request_timeout,
        batch_num = conf.producer_request_limits_messages_per_request,
        batch_size = conf.producer_request_limits_bytes_per_request,
        max_retry = conf.producer_request_retries_max_attempts,
        retry_backoff = conf.producer_request_retries_backoff_timeout,
        producer_type = conf.producer_async and "async" or "sync",
        flush_time = conf.producer_async_flush_timeout,
        max_buffering = conf.producer_async_buffering_limits_messages_in_memory,
    }
    local brokers = broker_list(conf.bootstrap_servers)
    return kafka_producer:new(brokers, producer_config)
end

function _M.execute(config, message)
    local conn = create_producer(config)
    local ok , _ = conn:send(config.topic, nil, cjson_encode(message))
    if not ok then
        ngx.log(ngx.ERR, "Failed to send a message on topic ", config.topic, ": ", err)
        return
    end
end

return _M
