pipeline {
    // agent {
    //     docker { image 'docker' }
    // }
    agent any
    // agent {
    //     docker { image 'node:16.13.1-alpine' }
    // }
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
                sh 'docker --version'
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
}