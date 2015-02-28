# VERSION 1.0
# AUTHOR:         Jerome Guibert <jguibert@gmail.com>
# DESCRIPTION:    Oracle Java 8
# TO_BUILD:       docker build --rm -t airdock/oracle-jdk:1.8 .
# SOURCE:         https://github.com/airdock-io/docker-oracle-jdk

# Pull base image.
FROM airdock/base:latest

MAINTAINER Jerome Guibert <jguibert@gmail.com>

# add webupd8 repository and Oracle JDK 8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update -qq && \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    rm -rf /var/cache/oracle-java8-installer  && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*


# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define default command.
CMD [ "/bin/bash", "-l"]
