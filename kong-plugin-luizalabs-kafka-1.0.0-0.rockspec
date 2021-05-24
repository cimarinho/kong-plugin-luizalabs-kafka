package = "kong-plugin-luizalabs-kafka"
version = "1.0.0-0"
source = {
   url = "git://github.com/cimarinho/kong-plugin-luizalabs-kafka",
   tag = "0.0.1"
}
description = {
   summary = "This plugin sends request to Kafka.",
   homepage = "https://github.com/cimarinho/kong-plugin-luizalabs-kafka",
   license = "Apache 2.0"
}
dependencies = {
   "lua >= 5.1",
   "lua-resty-kafka >= 0.06"
}
build = {
   type = "builtin",
   modules = {
      ["kong.plugins.kong.plugins.luizalabs-kafka.handler"] =       "kong/plugins/luizalabs-kafka/handler.lua",
      ["kong.plugins.kong.plugins.luizalabs-kafka.schema"] =        "kong/plugins/luizalabs-kafka/schema.lua",
      ["kong.plugins.kong.plugins.luizalabs-kafka.producer"] =      "kong/plugins/luizalabs-kafka/producer.lua",
   }
}
