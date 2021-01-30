.PHONY: build
build:
	sam build

.PHONY: deploy
deploy: build
	./script/deploy-syllabus.sh
