pipeline {
   agent any
   environment {
       // Docker Hub credentials and image details
       DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials') // Replace with your Jenkins credentials ID
       DOCKER_IMAGE = 'ramkumarmax12/quiz-app'            // Replace with your Docker Hub repository name
   }
   stages {
       stage('Clone Repository') {
           steps {
               // Clone the GitHub repository
               git 'https://github.com/Ramkumar-max-12/quiz-app.git' // Replace with your GitHub repository URL
           }
       }
       stage('Install Dependencies') {
           steps {
               script {
                   // Install Node.js dependencies
                   sh 'npm install'
               }
           }
       }
       stage('Run Tests') {
           steps {
               script {
                   // Run tests if available
                   sh 'npm test'
               }
           }
       }
       stage('Build Docker Image') {
           steps {
               script {
                   // Build Docker image using a unique tag for each build
                   sh 'docker build -t $DOCKER_IMAGE:${env.BUILD_ID} .'
               }
           }
       }
       stage('Push Docker Image to Docker Hub') {
           steps {
               script {
                   // Log in to Docker Hub
                   sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                   // Push Docker image to Docker Hub
                   sh 'docker push $DOCKER_IMAGE:${env.BUILD_ID}'
               }
           }
       }
       stage('Deploy') {
           steps {
               script {
                   // Stop any existing container with the same name
                   sh 'docker stop quiz-app || true && docker rm quiz-app || true'
                   // Run Docker container and expose it on port 8080
                   sh 'docker run -d -p 8080:3000 --name quiz-app $DOCKER_IMAGE:${env.BUILD_ID}'
               }
           }
       }
   }
   post {
       always {
           // Clean up Docker images created during the build process
           script {
               sh 'docker rmi $DOCKER_IMAGE:${env.BUILD_ID} || true'
           }
       }
       success {
           echo 'Build and deployment successful!'
       }
       failure {
           echo 'Build or deployment failed.'
       }
   }
}
