pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/Quintel473/WebApp-DevOps.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the web page...'
                // Add commands for building if necessary
            }
        }

        stage('Deploy to Docker') {
            steps {
                script {
                    // Docker build and run commands
                    docker.build('WebApp-DevOps')
                    docker.run('WebApp-DevOps')
                }
            }
        }
    }
}
