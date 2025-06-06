# Okta Integration

The Okta integration collects events from the Okta API, specifically reading from the Okta System Log API.

## Agentless Enabled Integration
Agentless integrations allow you to collect data without having to manage Elastic Agent in your cloud. They make manual agent deployment unnecessary, so you can focus on your data instead of the agent that collects it. For more information, refer to [Agentless integrations](https://www.elastic.co/guide/en/serverless/current/security-agentless-integrations.html) and the [Agentless integrations FAQ](https://www.elastic.co/guide/en/serverless/current/agentless-integration-troubleshooting.html).

Agentless deployments are only supported in Elastic Serverless and Elastic Cloud environments.  This functionality is in beta and is subject to change. Beta features are not subject to the support SLA of official GA features.

## Logs

### System

The Okta System Log records system events related to your organization in order to provide an audit trail that can be used to understand platform activity and to diagnose problems. This module is implemented using the httpjson input and is configured to paginate through the logs while honoring any rate-limiting headers sent by Okta.

## Types Of Authentication
### API Key
In this type of authentication, we only require an API Key for authenticating the client and polling for Okta System Logs.

### Oauth2
**In this type of authentication, we require the following information:**
1. Your Okta domain URL. [ Example: https://dev-123456.okta.com ]
2. Your Okta service app Client ID.
3. Your Okta service app JWK Private Key
4. The Okta scope that is required for OAuth2. [ By default this is set to `okta.logs.read` which should suffice for most use cases ]

**Steps to acquire Okta Oauth2 credentials:**
1. Acquire an Okta dev or user account with privileges to mint tokens with the `okta.*` scopes.
2. Log into your Okta account, navigate to `Applications` on the left-hand side, click on the `Create App Integration` button and create an API Services application.
3. Click on the created app, note down the `Client ID` and select the option for `Public key/Private key`.
4. Generate your own `Private/Public key` pair in the `JWK` format (PEM is not supported at the moment) and save it in a credentials JSON file or copy it to use directly in the config.

### Okta Integration Network (OIN)
The Okta Integration Network provides a simple integration authentication based on OAuth2, but using an API key.
In this type of authentication, we only require an API Key for authenticating the client and polling for Okta System Logs.
1. Your Okta domain URL. [ Example: https://dev-123456.okta.com ]
2. Your Okta service app Client ID.
3. Your Okta service app Client Secret.

**Steps to configure Okta OIN authenticaton:**
1. Log into your Okta account, navigate to `Applications` on the left-hand side, click on the `Browse App Catalog` button and search for "Elastic".
2. Click on the Elastic app card and then click `Add Integration`, and then `Install & Authorize`.
3. Copy the Client Secret.
4. Navigate to the Fleet integration configuration page for the integration.
5. Set the "Okta System Log API URL" field from the value of the Okta app with the URL path "/api/v1/logs" added as shown in the UI documentation
6. Set the "Okta Domain URL" field from the value of the Okta app
7. Set the "Client ID" field with the Client ID provided by the Okta app
8. Set the "API Key" field to the Client Secret provided by the Okta app
9. Set the "Use OIN Authentication" toggle to true

> **_NOTE:_**
 Tokens with `okta.*` Scopes are generally minted from the Okta Org Auth server and not the default/custom authorization server.
 The standard Okta Org Auth server endpoint to mint tokens is https://<your_okta_org>.okta.com/oauth2/v1/token

An example event for `system` looks as following:

```json
{
    "@timestamp": "2020-02-14T20:18:57.718Z",
    "agent": {
        "ephemeral_id": "f0fa8393-26a1-453e-96fe-212743206a30",
        "id": "da1b4fd1-cf45-42bc-8036-09da5b16e085",
        "name": "elastic-agent-91674",
        "type": "filebeat",
        "version": "8.18.1"
    },
    "client": {
        "geo": {
            "city_name": "Dublin",
            "country_name": "United States",
            "location": {
                "lat": 37.7201,
                "lon": -121.919
            },
            "region_name": "California"
        },
        "ip": "108.255.197.247",
        "user": {
            "email": "xxxxxx@elastic.co",
            "full_name": "xxxxxx",
            "id": "00u1abvz4pYqdM8ms4x6",
            "name": "xxxxxx@elastic.co"
        }
    },
    "data_stream": {
        "dataset": "okta.system",
        "namespace": "58099",
        "type": "logs"
    },
    "ecs": {
        "version": "8.11.0"
    },
    "elastic_agent": {
        "id": "da1b4fd1-cf45-42bc-8036-09da5b16e085",
        "snapshot": false,
        "version": "8.18.1"
    },
    "event": {
        "action": "user.session.start",
        "agent_id_status": "verified",
        "category": [
            "authentication",
            "session"
        ],
        "created": "2025-06-04T15:16:49.436Z",
        "dataset": "okta.system",
        "id": "3aeede38-4f67-11ea-abd3-1f5d113f2546",
        "ingested": "2025-06-04T15:16:50Z",
        "kind": "event",
        "original": "{\"actor\":{\"alternateId\":\"xxxxxx@elastic.co\",\"detailEntry\":null,\"displayName\":\"xxxxxx\",\"id\":\"00u1abvz4pYqdM8ms4x6\",\"type\":\"User\"},\"authenticationContext\":{\"authenticationProvider\":null,\"authenticationStep\":0,\"credentialProvider\":null,\"credentialType\":null,\"externalSessionId\":\"102bZDNFfWaQSyEZQuDgWt-uQ\",\"interface\":null,\"issuer\":null},\"client\":{\"device\":\"Computer\",\"geographicalContext\":{\"city\":\"Dublin\",\"country\":\"United States\",\"geolocation\":{\"lat\":37.7201,\"lon\":-121.919},\"postalCode\":\"94568\",\"state\":\"California\"},\"id\":null,\"ipAddress\":\"108.255.197.247\",\"userAgent\":{\"browser\":\"FIREFOX\",\"os\":\"Mac OS X\",\"rawUserAgent\":\"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:72.0) Gecko/20100101 Firefox/72.0\"},\"zone\":\"null\"},\"debugContext\":{\"debugData\":{\"deviceFingerprint\":\"541daf91d15bef64a7e08c946fd9a9d0\",\"requestId\":\"XkcAsWb8WjwDP76xh@1v8wAABp0\",\"requestUri\":\"/api/v1/authn\",\"threatSuspected\":\"false\",\"url\":\"/api/v1/authn?\"}},\"displayMessage\":\"User login to Okta\",\"eventType\":\"user.session.start\",\"legacyEventType\":\"core.user_auth.login_success\",\"outcome\":{\"reason\":null,\"result\":\"SUCCESS\"},\"published\":\"2020-02-14T20:18:57.718Z\",\"request\":{\"ipChain\":[{\"geographicalContext\":{\"city\":\"Dublin\",\"country\":\"United States\",\"geolocation\":{\"lat\":37.7201,\"lon\":-121.919},\"postalCode\":\"94568\",\"state\":\"California\"},\"ip\":\"108.255.197.247\",\"source\":null,\"version\":\"V4\"}]},\"securityContext\":{\"asNumber\":null,\"asOrg\":null,\"domain\":null,\"isProxy\":null,\"isp\":null},\"severity\":\"INFO\",\"target\":null,\"transaction\":{\"detail\":{},\"id\":\"XkcAsWb8WjwDP76xh@1v8wAABp0\",\"type\":\"WEB\"},\"uuid\":\"3aeede38-4f67-11ea-abd3-1f5d113f2546\",\"version\":\"0\"}",
        "outcome": "success",
        "type": [
            "start",
            "info"
        ]
    },
    "host": {
        "name": "svc-okta-oauth2"
    },
    "input": {
        "type": "httpjson"
    },
    "okta": {
        "actor": {
            "alternate_id": "xxxxxx@elastic.co",
            "display_name": "xxxxxx",
            "id": "00u1abvz4pYqdM8ms4x6",
            "type": "User"
        },
        "authentication_context": {
            "authentication_step": 0,
            "external_session_id": "102bZDNFfWaQSyEZQuDgWt-uQ"
        },
        "client": {
            "device": "Computer",
            "ip": "108.255.197.247",
            "user_agent": {
                "browser": "FIREFOX",
                "os": "Mac OS X",
                "raw_user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:72.0) Gecko/20100101 Firefox/72.0"
            },
            "zone": "null"
        },
        "debug_context": {
            "debug_data": {
                "device_fingerprint": "541daf91d15bef64a7e08c946fd9a9d0",
                "flattened": {
                    "deviceFingerprint": "541daf91d15bef64a7e08c946fd9a9d0",
                    "requestId": "XkcAsWb8WjwDP76xh@1v8wAABp0",
                    "requestUri": "/api/v1/authn",
                    "threatSuspected": "false",
                    "url": "/api/v1/authn?"
                },
                "request_id": "XkcAsWb8WjwDP76xh@1v8wAABp0",
                "request_uri": "/api/v1/authn",
                "threat_suspected": "false",
                "url": "/api/v1/authn?"
            }
        },
        "display_message": "User login to Okta",
        "event_type": "user.session.start",
        "outcome": {
            "result": "SUCCESS"
        },
        "request": {
            "ip_chain": [
                {
                    "geographical_context": {
                        "city": "Dublin",
                        "country": "United States",
                        "geolocation": {
                            "lat": 37.7201,
                            "lon": -121.919
                        },
                        "postal_code": "94568",
                        "state": "California"
                    },
                    "ip": "108.255.197.247",
                    "version": "V4"
                }
            ]
        },
        "transaction": {
            "id": "XkcAsWb8WjwDP76xh@1v8wAABp0",
            "type": "WEB"
        },
        "uuid": "3aeede38-4f67-11ea-abd3-1f5d113f2546"
    },
    "related": {
        "ip": [
            "108.255.197.247"
        ],
        "user": [
            "xxxxxx",
            "xxxxxx@elastic.co"
        ]
    },
    "source": {
        "ip": "108.255.197.247",
        "user": {
            "email": "xxxxxx@elastic.co",
            "full_name": "xxxxxx",
            "id": "00u1abvz4pYqdM8ms4x6",
            "name": "xxxxxx@elastic.co"
        }
    },
    "tags": [
        "preserve_original_event",
        "forwarded",
        "okta-system"
    ],
    "user": {
        "email": "xxxxxx@elastic.co",
        "full_name": "xxxxxx",
        "name": "xxxxxx@elastic.co"
    },
    "user_agent": {
        "device": {
            "name": "Mac"
        },
        "name": "Firefox",
        "original": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:72.0) Gecko/20100101 Firefox/72.0",
        "os": {
            "full": "Mac OS X 10.15",
            "name": "Mac OS X",
            "version": "10.15"
        },
        "version": "72.0"
    }
}
```

**Exported fields**

| Field | Description | Type |
|---|---|---|
| @timestamp | Date/time when the event originated. This is the date/time extracted from the event, typically representing when the event was generated by the source. If the event source has no original timestamp, this value is typically populated by the first time the event was received by the pipeline. Required field for all events. | date |
| cloud.image.id | Image ID for the cloud instance. | keyword |
| data_stream.dataset | The field can contain anything that makes sense to signify the source of the data. Examples include `nginx.access`, `prometheus`, `endpoint` etc. For data streams that otherwise fit, but that do not have dataset set we use the value "generic" for the dataset value. `event.dataset` should have the same value as `data_stream.dataset`. Beyond the Elasticsearch data stream naming criteria noted above, the `dataset` value has additional restrictions:   \* Must not contain `-`   \* No longer than 100 characters | constant_keyword |
| data_stream.namespace | A user defined namespace. Namespaces are useful to allow grouping of data. Many users already organize their indices this way, and the data stream naming scheme now provides this best practice as a default. Many users will populate this field with `default`. If no value is used, it falls back to `default`. Beyond the Elasticsearch index naming criteria noted above, `namespace` value has the additional restrictions:   \* Must not contain `-`   \* No longer than 100 characters | constant_keyword |
| data_stream.type | An overarching type for the data stream. Currently allowed values are "logs" and "metrics". We expect to also add "traces" and "synthetics" in the near future. | constant_keyword |
| event.dataset | Name of the dataset. If an event source publishes more than one type of log or events (e.g. access log, error log), the dataset is used to specify which one the event comes from. It's recommended but not required to start the dataset name with the module name, followed by a dot, then the dataset name. | constant_keyword |
| event.module | Name of the module this data is coming from. If your monitoring agent supports the concept of modules or plugins to process events of a given source (e.g. Apache logs), `event.module` should contain the name of this module. | constant_keyword |
| host.containerized | If the host is a container. | boolean |
| host.os.build | OS build information. | keyword |
| host.os.codename | OS codename, if any. | keyword |
| input.type | Type of Filebeat input. | keyword |
| log.flags | Flags for the log file. | keyword |
| log.offset | Offset of the entry in the log file. | long |
| okta.actor.alternate_id | Alternate identifier of the actor. | keyword |
| okta.actor.display_name | Display name of the actor. | keyword |
| okta.actor.display_name.text | Multi-field of `okta.actor.display_name`. | match_only_text |
| okta.actor.id | Identifier of the actor. | keyword |
| okta.actor.type | Type of the actor. | keyword |
| okta.authentication_context.authentication_provider | The information about the authentication provider. Must be one of OKTA_AUTHENTICATION_PROVIDER, ACTIVE_DIRECTORY, LDAP, FEDERATION, SOCIAL, FACTOR_PROVIDER. | keyword |
| okta.authentication_context.authentication_step | The authentication step. | integer |
| okta.authentication_context.credential_provider | The information about credential provider. Must be one of OKTA_CREDENTIAL_PROVIDER, RSA, SYMANTEC, GOOGLE, DUO, YUBIKEY. | keyword |
| okta.authentication_context.credential_type | The information about credential type. Must be one of OTP, SMS, PASSWORD, ASSERTION, IWA, EMAIL, OAUTH2, JWT, CERTIFICATE, PRE_SHARED_SYMMETRIC_KEY, OKTA_CLIENT_SESSION, DEVICE_UDID. | keyword |
| okta.authentication_context.external_session_id | The session identifier of the external session if any. | keyword |
| okta.authentication_context.interface | The interface used. e.g., Outlook, Office365, wsTrust | keyword |
| okta.authentication_context.issuer.id | The identifier of the issuer. | keyword |
| okta.authentication_context.issuer.type | The type of the issuer. | keyword |
| okta.authentication_context.root_session_id | The session identifier of the root if any. | keyword |
| okta.client.device | The information of the client device. | keyword |
| okta.client.id | The identifier of the client. | keyword |
| okta.client.ip | The IP address of the client. | ip |
| okta.client.user_agent.browser | The browser informaton of the client. | keyword |
| okta.client.user_agent.os | The OS informaton. | keyword |
| okta.client.user_agent.raw_user_agent | The raw informaton of the user agent. | keyword |
| okta.client.user_agent.raw_user_agent.text | Multi-field of `okta.client.user_agent.raw_user_agent`. | match_only_text |
| okta.client.zone | The zone information of the client. | keyword |
| okta.debug_context.debug_data |  | object |
| okta.debug_context.debug_data.authnRequestId | The authorization request ID. | keyword |
| okta.debug_context.debug_data.behaviors |  | keyword |
| okta.debug_context.debug_data.behaviors.New_City |  | keyword |
| okta.debug_context.debug_data.behaviors.New_Country |  | keyword |
| okta.debug_context.debug_data.behaviors.New_Device |  | keyword |
| okta.debug_context.debug_data.behaviors.New_Geo_Location |  | keyword |
| okta.debug_context.debug_data.behaviors.New_IP |  | keyword |
| okta.debug_context.debug_data.behaviors.New_State |  | keyword |
| okta.debug_context.debug_data.behaviors.Velocity |  | keyword |
| okta.debug_context.debug_data.behaviors.Velocity_Behavior |  | keyword |
| okta.debug_context.debug_data.client_secret |  | keyword |
| okta.debug_context.debug_data.device_fingerprint | The fingerprint of the device. | keyword |
| okta.debug_context.debug_data.dt_hash | The device token hash | keyword |
| okta.debug_context.debug_data.factor | The factor used for authentication. | keyword |
| okta.debug_context.debug_data.flattened | The complete debug_data object. | flattened |
| okta.debug_context.debug_data.grant_type |  | keyword |
| okta.debug_context.debug_data.granted_scopes |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.New_City |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.New_Country |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.New_Device |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.New_Geo_Location |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.New_IP |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.New_State |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.behaviors.Velocity |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.risk |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.risk.level |  | keyword |
| okta.debug_context.debug_data.logOnlySecurityData.risk.reasons |  | keyword |
| okta.debug_context.debug_data.originalPrincipal |  | keyword |
| okta.debug_context.debug_data.originalPrincipal.alternateId |  | keyword |
| okta.debug_context.debug_data.originalPrincipal.displayName |  | keyword |
| okta.debug_context.debug_data.originalPrincipal.id |  | keyword |
| okta.debug_context.debug_data.originalPrincipal.type |  | keyword |
| okta.debug_context.debug_data.promptingPolicyTypes |  | keyword |
| okta.debug_context.debug_data.request_id | The identifier of the request. | keyword |
| okta.debug_context.debug_data.request_uri | The request URI. | keyword |
| okta.debug_context.debug_data.requested_scopes |  | keyword |
| okta.debug_context.debug_data.risk |  | keyword |
| okta.debug_context.debug_data.risk.level |  | keyword |
| okta.debug_context.debug_data.risk.reasons |  | keyword |
| okta.debug_context.debug_data.risk_behaviors | The set of behaviors that contribute to a risk assessment. | keyword |
| okta.debug_context.debug_data.risk_level | The risk level assigned to the sign in attempt. | keyword |
| okta.debug_context.debug_data.risk_object |  | keyword |
| okta.debug_context.debug_data.risk_reasons | The reasons for the risk. | keyword |
| okta.debug_context.debug_data.threat_suspected | Threat suspected. | keyword |
| okta.debug_context.debug_data.tunnels |  | object |
| okta.debug_context.debug_data.url | The URL. | keyword |
| okta.debug_context.debug_data.url.text | Multi-field of `okta.debug_context.debug_data.url`. | match_only_text |
| okta.device.device_integrator |  | flattened |
| okta.device.disk_encryption_type | The value of the device profile’s disk encryption type. One of "NONE", "FULL", "USER", "ALL_INTERNAL_VOLUMES" or "SYSTEM_VOLUME". | keyword |
| okta.device.id | Identifier of the device. | keyword |
| okta.device.managed | Whether the device is managed. | boolean |
| okta.device.name | The name of the device. | keyword |
| okta.device.os_platform | The OS of the device. | keyword |
| okta.device.os_version | The device's OS version. | keyword |
| okta.device.registered | Whether the device is registered. | boolean |
| okta.device.screen_lock_type | The mechanism for locking the device's screen. One of "NONE", "PASSCODE" or "BIOMETRIC". | keyword |
| okta.device.secure_hardware_present | Whether there is secure hardware present on the device. This is a checks for chip presence: trusted platform module (TPM) or secure enclave. It does not mark whether there are tokens on the secure hardware. | boolean |
| okta.display_message | The display message of the LogEvent. | keyword |
| okta.event_type | The type of the LogEvent. | keyword |
| okta.outcome.reason | The reason of the outcome. | keyword |
| okta.outcome.result | The result of the outcome. Must be one of: SUCCESS, FAILURE, SKIPPED, ALLOW, DENY, CHALLENGE, UNKNOWN. | keyword |
| okta.request.ip_chain |  | flattened |
| okta.security_context.as.number | The AS number. | integer |
| okta.security_context.as.organization.name | The organization name. | keyword |
| okta.security_context.domain | The domain name. | keyword |
| okta.security_context.is_proxy | Whether it is a proxy or not. | boolean |
| okta.security_context.isp | The Internet Service Provider. | keyword |
| okta.severity | The severity of the LogEvent. Must be one of DEBUG, INFO, WARN, or ERROR. | keyword |
| okta.target.alternate_id | The alternate ID of the target. | keyword |
| okta.target.changeDetails.from.\* |  | object |
| okta.target.changeDetails.to.\* |  | object |
| okta.target.detailEntry.\* |  | object |
| okta.target.display_name | The display name of the target. | keyword |
| okta.target.id | The ID of the target. | keyword |
| okta.target.type | The type of target. | keyword |
| okta.transaction.detail.request_api_token_id | ID of the API token used in a request. | keyword |
| okta.transaction.detail.root_api_token_id | ID of the root API token. | keyword |
| okta.transaction.id | Identifier of the transaction. | keyword |
| okta.transaction.type | The type of transaction. Must be one of "WEB", "JOB". | keyword |
| okta.uuid | The unique identifier of the Okta LogEvent. | keyword |
| okta.version | The version of the LogEvent. | keyword |
