PROJECT_NAME := gfx
CC	:= zcc
CFLAGS	:= +aquarius --generic-console --opt-code-speed -lm -clib=aqplus -m -pragma-include:zpragma.inc -create-app -subtype=aqx

CSRC=$(wildcard *.c)
ASSRC=$(wildcard *.asm)

.PHONY: all clean run dis

all: build build/aqplus/$(PROJECT_NAME).aqx

clean:
	rm -f *.aqx *.map *.bin *.o
	rm -rf build

dis: all
	z88dk-dis -x build/aqplus/$(PROJECT_NAME).map -o CRT_ORG_CODE build/aqplus/$(PROJECT_NAME).bin | less

run: all
	aquarius_emu -u build/aqplus -t "\nrun $(PROJECT_NAME).aqx\n"

build:
	mkdir -p build/aqplus

build/aqplus/%.aqx: $(CSRC) $(ASSRC)
	$(CC) $(CFLAGS) $^ -obuild/aqplus/$(PROJECT_NAME).bin
