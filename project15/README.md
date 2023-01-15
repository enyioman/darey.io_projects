# AWS Cloud Solution For 2 Company Websites Using Reverse Proxy Technology


This project demonstrates how a secure infrastructure inside AWS VPC (Virtual Private Cloud) network is built for a particular company, which uses WordPress CMS for its main business website, and a Tooling Website for their DevOps team. As part of the company’s desire for improved security and performance, a decision has been made to use a reverse proxy technology from NGINX to achieve this. The infrastructure will look like the following diagram:


![Project architecture](./media/archy.png)

Steps taken:

1. Set up Organisation Unit and a Sub-account. 

2. Create and configure an AWS VPC.

3. Set up compute resources.

4. Create TLS Certificates from Amazon Certificate Manager(ACM).

5. Configure Application Load Balancers(ALB). 

6. Setup EFS and RDS. 

7. Configure DNS with Route53.


Full documentation is located [here](https://github.com/enyioman/project15/blob/main/project15.md).

