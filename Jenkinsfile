pipeline {
    // agent {
    //     docker { image 'docker' }
    // }
    agent any
    environment { 
        CC = 'clang'
        GIT_SSL_NO_VERIFY = true
        APP_REPO = "shield07"
        // Credentials bound in OpenShift
		// GIT_CREDS = credentials("${OPENSHIFT_BUILD_NAMESPACE}-git-auth")
        DOCKER_CREDS = credentials("docker")
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
                sh 'printenv'
                script {
                    env.APP_VERSION = sh(returnStdout: true, script: "npm run version --silent").trim()
                    env.APP_NAME = sh(returnStdout: true, script: "npm run name --silent").trim()
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
                echo "$DOCKER_CREDS"
                sh '''
                    #docker build -t $APP_REPO/$APP_NAME:${APP_VERSION} .
                    #docker push $APP_REPO/$APP_NAME:${APP_VERSION}
                    #docker rmi -f $APP_REPO/$APP_NAME:${APP_VERSION}
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