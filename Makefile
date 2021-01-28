.PHONY: build

build:
	sam build

deploy: build
	sam deploy --parameter-overrides $$(cat .env | tr '\n' ' ') --no-fail-on-empty-changeset

