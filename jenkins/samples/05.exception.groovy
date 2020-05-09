// 例外/エラー発生時の処理実装
// @param boolean isStageSuccess
// @param boolean isStepSuccess
// @param string  errorType

pipeline {
    agent any

    stages {
        stage('Step Success or Failed') {
            steps {
                script {
                    if ( isStepSuccess.toBoolean() ) {
                        echo "Step Success"
                    } else {
                        echo "Step Failed"
                        // ここで終了し、後続のstageは実行しない
                        sh '[ 1 -eq 0 ]'
                    }
                }
            }
        }
        stage('Stage Failed') {
            when {
                not { expression { isStageSuccess.toBoolean() } }
            }
            steps {
                echo "Stage Failed"
                script { sh 'exit 1' }
            }
        }
        stage('Last Stage') {
            steps {
                echo "Last"
            }
        }

    }
}
