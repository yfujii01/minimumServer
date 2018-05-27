# minimumPython

pipとflaskを利用したwebサーバーの最小構成

## 作業環境
- pipとpythonがインストールされていること
- ネットワークに繋がること
- windowsの場合、git(またはcygwin)をインストールしておくこと

## 作り方
1. 空のディレクトリを用意

1. 以下のコマンドを順次実行していく
	```sh
	pip install Flask

	# 実行ファイル作成
	echo -e "import flask" > index.py
	echo -e "app = flask.Flask(__name__)" >> index.py
	echo -e "" >> index.py
	echo -e "" >> index.py
	echo -e "@app.route('/')" >> index.py
	echo -e "def index():" >> index.py
	echo -e "    return \"hello world\"" >> index.py
	echo -e "" >> index.py
	echo -e "" >> index.py
	echo -e "if __name__ == '__main__':" >> index.py
	echo -e "    app.run(port=3000, debug=True)" >> index.py

	# サーバー起動
	python index.py
	```

1. 以下のURLにブラウザでアクセス

	http://localhost:3000

	```html
	hello world
	```
	と表示されれば成功