@Library('empathetechScripts') _

node('00-docker') {
  try {
    stage('checkout') {
      checkout scm
    }

    def baseBranch = 'main' // CPP (Copy/Paste Point)

    // Ordered manually
    def images = ['debian-gh', 'debian-android-sdk', 'debian-flutter-min', 'debian-flutter-max', 'jenkins-agent-docker', 'jenkins-agent-flutter']

    if (env.BRANCH_NAME != baseBranch) {
      stage('Validate versioning') {
        withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
          dockerDev.validateDockerfileVersions(env.CHANGE_ID, baseBranch, env.BRANCH_NAME, images)
        }
      }
    }

    // Clean up cache on main so we don't push old layers
    if (env.BRANCH_NAME == baseBranch) {
      stage('cleanup') {
        dockerDev.clean()
      }

      stage('login') {
        withCredentials([usernamePassword(credentialsId: 'docker-pat', passwordVariable: 'DOCKER_TOKEN', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_TOKEN}"
        }
      }
    }

    // Build images
    stage('build') {
      dockerDev.buildImages(images)
    }

    // Push images (on main branch only)
    if (env.BRANCH_NAME == baseBranch) {
      stage('push') {
        dockerDev.pushImages(images)
      }
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}
