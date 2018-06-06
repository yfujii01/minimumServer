rm -rf sample_ruby_sinatra
mkdir sample_ruby_sinatra
cd sample_ruby_sinatra

# gem install
#gem install sinatra
#gem install unicorn
#gem install bundler

bundle init

cat << EOS > Gemfile
gem "sinatra"
EOS

# 実行ファイル作成
cat << EOS > app.rb
require 'rubygems'
require 'sinatra'

get '/' do
  "Hello World!!"
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
listen 3000, :tcp_nopush => false

# ログ
stderr_path 'log/unicorn.log'
stdout_path 'log/unicorn.log'
EOS

mkdir log
mkdir tmp

# サーバー起動
unicorn -c unicorn.conf

