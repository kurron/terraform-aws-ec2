#Overview
This is one project in a suite of cooperating projects that are used to simulate real world application deployments.  This
simulation is used to evaluate different application monitoring services as well as distributed logging solutions.

This project creates, but does not provision, an [AWS](http://aws.amazon.com/) [EC2](http://aws.amazon.com/ec2/) instance.  
The provision step is done via the [Ansible Provisioning Project](https://github.com/kurron/ansible-monitor-provision)

#Prerequisites

* [Terraform](https://terraform.io/) installed and working
* Development and testing was done on [Ubuntu Linux](http://www.ubuntu.com/)
* [SSH](http://www.openssh.com/) installed and working
* The environment variable `AWS_ACCESS_KEY_ID` set to your AWS Access Key ID 
* The environment variable `AWS_SECRET_ACCESS_KEY` set to your AWS Secret Access Key
* An AWS SSH Key Pair

#Building
This project is a collection of data files consumed by Terraform so there is nothing to build. 

#Installation
You need to export your AWS key information to the environment so that Terraform can pick them up and use them.  Typically, this is 
done via a simple export command.

* `export AWS_ACCESS_KEY_ID=AAAAAAAAAAAAAAAAAAAA`
* `export AWS_SECRET_ACCESS_KEY=AAAAAAAAAAAAAAAAAAAA`

You also need to have access to the private half of the AWS SSH key pair.  The file needs to be set to the correct permissions or 
SSH will refuse to run.  Typically this is done via the `chmod` command: `chmod 0400 private-half.pem`.

Finally, you'll need to edit the `variables.tf` and adjust the `key_name` variable to use your SSH Key Pair name.  You also need to
adjust the `key_path` variable to point to the private half of the SSH key pair.

#Tips and Tricks

##Creating The Virtual Hardware
To create a new environment, run `./create.sh` and you should have a new VPC with a single EC2 instance running that accepts all traffic 
from the internet.

##Verifying The Setup
Open the AWS console and grab the public ip address of the new EC2 instance and then run `./ssh-into-instance.sh` giving it the ip address 
as an argument.  If everything is correct, you should be ssh'ed into your newly created box.

##Start Over
If there is an error with configuration that prevents Terraform from completing its mission, run `./destroy.sh` to remove any assets that 
have been created.  You don't want to get charged for assets that you are not going to use!

#Troubleshooting

TODO

#License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

#List of Changes
