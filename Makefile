.PHONY: build clean

IMAGE=zmk-config
BUILD_DIR=build
BOARD=

build: Dockerfile west.yml scripts/*
ifeq ($(strip $(BOARD)),)
	@echo "'BOARD' is a required argument."
else
	@if [ -f boards/$(BOARD)/west.yml ]; then \
		docker build --rm --build-arg WEST_CONFIG=boards/$(BOARD)/west.yml --tag $(IMAGE)-$(BOARD) .; \
	else \
		docker build --rm --tag $(IMAGE)-$(BOARD) .; \
	fi;
	mkdir --parents $(BUILD_DIR)
	docker run --rm --env BOARD=$(BOARD) --volume $(PWD)/$(BUILD_DIR):/build $(IMAGE)-$(BOARD)
endif

clean:
	rm -rf $(BUILD_DIR)
