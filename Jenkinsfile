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
                // Correct way to upgrade pip in Jenkins on Windows
                bat 'python -m pip install --upgrade pip'
                
                // Install everything from requirements.txt
                bat 'python -m pip install -r requirements.txt'
            }
        }

        stage('Run Robot Tests') {
            steps {
                // Run tests and save results
                bat 'python -m robot --outputdir results Login.robot'
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
