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
                // wait for 10 seconds using PowerShell
                bat 'powershell -Command "Start-Sleep -Seconds 10"'
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
                    reportDir: 'results',
                    reportFiles: 'log.html',
                    reportName: 'Robot Framework Report'
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
