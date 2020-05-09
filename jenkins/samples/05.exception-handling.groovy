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
                        // ここで終了し、後続のstageは実行しない
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
