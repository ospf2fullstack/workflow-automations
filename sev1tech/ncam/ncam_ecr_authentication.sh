export AWS_PROFILE='default'
aws eks update-kubeconfig --name gss-eks-prod-cluster --profile default
aws ecr get-login-password --region us-gov-west-1 | docker login --username AWS --password-stdin 052330603252.dkr.ecr.us-gov-west-1.amazonaws.com