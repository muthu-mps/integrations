# Google Cloud Integration

The Google Cloud integration collects and parses Google [Cloud Audit Logs](https://cloud.google.com/logging/docs/audit), [VPC Flow Logs](https://cloud.google.com/vpc/docs/using-flow-logs), [Firewall Rules Logs](https://cloud.google.com/vpc/docs/firewall-rules-logging) and [Cloud DNS](https://cloud.google.com/dns) logs that have been exported from Stackdriver to a Google Pub/Sub topic sink.


## Authentication

To use this Google Cloud Platform (GCP) integration, you need to set up a [Service Account](https://cloud.google.com/iam/docs/understanding-service-accounts) with a few [Roles](https://cloud.google.com/iam/docs/viewing-grantable-roles) and a [Service Account Key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) to access data on your GCP project.

### Service Account

First, you need to [create a Service Account](https://cloud.google.com/iam/docs/creating-managing-service-accounts). A Service Account is special type of Google account intended to represent a non-human user that needs to access resources on the Google Cloud Platform (GCP).

The Service Account will be used by the Elastic Agent access data from the Google APIs.

### Roles

You need to grant your Service Account access to GCP resources adding one or more roles.

For this integration to work, you need need to add the following roles to your Service Account:

- Compute Viewer
- Monitoring Viewer
- Pub/Sub Viewer
- Pub/Sub Subscriber

If you haven's already, this might be a good time to check out the [best practices for securing service accounts](https://cloud.google.com/iam/docs/best-practices-for-securing-service-accounts).

### Service Account Keys

Now, with your brand new Service Account with access to GCP resources, you need some credentials to assiciate with it: a Service Account Key.

Open your Service Account, create a new key, download and store the generated private key securely. The private key can't be recovered from GCP, if lost.

When adding an additional role, please always follow the [priciple of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege), and take some time to review the GCP's [best practices for managing service account keys](https://cloud.google.com/iam/docs/best-practices-for-managing-service-account-keys).

## Configure the Integration Settings

The Integration Settings require you to enter a few values that will be used for all services (audit, DNS, firewall and vpcflows logs).

The Project Id and either the Credentials File or Credentials Json will need to be provided in the integration UI when adding the Google Cloud Platform (GCP) integration.

### Project Id

This is the ID of your GCP project where the resources exist.

### Credentials File vs Json

Specify the information in either the Credentials File OR Credentials Json field based on your preference.

#### Option 1: Credentials File

Save the JSON file with the private key in a secure location, and make sure that Elastic agent has at least read-only privileges to this file.

Specify the file path in the Credentials File field in the Elastic Agent GCP integration UI.

Example: "/home/ubuntu/credentials.json"

#### Option 2: Credentials Json

Specify the JSON content you downloaded from Google Cloud Platform directly in the Credentials Json field in the Elastic Agent integration.

#### Recommendations

Elastic recommends using Credentials File as in this method, so the credential information doesn’t leave your Google Cloud Platform environment. When using Credentials Json the information is stored in Elasticsearch, and the access is controlled based on policy permissions or access to underlying Elasticsearch data.
