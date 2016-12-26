# DESCRIPTION:    Oracle Java %FOLDER%
# SOURCE:         https://github.com/airdock-io/docker-oracle-jdk/tree/master/%FOLDER%

FROM airdock/base:jessie
MAINTAINER Jerome Guibert <jguibert@gmail.com>

# Add java dynamic memory script
COPY java-dynamic-memory-opts /srv/java/

# Install Oracle JDK %VERSION%
RUN cd /tmp && \
    curl -L -O -H "Cookie: oraclelicense=accept-securebackup-cookie" -k "%VERSION_URL%" && \
    tar xf %FOLDER%-linux-x64.tar.gz -C /srv/java && \
    rm -f %FOLDER%-linux-x64.tar.gz && \
    ln -s /srv/java/%PREFIX%* /srv/java/%PREFIX% && \
    ln -s /srv/java/%PREFIX% /srv/java/jvm && \
    chown -R java:java /srv/java && \
    /root/post-install

# Define commonly used JAVA_HOME variable
# Add /srv/java and jdk on PATH variable
ENV JAVA_HOME=/srv/java/%PREFIX% \
    PATH=${PATH}:/srv/java/%PREFIX%/bin:/srv/java
