rm -rf sample_python_flask
mkdir sample_python_flask
cd sample_python_flask

which pip

# 実行ファイル作成
cat << EOS > index.py
import flask
app = flask.Flask(__name__)


@app.route('/')
def index():
    return "hello world"


if __name__ == '__main__':
    app.run(port=3000, debug=True)
EOS

# サーバー起動
python index.py
