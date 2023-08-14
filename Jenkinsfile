pipeline {
    agent any
    stages {
		stage('build') {
			steps {
				script {
					env.RANDOM_CONTAINER_NAME = sh(returnStdout: true, script: 'echo "$((1 + $(od -An -N2 -i /dev/urandom) % 99999))"').trim()
					if(env.BRANCH_NAME == 'main') { 
						sh 'echo "main"'
						sshagent(credentials: ['talk4-gitlab']) {
							//sh 'git push git@gitlab.com:tal_docs/portfolio-docker.git main ${s}'--force
							sh 'git tag'
							sh 'git fetch --tags --force git@gitlab.com:tal_docs/portfolio-docker.git'
							env.GIT_TAG = sh(returnStdout: true, script: './check-tag.sh').trim()
						}
					} else { 
						sh 'echo not main'
						env.GIT_TAG = sh(returnStdout: true, script: 'echo "$GIT_COMMIT" | cut -c1-7').trim()
					}
				}
				sh 'docker build -t tal/flask ./'
				sh 'docker build -t tal/mongodb ./mongo-image/'
				sh 'docker build -t tal/test ./test-image/'
       		}
		}
        stage('test') {
			steps {
				sh 'docker-compose up --abort-on-container-exit --timeout 0'
       		}
		}
		stage('deploy') {
			steps {
				script {
					if(env.GIT_TAG != '' && env.BRANCH_NAME == 'main') { 
						sh 'echo "main"'
						sshagent(credentials: ['talk4-gitlab']) {
							//sh 'git push git@gitlab.com:tal_docs/portfolio-docker.git main ${s}'
							//sh 'git fetch --tags --force git@gitlab.com:tal_docs/portfolio-docker.git' <---- not sure why I added this before
							env.GIT_TAG = sh(returnStdout: true, script: './check-tag.sh').trim()
							sh 'git tag ${GIT_TAG}'
							sh 'git push --tags git@gitlab.com:tal_docs/portfolio-docker.git ${GIT_TAG}'
						}
					}
				}	
				withAWS(region: 'eu-west-3', credentials: 'tal-aws'){
					sh 'aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 644435390668.dkr.ecr.eu-west-3.amazonaws.com'
					sh 'docker tag tal/flask 644435390668.dkr.ecr.eu-west-3.amazonaws.com/talk:${GIT_TAG}'
					sh 'docker push 644435390668.dkr.ecr.eu-west-3.amazonaws.com/talk:${GIT_TAG}'
				}	
			}		
		}

		stage('gitops') {
			steps {
				script {
					if(env.BRANCH_NAME == 'main') {
						sh 'echo "main"'
						sshagent(credentials: ['talk4-gitlab']) {
							sh 'rm -r for-gitops || true'
							sh 'mkdir for-gitops'
							sh 'git clone git@gitlab.com:tal_docs/gitops-portfolio.git for-gitops'
							dir("./for-gitops/tal-todo") {
								sh "sed -i 's|Appimage: .*|Appimage: 644435390668.dkr.ecr.eu-west-3.amazonaws.com/talk:${GIT_TAG}|g' values.yaml"
							}
							dir("./for-gitops") {
								sh 'git add --all; git commit -m "Jenkins"'
								sh 'git push git@gitlab.com:tal_docs/gitops-portfolio.git main'
							}
							sh 'rm -r for-gitops || true'
							sh 'rm -r for-gitops@tmp || true'
						}
					}
				}
			}
		}




	}
	post {
		always {
			sh 'docker-compose down'
		}
	}		
}