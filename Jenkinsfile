pipeline{
	agent any
	stages{
		stage('Build'){
			steps{
				sh 'cp ./index.html /var/www/html/'
			}
		}
		stage('Test'){
			steps{
				sh 'sudo systemctl start httpd'
			}
		}
	}
}

