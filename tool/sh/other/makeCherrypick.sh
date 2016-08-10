#!/bin/bash

# git cherry-pick実行ファイル作成スクリプト
# ./makeCherrypick.sh [git logのオプション] の実行で
# 　カレントディレクトリにcherry pickするための実行ファイルを生成する
# 　・cherry pickするコミットハッシュ値はgit logで出力した内容
# 　・オプション未指定の場合は全ログを出力
# 　・生成する実行ファイル名は「変数：exefilename」で指定した文字列
# 　・生成する実行ファイルが存在している場合は上書きする

exefilename='git_cherrypick.sh';
ops=$@;

# 定型文入力
echo "#!/bin/bash -e" > ${exefilename};
echo "" >> ${exefilename};

# git logからコミットハッシュ値を抽出し、コマンド文を入力
if [ -n "${ops}" ]; then
  git log --reverse ${ops} | sed 's/^/#/' | sed 's/#commit/git cherry-pick/' >> ${exefilename};
else
  git log --reverse | sed 's/^/#/' | sed 's/#commit/git cherry-pick/' >> ${exefilename};
fi;
