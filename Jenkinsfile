pipeline { 

    agent any 

 

    parameters { 

        choice choices: ['dev', 'prod'], name: 'select_environment' 

    } 

 

    environment { 

        APK_SOURCE_NAME = 'app-release 3.apk' 

        APK_DEST = 'Build\\app.apk' 

        AVD_NAME = 'Medium_Tablet' 

        APP_PACKAGE = 'com.smartrep' 

    } 

 

    stages { 

 

        stage('Clean Results') { 

            steps { 

                bat ''' 

                    if exist Results rmdir /s /q Results 

                    if exist Build rmdir /s /q Build 

                ''' 

            } 

        } 

 

        stage('Checkout Test Branch') { 

            steps { 

                checkout scm 

            } 

        } 

 

        stage('Fetch APK from Build Branch (if not present)') { 

            steps { 

                bat ''' 

                    if not exist Build\\app.apk ( 

                        echo APK not found. Fetching from build branch... 

                        git fetch origin build 

                        git checkout origin/build 

 

                        mkdir Build 

                        copy "path\\to\\apk\\app-release 3.apk" Build\\app.apk 

 

                        git checkout tests 

                        echo APK copied to Build\\app.apk 

                    ) else ( 

                        echo APK already exists. Skipping fetch. 

                    ) 

                ''' 

            } 

        } 

 

        stage('Set up Python Env') { 

            steps { 

                bat ''' 

                    python -m venv venv 

                    call venv\\Scripts\\activate.bat 

                    pip install -r requirements.txt 

                ''' 

            } 

        } 

 

        stage('Start Appium & Emulator') { 

            steps { 

                bat ''' 

                    echo Starting Appium Server... 

                    start /B cmd /c appium 

 

                    timeout /t 10 

 

                    echo Starting Emulator... 

                    start /B cmd /c emulator -avd Medium_Tablet -gpu off -verbose 

 

                    echo Waiting for emulator to boot... 

                    timeout /t 60 

                ''' 

            } 

        } 

 

        stage('Install APK (if not already installed)') { 

            steps { 

                bat ''' 

                    echo Checking if APK is already installed... 

 

                    adb shell pm list packages | findstr /i com.smartrep > nul 

 

                    if %errorlevel% neq 0 ( 

                        echo APK not installed. Installing now... 

                        adb install -r Build\\app.apk 

                    ) else ( 

                        echo APK is already installed. Skipping installation. 

                    ) 

                ''' 

            } 

        } 

 

        stage('Run Robot Mobile Tests') { 

            steps { 

                bat ''' 

                    call venv\\Scripts\\activate.bat 

                    pabot --processes 1 --outputdir Results MobileTests\\*.robot 

                ''' 

            } 

            post { 

                success { 

                    dir('Results') { 

                        stash name: 'Artifacts', includes: '**/*.*' 

                    } 

                    echo 'Mobile Test Results stashed successfully.' 

                } 

                failure { 

                    echo 'Mobile Tests failed. Nothing stashed.' 

                } 

            } 

        } 

 

        stage('Deploy Dev') { 

            when { 

                expression { params.select_environment == 'dev' } 

                beforeAgent true 

            } 

            agent { label 'Window2' } 

            steps { 

                dir('Results') { 

                    unstash 'Artifacts' 

                    bat ''' 

                        echo Listing Results contents: 

                        dir 

                    ''' 

                } 

            } 

        } 

 

        stage('Deploy Prod') { 

            when { 

                expression { params.select_environment == 'prod' } 

                beforeAgent true 

            } 

            agent { label 'Window2' } 

            steps { 

                timeout(time: 5, unit: 'DAYS') { 

                    input message: "Deployment Approved?" 

                } 

                dir('Results') { 

                    unstash 'Artifacts' 

                    bat ''' 

                        echo Listing Results contents: 

                        dir 

                    ''' 

                } 

            } 

        } 

    } 

 

    post { 

        failure { 

            echo "Failure!" 

            mail to: 'laraib.khalid@bssuniversal.com', 

                subject: "FAILED: ${env.JOB_NAME} - Build #${env.BUILD_NUMBER}", 

                body: "Job '${env.JOB_NAME}' (${env.BUILD_URL}) failed." 

        } 

        success { 

            echo "All Stages Successful!" 

        } 

    } 

} 
