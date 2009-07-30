PREFIX ?= /home/users/stephen/bins/atheme
ATHEME ?= ../atheme

ATHEME_CFLAGS = -I$(ATHEME)/include -I$(ATHEME)/libmowgli/src/libmowgli -DDATADIR=\"$(PREFIX)/etc\"

SOURCES = $(wildcard *.c)
MODULES = $(patsubst %.c,%.so,$(SOURCES))

default: $(MODULES)

clean:
	rm -f $(MODULES)

%.so: %.c syn.h
	gcc -std=c99 -Wall -Werror -O1 -ggdb3 -fPIC $(ATHEME_CFLAGS) -shared -o$@ $<

.PHONY: install

install: $(MODULES)
	install -d $(PREFIX)/modules/syn
	for m in $(MODULES); do \
	    install $${m} $(PREFIX)/modules/syn/$${m}.tmp; \
	    mv $(PREFIX)/modules/syn/$${m}{.tmp,}; \
	done
	install -d $(PREFIX)/help/syn
	install -t $(PREFIX)/help/syn help/*




