MODULE_NAME = Swiftg8
MODULE_BUILD_TYPE = Debug

FRONTG8_ROOT_DIR=../..
FRONTG8_INCLUDE_DIR=$(FRONTG8_ROOT_DIR)/include
FRONTG8_BUILD_DIR=$(FRONTG8_ROOT_DIR)/build
FRONTG8_LIB_DIR=$(FRONTG8_BUILD_DIR)/products/$(MODULE_BUILD_TYPE)/lib

SCFLAGS = -I CFrontg8
CCFLAGS = -isystem $(FRONTG8_INCLUDE_DIR)
LDFLAGS = -lfrontg8 -lprotobuf -L $(FRONTG8_LIB_DIR) -rpath $(FRONTG8_LIB_DIR)
CMFLAGS = -DCMAKE_BUILD_TYPE=$(MODULE_BUILD_TYPE)

S = swift
SFLAGS = $(foreach flag,$(SCFLAGS),-Xswiftc $(flag)) \
				 $(foreach flag,$(CCFLAGS),-Xcc $(flag)) \
				 $(foreach flag,$(LDFLAGS), -Xlinker $(flag)) \

.PHONY: all clean

all: frontg8 module test

clean:
	@echo CLEAN
	@$(S) build --clean

frontg8:
	@echo "CMAKE Frontg8 - $(MODULE_BUILD_TYPE)"
	@cd $(FRONTG8_BUILD_DIR) && cmake $(CMFLAGS) .. &>/dev/null
	@echo "BUILD Frontg8 - $(MODULE_BUILD_TYPE)"
	@cd $(FRONTG8_BUILD_DIR) && cmake --build . -- -j$(shell nproc) &>/dev/null

module:
	@echo "SWIFT $(MODULE_NAME)"
	@$(S) build -c $(shell echo $(MODULE_BUILD_TYPE) | tr A-Z a-z) $(SFLAGS)

test:
	@echo "TEST $(MODULE_NAME)"
	@$(S) test $(SFLAGS)
