pipeline {
  agent any

  parameters {
    choice(name: 'ENVIRONMENT', choices: ['UAT', 'PROD'], description: 'Choose deployment environment')
    string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'Docker image tag')
  }

  environment {
    DOCKER_IMAGE = "your-dockerhub-username/dotnet-hello-world"
    DOCKER_CREDENTIALS = "dockerhub-cred-id"  // Jenkins credential ID
    SSH_CREDENTIALS = "ec2-ssh-key-id"       // Jenkins SSH key credential ID
    UAT_HOST = "ubuntu@<UAT_EC2_IP>"
    PROD_HOST = "ubuntu@<PROD_EC2_IP>"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          sh "docker build -t ${DOCKER_IMAGE}:${params.IMAGE_TAG} ."
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
            sh """
              echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
              docker push ${DOCKER_IMAGE}:${params.IMAGE_TAG}
            """
          }
        }
      }
    }

    stage('Deploy to EC2') {
      steps {
        script {
          def targetHost = (params.ENVIRONMENT == 'PROD') ? PROD_HOST : UAT_HOST

          sshagent([SSH_CREDENTIALS]) {
            sh """
              ssh -o StrictHostKeyChecking=no ${targetHost} '
                docker pull ${DOCKER_IMAGE}:${params.IMAGE_TAG} &&
                docker rm -f dotnet-hello-world || true &&
                docker run -d --name dotnet-hello-world -p 5000:5000 ${DOCKER_IMAGE}:${params.IMAGE_TAG} &&
                sleep 5 &&
                curl -f http://localhost:5000/api/hello
              '
            """
          }
        }
      }
    }
  }

  post {
    success {
      echo "Successfully deployed to ${params.ENVIRONMENT}"
    }
    failure {
      echo "Deployment failed"
    }
  }
}
