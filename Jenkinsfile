pipeline {
  agent any
  environment {
    WORKSPACE = "${env.WORKSPACE}"
    NEXUS_CREDENTIAL_ID = 'Nexus-Credential'
    //NEXUS_USER = "$NEXUS_CREDS_USR"
    //NEXUS_PASSWORD = "$Nexus-Token"
    //NEXUS_URL = "44.204.17.207:8081"
    //NEXUS_REPOSITORY = "maven_project"
    //NEXUS_REPO_ID    = "maven_project"
    //ARTVERSION = "${env.BUILD_ID}"
  }
  tools {
    maven 'localMaven'
    jdk 'localJdk'
  }
  stages {
    stage('Build Artifacts') {
      steps {
        sh 'mvn clean package'
      }
      post {
        success {
          echo ' now Archiving '
          archiveArtifacts artifacts: '**/*.war'
        }
      }
    }
    stage('Unit Test'){
        steps {
            sh 'mvn test'
        }
    }
    stage('Integration Test'){
        steps {
          sh 'mvn verify -DskipUnitTests'
        }
    }
    stage ('Checkstyle Code Analysis'){
        steps {
            sh 'mvn checkstyle:checkstyle'
        }
        post {
            success {
                echo 'Generated Analysis Result'
            }
        }
    }
    stage('SonarQube Inspection') {
        steps {
            withSonarQubeEnv('SonarQube') { 
                withCredentials([string(credentialsId: 'SonarQube-Token', variable: 'SONAR_TOKEN')]) {
                sh """
                mvn sonar:sonar \
                -Dsonar.projectKey=CICD-Project \
                -Dsonar.host.url=http://34.229.136.178/:9000 \
                -Dsonar.login=634cda35d7ab61851932e8bec32360f012f36057                              
                """
                }
            }
        }
    }
  }
}    