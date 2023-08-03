node('00-docker') {
  try {
    stage('checkout') {
      checkout scm
    }

    if (env.BRANCH_NAME == 'main') {
      stage('login') {
        withCredentials([usernamePassword(credentialsId: 'docker-pat', passwordVariable: 'DOCKER_TOKEN', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_TOKEN}"
        }
      }
    }

    def image1="debian-gh"
    def image2="debian-android-sdk"
    def image3="debian-flutter"
    def image4="jenkins-agent-flutter"

    stage('build') {
      sh "docker build -t empathetech/${image1} ${image1}/."

      sh "docker build -t empathetech/${image2} ${image2}/."

      sh "docker build -t empathetech/${image3}:min ${image3}/min/."
      sh "docker build -t empathetech/${image3}:max ${image3}/max/."

      sh "docker build -t empathetech/${image4} ${image4}/."
    }

    if (env.BRANCH_NAME == 'main') {
      stage('push') {
        sh "docker push empathetech/${image1}"
        
        sh "docker push empathetech/${image2}"
        
        sh "docker push empathetech/${image3}:min"
        sh "docker push empathetech/${image3}:max"

        sh "docker push empathetech/${image4}"
      }
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}