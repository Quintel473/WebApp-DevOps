pipeline {
  agent any

  environment {
    DOCKER_IMAGE = 'quintelcharles021/webapp-devops'
    DOCKER_TAG   = 'latest'
    EC2_HOST     = '44.208.89.64'
    CONTAINER    = 'webapp-devops-container'
    HOST_PORT    = '8081'              // ← new
  }

  stages {
    stage('Checkout') {
      steps {
        cleanWs()
        checkout([
          $class: 'GitSCM',
          branches: [[ name: '*/main' ]],
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
        withCredentials([sshUserPrivateKey(
          credentialsId: 'ec2-ssh-key',
          keyFileVariable: 'KEYFILE',
          usernameVariable: 'SSH_USER'
        )]) {
          sh """
            ssh -i \$KEYFILE -o StrictHostKeyChecking=no \$SSH_USER@\$EC2_HOST \\
              "docker pull ${DOCKER_IMAGE}:${DOCKER_TAG} && \\
               docker rm -f ${CONTAINER} || true && \\
               docker run -d -p ${HOST_PORT}:80 --name ${CONTAINER} ${DOCKER_IMAGE}:${DOCKER_TAG}"
          """
        }
      }
    }
  }

  post {
    success { echo '✔ Pipeline succeeded — app is deployed on port ' + env.HOST_PORT }
    failure { echo '✘ Pipeline failed. Check the logs above.' }
  }
}
