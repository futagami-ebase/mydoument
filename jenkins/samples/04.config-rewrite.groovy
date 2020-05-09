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
        stage('read write sample-version') {
            steps {
                script {
                    def line = readFile(file: CONFIG_PATH_NO)
                    writeFile(file: CONFIG_PATH_NO, text: line + "-1")
                    echo line
                    echo readFile(file: CONFIG_PATH_NO)
                }
            }
        }
        stage('read yaml') {
            steps {
                script{
                    datas = readYaml file: "${CONFIG_PATH_YML}"
                    println(datas)
                    for (host in datas.root.hosts."${type}") {
                        println(host.name)
                        println(host.ip)
                        // ビルドに時間がかかるので、コメントアウト
                        // build(
                        //     job: '00.sub',
                        //     parameters: [
                        //         string(name: 'name', value: host.name),
                        //         string(name: 'ip', value: host.ip)
                        //     ]
                        // )
                    }
                }
            }
        }

        // ビルド時間短縮のため、コメントアウト
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