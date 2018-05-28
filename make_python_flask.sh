mkdir sample_python_flask
cd sample_python_flask

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
