// CPP = Copy/Paste Point. Values a copy/paster might want to double check matches their needs.

pipeline {
  agent { 
    dockerfile true // Jenkins will spin up an agent with the Dockerfile in the currnt repo/directory
  }

  environment {
    DOCKER_BUILDKIT = '1' // Tells Jenkins to use the modern buildkit vs legacy
  }

  stages {
    stage('prep'){
      sh "docker system prune -f"

      withCredentials([string(credentialsId: 'docker-pat', variable: 'DOCKERHUB_TOKEN')]) {
        sh "docker login -u empathetech -p ${DOCKERHUB_TOKEN}"
      }
    }

    stage('debian-gh'){
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

    stage('cleanup'){
      sh "docker logout"
    }
  }
}