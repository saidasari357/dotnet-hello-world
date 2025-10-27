
1. Objective
Automated the build and deployment of a Dockerized .NET Core API using Jenkins and Docker
Hub, deployed on AWS EC2 instances.
2. Repository Links
GitHub Repository https://github.com/saidasari357/dotnet-hello-world.git
Docker Hub Repository https://hub.docker.com/repository/docker/saidasari357/dotnet-hello-world/gDeployment Deployed successfully to UAT/PROD
3. Jenkins Pipeline Overview
The Jenkins pipeline automates build and deployment through the following stages:
• Checkout source code from GitHub.
• Build Docker image using Dockerfile.
• Push Docker image to Docker Hub.
• Deploy to AWS EC2 (UAT or PROD based on parameters).
• Perform health check verification using curl command.
Pipeline Parameters
• ENVIRONMENT – allows selection between UAT and PROD.
• IMAGE_TAG – specifies the version tag for the Docker image.
4. Tools & Technologies Used
Category Tool
CI/CD Jenkins
Containerization Docker
Cloud Platform AWS EC2
Source Control GitHub
.NET Framework .NET Core 2.1
5. Summary
Successfully implemented and tested a CI/CD pipeline that builds and deploys a .NET Core API
using Docker and Jenkins. The pipeline integrates with Docker Hub and AWS EC2 for automated
deployment across UAT and Production environments.
6. Remarks
All tasks have been completed successfully. The application has been built, containerized, pushed
to Docker Hub, and deployed to AWS EC2 environments. This demonstrates end-to-end DevOps
automation skills involving CI/CD, container orchestration, and AWS cloud infrastructure
