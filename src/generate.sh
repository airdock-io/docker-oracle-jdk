#!/bin/bash

# supported version
JDK_VERSION_LIST="8u74-b02/jdk-8u74 8u72-b15/jdk-8u72 \
  8u66-b17/jdk-8u66 8u65-b17/jdk-8u65 8u60-b27/jdk-8u60 \
	8u51-b16/jdk-8u51 \
	8u45-b14/jdk-8u45 8u40-b25/jdk-8u40 8u31-b13/jdk-8u31 8u25-b17/jdk-8u25 \
	7u80-b15/jdk-7u80 7u79-b15/jdk-7u79 \
	"
JRE_VERSION_LIST="8u74-b02/jre-8u74 8u66-b17/jre-8u66 8u65-b17/jre-8u65 \
	7u80-b15/jre-7u80 \
	"

# special tag
LATEST_VERSION="jdk-8u74"
TAG_JDK_8="jdk-8u74"
TAG_JRE_8="jre-8u74"
TAG_JDK_7="jdk-7u80"
TAG_JRE_7="jre-7u80"


# project definition
NAMESPACE="airdock"
NAME="oracle-jdk"
FULLNAME="$NAMESPACE/$NAME"
BASE_URL="http://download.oracle.com/otn-pub/java/jdk/"
PLATFORM="-linux-x64.tar.gz"

# Basic variable
ROOT_DIR=${PWD}
BUILD_DIR=$ROOT_DIR/../build
SRC_DIR=$ROOT_DIR
TARGET_DIR=$ROOT_DIR/..

# log a message $1
log() {
  echo "[$(date +'%d/%m/%y %X')] $1"
}

# clean all build directory
clean() {
    rm -rf ${BUILD_DIR}
}


# generate docker source for a specific version ($1) and prefix $2 (jre or jdk)
generate() {
    version_prefix=$1
		prefix=$2
    folder=$(basename $version_prefix)
		prefix=${folder:0:3}
    version=${folder:4:4}
    version_url=${BASE_URL}${version_prefix}${PLATFORM}
    target_folder=${TARGET_DIR}/${folder}
    log "Build ${version} (${version_url}) into ${folder}"

    mkdir -p ${target_folder}
    # clean up
    rm -rf ${target_folder}/*

    cp ${SRC_DIR}/docker/* ${target_folder}
    cp ${SRC_DIR}/docker/.dockerignore ${target_folder}
    cp ${SRC_DIR}/docker/.gitignore ${target_folder}
    cp ${BUILD_DIR}/README.md ${target_folder}

    for template in ${SRC_DIR}/template/*; do
        template_output=${target_folder}/${template##*/}
        sed -e "s;%NAMESPACE%;$NAMESPACE;g" -e "s;%NAME%;$NAME;g" \
                -e "s;%FOLDER%;$folder;g" -e "s;%VERSION%;$version;g" \
                -e "s;%VERSION_URL%;$version_url;g"  -e "s;%README_VERSION%;$README_VERSION;g" \
								-e "s;%PREFIX%;$prefix;g" \
								$template > $template_output
     done;
}

