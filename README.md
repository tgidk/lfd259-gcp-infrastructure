This example sets up 2 Google Compute Engine instances with Ubuntu-20.04 lts on the Google Cloud Platform (GCP) in a VPC in the northamerica-south1 (the cheapest GCP region as of this writing) with Terraform. 

With this HCL students can quickly apply and destroy their cloud infrastructure to save costs.

The infrastructure is as specified in the LFS259 Certified Kubernetes Application Developer course from The Linux Foundation. 

Access to the infrastructure has been tested on Windows 11 with Git Bash/Terminal and SSH (instead of using Putty).

--- to create a new SSH key pair using Git Bash:
```
ssh-keygen -t rsa -f ~/.ssh/KEY_FILENAME -C USERNAME
```

--- build GCP infrastructure for k8s from your home-dir:
```
terraform -chdir=source/projects/lfd259-gcp-infrastructure/ initfmt
terraform -chdir=source/projects/lfd259-gcp-infrastructure/ fmt
terraform -chdir=source/projects/lfd259-gcp-infrastructure/ validate
terraform -chdir=source/projects/lfd259-gcp-infrastructure/ apply
```

--- ssh to GCP vm using Git Bash:
```
ssh -i ~/.ssh/PRIVATE_KEY_FILENAME USERNAME@<IP-address-of-VM-here>
```

--- destroy GCP infrastructure:
```
terraform -chdir=source/projects/lfd259-gcp-infrastructure/ destroy
```



