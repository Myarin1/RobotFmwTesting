pipeline {
    agent any

    parameters {
        choice(name: 'SELENIUM_BROWSER',
               choices: ['chrome', 'firefox', 'edge'],
               description: 'Navigateur à utiliser')
    }

    environment {
        XRAY_BASE_URL = "https://xray.cloud.getxray.app"
    }

    stages {

        stage('Build & Test') {
            steps {
                dir('C:/dev/Jenkins/workspace/POEI2026/robotTest') {
                    bat """
                        robot ^
                        --output output.xml ^
                        --log log.html ^
                        --report report.html ^
                        --variable BROWSER:%SELENIUM_BROWSER% ^
                        tests/product_test.robot
                    """
                }
            }
        }

        stage('Generate XRAY Token') {
            steps {
                withCredentials([
                    string(credentialsId: 'client_id', variable: 'CLIENT_ID'),
                    string(credentialsId: 'client_secret', variable: 'CLIENT_SECRET')
                ]) {
                    script {
                        // Exécution curl pour générer token XRAY
                        def token = bat(
                            script: """
                                curl -s -X POST ^
                                -H "Content-Type: application/json" ^
                                -d "{\\"client_id\\":\\"%CLIENT_ID%\\",\\"client_secret\\":\\"%CLIENT_SECRET%\\"}" ^
                                %XRAY_BASE_URL%/api/v2/authenticate
                            """,
                            returnStdout: true
                        ).trim()

                        // Nettoyage des guillemets
                        env.XRAY_TOKEN = token.replace('"', '')
                        echo "Token XRAY généré"
                    }
                }
            }
        }

        stage('Export results to XRAY') {
            steps {
                dir('C:/dev/Jenkins/workspace/POEI2026/robotTest') {
                    bat """
                        if not exist output.xml (echo output.xml introuvable & exit /b 1)
                        
                        curl -X POST ^
                             -H "Authorization: Bearer %XRAY_TOKEN%" ^
                             -F "file=@output.xml" ^
                             %XRAY_BASE_URL%/api/v2/import/execution/robot?projectKey=POEI2
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Tests exécutés et envoyés à XRAY 🎉'
        }
        failure {
            echo 'Des tests ont échoué ❌'
        }
    }
}

