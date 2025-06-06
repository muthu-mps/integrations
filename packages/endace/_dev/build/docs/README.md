# Endace

Endace is a company known for its network recording, traffic capture, and analysis technology. Endace's solutions are often used for network security, performance monitoring, and troubleshooting.
This integration allows users to ingest Network flow data from either Endace Flow via syslog input or use Elastic Agent to generate and ship Network Flow data to an Elastic deployment. Both of these methods add the `event.reference` field to each event when ingested into Elasticsearch which is a URL used to pivot to Endace.   


## Additional Setup

### Dataview
Once the integration is deployed, in order for the pivot link to be clickable to format for the `event.reference` field needs to be set, this can be done via Kibana Dev Tools and making the following request:
```
POST kbn:/api/data_views/data_view/logs-*/fields
{
    "fields": {
        "event.reference": {
            "format":{
              "id": "url"
            }
        }
    }
}
```

### IP Reputation
When in Elastic Security users are able to quickly lookup information about IPs from external services, to add Endace as an IP Reputation lookup service run the following in Kibana Dev Tools. Ensure to replace `<Your Endace appliance url>` with your Endace appliance URL.

```
POST kbn:/api/kibana/settings
{"changes":{"securitySolution:ipReputationLinks": """[
  { "name": "Endace", "url_template": "https://<Your Endace appliance url>/vision2/v1/pivotintovision/?datasources=tag:all&title=Untitled&reltime=12h&sip={{`{{ip}}`}}&tools=conversations_by_ipaddress" },
  { "name": "virustotal.com", "url_template": "https://www.virustotal.com/gui/search/{{`{{ip}}`}}" },
  { "name": "talosIntelligence.com", "url_template": "https://talosintelligence.com/reputation_center/lookup?search={{`{{ip}}`}}" }
]"""}}
```


## Integration Variables
#### `endace_url`
The base URL for Endace UI. Example: https://myvprobe.com

#### `endace_datasources`
The datasource within Endace to pivot to. Example: tag:rotation-file

#### `endace_tools`
The tools to use within the Endace Pivot. Example: trafficOverTime_by_app,conversations_by_ipaddress


#### `endace_view_window`
The size of the search window in minutes centered on the event time. The default is 10m, resulting in a search from 5m before to 5m after the event.

## Endace Flow
#### `map_to_ecs`

Remap any non-ECS Packetbeat fields in root to their correct ECS fields.
This will rename fields that are moved so the fields will not be present
at the root of the document and so any rules that depend on the fields
will need to be updated.

The legacy behaviour of this option is to not remap to ECS. This behaviour
is still the default, but is deprecated and users are encouraged to set
this option to true.

ECS remapping may have an impact on workflows that depend on the identity
of non-ECS fields, and users should assess their use of these fields before
making the change. Users who need to retain data collected with the legacy
mappings may need to re-index their older documents. Instructions for doing
this are available [here](https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-reindex.html).
The pipeline used to perform ECS remapping for each data stream can be found
in `Stack Management`›`Ingest Pipelines` and and searching for
"logs-network_traffic compatibility".

The deprecation and retirement timeline for legacy behavior is available
[here](https://github.com/elastic/integrations/issues/8185).

#### `enabled`

The enabled setting is a boolean setting to enable or disable protocols
without having to comment out configuration sections. If set to false,
the protocol is disabled.

The default value is true.

#### `ports`

Exception: For ICMP the option `enabled` has to be used instead.

The ports where Network Packet Capture will look to capture traffic for specific
protocols. Network Packet Capture installs a
[BPF](https://en.wikipedia.org/wiki/Berkeley_Packet_Filter) filter based
on the ports specified in this section. If a packet doesn’t match the
filter, very little CPU is required to discard the packet. Network Packet Capture
also uses the ports specified here to determine which parser to use for
each packet.

#### `monitor_processes`

If this option is enabled then network traffic events will be enriched
with information about the process associated with the events.

The default value is false.

#### `send_request`

If this option is enabled, the raw message of the request (`request`
field) is sent to Elasticsearch. The default is false. This option is
useful when you want to index the whole request. Note that for HTTP, the
body is not included by default, only the HTTP headers.

#### `send_response`

If this option is enabled, the raw message of the response (`response`
field) is sent to Elasticsearch. The default is false. This option is
useful when you want to index the whole response. Note that for HTTP,
the body is not included by default, only the HTTP headers.

#### `transaction_timeout`

The per protocol transaction timeout. Expired transactions will no
longer be correlated to incoming responses, but sent to Elasticsearch
immediately.

#### `tags`

A list of tags that will be sent with the transaction event. This
setting is optional.

#### `processors`

A list of processors to apply to the data generated by the protocol.

#### `keep_null`

If this option is set to true, fields with `null` values will be
published in the output document. By default, `keep_null` is set to
`false`.


## Network Flows

Overall flow information about the network connections on a
host.

You can configure Network Packet Capture to collect and report statistics
on network flows. A *flow* is a group of packets sent over the same time
period that share common properties, such as the same source and destination
address and protocol. You can use this feature to analyze network
traffic over specific protocols on your network.

For each flow, Network Packet Capture reports the number of packets and the
total number of bytes sent from the source to the destination. Each flow event
also contains information about the source and destination hosts, such
as their IP address. For bi-directional flows, Network Packet Capture reports
statistics for the reverse flow.

Network Packet Capture collects and reports statistics up to and including the
transport layer.

**Configuration options**

You can specify the following options for capturing flows.

#### `enabled`

Enables flows support if set to true. Set to false to disable network
flows support without having to delete or comment out the flows section.
The default value is true.

#### `timeout`

Timeout configures the lifetime of a flow. If no packets have been
received for a flow within the timeout time window, the flow is killed
and reported. The default value is 30s.

#### `period`

Configure the reporting interval. All flows are reported at the very
same point in time. Periodical reporting can be disabled by setting the
value to -1. If disabled, flows are still reported once being timed out.
The default value is 10s.

{{fields "flow"}}

{{event "flow"}}

## Licensing for Windows Systems

The Network Packet Capture Integration incorporates a bundled Npcap installation on Windows hosts. The installation is provided under an [OEM license](https://npcap.com/oem/redist.html) from Insecure.Com LLC ("The Nmap Project").
