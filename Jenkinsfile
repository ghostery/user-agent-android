
node('docker && magrathea') {
    stage('checkout') {
        checkout scm
        sh 'git submodule init'
	sh 'git submodule update --remote --force'
        sh './import.sh'
    }

    image = stage('docker build') {
        docker.build('fostery-build', '--build-arg user=`whoami` --build-arg UID=`id -u` --build-arg GID=`id -g` .')
    }

    image.inside("--env GRADLE_USER_HOME=${pwd()}/gradle_home") {
        dir('browser') {
            stage('bootstrap') {
                sh './bootstrap.sh'
            }

            withCredentials([
                file(credentialsId: 'ef90e3e3-5563-4ac3-9e20-ae07db74db21', variable: 'PLAY_STORE_CERT'),
                file(credentialsId: '2df3d37d-0bc9-4152-a361-7fec0a73ce69', variable: 'CERT_PATH'),
                string(credentialsId: 'a87fff1f-8045-49e9-8038-861e7e8c58e4', variable: 'CERT_PASS'),
                string(credentialsId: '4de6b6fc-4302-429d-b4b7-2e97b0e5e5f7', variable: 'SENTRY_TOKEN')
            ]) {
                stage('fastlane') {
                    sh 'echo $SENTRY_TOKEN > .sentry_token'
                    sh 'fastlane internal'
                    sh 'rm .sentry_token'
                }
            }
        }
    }
}
