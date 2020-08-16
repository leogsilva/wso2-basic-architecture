
# module "edge-cluster" {
#   source = "../modules/eks-cluster"
#   region = "us-east-1"
#   cluster_name = "edge"
#   instance_types = ["t3.medium"]
# }

module "edge_certmanager_serviceaccount" {
  source = "../modules/eks-sa"
  role_name = "cert-manager"
  serviceaccount_name = "cert-manager:cert-manager  "
  region = "us-east-1"
  oidc_arn = "arn:aws:iam::721411679615:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/BBC0F777824971E21CFFC5C0CA08FF3C"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:GetChange",
            "Resource": "arn:aws:route53:::change/*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:ChangeResourceRecordSets",
                "route53:ListResourceRecordSets"
            ],
            "Resource": "arn:aws:route53:::hostedzone/*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        }
    ]
}
EOF
}