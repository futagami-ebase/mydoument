// agent dockerを使用した場合の処理(動作未確認)
// jenkinsサーバーに、dockerコマンドのインストールおよび実行権限付与が必要
pipeline {
    agent { docker { image 'php' } }
    stages {
        stage('build') {
            steps {
                sh 'php --version'
            }
        }
    }
}