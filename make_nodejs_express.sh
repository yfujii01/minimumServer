rm -rf sample_nodejs_express
mkdir sample_nodejs_express
cd sample_nodejs_express

npm init -y
npm install express --save

# 実行ファイル作成
cat << EOS > index.js
var express = require('express');
var app = express();

app.get('/', function (req, res) {
        res.send('hello world');
});

app.listen(3000);
console.log('http://localhost:3000/');
EOS

# サーバー起動
node index.js
