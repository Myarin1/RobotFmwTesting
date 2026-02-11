pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Si ton projet n'est PAS sur Git, on saute cette étape
                echo 'Projet local - pas de checkout Git'
            }
        }

        stage('Build & Test') {
            steps {
				
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
    	curl -X POST ^
         -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0ZW5hbnQiOiJiNmNhZGQwNS1lMzQxLTNmMTctYjU1Zi00OTM0MTI4MWQ4MmEiLCJhY2NvdW50SWQiOiI3MTIwMjA6MDAzMGIzMjMtNjQ3OC00MzYxLThlZjYtNjcyZjg3NWI4YTNlIiwiaXNYZWEiOmZhbHNlLCJpYXQiOjE3NzA2MjcwMjYsImV4cCI6MTc3MDcxMzQyNiwiYXVkIjoiNzJDNkI1MEYwRkU0NDY5REJGRjhFNzgwQUFBNUIzRkYiLCJpc3MiOiJjb20ueHBhbmRpdC5wbHVnaW5zLnhyYXkiLCJzdWIiOiI3MkM2QjUwRjBGRTQ0NjlEQkZGOEU3ODBBQUE1QjNGRiJ9.3LRLZS9HhxLWxX0oy4pCYmBW1naSuIMMPs9t4NzDkts" ^
         -F "file=@C:/dev/Jenkins/workspace/POEI2026/PomPipeline/output.xml" ^
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