# Project Configuration
NAMESPACE = airdock
NAME = oracle-jdk
FULLNAME=$(NAMESPACE)/$(NAME)
BASE_URL=http://download.oracle.com/otn-pub/java/jdk/
PLATFORM=-linux-x64.tar.gz

# supported version
VERSION_LIST = 8u66-b17/jdk-8u66 8u65-b17/jdk-8u65 8u60-b27/jdk-8u60 8u51-b16/jdk-8u51 \
	8u45-b14/jdk-8u45 8u40-b25/jdk-8u40 8u31-b13/jdk-8u31 8u25-b17/jdk-8u25 \
	7u80-b15/jdk-7u80 7u79-b15/jdk-7u79

# special tag
LATEST_VERSION := jdk-8u66
TAG_JAVA_8 := jdk-8u66
TAG_JAVA_7 := jdk-7u80

# Inner make rules
INFO_VERSION := $(addsuffix .info,$(VERSION_LIST))
GENERATE_VERSION := $(addsuffix .generate,$(VERSION_LIST))
BUILD_VERSION :=  $(addsuffix .build,$(VERSION_LIST))
CLEAN_VERSION :=  $(addsuffix .clean,$(VERSION_LIST))
READ_VERSION :=  $(addsuffix .read,$(VERSION_LIST))

# ----------------------------------------
# Build all docker image
#
build: COMMENT=Build all docker image
build: header $(BUILD_VERSION) footer
$(BUILD_VERSION):
	@set -e ;\
	SUFFIX=$@; SUFFIX=$${SUFFIX%.build}; \
	FOLDER=$$(basename $$SUFFIX); \
	make -C $$FOLDER build;

# ----------------------------------------
# Clean all docker image
#
clean: COMMENT=Clean all docker image
clean: header $(CLEAN_VERSION) footer
$(CLEAN_VERSION):
	@set -e ;\
	SUFFIX=$@; SUFFIX=$${SUFFIX%.clean}; \
	FOLDER=$$(basename $$SUFFIX); \
	make -C $$FOLDER clean;

# ----------------------------------------
# Generate Docker project source
#
generate: COMMENT=Generating Docker source files
generate: clean_generate header $(GENERATE_VERSION)
	@echo Generate latest tag to $(LATEST_VERSION)
	@ln -s $(LATEST_VERSION) jdk-latest
	@echo Generate 1.8 tag to $(TAG_JAVA_8)
	@ln -s $(TAG_JAVA_8) jdk-1.8
	@echo Generate 1.7 tag to $(TAG_JAVA_7)
	@ln -s $(TAG_JAVA_7) jdk-1.7
	@echo "----------------------------------------"
	@echo

clean_generate:
	@rm -rf jdk-*

$(GENERATE_VERSION):
	@set -e ;\
	SUFFIX=$@; SUFFIX=$${SUFFIX%.generate}; \
	FOLDER=$$(basename $$SUFFIX); \
	VERSION=$${SUFFIX##*/jdk-}; \
	VERSION_URL=$(BASE_URL)$${SUFFIX}$(PLATFORM); \
	echo Generate $$VERSION; \
	mkdir -p $$FOLDER; \
	cp -R src/docker/* $$FOLDER; \
	cp src/docker/.dockerignore $$FOLDER; \
	for template in src/template/*; do \
		target=$${template##*/}; \
		sed -e "s;%NAMESPACE%;$(NAMESPACE);g" -e "s;%NAME%;$(NAME);g" \
			-e "s;%FOLDER%;$$FOLDER;g" -e "s;%VERSION%;$$VERSION;g" \
			-e "s;%VERSION_URL%;$$VERSION_URL;g" $$template > $$FOLDER/$$target; \
	done;


# ----------------------------------------
# Information about supported version
#
info: COMMENT=List of supported Oracle JDK Version
info: header $(INFO_VERSION) footer
$(INFO_VERSION):
	@set -e ;\
	SUFFIX=$@; SUFFIX=$${SUFFIX%.info}; \
	FOLDER=$$(basename $$SUFFIX); \
	VERSION=$${SUFFIX##*/jdk-}; \
	VERSION_URL=$(BASE_URL)$${SUFFIX}$(PLATFORM); \
	echo $$VERSION: folder=$$FOLDER, url=$$VERSION_URL;

# ----------------------------------------
# Used to generate Supported Version
# of Readme file
read: $(READ_VERSION)
	@set -e ;\
	echo \> [$(FULLNAME):latest]\(https://github.com/airdock-io/docker-oracle-jdk/tree/master/latest\) \($(LATEST_VERSION)\); \
	echo \> [$(FULLNAME):1.8]\(https://github.com/airdock-io/docker-oracle-jdk/tree/master/latest\) \($(TAG_JAVA_8)\); \
	echo \> [$(FULLNAME):1.7]\(https://github.com/airdock-io/docker-oracle-jdk/tree/master/latest\) \($(TAG_JAVA_7)\);

$(READ_VERSION):
	@set -e ;\
	SUFFIX=$@; SUFFIX=$${SUFFIX%.read}; \
	FOLDER=$$(basename $$SUFFIX); \
	echo - [$(FULLNAME):$$FOLDER]\(https://github.com/airdock-io/docker-oracle-jdk/tree/master/$$FOLDER\);

# ----------------------------------------
# Utilities
#
header:
	@echo "----------------------------------------"
	@echo $(COMMENT)
	@echo "----------------------------------------"

footer:
	@echo "----------------------------------------"
	@echo

# ----------------------------------------
# Start default docker machine
#
start:
	@docker-machine start default
	@eval "$(docker-machine env default)"

.PHONY: info $(INFO_VERSION) generate clean_generate $(GENERATE_VERSION) build $(BUILD_VERSION) clean $(CLEAN_VERSION) read $(READ_VERSION) header footer start
