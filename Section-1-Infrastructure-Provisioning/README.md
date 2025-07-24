## Section 1 – Part 1: Shared Storage Layer

I updated the Terraform configuration found within the `Code` directory to provision three individual S3 buckets for Application logs, Service backups, Application data. These buckets have been configured to allow:

- Server-side encryption

- Versioning

- Blocking all public access


## Section 1 - Part 2: Access to S3 Buckets
I updated the Terraform configuration found within the `Code` directory to enable an EC2 instance to read from and write to the S3 buckets provisioned earlier. This involved:

- Creating an IAM role with the required permissions

- Attaching that role to the EC2 instance via an instance profile

- Ensuring the role allowed only object-level read and write access to all three buckets

<br> 

Additionally, I set up an IAM user attached to a group. This group has the access (through an IAM policy) to:

- Retrieve individual objects and object versions from the S3 buckets

- List all S3 buckets

<br>

This setup ensured both programmatic and instance-level access were handled securely and aligned with the principle of least privilege.