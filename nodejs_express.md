# nodejs express

npmとexpressを利用したwebサーバーの最小構成

## 作業環境
- npmとnodeがインストールされていること
- ネットワークに繋がること
- windowsの場合、git(またはcygwin)をインストールしておくこと

## 作り方
1. 空のディレクトリを用意

1. 以下のコマンドを順次実行していく
	```sh
	npm init -y
	npm install express --save

	# 実行ファイル作成
	echo -e \
		"var express = require('express');\n"\
		"var app = express();\n"\
		"\napp.get('/', function (req, res) {\n"\
		"\tres.send('hello world');\n"\
		"});\n"\
		"\n"\
		"app.listen(3000);\n"\
		"console.log('http://localhost:3000/');"\
	> index.js

	# サーバー起動
	node index.js
	```

1. 以下のURLにブラウザでアクセス

	http://localhost:3000

	```html
	hello world
	```
	と表示されれば成功