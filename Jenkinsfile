pipeline {
  agent any
  environment {
    WORKSPACE = "${env.WORKSPACE}"
    NEXUS_CREDENTIAL_ID = 'Nexus-Credential'
    //NEXUS_USER = "$NEXUS_CREDS_USR"
    //NEXUS_PASSWORD = "$Nexus-Token"
    //NEXUS_URL = "54.90.39.222:8081"
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
                -Dsonar.host.url=http://67.202.47.52:9000 \
                -Dsonar.login=634cda35d7ab61851932e8bec32360f012f36057                              
                """
                }
            }
        }
    }
    stage("Nexus Artifact Uploader"){
        steps{
           nexusArtifactUploader(
              nexusVersion: 'nexus3',
              protocol: 'http',
              nexusUrl: '35.153.98.245:8081',
              groupId: 'webapp',
              version: "${env.BUILD_ID}-${env.BUILD_TIMESTAMP}",
              repository: 'maven-project-releases',  //"${NEXUS_REPOSITORY}",
              credentialsId: "${NEXUS_CREDENTIAL_ID}",
              artifacts: [
                  [artifactId: 'webapp',
                  classifier: '',
                  file: "${WORKSPACE}/webapp/target/webapp.war",
                  type: 'war']
              ]
           )
        }
    }
    stage('Deploy to Development Env') {
        environment {
            HOSTS = 'dev'
        }
        steps {
            withCredentials([usernamePassword(credentialsId: 'Ansible-Credential', passwordVariable: 'PASSWORD', usernameVariable: 'USER_NAME')]) {
            //    sh "ansible-playbook -i ${WORKSPACE}/ansible-config/aws_ec2.yaml ${WORKSPACE}/deploy.yaml --extra-vars \"ansible_user=$USER_NAME ansible_password=$PASSWORD hosts=tag_Environment_$HOSTS workspace_path=$WORKSPACE\""
                sh "ansible-playbook deploy.yaml --extra-vars \"ansible_user=$USER_NAME ansible_password=$PASSWORD hosts=dev"
            }
        }
    }
  }
}    