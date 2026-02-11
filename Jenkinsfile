pipeline {
    agent any

    parameters {
        choice(name: 'SELENIUM_BROWSER',
               choices: ['chrome', 'firefox', 'edge'],
               description: 'Navigateur à utiliser')
    }

    stages {
        stage('Checkout') {
            steps {
                // Si ton projet n'est PAS sur Git, on saute cette étape
                echo 'Projet local - pas de checkout Git'
            }
        }

        stage('Build & Test') {
			steps {

				echo 'Execution d’un seul fichier Robot Framework...'

				dir('C:/dev/Jenkins/workspace/POEI2026/robotTest') {
					bat '''
						robot ^
						--output output.xml ^
						--log log.html ^
						--report report.html ^
						--variable BROWSER:%SELENIUM_BROWSER% ^
						tests/product_test.robot
					'''
				}
			}
		}
        stage('Export results to XRAY') {
			steps {
				echo 'Export des .xml vers XRAY'

				bat '''
					curl -H "Content-Type: text/xml" ^
     					-H "Authorization: Bearer %token%" ^
     					--data-binary @"C:/dev/Jenkins/workspace/POEI2026/robotTest/output.xml" ^
     					https://xray.cloud.getxray.app/api/v1/import/execution/robot?projectKey=POEI2-1042
				'''
			}
		}

	}
    post {

        success {
            echo 'Tests exécutés avec succès 🎉'
        }

        failure {
            echo 'Des tests ont échoué ❌'
        }
    }
}

