.PHONY: build clean

IMAGE=zmk-config
BUILD_DIR=build
BOARD=

build: Dockerfile west.yml scripts/*
ifeq ($(strip $(BOARD)),)
	@echo "'BOARD' is a required argument."
else
	docker build --rm --tag $(IMAGE) .
	mkdir --parents $(BUILD_DIR)
	docker run --rm --env BOARD=$(BOARD) --volume $(PWD)/$(BUILD_DIR):/build $(IMAGE)
endif

clean:
	rm -rf $(BUILD_DIR)
