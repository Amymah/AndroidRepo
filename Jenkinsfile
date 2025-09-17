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
                // Python dependencies install karna
                bat 'pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                // Login.robot execute hoga (resources.robot auto-import ho jayega)
                bat 'robot --outputdir results Login.robot'
            }
        }

        stage('Publish Reports') {
            steps {
                publishHTML([
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    reportName: 'Robot Framework Report'
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
