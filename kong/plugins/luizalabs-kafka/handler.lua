local BasePlugin = require "kong.plugins.base_plugin"
local producer = require "kong.plugins.luizalabs-kafka.producer"
local KafkaLogHandler = BasePlugin:extend()
local kong = kong.request
KafkaLogHandler.PRIORITY = 500
KafkaLogHandler.VERSION = "1.0.0"

function KafkaLogHandler:new()
  KafkaLogHandler.super.new(self, "luizalabs-kafka")
end

function KafkaLogHandler:access(config)
  KafkaLogHandler.super.log(self)
  local _ , err = pcall(producer.execute, config,   kong.get_body())
  if err then
    ngx.log(ngx.CRIT, err)
  end
end

return KafkaLogHandler
