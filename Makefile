#
# Makefile for the output source package
#

ifeq ($(KERNELRELEASE),)

MAKEFLAGS += --no-print-directory
SHELL := /bin/bash
BACKPORT_DIR := $(shell pwd)

KMODDIR ?= updates
ifneq ($(origin KLIB), undefined)
KMODPATH_ARG := "INSTALL_MOD_PATH=$(KLIB)"
else
KLIB := /lib/modules/$(shell uname -r)/
KMODPATH_ARG :=
endif
KLIB_BUILD ?= $(KLIB)/build/
KERNEL_CONFIG := $(KLIB_BUILD)/.config
KERNEL_MAKEFILE := $(KLIB_BUILD)/Makefile
CONFIG_MD5 := $(shell md5sum $(KERNEL_CONFIG) 2>/dev/null | sed 's/\s.*//')

export KLIB KLIB_BUILD BACKPORT_DIR KMODDIR KMODPATH_ARG

# disable built-in rules for this file
.SUFFIXES:

.PHONY: default
default:
	$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_DIR)
	
.PHONY: clean
clean:
	$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_DIR) clean
	
.PHONY: install
install: default
	@$(MAKE) -C $(KLIB_BUILD) M=$(BACKPORT_DIR)			\
		INSTALL_MOD_DIR=$(KMODDIR) $(KMODPATH_ARG)		\
		modules_install
	@./scripts/check_depmod.sh
	@/sbin/depmod -a
	@./scripts/fw_install.sh

.PHONY: uninstall
uninstall:
	@./scripts/uninstall.sh
	@/sbin/depmod -a
		
else
include $(BACKPORT_DIR)/Makefile.kernel
endif

