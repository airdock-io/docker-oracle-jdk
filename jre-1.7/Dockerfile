# DESCRIPTION:    Oracle Java jre-7u80
# SOURCE:         https://github.com/airdock-io/docker-oracle-jdk/tree/master/jre-7u80

FROM airdock/base:jessie
MAINTAINER Jerome Guibert <jguibert@gmail.com>

# Add java dynamic memory script
COPY java-dynamic-memory-opts /srv/java/

# Install Oracle JDK 7u80
RUN cd /tmp && \
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "http://download.oracle.com/otn-pub/java/jdk/7u80-b15/jre-7u80-linux-x64.tar.gz" && \
    tar xf jre-7u80-linux-x64.tar.gz -C /srv/java && \
    rm -f jre-7u80-linux-x64.tar.gz && \
    ln -s /srv/java/jre* /srv/java/jre && \
    ln -s /srv/java/jre /srv/java/jvm && \
    chown -R java:java /srv/java && \
    /root/post-install

# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/srv/java/jre \
    PATH=${PATH}:/srv/java/jre/bin:/srv/java
