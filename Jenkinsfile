pipeline {
    // agent {
    //     docker { image 'docker' }
    // }
    // agent any
    agent {
        kubernetes {
            containerTemplate {
                name 'docker'
                image 'docker:latest'
                ttyEnabled true
                command 'cat'
                volumeMounts {
                    name 'docker-sock'
                    mountPath '/var/run/docker.sock'
                }
            }
        }
    }
    environment { 
        CC = 'clang'
        GIT_SSL_NO_VERIFY = true
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '1'))
		timeout(time: 15, unit: 'MINUTES')
		ansiColor('xterm')
    }
    stages {
        stage('Prepare') {
            steps {
                echo 'Building..'
                sh 'printenv'
                container('docker') {
                   sh 'docker build -t my-image .'
                }
                sh 'whoami'
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
        stage('Build') {
            steps {
                echo 'Building..'
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
    volumes {
       hostPath {
           path '/var/run/docker.sock'
       }
    }
}