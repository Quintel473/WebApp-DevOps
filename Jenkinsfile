pipeline {
    agent any

    stages {
        stage('Clone Repository') {
            steps {
                // Clone the repository from GitHub, specifically the main branch
                git branch: 'main', url: 'https://github.com/Quintel473/WebApp-DevOps.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building the web page...'
                // Add commands for building if necessary, e.g., run a build script or install dependencies
                // Example:
                // sh 'npm install'  // If it's a Node.js project
                // sh 'npm run build'  // For building the project
            }
        }

        stage('Deploy to Docker') {
            steps {
                script {
                    // Build Docker image from the Dockerfile in the current directory
                    echo 'Building Docker image...'
                    docker.build('webapp-devops')  // Ensure the Dockerfile is in the root or specify its location

                    // Run the Docker container (you may need to configure ports and other options)
                    echo 'Deploying Docker container...'
                    docker.run('webapp-devops', '-d -p 8080:80')  // Example: map port 8080 to container port 80
                }
            }
        }
    }
}
