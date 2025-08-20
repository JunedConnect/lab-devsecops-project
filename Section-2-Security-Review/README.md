Potential Security/Operational issues noted with the current Terraform files found within the `code` directory:

<br>

1.  **Issue**: S3 Bucket having no server-side encryption enabled

    **Potential Impact**: This coupled in with issue #2, it means that literally anyone who accesses the bucket can read it's contents, of which is personal identifiable information. There is also the possibility of Amazon being able to view the data, as it (and the S3 bucket itself) is hosted on their servers.

    **How to resolve**: Enable server-side encryption on the S3 Bucket.

<br>

2.  **Issue**: S3 Bucket has no ACL to block public access to the data.

    **Potential Impact**: This coupled in with issue #1, it means that literally anyone who accesses the bucket can read it's contents, of which is personal identifiable information.

    **How to resolve**: Block public access to the S3 Bucket through ACLs.

<br>

3.  **Issue**: aws_api_gateway_method resource block has no authorisation method enabled.

    **Potential Impact**: Due to no layer of authorisation, there is no way of controlling the level of access to the gateway, meaning someone, who should be having elevated access to it, will have unrestricted access to it.

    **How to resolve**: Use a method of authorisation e.g. IAM, to control what a person/entity can do with the gateway.

<br>

4.  **Issue**: No CloudWatch / CloudTrail / S3 Bucket Access Logging enabled

    **Potential Impact**: No accountability, as to who is performing actions with the different services, can lead to unauthorised actions being performed, that will go unnoticed. There is also no monitoring of metrics for services, why may present problems if a service is being used maliciously, that will go unnoticed as things such as performance metrics will not be logged.

    **How to resolve**: Enable CloudWatch and CloudTrail for services, and Access Logging for S3 Bucket.

<br>

5.  **Issue**: No S3 Bucket Versioning / Object Locking

    **Potential Impact**: Accidental deletion/alteration of objects (due to no Object Locking) cannot be recovered (due to no S3 Bucket Versioning).

    **How to resolve**: Enable S3 bucket versioning / Object Locking.

<br>

6.  **Issue**: No routine reports on S3 Bucket.

    **Potential Impact**: There is no routine updating on details for S3 Bucket (including those relating to security such as encryption status). This gives less visibility to what is going on with your data.

    **How to resolve**: Enable Inventory Configuration for S3 Bucket.

<br>

7.  **Issue**: No monitoring of policies related to S3 Bucket and Lambda

    **Potential Impact**: Not being aware of any policy changes that may occur, leading to unauthorised access to the service.

    **How to resolve**: Enable IAM Access Analyser.

<br>

8.  **Issue**: No backup / Replication of S3 Bucket

    **Potential Impact**: No redundancy if bucket was to be deleted / unavailable.

    **How to resolve**: Enable Replication Rules, allowing replication of bucket in different regions.

<br>

9.  **Issue**: No Intelligent Tiering for S3 Bucket

    **Potential Impact**: Unwanted costs due to the frequency that the bucket is accessed.

    **How to resolve**: Enable Intelligent Tiering for S3 Bucket.