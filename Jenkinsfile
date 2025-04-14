// springboot-crud-k8s-mysql-cicd-master-branch

pipeline {
    agent any

    environment {
        IMAGE_NAME = "spring-boot-crud-mysql-k8s-example-2"
        IMAGE_TAG = "master-${BUILD_NUMBER}"    // or use BRANCH_NAME if you split pipelines
        DOCKERHUB_USER = "sayantan2k21"
    }

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/Sayantan2k24/spring-boot-crud-mysql-k8s-example02.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([string(credentialsId: 'dockerhub_cred', variable: 'DOCKERHUB_TOKEN')]) {
                    script {
                        sh """
                            echo "$DOCKERHUB_TOKEN" | docker login -u "${DOCKERHUB_USER}" --password-stdin
                            docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                            docker push ${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}
                        """
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Inject environment variables into deployment YAML using envsubst
                    sh """
                        export DOCKERHUB_USER=${DOCKERHUB_USER}
                        export IMAGE_NAME=${IMAGE_NAME}
                        export IMAGE_TAG=${IMAGE_TAG}
                        envsubst < app-deployment.yaml > app-deployment-rendered.yaml
                    """

                    // Apply manifests
                    sh 'kubectl apply -f mysql-configMap.yaml'
                    sh 'kubectl apply -f mysql-secrets.yaml'
                    sh 'kubectl apply -f mysql-deployment.yaml'
                    sh 'kubectl apply -f app-deployment-rendered.yaml'
                    sh 'kubectl apply -f ingress.yaml'
                }
            }
        }
    }

    post {
        success {
            echo '🚀 Deployment successful!'
        }
        failure {
            echo '❌ Something went wrong.'
        }
    }
}
