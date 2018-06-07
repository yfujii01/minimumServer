# minimumServer

各言語で最小構成のserverを構築する

shellを実行してください


## ruby

引数(アプリ名称,ポート番号)

curl -L raw.github.com/yfujii01/minimumServer/master/ruby_sinatra_unicorn/make.sh | sh -s -- sample_rubyapp 3000

curl -L raw.github.com/yfujii01/minimumServer/master/ruby_sinatra_thin/make.sh | sh -s -- sample_rubyapp 3000

curl -L raw.github.com/yfujii01/minimumServer/master/ruby_rails_puma/make.sh | sh -s -- sample_rubyapp 3000

