pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'quintelcharles021/webapp-devops'
    DOCKER_TAG   = 'latest'
    EC2_HOST     = '44.208.89.64'
    CONTAINER    = 'webapp-devops-container'
  }

  stages {
    stage('Checkout') {
      steps {
        // clean workspace then checkout
        cleanWs()
        checkout([
          $class: 'GitSCM',
          branches: [[ name: '*/main' ]],
          doGenerateSubmoduleConfigurations: false,
          extensions: [ [ $class: 'CleanBeforeCheckout' ] ],
          userRemoteConfigs: [[ url: 'https://github.com/Quintel473/WebApp-DevOps.git' ]]
        ])
      }
    }

    stage('Build Docker Image') {
      steps {
        script {
          docker.build(DOCKER_IMAGE)
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        script {
          docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-creds') {
            docker.image(DOCKER_IMAGE).push(DOCKER_TAG)
          }
        }
      }
    }

    stage('Deploy to AWS EC2') {
      steps {
        sshagent (credentials: ['ec2-ssh-key']) {
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
