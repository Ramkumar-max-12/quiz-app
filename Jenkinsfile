pipeline {
   agent any
   environment {
       DOCKER_HUB_REPO = 'ramkumarmax12/quiz-app'
       DOCKER_HUB_CREDENTIALS_ID = 'dockerhub' // Add Docker credentials in Jenkins
   }
   stages {
       stage('Clone Repository') {
           steps {
               // Clone the repository
               git branch: 'master', url: 'https://github.com/Ramkumar-max-12/quiz-app.git'
           }
       }
       stage('Build Docker Image') {
           steps {
               // Build Docker image
               script {
                   docker.build("${DOCKER_HUB_REPO}:${env.BUILD_ID}")
               }
           }
       }
       stage('Push Docker Image') {
           steps {
               // Log in and push image to Docker Hub
               script {
                   docker.withRegistry('', DOCKER_HUB_CREDENTIALS_ID) {
                       docker.image("${DOCKER_HUB_REPO}:${env.BUILD_ID}").push()
                   }
               }
           }
       }
       stage('Deploy to Localhost') {
           steps {
               script {
                   // Run the app as a container and expose it on port 8080
                   sh "docker run -d -p 8080:3000 ${DOCKER_HUB_REPO}:${env.BUILD_ID}"
               }
           }
       }
   }
   post {
       always {
           // Clean up workspace and remove Docker images to free space
           cleanWs()
           script {
               sh "docker rmi ${DOCKER_HUB_REPO}:${env.BUILD_ID}"
           }
       }
   }
}
