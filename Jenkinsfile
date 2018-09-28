pipeline {
  agent any

  environment {
    VERSION = "${UUID.randomUUID().toString().replace('-','')[0..6]}" 
  }

  stages {

    stage('Test App') {
      steps{
        echo 'Testing app'
        echo 'Comming son'
      }
    }

    stage('Build image docker') {
      when {
        expression {
          env.BRANCH_NAME in ["master","stage","production"]
        }
      }
      steps{
        script {
          docker.withTool('Docker') {
            docker.withRegistry('https://166775549767.dkr.ecr.us-east-1.amazonaws.com/keyboard_heroes', 'ecr:us-east-1:e8b72a0b-f4f3-421e-b64b-7ec1a50c08a4') {
              def customImage = docker.build("keyboard_heroes:${env.VERSION}", '--build-arg ENV=prod .')
              customImage.push()
            }
          }
        }
      }
    }

    stage('Deploy Kube') {
      when {
        expression {
          env.BRANCH_NAME in ["master","stage","production"]
        }
      }
      environment {
        ENVIRONMENT = "${env.BRANCH_NAME == 'master' ? 'development' : env.BRANCH_NAME}"
      }
      steps{
        sh "ssh ec2-user@ci.makingdevs.com sh /home/ec2-user/deployApp.sh ${env.VERSION} ${env.ENVIRONMENT} keyboard-heroes"
      }
    }

  }

  post {
    always {
      cleanWs()
    }
  }
}