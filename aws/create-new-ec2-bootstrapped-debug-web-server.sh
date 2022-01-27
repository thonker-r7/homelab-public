#!/bin/bash
# Tim H 2020

# bail if any errors
set -e

export AWS_REGION="us-east-1"
export INSTANCE_TYPE="t2.large"					# size so InsightVM will pick it up (large and above)
export AMI="ami-09d95fab7fff3776c"					# Amazon Linux 2 64bit
export KEYPAIR="aws-marketplace-testing1"			# SSH Keypair to be used
export BOOTSTRAP_SCRIPT_FILENAME="file://../presales-engineering-tim-dev/bootstraps/bootstrap-amazonlinux2-web-server.sh"
export SECURITY_GROUP="sg-xxxxxxxxxxxxxxxx"		# My default one, only from home and work
export SUBNET_ID="subnet-xxxxxxxxxxxxxxxxx"		# Default VPC, us-east-1a (use1-az4)
export COUNTER_FILE="$HOME/.counter.dat"
export ROUTE_53_DNS_RECORD_TO_USE="redacted.com" # a domain that is registered with AWS ROUTE 53
export ROUTE_53_DNS_SERVER="ns-XXX.awsdns-XX.net"  # FQDN of the AWS Route 53 DNS server used for $ROUTE_53_DNS_RECORD_TO_USE

./create-new-ec2-bootstrapped-server.sh "$BOOTSTRAP_SCRIPT_FILENAME"
