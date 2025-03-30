pipeline {
    agent any
    
    parameters {
        booleanParam(name: 'SKIP_DIFF', defaultValue: false, description: 'Skip the diff stage and proceed directly to apply')
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/filipegalo/playground_k8s.git', branch: 'main'
            }
        }
        
        stage('Setup Helm Cache') {
            steps {
                cache(maxCacheSize: 500, caches: [
                    arbitraryFileCache(
                        path: '/home/jenkins/.cache/helm',
                        includes: '**/*',
                        compressionMethod: 'TARGZ'
                    )
                ]) {
                    echo "Helm cache restored"
                }
            }
        }
        
        stage('Helmfile Diff') {
            when {
                expression { return !params.SKIP_DIFF }
            }
            steps {
                dir('helmfile') {
                    sh 'helmfile diff'
                }
            }
        }

        stage('Approve deploy') {
            when {
                expression { return !params.SKIP_DIFF }
            }
            steps {
                input message: "Apply this changes ?", ok: "Yes, continue"
            }
        }
        
        stage('Helmfile Apply') {
            steps {
                dir('helmfile') {
                    sh 'helmfile apply'
                }
            }
        }
    }
}