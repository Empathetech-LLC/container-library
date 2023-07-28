node {
  // Tell Jenkins to use a Docker agent, built from the local Dockerfile
  dockerfile true

  // Tell Jenkins to use the modern buildkit
  env.DOCKER_BUILDKIT = '1'
  
  try {
    stage('clean system'){
      sh "docker system prune -f" 
    }

    stage('login'){
      withCredentials([string(credentialsId: 'docker-pat', variable: 'DOCKERHUB_TOKEN')]) {
        sh "docker login -u empathetech -p ${DOCKERHUB_TOKEN}"
      }
    }

    stage('buildx build debian-gh'){
      def image="debian-gh"

      sh "docker buildx build --platform linux/amd64,linux/arm64 -t empathetech/${image} ${image}/."
    }

    stage('buildx push debian-gh'){
      def image="debian-gh"

      sh "docker buildx build --push --platform linux/amd64,linux/arm64 -t empathetech/${image} ${image}/."
    }

    stage('debian-android-sdk'){
      def image="debian-android-sdk"

      sh "docker build -t empathetech/${image} ${image}/."
      sh "docker push empathetech/${image}"
    }

    stage('debian-flutter'){
      def image="debian-flutter"

      sh "docker build -t empathetech/${image}:min ${image}/min/."
      sh "docker push empathetech/${image}:min"

      sh "docker build -t empathetech/${image}:max ${image}/max/."
      sh "docker push empathetech/${image}:max"
    }

    stage('logout'){
      sh "docker logout"
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}