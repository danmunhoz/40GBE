CXX=gcc
CODE=RFC2544
CMP_FLAGS=-lm -lpthread
DBG_FLAGS=-D DEBUG
RESOURCES=$(shell find ./ -name '*.c' -print)
RESOURCES+= $(shell find ./ -name '*.h' -print)

all: $(RESOURCES)
all: clean
all: executable

debug: $(RESOURCES)
debug: clean
debug: CMP_FLAGS += $(DBG_FLAGS)
debug: executable

executable:
	$(CXX) -o RFC2544 RFC2544.c $(CMP_FLAGS)

clean:
	rm -f RFC2544
