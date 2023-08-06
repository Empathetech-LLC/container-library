node('00-docker') {
  try {
    stage('checkout') {
      checkout scm
    }

    // Define image names
    def image1="debian-gh"
    def image2="debian-android-sdk"
    def image3="debian-flutter"

    // Clean up cache on main so we don't push old layers
    if (env.BRANCH_NAME == 'main') {
      stage('cleanup') {
        sh "docker image rm -f ${image1}"
        sh "docker image rm -f ${image2}"

        sh "docker image rm -f ${image3}:min"
        sh "docker image rm -f ${image3}:max"
      }
    }

    // Build images
    stage('build') {
      sh "docker build -t empathetech/${image1} ${image1}/."

      sh "docker build -t empathetech/${image2} ${image2}/."

      sh "docker build -t empathetech/${image3}:min ${image3}/min/."
      sh "docker build -t empathetech/${image3}:max ${image3}/max/."
    }

    // Push images (on main branch only)
    if (env.BRANCH_NAME == 'main') {
      stage('push') {
        sh "docker push empathetech/${image1}"
        
        sh "docker push empathetech/${image2}"
        
        sh "docker push empathetech/${image3}:min"
        sh "docker push empathetech/${image3}:max"
      }
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}