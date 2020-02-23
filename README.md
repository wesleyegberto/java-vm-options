# Java Docker Images

Repository to test different JVM.

Project structure:

* *hello-app*: Spring Boot app with simple REST controller.
* *test-results*: Output from the tests.
* *monitored_ab_stress.sh*: Script to run a given command, attach a monitoring tool to the process  and run Apache Bench test against a given URL.

## Build the App

First build the app with: `sh build_app.sh`.

Test the app: `curl http://localhost:8080/greetings`

## JVMs

Environments variables:

* JAVA11_HOME: HotSpot 11
* JAVAj11_HOME: OpenJ9 11
* JAVAg11_HOME: GraalVM 11
* JAVAz11_HOME: Zulu 11

## Partial Results

### HotSpot 11

```
java version "11.0.1" 2018-10-16 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.1+13-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.1+13-LTS, mixed mode)
```

```
Time to start the server: 4 s
Total CPU time used at startup: 14050 s
Time to finish the test: 2 s
```

![Resources](test-results/output-hotspot-11/hotspot-11.png)

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

```
Time to start the server: 4 s
Total CPU time used at startup: 7590 s
Time to finish the test: 2 s
```

![Resources](test-results/output-openj9-11/openj9-11.png)

#### Tuned and Prewarmed

```
Time to start the server: 3 s
Total CPU time used at startup: 3870 s
Time to finish the test: 2 s
```

![Resource](test-results/output-openj9-11-tuned/openj9-11-tuned.png)

### Zulu 11

```
openjdk version "11.0.6" 2020-01-14 LTS
OpenJDK Runtime Environment Zulu11.37+17-CA (build 11.0.6+10-LTS)
OpenJDK 64-Bit Server VM Zulu11.37+17-CA (build 11.0.6+10-LTS, mixed mode)
```

```
Time to start the server: 3 s
Total CPU time used at startup: 8000 s
Time to finish the test: 2 s
```

![Resources](test-results/output-zulu-11/zulu-11.png)

## TODO

* [x] HotSpot VM 11
* [x] OpenJ9 VM 11
* [x] Zulu VM 11
* [ ] GraalVM 11
* [ ] Increase the load

## Links

* [OpenJ9](https://www.eclipse.org/openj9/)
* [GraalVM](https://www.graalvm.org/)
* [Zulu VM](https://www.azul.com/downloads/zulu-community)
