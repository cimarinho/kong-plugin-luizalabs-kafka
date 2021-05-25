
# Kong Kafka Plugin


```bash
$ curl -X POST http://kong:8001/plugins \
    --data "name=kong-plugin-luizalabs-kafka" \
    --data "config.bootstrap_servers=localhost:9092" \
    --data "config.topic=kong-log" \
    --data "config.timeout=10000" \
    --data "config.keepalive=60000" \
    --data "config.producer_request_acks=1" \
    --data "config.producer_request_timeout=2000" \
    --data "config.producer_request_limits_messages_per_request=200" \
    --data "config.producer_request_limits_bytes_per_request=1048576" \
    --data "config.producer_request_retries_max_attempts=10" \
    --data "config.producer_request_retries_backoff_timeout=100" \
    --data "config.producer_async=true" \
    --data "config.producer_async_flush_timeout=1000" \
    --data "config.producer_async_buffering_limits_messages_in_memory=50000"
```

### Parameters

Here's a list of all the parameters which can be used in this plugin's configuration:

| Form Parameter | default | description |
| --- 						| --- | --- |
| `name` 					                        |       | The name of the plugin to use, in this case `kafka-log` |
| `config.bootstrap_servers` 	                    |       | List of bootstrap brokers in `host:port` format |
| `config.topic` 			                        |       | Topic to publish to |
| `config.timeout`   <br /> <small>Optional</small> | 10000 | Socket timeout in millis |
| `config.keepalive` <br /> <small>Optional</small> | 60000 | Keepalive timeout in millis |
| `config.producer_request_acks` <br /> <small>Optional</small>                              | 1       | The number of acknowledgments the producer requires the leader to have received before considering a request complete. Allowed values: 0 for no acknowledgments, 1 for only the leader and -1 for the full ISR |
| `config.producer_request_timeout` <br /> <small>Optional</small>                           | 2000    | Time to wait for a Produce response in millis |
| `config.producer_request_limits_messages_per_request` <br /> <small>Optional</small>       | 200     | Maximum number of messages to include into a single Produce request |
| `config.producer_request_limits_bytes_per_request` <br /> <small>Optional</small> 	     | 1048576 | Maximum size of a Produce request in bytes |
| `config.producer_request_retries_max_attempts` <br /> <small>Optional</small> 	         | 10      | Maximum number of retry attempts per single Produce request |
| `config.producer_request_retries_backoff_timeout` <br /> <small>Optional</small>	     	 | 100     | Backoff interval between retry attempts in millis |
| `config.producer_async` <br /> <small>Optional</small>                                     | true    | Flag to enable asynchronous mode |
| `config.producer_async_flush_timeout` <br /> <small>Optional</small>                       | 1000    | Maximum time interval in millis between buffer flushes in in asynchronous mode | 
| `config.producer_async_buffering_limits_messages_in_memory` <br /> <small>Optional</small> | 50000   | Maximum number of messages that can be buffered in memory in asynchronous mode |

