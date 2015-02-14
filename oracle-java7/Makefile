NAME = airdock/oracle-jdk7
VERSION = 1.0

.PHONY: all clean build tag_latest release debug run

all: build 

clean:
	@CID=$(shell docker ps -a | awk '{ print $$1 " " $$2 }' | grep $(NAME) | awk '{ print $$1 }');  
	@if [ ! -z "$(CID)" ]; then echo "Removing container which reference $(NAME)"; for container in $(CID); do docker rm -f $$container; done; fi;   
	@if docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then docker rmi -f $(NAME):$(VERSION); fi
	@if docker images $(NAME) | awk '{ print $$2 }' | grep -q -F latest; then docker rmi -f $(NAME):latest; fi
	 

build: clean
	docker build -t $(NAME):$(VERSION) --rm .

tag_latest: build
	@docker tag $(NAME):$(VERSION) $(NAME):latest

release: tag_latest
	@if ! docker . $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)
	@echo "Create a tag v-$(VERSION)"
	@git tag v-$(VERSION)
	@git push origin v-$(VERSION) 
	
debug:
	docker run -t -i $(NAME):$(VERSION)

run:
	@echo "IPAddress =" $$(docker inspect --format '{{.NetworkSettings.IPAddress}}' $$(docker run -d $(NAME):$(VERSION)))
	
