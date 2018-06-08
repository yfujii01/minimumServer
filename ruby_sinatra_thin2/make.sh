#/bin/bash

if [ $# -ne 2 ]; then
  echo "引数1にapp nameを入れてください"
  echo "引数2にport番号を入れてください"
  return
fi

appname=$1
appport=$2

rm -rf ${appname}
mkdir ${appname}
cd ${appname}

bundle init

cat << EOS >> Gemfile
gem "sinatra"
gem 'thin'
gem "json"
gem "config"
EOS

bundle install

# 実行ファイル作成
cat << EOS > main.rb
require 'rubygems'
require 'sinatra'
require 'json'

get '/' do
  'Hello, SSL.'
end

# 実行例
# curl -k -H 'Content-Type:application/json' -d '{"asd":"wet"}' https://localhost:${appport}/posttest
post '/posttest' do
  params = JSON.parse request.body.read
  puts params
  puts 'hello'
  "Hello World!!" + params.to_s
end
EOS

cat << EOS > config.ru
require 'rubygems'
require 'sinatra'
require 'json'
require './main.rb'
run Sinatra::Application
EOS


cat << EOS > start.sh
#!/bin/bash
export PATH="$PATH"
cd \`dirname \$0\`
bundle exec thin start -p ${appport} --ssl
EOS

chmod +x start.sh

#service登録用のひな形作成
mkdir service
cd service
cat << EOS > ${appname}.service
[Unit]
Description = ${appname}
[Service]
ExecStart=`pwd`/start.sh
Restart=always
Type=simple
User=`whoami`
[Install]
WantedBy=multi-user.target
EOS

cat << EOS > serviceMemo.txt
アプリケーションが作成されました
--------------------
#サーバーを起動する
./${appname}/start.sh
#サービスを削除する
sudo systemctl stop ${appname}
sudo systemctl daemon-reload
sudo rm /etc/systemd/system/${appname}.service
#サービスを登録する
sudo cp ./${appname}/${appname}.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start ${appname}
#サービスの状態を確認する
systemctl status ${appname}
journalctl -xe
#サービスを自動起動する
sudo systemctl is-enabled ${appname}
sudo systemctl enable ${appname}
sudo systemctl disable ${appname}
--------------------
#動作確認する
curl -k -H 'Content-Type:application/json' -d '{"asd":"wet"}' https://localhost:${appport}/posttest
EOS
cd ..

#git登録
git init
cat << EOS > .gitignore
service/
ssl/
start.sh
EOS
cat << EOS > README.md
# ${appname}

## How to Exec

bundle exec thin start -p ${appport} --ssl
EOS
git add .
git commit -m '${appname} create!'

cat ./service/serviceMemo.txt

# 初期ディレクトリに戻る
cd ..
