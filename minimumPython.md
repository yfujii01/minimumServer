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
	echo -e \
		"app = flask.Flask(__name__)\n"\
		"import flask\n"\
		"\n"\
		"\n"\
		"@app.route('/')\n"\
		"def index():\n"\
		"    return \"hello world\"\n"\
		"\n"\
		"\n"\
		"if __name__ == '__main__':\n"\
		"    app.run(port=3000, debug=True)"\
	>index.py

	# サーバー起動
	python index.py
	```

1. 以下のURLにブラウザでアクセス

	http://localhost:3000

	```html
	hello world
	```
	と表示されれば成功