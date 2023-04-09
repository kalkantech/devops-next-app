pipeline {
    // agent {
    //     docker { image 'docker' }
    // }
    agent any
    environment {
        ARGOCD_CONFIG_REPO = "github.com/kalkantech/devops-app-config.git"
        ARGOCD_CONFIG_REPO_PATH = "/tmp/devops-app-config"
        ARGOCD_CONFIG_REPO_BRANCH = "main"
        DOCKER_APP_REPO = "shield07"
        // Credentials
        DOCKER_CREDS = credentials("docker")
        GIT_CREDS = credentials("github-cred")
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
                sh 'docker login -u $DOCKER_CREDS_USR -p $DOCKER_CREDS_PSW'
                sh 'git clone https://$GIT_CREDS@$ARGOCD_CONFIG_REPO $ARGOCD_CONFIG_REPO_PATH'
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
                    docker build -t $DOCKER_APP_REPO/$APP_NAME:${APP_VERSION} .
                    docker push $DOCKER_APP_REPO/$APP_NAME:${APP_VERSION}
                    docker rmi -f $DOCKER_APP_REPO/$APP_NAME:${APP_VERSION}
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Testing..'
            }
        }
        stage('Deploy Helm') {
            steps {
                echo 'Deploying Helm....'
                sh '''
                    cd $ARGOCD_CONFIG_REPO_PATH
                    ls
                '''
            }
        }
        stage('Sync ArgoCD') {
            steps {
                echo 'Syncying ArgoCD....'
            }
        }
    }
}