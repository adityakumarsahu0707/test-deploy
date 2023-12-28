pipeline{
	agent any
	stages{
		stage('Build'){
			steps{
				sh 'sudo cp ./index.html /var/www/html/'
			}
		}
		stage('Test'){
			steps{
				sh 'sudo systemctl start httpd'
			}
		}
	}
}

