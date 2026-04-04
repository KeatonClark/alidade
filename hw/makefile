.PHONY: clean all install

PROJECT ?= $(basename $(firstword $(wildcard *.kicad_pro)))
ifeq ($(PROJECT),)
	$(error No .kicad_pro file found. Set PROJECT=<name> explicitly)
endif

KICAD_SCH ?= $(PROJECT).kicad_sch
KICAD_PCB ?= $(PROJECT).kicad_pcb
CONFIG ?= $(PROJECT).kibot.yaml
LICENSE ?= LICENSE-CC-BY-SA

OUT_DIR ?= build
DATASHEET_DIR ?= lib/datasheets

PREFIX ?= /usr/local
DATAROOTDIR ?= $(PREFIX)/share
DATADIR ?= $(DATAROOTDIR)/$(PROJECT)
DESTDIR ?=

INSTALL_DIR := $(DESTDIR)$(DATADIR)

SOURCES := $(shell find . \
	   \( -name '*.kicad_pro' \
	   -o -name '*.kicad_sch' \
	   -o -name '*.kicad_pcb' \
	   -o -name '*.kicad_sym' \
	   -o -name '*.kicad_mod' \
	   -o -name '*.kibot.yaml' \
	   \) -not -path './.git/*' \
	   -not -path './$(OUT_DIR)/*' \
	   2>/dev/null)

STAMP := $(OUT_DIR)/.build_stamp

KIBOT_FLAGS := -e $(KICAD_SCH) -b $(KICAD_PCB) -c $(CONFIG) -d $(OUT_DIR)

all: $(STAMP)

$(STAMP): $(SOURCES)
	@mkdir -p $(OUT_DIR)
	kibot $(KIBOT_FLAGS)
	@touch $@

install: $(STAMP)
	@echo "Installing to $(INSTALL_DIR)"
	@install -d $(INSTALL_DIR)
	@cd $(OUT_DIR) && find . -type f -exec \
		install -D -m 0644 {} $(INSTALL_DIR)/{} \;
	@install -D -m 0644 $(LICENSE) $(INSTALL_DIR)
	@cd $(DATASHEET_DIR) && find . -type f -exec \
		install -D -m 0644 {} $(INSTALL_DIR)/datasheets/{} \;

clean:
	rm -rf $(OUT_DIR)

