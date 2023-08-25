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
          script {
            if (env.CHANGE_ID) {
              // If "this" a PR
              sh "git fetch origin ${baseBranch}:${baseBranch} refs/pull/${env.CHANGE_ID}/head:PR-${env.CHANGE_ID}"
            } else {
              // If "this" regular branch
              sh "git fetch origin ${baseBranch}:${baseBranch} ${env.BRANCH_NAME}:${env.BRANCH_NAME}"
            }
            
            def updatedFiles = sh(script: "git diff --name-only ${baseBranch} ${env.BRANCH_NAME}", returnStdout: true).trim().split("\n")
            println "Updated files:\n$updatedFiles"
            
            images.each { image ->
              def dockerfileUpdated = updatedFiles.any { it.startsWith("${image}/Dockerfile") }
              def appVersionUpdated = updatedFiles.any { it.startsWith("${image}/APP_VERSION") }
              def changelogUpdated = updatedFiles.any { it.startsWith("${image}/CHANGELOG.md") }
              
              if (dockerfileUpdated && (!appVersionUpdated || !changelogUpdated)) {
                error("Dockerfile updated in ${image}, but APP_VERSION and/or CHANGELOG.md did not. Please update them.")
              }
            }

            println "All versioning trios are were updated together!"
          }
        }
      }
    }

    // Clean up cache on main so we don't push old layers
    if (env.BRANCH_NAME == baseBranch) {
      stage('cleanup') {
        images.each { image -> 
          sh "docker image rm -f empathetech/${image}"
          sh "docker system prune -f"
        }
      }

      stage('login') {
        withCredentials([usernamePassword(credentialsId: 'docker-pat', passwordVariable: 'DOCKER_TOKEN', usernameVariable: 'DOCKER_USERNAME')]) {
          sh "docker login -u ${DOCKER_USERNAME} -p ${DOCKER_TOKEN}"
        }
      }
    }

    // Build images
    stage('build') {
      images.each { image ->
        def version = readFile("${image}/APP_VERSION").trim()
        sh "docker build -t empathetech/${image}:${version} ${image}/."
      }
    }

    // Push images (on main branch only)
    if (env.BRANCH_NAME == baseBranch) {
      stage('push') {
        images.each { image -> 
          def version = readFile("${image}/APP_VERSION").trim()
          sh "docker push empathetech/${image}:${version}"
        }
      }
    }
  } catch (Exception e) {
    currentBuild.result = 'FAILURE'
    throw e
  }
}
