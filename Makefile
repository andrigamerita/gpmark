# GPMark for Miyoo by octospacc
# originally for RetroFW by pingflood; 2019

TARGET = gpmark/gpmark

ifdef HOST
	SYSROOT := $(shell $(CC) --print-sysroot)
	SDL_CONFIG = $(SYSROOT)/usr/bin/sdl-config
	TARGET = gpmark/gpmark.exe
else
	CHAINPREFIX=/opt/miyoo
	CROSS_COMPILE=$(CHAINPREFIX)/bin/arm-miyoo-linux-uclibcgnueabi-
	CC = $(CROSS_COMPILE)gcc
	CXX = $(CROSS_COMPILE)g++
	STRIP = $(CROSS_COMPILE)strip
	SYSROOT := $(shell $(CC) --print-sysroot)
	SDL_CONFIG = $(SYSROOT)/usr/bin/sdl-config
endif

OBJ  = src/objs/menu.o src/objs/bitfonts.o src/objs/blitting.o src/objs/bunny3d.o src/objs/engine3d.o src/objs/env1.o src/objs/generate3d.o src/objs/main.o src/objs/plasma.o src/objs/radialblur.o src/objs/render3d.o src/objs/rotozoomer.o src/objs/sky1.o
LINKOBJ  = $(OBJ)
LIBS =  `$(SDL_CONFIG) --libs` -s -lSDL_ttf
INCS =  -I$(SYSROOT)/usr/include  -I$(SYSROOT)/usr/lib  -I$(SYSROOT)/lib -I./src
CXXINCS =  $(INCS)
CXXFLAGS = $(CXXINCS) -DGP2X -fexpensive-optimizations -O3
CFLAGS = $(INCS) -DGP2X -fexpensive-optimizations -O3
RM = rm -f
MKDIR = mkdir -p

.PHONY: all all-before all-after clean clean-custom

all: all-before $(TARGET) all-after

all-before:
	@$(MKDIR) "src/objs" "gpmark"

$(TARGET): $(OBJ)
	$(CXX) $(LINKOBJ) -o $@ $(LIBS)

src/objs/menu.o: src/menu.c
	$(CXX) -c src/menu.c -o src/objs/menu.o $(CXXFLAGS)

src/objs/bitfonts.o: src/bitfonts.cpp
	$(CXX) -c src/bitfonts.cpp -o src/objs/bitfonts.o $(CXXFLAGS)

src/objs/blitting.o: src/blitting.cpp
	$(CXX) -c src/blitting.cpp -o src/objs/blitting.o $(CXXFLAGS)

src/objs/bunny3d.o: src/bunny3d.cpp
	$(CXX) -c src/bunny3d.cpp -o src/objs/bunny3d.o $(CXXFLAGS)

src/objs/engine3d.o: src/engine3d.cpp
	$(CXX) -c src/engine3d.cpp -o src/objs/engine3d.o $(CXXFLAGS)

src/objs/env1.o: src/env1.cpp
	$(CXX) -c src/env1.cpp -o src/objs/env1.o $(CXXFLAGS)

src/objs/generate3d.o: src/generate3d.cpp
	$(CXX) -c src/generate3d.cpp -o src/objs/generate3d.o $(CXXFLAGS)

src/objs/main.o: src/main.cpp
	$(CXX) -c src/main.cpp -o src/objs/main.o $(CXXFLAGS)

src/objs/plasma.o: src/plasma.cpp
	$(CXX) -c src/plasma.cpp -o src/objs/plasma.o $(CXXFLAGS)

src/objs/radialblur.o: src/radialblur.cpp
	$(CXX) -c src/radialblur.cpp -o src/objs/radialblur.o $(CXXFLAGS)

src/objs/render3d.o: src/render3d.cpp
	$(CXX) -c src/render3d.cpp -o src/objs/render3d.o $(CXXFLAGS)

src/objs/rotozoomer.o: src/rotozoomer.cpp
	$(CXX) -c src/rotozoomer.cpp -o src/objs/rotozoomer.o $(CXXFLAGS)

src/objs/sky1.o: src/sky1.cpp
	$(CXX) -c src/sky1.cpp -o src/objs/sky1.o $(CXXFLAGS)

clean: clean-custom
	${RM} $(OBJ) $(TARGET) $(TARGET).exe
