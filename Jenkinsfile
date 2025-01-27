pipeline {
    agent any
    tools {
    maven 'myMaven'
    }
    environment {
    JAVA_HOME = "/usr/lib/jvm/java-1.11.0-openjdk-amd64"
             }
    
    stages {
        stage('Compile and Clean') { 
            steps {
                sh "mvn clean compile"
            }
        }
        stage('Test') { 
            steps {
                sh "mvn test site"
            }
            
             post {
                always {
                    junit allowEmptyResults: true, testResults: 'target/surefire-reports/*.xml'   
                }
            }     
        }

        stage('deploy') { 
            steps {
                sh "mvn package"
            }
        }
        
        stage('Build Docker image'){
            steps {
                sh 'docker build -t shvkmr536/docker_jenkins-pipeline:${BUILD_NUMBER} .'
            }
        }

        stage('Docker Login'){
            steps {
                 withCredentials([string(credentialsId: 'DockerHub', variable: 'dockerpwd')]) {
                    sh "docker login -u shvkmr536 -p ${dockerpwd}"
                }
            }                
        }

        stage('Docker Push'){
            steps {
                sh 'docker push shvkmr536/docker_jenkins-pipeline:${BUILD_NUMBER}'
            }
        }
        
        stage('Docker deploy'){
            steps {
                sh 'docker run -itd -p 8081:8081 shvkmr536/docker_jenkins-pipeline:${BUILD_NUMBER}'
            }
        }

        
        stage('Archving') { 
            steps {
                 archiveArtifacts '**/target/*.jar'
            }
        }
    }
}
