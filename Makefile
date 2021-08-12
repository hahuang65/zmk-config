.PHONY: build clean

IMAGE=zmk-config
BUILD_DIR=build
BOARD=

.image: Dockerfile west.yml scripts/*
	docker build --rm --tag $(IMAGE) .
	@echo "This file is generated from the Makefile for the $@ rule" > $@

build: .image
ifeq ($(strip $(BOARD)),)
	@echo "\`BOARD\` is a required argument."
else
	mkdir --parents $(BUILD_DIR)
	docker run --rm --env BOARD=$(BOARD) --volume $(PWD)/$(BUILD_DIR):/build $(IMAGE)
endif

clean:
	rm -rf $(BUILD_DIR) .image
