node {
  // Tell Jenkins to use a Docker agent, built from the local Dockerfile
  dockerfile true

  // Tell Jenkins to use the modern buildkit
  env.DOCKER_BUILDKIT = '1'
  
  try {
    if (env.BRANCH_NAME == 'main') {
      stage('login') {
        withCredentials([usernamePassword(credentialsId: 'docker-pat', passwordVariable: 'DOCKER_TOKEN', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_TOKEN}"
        }
      }
    }

    stage('build debian-gh') {
      def image="debian-gh"
      sh "docker buildx build --platform linux/amd64,linux/arm64 -t empathetech/${image} ${image}/."
    }

    if (env.BRANCH_NAME == 'main') {
      stage('push debian-gh') {
        def image="debian-gh"
        sh "docker buildx build --push --platform linux/amd64,linux/arm64 -t empathetech/${image} ${image}/."
      }
    }

    stage('build debian-android-sdk') {
      def image="debian-android-sdk"
      sh "docker build -t empathetech/${image} ${image}/."
    }

    if (env.BRANCH_NAME == 'main') {
      stage('push debian-android-sdk') {
        def image="debian-android-sdk"
        sh "docker push empathetech/${image}"
      }
    }

    stage('build debian-flutter') {
      def image="debian-flutter"
      sh "docker build -t empathetech/${image}:min ${image}/min/."
      sh "docker build -t empathetech/${image}:max ${image}/max/."
    }
    
    if (env.BRANCH_NAME == 'main') {
      stage('push debian-flutter') {
        def image="debian-flutter"
        sh "docker push empathetech/${image}:min"
        sh "docker push empathetech/${image}:max"
      }
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}