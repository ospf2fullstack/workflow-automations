export AWS_PROFILE='gss-prod'
aws eks update-kubeconfig --name gss-eks-prod-cluster --profile gss-prod
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 851725382549.dkr.ecr.us-east-1.amazonaws.com