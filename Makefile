
C99 = -std=c99

LDFLAGS := -lm
CFLAGS := -Wall -Os -g

PREFIX ?= /usr
PKG_CONFIG_PATH = ${PREFIX}/lib/pkgconfig:${PREFIX}/lib64/pkgconfig
PKG_CONFIG = PKG_CONFIG_PATH="$$PKG_CONFIG_PATH:${PKG_CONFIG_PATH}" pkg-config

GAMMU_LDFLAGS := $(shell $(PKG_CONFIG) --libs gammu 2>/dev/null)
GAMMU_CFLAGS := $(shell $(PKG_CONFIG) --cflags gammu 2>/dev/null)

all: gammu-json

gammu-json:
	gcc -o gammu-json gammu-json.c $(C99) $(CFLAGS) $(LDFLAGS) $(GAMMU_CFLAGS) $(GAMMU_LDFLAGS)

clean:
	rm -f gammu-json

install: install-gammu-json

install-gammu-json: gammu-json
	install -o root gammu-json "$(PREFIX)/bin/gammu-json"

uninstall: uninstall-gammu-json

uninstall-gammu-json:
	rm -f "$(PREFIX)/bin/gammu-json"

