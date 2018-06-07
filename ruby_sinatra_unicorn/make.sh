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

cat << EOS > Gemfile
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

source ~/.bashrc

cd \`dirname \$0\`
bundle exec unicorn -c unicorn.conf
EOS

chmod +x start.sh

# 初期ディレクトリに戻る
cd ..

# サーバー起動
./${appname}/start.sh

