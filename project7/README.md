# IMPLEMENTATION OF WEB APPLICATION ARCHITECTURE WITH A SINGLE DATABASE AND NFS SERVER

In this project, I implemented a DevOps tooling website solution which makes access to DevOps tools with the following components:

- Infrastructure: AWS

- 3 Linux Webservers: Red Hat Enterprise Linux 8 that will serve the DevOps tooling website.

- A Database Server: Ubuntu 20.04 for reads and write.

- A Storage Server: Red Hat Enterprise Linux 8 that will serve as NFS Server for storing shared files that the 3 Web Servers will use.

- Programming Language: PHP

- Code Repository: GitHub

The following are the steps I took to set up this 3-tire Web Application Architecture with a single database and an NFS server as a shared file storage:

- Prepare the servers to be used.
- Set up the NFS Server.
- Create and Mount logical volumes on the EC2 Instance for the NFS Server.
- Configure the NFS Server.
- Configure the Webservers.


The website will display a dashboard of some of the most useful DevOps tools as listed below:

- Jenkins
- Kubernetes
- JFrog Artifactory
- Rancher
- Docker
- Grafana
- Prometheus
- Kibana

