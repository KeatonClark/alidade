.PHONY: clean all install

PROJECT ?= $(basename $(firstword $(wildcard *.kicad_pro)))
ifeq ($(PROJECT),)
	$(error No .kicad_pro file found. Set PROJECT=<name> explicitly)
endif

SCH ?= $(PROJECT).kicad_sch
PCB ?= $(PROJECT).kicad_pcb
CONFIG ?= $(PROJECT).kibot.yaml

OUT_DIR ?= output

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

KIBOT_FLAGS := -e $(SCH) -b $(PCB) -c $(CONFIG) -d $(OUT_DIR)

all: $(STAMP)

$(STAMP): $(SOURCES)
	@mkdir -p $(OUT_DIR)
	kibot $(KIBOT_FLAGS)
	@touch $@

install: $(STAMP)
	@echo "installing to $(INSTALL_DIR)"
	@cd $(OUT_DIR) && install -d $(INSTALL_DIR) && find . -type f -exec \
		install -D -m 0644 {} $(INSTALL_DIR)/{} \;

clean:
	rm -rf $(OUT_DIR)

