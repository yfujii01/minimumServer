#/bin/sh

if [ $# -ne 2 ]; then
  echo "引数1にapp nameを入れてください"
  echo "引数2にport番号を入れてください"
  return
fi

appname=$1
appport=$2

rm -rf ${appname}

rails new ${appname}

cd ${appname}

bundle install

# HTTPS設定
cat << EOS >> config/puma.rb
if "development" == ENV.fetch("RAILS_ENV") { "development" }
  ssl_bind '0.0.0.0', '$appport', {
    key: "./ssl/server.key",
    cert: "./ssl/server.crt",
    verify_mode: "none"
  }
end
EOS

# HTTPポートをふさぐ
sed -i 's/^port/#port/' config/puma.rb

# SSL証明書作成
mkdir ssl
cd ssl
curl -L raw.github.com/yfujii01/setting_oreoreSSL/master/make.sh | sh
cd ..



cat << EOS > start.sh
#!/bin/bash
export PATH="$PATH"
cd \`dirname \$0\`
bundle exec pumactl start
EOS

chmod +x start.sh

cat << EOS > ${appname}.service
[Unit]
Description = ${appname}
[Service]
ExecStart=`pwd`/start.sh
Restart=always
Type=simple
User=`whoami`
[Install]
WantedBy=multi-user.target
EOS


cat << EOS > serviceMemo.txt
アプリケーションが作成されました
--------------------
#サーバーを起動する
./${appname}/start.sh
#サービスを削除する
sudo systemctl stop ${appname}
sudo systemctl daemon-reload
sudo rm /etc/systemd/system/${appname}.service
#サービスを登録する
sudo cp ./${appname}/${appname}.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start ${appname}
#サービスの状態を確認する
systemctl status ${appname}
journalctl -xe
#サービスを自動起動する
sudo systemctl is-enabled ${appname}
sudo systemctl enable ${appname}
sudo systemctl disable ${appname}
--------------------
#動作確認する
curl -k -H 'Content-Type:application/json' -d '{"asd":"wet"}' https://localhost:${appport}/
EOS

cat serviceMemo.txt

# 初期フォルダに戻る
cd ..
