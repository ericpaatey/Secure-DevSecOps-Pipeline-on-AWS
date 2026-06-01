pipeline {

    agent any

    environment {
        IMAGE_NAME = "devsecops-app"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('SonarQube Scan') {
            steps {
                sh '''
                sonar-scanner
                '''
            }
        }

        stage('Dependency Scan') {
            steps {
                sh '''
                chmod +x scripts/dependency-scan.sh
                ./scripts/dependency-scan.sh
                '''
            }
        }

        stage('Secrets Detection') {
            steps {
                sh '''
                chmod +x scripts/secrets-scan.sh
                ./scripts/secrets-scan.sh
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Container Scan') {
            steps {
                sh '''
                chmod +x scripts/image-scan.sh
                ./scripts/image-scan.sh
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                dir('terraform') {
                    sh 'terraform init'
                    sh 'terraform apply -auto-approve'
                }
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh '''
                kubectl apply -f kubernetes/
                '''
            }
        }
    }

    post {
        failure {
            echo 'Pipeline failed due to security policy violation.'
        }
    }
}