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
     					-H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnQiOiJiNmNhZGQwNS1lMzQxLTNmMTctYjU1Zi00OTM0MTI4MWQ4MmEiLCJhY2NvdW50SWQiOiI3MTIwMjA6MDAzMGIzMjMtNjQ3OC00MzYxLThlZjYtNjcyZjg3NWI4YTNlIiwiaXNYZWEiOmZhbHNlLCJpYXQiOjE3NzA4MDQxNjIsImV4cCI6MTc3MDg5MDU2MiwiYXVkIjoiNzJDNkI1MEYwRkU0NDY5REJGRjhFNzgwQUFBNUIzRkYiLCJpc3MiOiJjb20ueHBhbmRpdC5wbHVnaW5zLnhyYXkiLCJzdWIiOiI3MkM2QjUwRjBGRTQ0NjlEQkZGOEU3ODBBQUE1QjNGRiJ9.0fW9GXB4-qUSIGosEMygU8IWDcAZHbpNHjadzBOuls4" ^
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

