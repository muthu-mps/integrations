# OpenCanary

This integration is for [Thinkst OpenCanary](https://github.com/thinkst/opencanary) honeypot event logs. The package processes messages from OpenCanary honeypot logs.

## Data streams

The OpenCanary integration collects the following event types:

`events`: Collects the OpenCanary logs.

## Requirements

Elastic Agent must be installed. For more details, check the Elastic Agent [installation instructions](docs-content://reference/fleet/install-elastic-agents.md).

### Enable the integration in Elastic

1. In Kibana navigate to **Management** > **Integrations**.
2. In the search top bar, type **OpenCanary**.
3. Select the **OpenCanary** integration and add it.
4. Add all the required integration configuration parameters.
5. Save the integration.

## Logs

### OpenCanary

The `events` dataset collects the OpenCanary logs.

An example event for `events` looks as following:

```json
{
    "@timestamp": "2024-04-05T14:37:26.457Z",
    "destination": {
        "address": "10.10.10.10",
        "domain": "OpenCanary1",
        "ip": "10.10.10.10",
        "port": 445
    },
    "event": {
        "action": "flistxattr",
        "category": [
            "network",
            "intrusion_detection"
        ],
        "created": "2024-04-05T14:37:26.457Z",
        "kind": [
            "alert"
        ],
        "original": "{\"dst_host\": \"10.10.10.10\", \"dst_port\": 445, \"local_time\": \"2024-04-05 14:37:26.457226\", \"local_time_adjusted\": \"2024-04-05 07:37:26.457252\", \"logdata\": {\"AUDITACTION\": \"flistxattr\", \"DOMAIN\": \"CONTOSO\", \"FILENAME\": \"/shares/database\", \"LOCALNAME\": \"OpenCanary1\", \"REMOTENAME\": \"Client1\", \"SHARENAME\": \"database\", \"SMBARCH\": \"OSX\", \"SMBVER\": \"SMB3_11\", \"STATUS\": \"ok\", \"USER\": \"jdoe\"}, \"logtype\": 5000, \"node_id\": \"opencanary-1\", \"src_host\": \"192.168.0.10\", \"src_port\": \"-1\", \"utc_time\": \"2024-04-05 14:37:26.457249\"}",
        "provider": "LOG_SMB_FILE_OPEN",
        "start": "2024-04-05T14:37:26.457Z",
        "type": [
            "connection"
        ]
    },
    "log": {
        "logger": "LOG_SMB_FILE_OPEN"
    },
    "network": {
        "direction": "internal"
    },
    "opencanary": {
        "node": {
            "id": "opencanary-1"
        },
        "smb": {
            "filename": "/shares/database",
            "share_name": "database",
            "smb_arch": "OSX",
            "smb_version": "SMB3_11",
            "status": "ok"
        }
    },
    "related": {
        "hosts": [
            "OpenCanary1",
            "Client1"
        ],
        "ip": [
            "10.10.10.10",
            "192.168.0.10"
        ],
        "user": [
            "jdoe"
        ]
    },
    "source": {
        "address": "192.168.0.10",
        "domain": "Client1",
        "ip": "192.168.0.10",
        "port": -1
    },
    "tags": [
        "preserve_original_event",
        "redact_passwords"
    ],
    "user": {
        "domain": "CONTOSO",
        "name": "jdoe"
    }
}
```

**Exported fields**

| Field | Description | Type |
|---|---|---|
| @timestamp | Date/time when the event originated. This is the date/time extracted from the event, typically representing when the event was generated by the source. If the event source has no original timestamp, this value is typically populated by the first time the event was received by the pipeline. Required field for all events. | date |
| cloud.image.id | Image ID for the cloud instance. | keyword |
| data_stream.dataset | Data stream dataset. | constant_keyword |
| data_stream.namespace | Data stream namespace. | constant_keyword |
| data_stream.type | Data stream type. | constant_keyword |
| event.dataset | Event dataset | constant_keyword |
| event.module | Event module | constant_keyword |
| host.containerized | If the host is a container. | boolean |
| host.os.build | OS build information. | keyword |
| host.os.codename | OS codename, if any. | keyword |
| input.type | Input type. | keyword |
| log.offset | Offset of the entry in the log file. | long |
| opencanary.logdata.cwr |  | keyword |
| opencanary.logdata.df |  | keyword |
| opencanary.logdata.ece |  | keyword |
| opencanary.logdata.id |  | long |
| opencanary.logdata.len |  | keyword |
| opencanary.logdata.prec |  | keyword |
| opencanary.logdata.res |  | keyword |
| opencanary.logdata.session |  | keyword |
| opencanary.logdata.syn |  | keyword |
| opencanary.logdata.tos |  | keyword |
| opencanary.logdata.ttl |  | long |
| opencanary.logdata.urgp |  | long |
| opencanary.logdata.window |  | long |
| opencanary.mssql.client.app |  | keyword |
| opencanary.mssql.client.hostname |  | keyword |
| opencanary.mssql.client.interface_library |  | keyword |
| opencanary.mssql.database |  | keyword |
| opencanary.node.id | Identifier for the OpenCanary node as configured in `/etc/opencanaryd/opencanary.conf` | keyword |
| opencanary.redis.args |  | keyword |
| opencanary.redis.command |  | keyword |
| opencanary.skin | Skin configured for the OpenCanary service. | keyword |
| opencanary.smb.audit_action |  | keyword |
| opencanary.smb.filename |  | keyword |
| opencanary.smb.share_name |  | keyword |
| opencanary.smb.smb_arch |  | keyword |
| opencanary.smb.smb_version |  | keyword |
| opencanary.smb.status |  | keyword |
| opencanary.ssh.local_version |  | keyword |
| opencanary.ssh.remote_version |  | keyword |
| opencanary.tcp_banner.banner_id |  | keyword |
| opencanary.tcp_banner.data |  | keyword |
| opencanary.tcp_banner.function |  | keyword |
| opencanary.tcp_banner.secret_string |  | keyword |

