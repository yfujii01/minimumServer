rm -rf./sample_java_spark
mkdir ./sample_java_spark
cd sample_java_spark

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
