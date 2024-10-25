pipeline {
   agent any
   environment {
       DOCKERHUB_CREDENTIALS = credentials('dockerhub-credentials')
       DOCKER_IMAGE = 'ramkumarmax12/quiz-app'
   }
   stages {
       stage('Clone Repository') {
           steps {
               git 'https://github.com/Ramkumar-max-12/quiz-app.git'
           }
       }
       stage('Check Node Version') {
           steps {
               sh 'node --version'
           }
       }
       stage('Install Dependencies') {
           steps {
               script {
                   // Add 'sudo' if permissions are an issue
                 
                   sh 'sudo npm install'
               }
           }
       }
       stage('Build Docker Image') {
           steps {
               script {
                   // Debug Docker command
                   sh 'docker version'
                   sh 'docker build -t $DOCKER_IMAGE:${env.BUILD_ID} .'
               }
           }
       }
       stage('Push to Docker Hub') {
           steps {
               script {
                   // Log in to Docker Hub and push image
                   sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                   sh 'docker push $DOCKER_IMAGE:${env.BUILD_ID}'
               }
           }
       }
       stage('Deploy') {
           steps {
               script {
                   // Stop and deploy the Docker container
                   sh 'docker stop quiz-app || true && docker rm quiz-app || true'
                   sh 'docker run -d -p 7000:80 --name quiz-app $DOCKER_IMAGE:${env.BUILD_ID}'
               }
           }
       }
   }
   post {
       always {
           // Clean up
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
