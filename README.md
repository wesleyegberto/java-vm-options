# Java Docker Images

Repository to test different JVM.

Project structure:

* *hello-app*: Spring Boot app with simple REST controller.
* *test-results*: Output from the tests.
* *monitored_ab_stress.sh*: Script to run a given command, attach a monitoring tool to the process  and run Apache Bench test against a given URL.

The result folde for each one contains:

* ApacheBench output
* Application log (to see the startup time taken)
* `psrecord` output and graph
* file with version of the JVM

## Setup

Install the JDKs using [Jabba](https://github.com/shyiko/jabba).

```
jabba install adopt@1.11.0-6
jabba install adopt-openj9@1.11.0-6
jabba install zulu@1.11.0-6
jabba install amazon-corretto@1.11.0-6.10.1
jabba install graalvm@19.3.1
```

## Build the App

First build the app with: `sh build_app.sh`.

Test the app: `curl http://localhost:8080/greetings`

## JVMs

Environments variables:

* JAVA11_HOME: HotSpot 11
* JAVAo11_HOME: OpenJ9 11
* JAVAg11_HOME: GraalVM 11
* JAVAz11_HOME: Zulu 11
* JAVAc11_HOME: Amazon Corretto 11

## Partial Results

### HotSpot 11

```
java version "11.0.1" 2018-10-16 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.1+13-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.1+13-LTS, mixed mode)
```

#### Vanilla

![Resources](test-results/output-hotspot-11/hotspot-11.png)

#### CDS

![Resources](test-results/output-hotspot-11-cds/hotspot-11-cds.png)

### OpenJ9 11

```
openjdk version "11.0.6" 2020-01-14
OpenJDK Runtime Environment AdoptOpenJDK (build 11.0.6+10)
Eclipse OpenJ9 VM AdoptOpenJDK (build openj9-0.18.1, JRE 11 Mac OS X amd64-64-Bit Compressed References 20200122_450 (JIT enabled, AOT enabled)
OpenJ9   - 51a5857d2
OMR      - 7a1b0239a
JCL      - da35e0c380 based on jdk-11.0.6+10)
```

#### Vanilla

![Resources](test-results/output-openj9-11/openj9-11.png)

#### [AOT](https://www.eclipse.org/openj9/docs/aot/)

![Resource](test-results/output-openj9-11-aot/openj9-11-aot.png)

#### [AOT](https://www.eclipse.org/openj9/docs/aot/) and [JIT](https://www.eclipse.org/openj9/docs/jit/)

![Resource](test-results/output-openj9-11-tuned/openj9-11-tuned.png)

### Zulu 11

```
openjdk version "11.0.6" 2020-01-14 LTS
OpenJDK Runtime Environment Zulu11.37+17-CA (build 11.0.6+10-LTS)
OpenJDK 64-Bit Server VM Zulu11.37+17-CA (build 11.0.6+10-LTS, mixed mode)
```

#### Vanilla

![Resources](test-results/output-zulu-11/zulu-11.png)

#### CDS

![Resources](test-results/output-zulu-11-cds/zulu-11-cds.png)

### Amazon Correto 11

```
openjdk version "11.0.6" 2020-01-14 LTS
OpenJDK Runtime Environment Corretto-11.0.6.10.1 (build 11.0.6+10-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.6.10.1 (build 11.0.6+10-LTS, mixed mode)
```

#### Vanilla

![Resources](test-results/output-corretto-11/corretto-11.png)

#### CDS

![Resources](test-results/output-corretto-11-cds/corretto-11-cds.png)

## TODO

* [x] HotSpot VM 11
* [x] OpenJ9 VM 11
* [x] Zulu VM 11
* [x] Amazon Corretto
* [ ] GraalVM 11
* [ ] Increase the load

## Links

* [OpenJ9](https://www.eclipse.org/openj9/)
* [OpenJ9 CDS](https://developer.ibm.com/components/java-platform/tutorials/j-class-sharing-openj9)
* [GraalVM](https://www.graalvm.org/)
* [Zulu VM](https://www.azul.com/downloads/zulu-community)
* [Amazon Corretto](https://aws.amazon.com/pt/corretto/)
* [Microsoft Docs Abount Containerize Java Applications](https://docs.microsoft.com/en-us/azure/developer/java/containers/overview)
