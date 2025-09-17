pipeline {
    agent any

    environment {
        PATH = "C:\\Users\\Amaima\\AppData\\Local\\Programs\\Python\\Python313;${PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/Amymah/AndroidRepo.git', branch: 'master'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Start Appium Server') {
            steps {
                // Start Appium in background and log output to file
                bat 'start /B appium --address 127.0.0.1 --port 4723 > appium_log.txt 2>&1'
                // wait for 10 seconds to ensure server starts
                bat 'powershell -Command "Start-Sleep -Seconds 10"'
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat 'robot Login.robot'
                bat 'robot User_Login.robot'
            }
        }

        stage('Publish Reports') {
            steps {
                publishHTML(target: [
                    allowMissing: false,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'results',
                    reportFiles: 'log.html,report.html',
                    reportName: 'Robot Framework Reports'
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**', fingerprint: true
        }
    }
}
