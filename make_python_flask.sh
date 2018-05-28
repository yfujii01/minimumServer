rm -rf sample_python_flask
mkdir sample_python_flask
cd sample_python_flask

which pip

# 実行ファイル作成
echo -e \
"import flask\n"\
"app = flask.Flask(__name__)\n"\
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
