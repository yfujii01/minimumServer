rm -rf sample_nodejs_express
mkdir sample_nodejs_express
cd sample_nodejs_express

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
