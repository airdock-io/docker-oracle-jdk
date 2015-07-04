# Oracle Java

Docker Image for Oracle Java 8 and 7 based on airdock/base:latest


> Name: airdock/oracle-jdk:1.8 (or airdock/oracle-jdk:latest) and airdock/oracle-jdk:1.7

**Dependency**: airdock/base:latest

**Few links**:

 - [Docker Java Image](https://github.com/dockerfile/java)


# Usage

You should have already install [Docker](https://www.docker.com/).

Execute:

	'docker run -t -i  airdock/oracle-jdk:1.8 java -version'


You can run your java application with java:java user (define in airdock/base) :

	gosu java:java java -jar /var/lib/java/myapplication.jar




# Change Log

## Tag 1.8 and latest (current)

- add java:java user
- add webupd8team key
- add oracle jdk 8
- declare JAVA_HOME
- use MIT license

## Tag: 1.7

- add java:java user
- add webupd8team key
- add oracle jdk 7
- declare JAVA_HOME
- use MIT license

# Build


- Install "make" utility, and execute: `make build`
- Or execute: 'docker build -t airdock/oracle-jdk8:latest --rm .'

See [Docker Project Tree](https://github.com/airdock-io/docker-base/wiki/Docker-Project-Tree) for more details.


# MIT License

```
The MIT License (MIT)

Copyright (c) 2015 Airdock.io

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
