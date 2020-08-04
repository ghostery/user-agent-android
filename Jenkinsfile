
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

        stage('fastlane') {
            sh 'fastlane internal'
        }
    }
}
