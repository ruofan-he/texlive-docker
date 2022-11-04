.PHONY: build
build: 
	docker build -t texlive-docker .

.PHONY: clear
clear:
	docker rmi texlive-docker