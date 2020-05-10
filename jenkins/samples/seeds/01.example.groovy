// job DSLプラグインによる、jobファイルの生成pipeline
// @use plugin Job DSL https://www.jenkins.io/doc/pipeline/steps/job-dsl/#jobdsl-process-job-dsls

def seedScript='''
pipelineJob('job-dsl-plugin') {
  definition {
    cpsScm {
      scm {
        git {
          remote {
            url('https://github.com/jenkinsci/job-dsl-plugin.git')
          }
          branch('*/master')
        }
      }
      lightweight()
    }
  }
}
'''
pipeline {
   agent any
   stages {
      stage('create pipeline') {
         steps {
             script {
                 jobDsl useScriptText: true,
                    scriptText: seedScript
             }
         }
      }
   }
}
