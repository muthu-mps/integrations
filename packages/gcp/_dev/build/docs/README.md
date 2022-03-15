# Google Cloud Integration

## Overview

The Google Cloud integration collects and parses Google Cloud [Audit Logs](https://cloud.google.com/logging/docs/audit), [VPC Flow Logs](https://cloud.google.com/vpc/docs/using-flow-logs), [Firewall Rules Logs](https://cloud.google.com/vpc/docs/firewall-rules-logging) and [Cloud DNS](https://cloud.google.com/dns) logs that have been exported from Stackdriver to a Google Pub/Sub topic sink.

## Authentication

To use this Google Cloud Platform (GCP) integration, you need to set up a *Service Account* with a few *Roles*, and a *Service Account Key* to access data on your GCP project.

### Service Account

First, you need to [create a Service Account](https://cloud.google.com/iam/docs/creating-managing-service-accounts). A Service Account is special type of Google account intended to represent a non-human user that needs to access resources on the GCP.

The Service Account will be used by the Elastic Agent access data from the Google APIs.

### Roles

You need to grant your Service Account (SA) access to GCP resources adding one or more roles.

For this integration to work, you need need to add the following roles to your Service Account:

- `Compute Viewer`
- `Monitoring Viewer`
- `Pub/Sub Viewer`
- `Pub/Sub Subscriber`

Always follow the "priciple of least privilege" when adding a new role to your SA. If you haven't already, this might be a good time to check out the [best practices for securing service accounts](https://cloud.google.com/iam/docs/best-practices-for-securing-service-accounts) guide.

### Service Account Keys

Now, with your brand new Service Account (SA) with access to GCP resources, you need some credentials to assiciate with it: a Service Account Key.

From the list of SA:

1. Click the one you just created to open the detailed view.
2. From the Keys section, click Add key > Create new Key and select JSON as the type.
3. Download and store the generated private key securely (and remember, the private key can't be recovered from GCP, if lost).

Optional: ake some time to review the GCP's [best practices for managing service account keys](https://cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys).

## Configure the Integration Settings

The Project Id and either the Credentials File or Credentials Json will need to be provided in the integration UI when adding the Google Cloud Platform (GCP) integration.

The settings values that will be used for all logs from the supported services (Audit, DNS, Firewall and VPC Flows).

### Project Id

This is the ID of your Google Cloud project where the resources exist.

### Credentials File vs Json

Specify the information in either the Credentials File OR Credentials Json field, based on your preference.

#### Option 1: Credentials File

Save the JSON file with the private key in a secure location of the file system, and make sure that Elastic agent has at least read-only privileges to this file.

Specify the file path in the Credentials File field in the Elastic Agent GCP integration UI. For example: `/home/ubuntu/credentials.json`.

#### Option 2: Credentials Json

Specify the JSON content you downloaded from Google Cloud Platform directly in the Credentials Json field in the Elastic Agent integration.

#### Recommendations

Elastic recommends using Credentials File as this method, so the credential information doesn’t leave your Google Cloud Platform environment. When using Credentials Json, the integration stores the info in Elasticsearch, and the access is controlled based on policy permissions or access to underlying Elasticsearch data.

## Logs Collection Configuration

You need to create a few dedicated Google Cloud resources before start collecting logs.

You need one or more of the following:

- Log Sink
- Pub/Sub Topic
- Subscription

Elastic recommends separate Pub/Sub topics for each of the log types, so that they can be parsed and stored in a specific data stream.

Here’s an example on how to collect Audit Logs with a Pub/Sub topic and a subscription using Log Router in the Google cloud console.

At a high level the steps required are:

- Visit "Logging" > "Log Router" > "Create Sink" and provide a sink name and description.
- In "Sink destination", select "Cloud Pub/Sub topic" as the sink service. Select an existing topic or Create a topic. Note the topic name, as it will be provided in the Topic field in the Elastic agent configuration.
- If you created a new topic, then you must remember to go to that topic and create a subscription for it. A subscription directs messages on a topic to subscribers. Note the "Subscription ID", as it will need to be entered in the "Subscription name" field in the Elastic Agent configuration.
- Under "Choose logs to include in sink", for example add `logName:"cloudaudit.googleapis.com"` in the "Inclusion filter" to include all audit logs.

This is just an example, you will need to create your own filter expression to select the log types you want to export to the Pub/Sub topic.

## Logs

### Audit

The `audit` dataset collects audit logs of administrative activities and accesses within your Google Cloud resources.

{{fields "audit"}}

{{event "audit"}}

### Firewall

The `firewall` dataset collects logs from Firewall Rules in your Virtual Private Cloud (VPC) networks.

{{fields "firewall"}}

{{event "firewall"}}

### VPC Flow

he `vpcflow` dataset collects logs sent from and received by VM instances, including instances used as GKE nodes.

{{fields "vpcflow"}}

{{event "vpcflow"}}

### DNS

The `dns` dataset collects queries that name servers resolve for your Virtual Private Cloud (VPC) networks, as well as queries from an external entity directly to a public zone.

{{fields "dns"}}

{{event "dns"}}
