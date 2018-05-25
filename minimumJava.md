# minimumJava

gradleとjettyを利用したwebサーバーの最小構成

## 作業環境
- gradleがインストールされていること
- ネットワークに繋がること
- windowsの場合、git(またはcygwin)をインストールしておくこと

## 作り方
1. 空のディレクトリを用意
	デフォルト設定ではフォルダ名＝機能名になる

1. 以下のコマンドを順次実行していく
	```sh
	gradle init

	mkdir -p ./src/main/webapp
	echo 'hello world!!' > ./src/main/webapp/index.html

	echo -e "apply plugin: 'war'\napply from: 'https://raw.github.com/akhikhl/gretty/master/pluginScripts/gretty.plugin'\n\ngretty {\n\thttpPort = 3000\n}" >> build.gradle

	# 起動
	gradle appRun
	```

1. 以下のURLにブラウザでアクセス

	http://localhost:3000/機能名

	```html
	hello world!!
	```
	と表示されれば成功