# Google Cloud Integration

The Google Cloud integration collects and parses Google Cloud Audit, VPC flow, Firewall and DNS logs that have been exported from Stackdriver to a Google Pub/Sub topic sink.


## Authentication

To use this Google Cloud Platform (GCP) integration, you need to set up a Service Account with a few roles and a key to access data on your GCP project.

### Service Account

You need to create a [Service Account](https://cloud.google.com/iam/docs/understanding-service-accounts), a special type of Google account intended to represent a non-human user that needs to access resources on the Google Cloud Platform (GCP).

The Service Account will be used by the Elastic Agent access data from the Google APIs.

### Roles

You need to grant your Service Accoutn access to GCP resources adding one or more roles.

For this integration to work, you need need to add the following roles:

- Compute Viewer
- Monitoring Viewer
- Pub/Sub Viewer
- Pub/Sub Subscriber

If you haven's already, this might be a good time to check out the [best practices for securing service accounts](https://cloud.google.com/iam/docs/best-practices-for-securing-service-accounts).

### Keys

Now, with your brand new Service Account with access to GCP resources, you need some credentials to assiciate with it: a key.

Open you Service Account, create a new key, download and store the generate private key securely. The key can't be recovered from GCP, if lost.

## Configure Integration Settings

The Integration Settings require you to enter a few values that will be used for all services (audit, DNS, firewall and vpcflows logs).

The Project Id and either the Credentials File or Credentials Json will need to be provided in the integration UI when adding the Google Cloud Platform (GCP) integration.

### Project Id

This is the ID of your GCP project where the resources exist.

### Credentials Json vs File

Specify the information in either the Credentials File OR Credentials Json field based on your preference.

#### Credentials Json

Specify the JSON content you downloaded from GCP directly in the Credentials Json field in the Elastic Agent integration.

#### Credentials File

Save the credentials file in a secure location and make sure that Elastic agent has at least read only privileges to this file.

Specify the file path in the Credentials File field in the Elastic Agent GCP integration UI.

Example: "/home/ubuntu/credentials.json"

**Note**: Elastic recommends using Credentials File as in this method, so the credential information doesn’t leave your Google cloud platform environment. When using Credentials Json the information is stored in Elasticsearch, and the access is controlled based on policy permissions or access to underlying Elasticsearch data.


***

You also need one Service Account Key, which are the credentials associated with the Service Account.

Please, always follow the least privilege principle and review the GCP's [best practices for managing service account keys](https://cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys).


To learn more about Google Cloud Platform authentication, check out the following resources:

- [Authentication overview](https://cloud.google.com/docs/authentication)
