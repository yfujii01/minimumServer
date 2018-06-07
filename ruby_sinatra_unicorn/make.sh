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

#gem install
#gem install bundler

bundle init

cat << EOS >> Gemfile
gem "sinatra"
gem "unicorn"
gem "json"
EOS

bundle install

# 実行ファイル作成
cat << EOS > app.rb
require 'rubygems'
require 'sinatra'
require 'json'

get '/' do
  "Hello World!!"
end

get '/abc' do
  "ABC Hello World!!"
end

post '/posttest' do
  params = JSON.parse request.body.read
  puts params
  puts 'hello'
  "BC Hello World!!" + params.to_s
end
EOS

cat << EOS > config.ru
require './app.rb'
run Sinatra::Application
EOS

cat << EOS > unicorn.conf
# ワーカーの数
worker_processes 2

# ソケット
listen '`pwd`/tmp/unicorn-lokka.sock'
listen ${appport}, :tcp_nopush => false

# ログ(ログに出力する場合は以下のコメントを外す)
# stderr_path 'log/unicorn.log'
# stdout_path 'log/unicorn.log'
EOS

mkdir log
mkdir tmp

cat << EOS > start.sh
#!/bin/bash

export PATH="\$HOME/.anyenv/bin:\$PATH"
eval "\$(anyenv init -)"

cd \`dirname \$0\`
bundle exec unicorn -c unicorn.conf
EOS

chmod +x start.sh

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

# 初期ディレクトリに戻る
cd ..

echo 'アプリケーションが作成されました'
echo '--------------------'
echo 'サーバーを起動する'
echo './'${appname}'/start.sh'
echo 'サービスを登録する'
echo 'sudo cp ./'${appname}'/'${appname}'.service /etc/systemd/system/'
echo 'sudo systemctl daemon-reload'
echo 'sudo systemctl start '${appname}
echo 'サービスの状態を確認する'
echo 'systemctl status '${appname}
echo 'journalctl -xe'
echo 'サービスを自動起動する'
echo 'sudo systemctl is-enabled '${appname}
echo 'sudo systemctl enable '${appname}
echo 'sudo systemctl disable '${appname}
echo 'サービスを削除する'
echo 'sudo systemctl stop '${appname}
echo 'sudo systemctl daemon-reload'
echo 'sudo rm /etc/systemd/system/'${appname}'.service' 
echo '--------------------'


