# AUTOMATE INFRASTRUCTURE WITH IAC USING TERRAFORM. PART 4 – TERRAFORM CLOUD

## Migrate `.tf `codes to Terraform Cloud

1. Create a Terraform Cloud account - Follow this [link](https://app.terraform.io/public/signup/account), create a new account, verify your email. Most of the features are free, but if you want to explore the difference between free and paid plans – you can check it on this [page](https://www.hashicorp.com/products/terraform/pricing).

2. Create an organization. Select "Start from scratch", choose a name for your organization and create it.

3. Configure a workspace. Chose version control workflow to run Terraform commands triggered from our git repository.


![Terraform workspace](./media/tfworkspace.png)

4. Create a new repository in your GitHub and call it terraform-cloud(or whatever you like), push the current Terraform codes we have been developing from project 16 to the repository.

5. Choose version control workflow and you will be prompted to connect your GitHub account to your workspace – follow the prompt and add your newly created repository to the workspace.

6. Move on to "Configure settings", provide a description for your workspace and leave all the rest settings default, click "Create workspace".

7. Configure variables - Terraform Cloud supports two types of variables: environment variables and Terraform variables. Either type can be marked as sensitive, which prevents them from being displayed in the Terraform Cloud web UI and makes them write-only. Set two environment variables: `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`, set the values that you used in Project 16. These credentials will be used to provision your AWS infrastructure by Terraform Cloud.


![Terraform variables](./media/tfvariables.png)

8. Add the AMI files for building packer images and the Ansible scripts to configure the infrastucture. Before you proceed ensure you have the following tools installed on your local machine;

- Packer
- Ansible

![Packer](./media/packer.png)


9. Run `terraform plan` and `terraform apply` from web console. Switch to "Runs" tab and click on "Queue plan manualy" button. If planning has been successfull, you can proceed and confirm Apply – press "Confirm and apply", provide a comment and "Confirm plan".


![Terraform plan](./media/tfplan.png)

![Terraform apply](./media/tfapply.png)

![Terraform apply](./media/tfapply2.png)

10. Check the logs and verify that everything has run correctly. Note that Terraform Cloud has generated a unique state version that you can open and see the codes applied and the changes made since the last run.


![Terraform state](./media/tfstates.png)


11. Check for the resources created. 

![Terraform resources](./media/resources.png)

![Resources](./media/ec2.png)

![Resources](./media/efs.png)

![Resources](./media/rds.png)

![Resources](./media/asg.png)

![Resources](./media/tg.png)

![Resources](./media/route53.png)

## Configuring The Infrastructure With Ansible

- After a successfully executing terraform apply, connect to the bastion server through ssh-agent to run ansible against the infrastructure:

![SSH into bastion](./media/bastionssh.png)

- Clone the ansible [repo](https://gitlab.com/enyioma/ansible-deploy-pbl-19.git).

![Clone repo](./media/ansiclone.png)

- Update the nginx.conf.j2 file to input the internal load balancer dns name generated via terraform. 

![Nginx configure](./media/nginxconf.png)


- Update the RDS endpoints, Database name, password and username in the `task/setup-db.yml` file for both the tooling and wordpress roles:


![RDS configure](./media/rdsconfig.png)



- Also update the EFS access points for both tooling and wordpress servers in `task/main.yml` of the respective roles.


Confirm that the apps are running at the backend:


![Curl host](./media/curlhost.png)


![Curl host](./media/curlhost3.png)


-Verify inventory with the following code:

```
ansible-inventory -i inventory/aws_ec2.yml --graph
```

![Ansible inventory](./media/ansierror.png)

I had a blocker: "The ec2 dynamic inventory plugin requires boto3 and botocore".

I resolved it with:

```
sudo python3.8 -m pip install boto3 botocore
```

![Ansible inventory](./media/ansigraph.png)


- Export the environment variable ANSIBLE_CONFIG to point to the `ansible.cfg` from the repo then run the ansible-playbook command: `ansible-playbook -i inventory/aws_ec2.yml playbook/site.yml`.


![Config export](./media/ansiexport.png)


- Update the target groups and push the repo:


![Tg update](./media/cicd.png)


![Tg update](./media/tgmodification.png)


Check the url endpoints:


![Tooling up](./media/toolingup.png)

![Wordpress up](./media/wordpressup.png)

![Tg update](./media/wordpressup2.png)


Here is the Terraform [repo](https://gitlab.com/enyioma/terraform-project18.git) while [this](https://gitlab.com/enyioma/ansible-deploy-pbl-19.git) is that of Ansible.