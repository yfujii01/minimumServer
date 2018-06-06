rm -rf ./sample_java_spark
mkdir ./sample_java_spark
cd sample_java_spark

gradle init

mkdir -p ./src/main/java/init
cat << EOS >> ./src/main/java/init/Server.java
package init;

import static spark.Spark.*;

public class Server {
    public static void main(String[] args) {
        port(3000);
        System.out.println("http://localhost:3000/hello");
        get("/hello", (request, response) -> "hello world");
        System.out.println("http://localhost:3000/json");
        get("/json", "application/json", (request, response) -> "{\"message\": \"Hello World\"}");
    }
}
EOS

cat << EOS >> build.gradle
apply plugin: 'application'
mainClassName = 'init/Server'
repositories {
    mavenCentral()
}
dependencies {
    // https://mvnrepository.com/artifact/com.sparkjava/spark-core
    compile group: 'com.sparkjava', name: 'spark-core', version: '2.7.2'
}
EOS

# 起動
gradle run
