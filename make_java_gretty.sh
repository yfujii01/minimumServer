rm -rf sample_java_gretty
mkdir sample_java_gretty
cd sample_java_gretty

gradle init

mkdir -p ./src/main/webapp
echo 'hello world!!' > ./src/main/webapp/index.html

echo -e \
	"apply plugin: 'war'\n"\
	"apply from: 'https://raw.github.com/akhikhl/gretty/master/pluginScripts/gretty.plugin'\n"\
	"\n"\
	"gretty {\n"\
	"\thttpPort = 3000\n"\
	"}"\
>> build.gradle

# 起動
gradle appRun
