node('00-docker') {
  try {
    stage('checkout') {
      checkout scm
    }

    // Ordered manually
    def images = ['debian-gh', 'debian-android-sdk', 'debian-flutter-min', 'debian-flutter-max']

    if (env.BRANCH_NAME != 'main') {
      stage('Validate versioning') {
        withCredentials([gitUsernamePassword(credentialsId: 'git-pat')]) {
          def baseBranch = 'main' // CPP (Copy/Paste Point)

          script {
            if (env.CHANGE_ID) {
              // If "this" a PR
              sh "git fetch origin ${baseBranch}:${baseBranch} refs/pull/${env.CHANGE_ID}/head:PR-${env.CHANGE_ID}"
            } else {
              // If "this" regular branch
              sh "git fetch origin ${baseBranch}:${baseBranch} ${env.BRANCH_NAME}:${env.BRANCH_NAME}"
            }
            
            def changedFiles = sh(script: "git diff --name-only ${baseBranch} ${env.BRANCH_NAME}", returnStdout: true).trim().split("\n")
            
            images.each { image ->
              def dockerfileChanged = changedFiles.any { it.startsWith("${image}/Dockerfile") }
              def appVersionChanged = changedFiles.any { it.startsWith("${image}/APP_VERSION") }
              def changelogChanged = changedFiles.any { it.startsWith("${image}/CHANGELOG.md") }
              
              if (dockerfileChanged && (!appVersionChanged || !changelogChanged)) {
                error("Dockerfile changed in ${image}, but APP_VERSION and/or CHANGELOG.md did not. Please update them.")
              }
            }
          }
        }
      }
    }

    // Clean up cache on main so we don't push old layers
    if (env.BRANCH_NAME == 'main') {
      stage('cleanup') {
        images.each { image -> 
          sh "docker image rm -f empathetech/${image}"
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
    if (env.BRANCH_NAME == 'main') {
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