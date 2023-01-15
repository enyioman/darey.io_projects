# Continuous Integration with Jenkins | Ansible | Artifactory | SonarQube | PHP


In this project, the concept of CI/CD is implemented whereby a php application from github is pushed to Jenkins to run a multi-branch pipeline job(build job is run on each branch of a repository simultaneously) which is better viewed from Blue Ocean plugin. This is done in order to achieve continuous integration of codes from different developers. After which the artifacts from the build job is packaged and pushed to sonarqube server for testing before it is deployed to artifactory from which ansible job is triggered to deploy the application to production environment.

The following are the steps taken to achieve this:

- Configure Ansible for Jenkins deployment.

- Set up the Artifactory server.

- Integrate Artifactory repository with Jenkins.

- Structure the Jenkinsfile.

- Set up the SonarQube server.

- Configure Jenkins for SonarQube Quality Gate.

- Run the pipeline job.

- Run the pipeline job with 2 Jenkins agents/slaves(nodes).