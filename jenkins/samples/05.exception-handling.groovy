// 例外/エラー発生時の処理実装
// @param boolean isStageSuccess
// @param boolean isStepSuccess
// @param string  StepErrorType
def callThrow() {
    throw new Exception("simple throw Exception")
}

pipeline {
    agent any

    stages {
        stage('Step Success or Failed') {
            steps {
                script {
                    if ( isStepSuccess.toBoolean() ) {
                        echo "Step Success"
                    } else {
                        // ここで終了し、後続のstageは実行しない（postで処理しても同様）
                        echo "Step Failed"
                        if (stepErrorType == "ShellExitCode=1") {
                            sh '[ 1 -eq 0 ]'
                        }
                        if (stepErrorType == "ThrowException") {
                            callThrow()
                        }
                        echo "Code Miss!!"
                    }
                }
                // // stepsではpost利用不可
                // post {
                //     success { echo 'steps post success' }
                //     unsuccessful { echo 'steps post unsuccessful' }
                //     failure { echo 'steps post failure' }
                //     always { echo 'steps post always' }
                // }
            }
            post {
                success { echo 'stage post success' }
                unsuccessful { echo 'stage post unsuccessful' }
                failure { echo 'stage post failure' }
                always { echo 'stage post always' }
            }
        }
        stage('Stage Failed') {
            when {
                not { expression { isStageSuccess.toBoolean() } }
            }
            steps {
                // ここで終了し、後続のstageは実行しない（postで処理しても同様）
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
    // 先発の処理結果に従い常に実行(try-catch文のfinallyに近い)
    post {
        success { echo 'pipeline post success' }
        unsuccessful { echo 'pipeline post unsuccessful' }
        failure { echo 'pipeline post failure' }
        always { echo 'pipeline post always' }
    }
}
