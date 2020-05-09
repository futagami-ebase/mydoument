// 設定ファイルの読み込み・書き込みを行うためのサンプル
// 予め、userContentにファイルを配置しておく必要あり

def CONFIG_PATH_YML = env.JENKINS_HOME + "/userContent/configs/config.yml"
def CONFIG_PATH_PRO = env.JENKINS_HOME + "/userContent/configs/config.properties"
def CONFIG_PATH_NO  = env.JENKINS_HOME + "/userContent/configs/sample-version"

def datas
def type = "all"

pipeline {
    agent any

    stages {
        stage('read yaml') {
            steps {
                script{
                    datas = readYaml file: "${CONFIG_PATH_YML}"
                    println(datas)
                    for (host in datas.root.hosts."${type}") {
                        build(
                            job: '00.sub',
                            parameters: [
                                string(name: 'name', value: host.name),
                                string(name: 'ip', value: host.ip)
                            ]
                        )
                        println(host.name)
                        println(host.ip)
                    }
                }
            }
        }
        // stage('read write sample-version') {
        //     steps {
        //          archiveArtifacts fileName
        //     }
        // }

        // stage('read properties') {
        //     steps {
        //         script{
        //             datas = readProperties file: "${CONFIG_PATH_PRO}"
        //             println(datas)
        //         }
        //     }
        // }

    }

    // post {
    //     always {
    //         cleanWs()
    //     }
    // }
}