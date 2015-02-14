# Oracle Java

Docker Image for Oracle Java 8 and 7 based on airdock/base:latest

This repository contains **Dockerfile** for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/airdock/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


> Name: airdock/oracle-jdk:1.8 (or airdock/oracle-jdk:latest) and airdock/oracle-jdk:1.7

**Dependency**: airdock/base:latest

**Few links**:

 - [Docker Java Image](https://github.com/dockerfile/java)


# Usage

1. You should have already install [Docker](https://www.docker.com/) and [Fig](http://www.fig.sh/) for more complex usage.
2. Download [automated build](https://registry.hub.docker.com/u/airdock/) from public [Docker Hub Registry](https://registry.hub.docker.com/):
`docker search airdock` or go directly in 3.
3. Execute:
	'docker run -t -i  airdock/oracle-jdk:1.8 java -version'



# Change Log

## Tag 1.8 and latest (current)

- add webupd8team key
- add oracle jdk 8
- declare JAVA_HOME
- use Expat/MIT license

## Tag: 1.7

- add webupd8team key
- add oracle jdk 7
- declare JAVA_HOME
- use Expat/MIT license

# Build

You can build an image from  [Dockerfile](https://github.com/airdock-io/docker-base).
You can install "make" utility, and execute: `make build`

In root makefile, you could retrieve two task:

- **build**: build all sub project
- **clean**: clean all sub project


In each sub project Makefile, you could retreive this *variables*:

- NAME: declare a full image name (aka airdock/oracle-jdk8)
- VERSION: declare image version

And *tasks*:

- **all**: alias to 'build'
- **clean**: remove all container which depends on this image, and remove image previously builded
- **build**: clean and build the current version
- **tag_latest**: build and tag current version with ":latest"
- **release**: execute tag_latest, push image onto registry, and tag git repository
- **debug**: launch default command with builded image in interactive mode
- **run**: run image as daemon and print IP address.



# License

```
 Copyright (c) 1998, 1999, 2000 Thai Open Source Software Center Ltd

 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:

 The above copyright notice and this permission notice shall be included
 in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
 CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
 TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 ```
