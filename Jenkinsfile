pipeline {
  agent any

  environment {
    // ← your Docker Hub image (all lowercase)
    DOCKER_IMAGE = 'quintelcharles021/webapp-devops'
    DOCKER_TAG   = 'latest'

    // ← your EC2 public or Elastic IP
    EC2_HOST     = '44.208.89.64'

    // name for the container on EC2
    CONTAINER    = 'webapp-devops-container'
  }

  stages {
    stage('Checkout') {
      steps {
        // correctly clean & checkout the main branch
        git branch: 'main',
            url:    'https://github.com/Quintel473/WebApp-DevOps.git',
            clean:  true
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          // builds: docker build -t quintelcharles021/webapp-devops .
          docker.build(DOCKER_IMAGE)
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          // uses the 'docker-hub-credentials' id in Jenkins
          docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            docker.image(DOCKER_IMAGE).push(DOCKER_TAG)
          }
        }
      }
    }

    stage('Deploy to AWS EC2') {
      steps {
        // ssh-agent wrapper for your EC2 SSH key credential
        sshagent (credentials: ['ec2-ssh-key']) {
          // SSH into EC2, pull the new image, remove old container, run new one
          sh """
            ssh -o StrictHostKeyChecking=no ec2-user@\$EC2_HOST \\
              'docker pull \$DOCKER_IMAGE:\$DOCKER_TAG && \\
               docker rm -f \$CONTAINER || true && \\
               docker run -d -p 80:80 --name \$CONTAINER \$DOCKER_IMAGE:\$DOCKER_TAG'
          """
        }
      }
    }
  }

  post {
    success {
      echo '✔ Pipeline succeeded — app is deployed!'
    }
    failure {
      echo '✘ Pipeline failed. Check the logs above.'
    }
  }
}
