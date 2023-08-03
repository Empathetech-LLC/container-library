node('00-docker') {
  try {
    if (env.BRANCH_NAME == 'main') {
      stage('login') {
        withCredentials([usernamePassword(credentialsId: 'docker-pat', passwordVariable: 'DOCKER_TOKEN', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_TOKEN}"
        }
      }
    }

    stage('build') {
      def image="debian-gh"
      sh "docker build -t empathetech/${image} ${image}/."

      def image="debian-android-sdk"
      sh "docker build -t empathetech/${image} ${image}/."

      def image="debian-flutter"
      sh "docker build -t empathetech/${image}:min ${image}/min/."
      sh "docker build -t empathetech/${image}:max ${image}/max/."

      def image="jenkins-agent-flutter"
      sh "docker build -t empathetech/${image} ${image}/."
    }

    if (env.BRANCH_NAME == 'main') {
      stage('push') {
        def image="debian-gh"
        sh "docker push empathetech/${image}"
        
        def image="debian-android-sdk"
        sh "docker push empathetech/${image}"
        
        def image="debian-flutter"
        sh "docker push empathetech/${image}:min"
        sh "docker push empathetech/${image}:max"

        def image="jenkins-agent-flutter"
        sh "docker push empathetech/${image}"
      }
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}