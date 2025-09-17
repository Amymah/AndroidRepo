pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Amymah/AndroidRepo.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Start Appium Server') {
            steps {
                bat 'start /B appium --address 127.0.0.1 --port 4723'
                // 10 sec wait to make sure server starts
                bat 'timeout /T 10'
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat 'robot --outputdir results Login.robot'
            }
        }

        stage('Publish Reports') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    reportName: 'Robot Framework Test Report'
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/*.*', fingerprint: true
        }
    }
}
