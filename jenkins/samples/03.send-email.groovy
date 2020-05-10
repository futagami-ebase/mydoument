// メール送信サンプル
// @use plugin Email Extension
// @use plugin Email Extension Template
// @param boolean isSuccess
// 予め, templateファイルをemail-templatesに配置しておく必要あり

pipeline {
    agent any

    stages {
        stage('send mail') {
            steps {
                script {
                    if ( isSuccess.toBoolean() ) {
                        echo "Step Success"
                    } else {
                        echo "Step Error"
                        sh "exit 1"
                    }
                }
            }
            post {
                success { 
                    script {
                        sendMail(
                            "[SUCCESS] " + currentBuild.fullDisplayName, 
                            "test"
                        )
                    }
                }
                unsuccessful { 
                    script {
                        sendMail(
                            "[Failed] " + currentBuild.fullDisplayName, 
                            "error test"
                        )
                    }
                }
                // failure { echo 'stage post failure' }
                // always { echo 'stage post always' }
            }
        }
    }
}

void sendMail(String subject, String body) {
    def mailRecipients = "develop@example.com"

    emailext mimeType: 'text/html',
        to: mailRecipients, replyTo: mailRecipients,
        subject: subject, body: body,
        attachLog: true, 
        recipientProviders: [[$class: 'CulpritsRecipientProvider']]
}
