
node('docker && magrathea') {
    stage('checkout') {
        checkout scm
    }

    image = stage('docker build') {
        docker.build('fostery-build', '--build-arg user=`whoami` --build-arg UID=`id -u` --build-arg GID=`id -g` .')
    }

    image.inside("--env GRADLE_USER_HOME=${pwd()}/gradle_home") {
        stage('prepare') {
            sh './bootstrap.sh'
        }

        withCredentials([
            file(credentialsId: 'ef90e3e3-5563-4ac3-9e20-ae07db74db21', variable: 'PLAY_STORE_CERT'),
            file(credentialsId: '2df3d37d-0bc9-4152-a361-7fec0a73ce69', variable: 'CERT_PATH'),
            string(credentialsId: '	a87fff1f-8045-49e9-8038-861e7e8c58e4', variable: 'CERT_PASS'),
        ]) {
            stage('fastlane') {
                sh 'fastlane internal'
            }
        }
    }
}
