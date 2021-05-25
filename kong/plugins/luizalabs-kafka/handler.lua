local BasePlugin = require "kong.plugins.base_plugin"
local producer = require "kong.plugins.luizalabs-kafka.producer"
local KafkaLogHandler = BasePlugin:extend()
local kong = kong
KafkaLogHandler.PRIORITY = 500
KafkaLogHandler.VERSION = "1.0.0"

function KafkaLogHandler:new()
  KafkaLogHandler.super.new(self, "luizalabs-kafka")
end

function KafkaLogHandler:access(config)
  --local inspect = require("inspect")
  --print('\n\n ', inspect(config))
  KafkaLogHandler.super.log(self)
  local ok, err = pcall(producer.execute, config,   kong.request.get_body())
  if not ok then
    ngx.log(ngx.CRIT, err)
  end
end

return KafkaLogHandler
