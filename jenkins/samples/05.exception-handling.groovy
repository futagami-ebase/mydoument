// 例外/エラー発生時の処理実装
// @param boolean isStageSuccess
// @param boolean isStepSuccess
// @param boolean isErrorHandle1
// @param boolean isErrorHandle2
// @param choice  StepErrorType
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
                        // ここに来たら、実装ミス
                        echo "Code Miss!!"
                    }
                }
            }
            post {
                success { echo 'stage post success' }
                unsuccessful { echo 'stage post unsuccessful' }
                failure { echo 'stage post failure' }
                always { echo 'stage post always' }
            }
        }
        stage('Step ErrorHandle1') {
            when {
                expression { isErrorHandle1.toBoolean() }
            }
            steps {
                script {
                    catchError(message: "catch error message") {
                        echo "catch error"
                    }
                    // ここで終了し、後続のstageは実行しない（postで処理しても同様）
                    echo "Start ErrorHandle1"
                    if (stepErrorType == "ShellExitCode=1") {
                        sh '[ 1 -eq 0 ]'
                    }
                    if (stepErrorType == "ThrowException") {
                        callThrow()
                    }
                    // ここに来たら、実装ミス
                    echo "Code Miss!!"
                }
            }
        }
        stage('Step ErrorHandle2') {
            when {
                expression { isErrorHandle2.toBoolean() }
            }
            steps {
                script {
                    try {
                        // ここで終了せず、後続のstageは実行する
                        echo "Start ErrorHandle2"
                        if (stepErrorType == "ShellExitCode=1") {
                            sh '[ 1 -eq 0 ]'
                        }
                        if (stepErrorType == "ThrowException") {
                            callThrow()
                        }
                        // ここに来たら、実装ミス
                        echo "Code Miss!!"
                    } catch(err) {
                        echo "Error: ${err}"

                    } finally {
                        echo "Finally"
                    }
                }
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