# generate readme content
generateReadMe() {
    readme=""
    NL="NEWLINE"
    # special tag
    readme="${readme} > [${FULLNAME}:latest](https://github.com/airdock-io/docker-oracle-jdk/tree/master/) (${LATEST_VERSION}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:latest.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:latest 'Get your own badge on imagelayers.io')${NL}${NL}"
    readme="${readme}###Latest tag per version and type${NL}"
		readme="${readme} - [${FULLNAME}:1.8](https://github.com/airdock-io/docker-oracle-jdk/tree/master/jdk-1.8) (${TAG_JDK_8}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:1.8.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:1.8 'Get your own badge on imagelayers.io')${NL}"
		readme="${readme} - [${FULLNAME}:jdk-1.8](https://github.com/airdock-io/docker-oracle-jdk/tree/master/jdk-1.8) (${TAG_JDK_8}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:jdk-1.8.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:jdk-1.8 'Get your own badge on imagelayers.io')${NL}"
		readme="${readme} - [${FULLNAME}:jre-1.8](https://github.com/airdock-io/docker-oracle-jdk/tree/master/jre-1.8) (${TAG_JRE_8}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:jre-1.8.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:jre-1.8 'Get your own badge on imagelayers.io')${NL}"
    readme="${readme} - [${FULLNAME}:1.7](https://github.com/airdock-io/docker-oracle-jdk/tree/master/jdk-1.7) (${TAG_JDK_8}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:1.7.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:1.7 'Get your own badge on imagelayers.io')${NL}"
		readme="${readme} - [${FULLNAME}:jdk-1.7](https://github.com/airdock-io/docker-oracle-jdk/tree/master/jdk-1.7) (${TAG_JDK_7}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:jdk-1.7.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:jdk-1.7 'Get your own badge on imagelayers.io')${NL}"
		readme="${readme} - [${FULLNAME}:jre-1.7](https://github.com/airdock-io/docker-oracle-jdk/tree/master/jre-1.7) (${TAG_JRE_7}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:jre-1.7.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:jre-1.7 'Get your own badge on imagelayers.io')${NL}${NL}${NL}"
		readme="${readme}###Specific version${NL}"
		# Version
    for supported_version in $JDK_VERSION_LIST; do
        folder=$(basename $supported_version)
        readme="${readme} - [${FULLNAME}:${folder}](https://github.com/airdock-io/docker-oracle-jdk/tree/master/${folder}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:${folder}.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:${folder} 'Get your own badge on imagelayers.io')${NL}"
    done;
		for supported_version in $JRE_VERSION_LIST; do
				folder=$(basename $supported_version)
				readme="${readme} - [${FULLNAME}:${folder}](https://github.com/airdock-io/docker-oracle-jdk/tree/master/${folder}) [![](https://badge.imagelayers.io/airdock/oracle-jdk:${folder}.svg)](https://imagelayers.io/?images=airdock/oracle-jdk:${folder} 'Get your own badge on imagelayers.io')${NL}"
		done;
    sed -e "s;%README_VERSION%;$readme;g" -e "s;NEWLINE;\n;g" ${SRC_DIR}/README.md > ${BUILD_DIR}/README.md
}

# generate docker source for special tag
generateTag() {
    name=$1
    version=$2
    log "Build alias ${name} to ${version}"
    target_folder=${TARGET_DIR}/${name}
    mkdir -p ${target_folder}
    rm -rf ${target_folder}/*
    cp -R ${TARGET_DIR}/${version}/* ${target_folder}
    cp ${TARGET_DIR}/${version}/.dockerignore ${target_folder}/
    cp ${TARGET_DIR}/${version}/.gitignore ${target_folder}/
}

generateLatest() {
    log "Build latest to ${LATEST_VERSION}"
    source_folder=${TARGET_DIR}/${LATEST_VERSION}
    for target in ${source_folder}/*; do
        file=$(basename $target)
        cp --force ${source_folder}/${file} ${TARGET_DIR}/${file}
    done;
    cp --force ${source_folder}/.dockerignore ${TARGET_DIR}/
    cp --force ${source_folder}/.gitignore ${TARGET_DIR}/
}

mkdir -p ${BUILD_DIR}
# prebuild readme
generateReadMe

# build each version
for supported_version in $JDK_VERSION_LIST; do
    generate $supported_version
done;
for supported_version in $JRE_VERSION_LIST; do
    generate $supported_version
done;

# generate special tag

generateTag "jdk-1.8" ${TAG_JDK_8}
generateTag "jre-1.8" ${TAG_JRE_8}

generateTag "jdk-1.7" ${TAG_JDK_7}
generateTag "jre-1.7" ${TAG_JRE_7}

# generate latest
generateLatest

clean
