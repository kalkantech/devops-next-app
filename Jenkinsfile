pipeline {
    // agent {
    //     docker { image 'docker' }
    // }
    agent any
    environment { 
        CC = 'clang'
        GIT_SSL_NO_VERIFY = true
        // Credentials bound in OpenShift
		GIT_CREDS = credentials("${OPENSHIFT_BUILD_NAMESPACE}-git-auth")
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '1'))
		timeout(time: 15, unit: 'MINUTES')
		// ansiColor('xterm')
    }
    stages {
        stage('Prepare') {
            steps {
                echo 'Preparing..'
                script {
                    env.APP_VERSION = sh(returnStdout: true, script: "npm run version --silent").trim()
                }
            }
            post {
                success {
                    script {
                        echo 'Stage success'
                    }
                }
                failure {
                    script {
                        echo 'Pipeline failure'
                    }
                }
            }
        }
        stage('Build App') {
            steps {
                echo 'Building App..'
            }
        }
        stage('Build Image') {
            steps {
                echo 'Building Image..'
                sh '''
                    docker build -t shield07/devops-next-app:${APP_VERSION} .
                    docker push shield07/devops-next-app:${APP_VERSION}
                    #docker rmi -f shield07/devops-next-app:${APP_VERSION}
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}