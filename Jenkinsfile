pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'quintelcharles021/WebApp-DevOps'
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/Quintel473/WebApp-DevOps.git'
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
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image(DOCKER_IMAGE).push(DOCKER_TAG)
                    }
                }
            }
        }

        stage('Deploy to AWS EC2') {
            steps {
                script {
                    // Add your deploy script here, like SSH or using ECS to deploy
                    sh 'echo "Deploying to AWS EC2 instance"'
                }
            }
        }
    }
}
