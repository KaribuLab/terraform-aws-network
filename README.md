```shell
terraform init -backend-config="bucket=tf-aws-vpc-module" -backend-config="key=terraform"
```

```shell
terraform apply --auto-approve
```