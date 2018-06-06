rm -rf sample_java_gretty
mkdir sample_java_gretty
cd sample_java_gretty

gradle init

mkdir -p ./src/main/webapp
cat << EOS > ./src/main/webapp/index.html
hello world!!
EOS

cat << EOS >> build.gradle
apply plugin: 'war'
apply from: 'https://raw.github.com/akhikhl/gretty/master/pluginScripts/gretty.plugin'

gretty {
    httpPort = 3000
}
EOS

# 起動
gradle appRun
