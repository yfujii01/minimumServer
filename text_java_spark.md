# java spark

gradleとsparkを利用したwebサーバーの最小構成

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

	mkdir -p ./src/main/java/init
	echo -e \
		'package init;\n'\
		'\n'\
		'import static spark.Spark.*;\n'\
		'\n'\
		'public class Server {\n'\
		'\tpublic static void main(String[] args) {\n'\
		'\t\tport(3000);\n'\
		'\t\tSystem.out.println("http://localhost:3000/hello");\n'\
		'\t\tget("/hello", (request, response) -> "hello world");\n'\
		'\n'\
		'\t\tSystem.out.println("http://localhost:3000/json");\n'\
		'\t\tget("/json", "application/json", (request, response) -> "{\"message\": \"Hello World\"}");\n'\
		'\t}\n'\
		'}'\
	>> ./src/main/java/init/Server.java

	echo -e \
		"apply plugin: 'application'\n"\
		"mainClassName = 'init/Server'\n"\
		"repositories {\n"\
		"\tmavenCentral()\n"\
		"}\n"\
		"dependencies {\n"\
		"\t// https://mvnrepository.com/artifact/com.sparkjava/spark-core\n"\
		"\tcompile group: 'com.sparkjava', name: 'spark-core', version: '2.7.2'\n"\
		"}"\
	>> build.gradle

	# 起動
	gradle run
	```

1. 以下のURLにブラウザでアクセス

	http://localhost:3000/hello

	```html
	hello world
	```
	と表示されれば成功