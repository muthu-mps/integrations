# AWS Billing

The AWS Billing integration allows you to monitor your [AWS spending](https://aws.amazon.com/aws-cost-management/aws-billing/).

Use the AWS Billing integration to collect metrics related to your monthly AWS bills. Then visualize that data in Kibana, create alerts to notify you if something goes wrong, and reference metrics when troubleshooting an issue.

For example, you could use this data to easily view your total estimated charges or billing by service. Then you can alert the relevant budget holder about those costs by email.

**IMPORTANT: Extra AWS charges on API requests will be generated by this integration. Check [API Requests](https://www.elastic.co/docs/current/integrations/aws#api-requests) for more details.**

## Limitations

When you want to group by a combination of several tags and dimensions, like `SERVICE` along with various tags (e.g., `team`, `project`, `aws:createdBy`), you might see duplicated data. This happens because of a [limitation](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_GetCostAndUsage.html) with the `GetCostAndUsage` API, which only allows grouping costs by two different groups.

To avoid data duplication, it's recommended to aggregate data using a combination of two attributes, which can be either: one tag and one dimension, two tags or two dimensions.

## Data streams

The AWS Billing integration collects one type of data: metrics.

**Metrics** give you insight into the state of your AWS spending, including the estimated costs for various AWS services. Metrics are gathered with the AWS [Cost Explorer API](https://docs.aws.amazon.com/cost-management/latest/userguide/ce-api.html)).

See more details in the [Metrics reference](#metrics-reference).

## Requirements

You need Elasticsearch for storing and searching your data and Kibana for visualizing and managing it.
You can use our hosted Elasticsearch Service on Elastic Cloud, which is recommended, or self-manage the Elastic Stack on your own hardware.

Before using any AWS integration you will need:

* **AWS Credentials** to connect with your AWS account.
* **AWS Permissions** to make sure the user you're using to connect has permission to share the relevant data.

For more details about these requirements, please take a look at the [AWS integration documentation](https://docs.elastic.co/integrations/aws#requirements).

## Setup

Use this integration if you only need to collect billing data from AWS.

If you want to collect data from two or more AWS services, consider using the **AWS** integration. When you configure the AWS integration, you can collect data from as many AWS services as you'd like.

For step-by-step instructions on how to set up an integration, see the
[Getting started](https://www.elastic.co/guide/en/starting-with-the-elasticsearch-platform-and-its-solutions/current/getting-started-observability.html) guide.

## Metrics reference

The `billing` data stream collects billing metrics from AWS.

An example event for `billing` looks as following:

An example event for `billing` looks as following:

```json
{
    "@timestamp": "2020-05-28T17:17:06.212Z",
    "agent": {
        "ephemeral_id": "17803f33-b617-4ce9-a9ac-e218c02aeb4b",
        "id": "12f376ef-5186-4e8b-a175-70f1140a8f30",
        "name": "MacBook-Elastic.local",
        "type": "metricbeat",
        "version": "8.0.0"
    },
    "aws": {
        "billing": {
            "AmortizedCost": {
                "amount": 51.6,
                "unit": "USD"
            },
            "BlendedCost": {
                "amount": 51.6,
                "unit": "USD"
            },
            "Currency": "USD",
            "EstimatedCharges": 39.26,
            "NormalizedUsageAmount": {
                "amount": 672,
                "unit": "N/A"
            },
            "ServiceName": "AmazonEKS",
            "UnblendedCost": {
                "amount": 51.6,
                "unit": "USD"
            },
            "UsageQuantity": {
                "amount": 168,
                "unit": "N/A"
            }
        }
    },
    "cloud": {
        "account": {
            "id": "428152502467",
            "name": "elastic-beats"
        },
        "provider": "aws",
        "region": "us-east-1"
    },
    "ecs": {
        "version": "8.11.0"
    },
    "event": {
        "dataset": "aws.billing",
        "duration": 1938760247,
        "module": "aws"
    },
    "metricset": {
        "name": "billing",
        "period": 43200000
    },
    "service": {
        "type": "aws"
    }
}
```

**ECS Field Reference**

Please refer to the following [document](https://www.elastic.co/guide/en/ecs/current/ecs-field-reference.html) for detailed information on ECS fields.

**Exported fields**

| Field | Description | Type | Metric Type |
|---|---|---|---|
| @timestamp | Event timestamp. | date |  |
| agent.id | Unique identifier of this agent (if one exists). Example: For Beats this would be beat.id. | keyword |  |
| aws.billing.AmortizedCost.amount | Amortized cost amount. | double | gauge |
| aws.billing.AmortizedCost.unit | Amortized cost unit. | keyword |  |
| aws.billing.BlendedCost.amount | Blended cost amount. | double | gauge |
| aws.billing.BlendedCost.unit | Blended cost unit. | keyword |  |
| aws.billing.Currency | Currency name. | keyword |  |
| aws.billing.EstimatedCharges | Maximum estimated charges for AWS acccount. | long | gauge |
| aws.billing.NormalizedUsageAmount.amount | Normalized usage amount. | double | gauge |
| aws.billing.NormalizedUsageAmount.unit | Normalized usage amount unit. | keyword |  |
| aws.billing.ServiceName | AWS service name. | keyword |  |
| aws.billing.UnblendedCost.amount | Unblended cost amount. | double | gauge |
| aws.billing.UnblendedCost.unit | Unblended cost unit. | keyword |  |
| aws.billing.UsageQuantity.amount | Usage quantity amount. | double | gauge |
| aws.billing.UsageQuantity.unit | Usage quantity unit. | keyword |  |
| aws.billing.end_date | End date for retrieving AWS costs. | keyword |  |
| aws.billing.group_by | Cost explorer group by key values. | object |  |
| aws.billing.group_by.fingerprint |  | keyword |  |
| aws.billing.group_definition.key | The string that represents a key for a specified group. | keyword |  |
| aws.billing.group_definition.type | The string that represents the type of group. | keyword |  |
| aws.billing.start_date | Start date for retrieving AWS costs. | keyword |  |
| aws.cloudwatch.namespace | The namespace specified when query cloudwatch api. | keyword |  |
| aws.linked_account.id | ID used to identify linked account. | keyword |  |
| aws.linked_account.name | Name or alias used to identify linked account. | keyword |  |
| aws.tags | Tag key value pairs from aws resources. | flattened |  |
| cloud.account.id | The cloud account or organization id used to identify different entities in a multi-tenant environment. Examples: AWS account id, Google Cloud ORG Id, or other unique identifier. | keyword |  |
| cloud.image.id | Image ID for the cloud instance. | keyword |  |
| data_stream.dataset | Data stream dataset. | constant_keyword |  |
| data_stream.namespace | Data stream namespace. | constant_keyword |  |
| data_stream.type | Data stream type. | constant_keyword |  |
| event.module | Event module | constant_keyword |  |
| host.containerized | If the host is a container. | boolean |  |
| host.os.build | OS build information. | keyword |  |
| host.os.codename | OS codename, if any. | keyword |  |

