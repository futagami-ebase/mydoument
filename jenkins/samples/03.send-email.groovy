// メール送信サンプル
// @use plugin Email Extension
// @use plugin Email Extension Template
// @param boolean isSuccess
// 予め, templateファイルを$JENKINS_HOME/email-templatesに配置しておく必要あり
// 配置したtemplateファイルの内容
/*
GENERAL INFO

BUILD ${build.result ?: 'SUCCESSFUL'}
Build URL: ${rooturl}${build.url}
Project: ${project.name}
Date of build: ${it.timestampString}
Build duration: ${build.durationString}

<%
def changeSets = build.changeSets
if(changeSets != null) {
  def hadChanges = false %>
CHANGE SET
<% changeSets.each() { cs_list ->
      cs_list.each() { cs ->
     hadChanges = true %>
  	 Revision <%= cs.metaClass.hasProperty('commitId') ? cs.commitId : cs.metaClass.hasProperty('revision') ? cs.revision :
        cs.metaClass.hasProperty('changeNumber') ? cs.changeNumber : "" %> by <%= cs.author %>: (<%= cs.msgAnnotated %>)
<%	 cs.affectedFiles.each() { p -> %>
	 change: <%= p.editType.name %> <%= p.path %>
<%     }
     }
   }
  if(!hadChanges) { %>
  No changes
<% }
} %>


<% if(build.result==hudson.model.Result.FAILURE) { %>
CONSOLE OUTPUT
<% 	build.getLog(100).each() { line -> %>
	${line}
<% 	}
   } %>
*/

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
                            '''${SCRIPT, template="sample.template"}'''
                        )
                    }
                }
                unsuccessful { 
                    script {
                        sendMail(
                            "[Failed] " + currentBuild.fullDisplayName, 
                            '''${SCRIPT, template="sample.template"}'''
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

    emailext mimeType: 'text/plain',
        to: mailRecipients, replyTo: mailRecipients,
        subject: subject, body: body,
        attachLog: true, 
        recipientProviders: [[$class: 'CulpritsRecipientProvider']]
}
