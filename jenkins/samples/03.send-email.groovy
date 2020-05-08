pipeline {
    agent any

    stages {
        stage('send mail') {
            steps {
                script {
                    def mailRecipients = "develop@example.com"
                    def jobName = currentBuild.fullDisplayName

                    emailext body: '''これはテストです''',
                        mimeType: 'text/html',
                        subject: "[Jenkins TEST] ${jobName}",
                        to: "${mailRecipients}",
                        replyTo: "${mailRecipients}",
                        recipientProviders: [[$class: 'CulpritsRecipientProvider']]
                }
            }
        }
    }
}