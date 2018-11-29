node {
    stage('Checkout') {
        checkout scm
    }
    stage('Build Image') {
        sh 'docker build -f Dockerfile -t sysdigcicd/cronagent .'
    }
    stage('Push Image') {
        withCredentials([usernamePassword(credentialsId: 'docker-repository-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
            sh '''
                docker login --username ${DOCKER_USERNAME} --password ${DOCKER_PASSWORD}
                docker push sysdigcicd/cronagent
            '''
        }
    }
    stage('Scanning Image') {
        anchore 'sysdig_secure_images'
    }
}
