# -*- mode: makefile -*-

INC_DIR =
LIBS =

HEADERS = calculation.h
SRC = calculation.c
OBJ = calculation.o
OBJ_dbg = calculation_dbg.o

CXX = g++
CFLAGS=-O3 -Wall -Wextra -Wvla -msse3 \
	-W -Wwrite-strings \
	-Winline \
	-I${INC_DIR} \
	-std=gnu++11

CFLAGS_CYTHON=$(shell python3-config --cflags) ${INC_DIR} \
    -shared -pthread -fPIC -fwrapv -fno-strict-aliasing

PYLIBS=$(shell python3-config --ldflags) ${LIBS}

# do not delete vtk files -- in fact: don't delete any secondary files
# See: [[https://www.gnu.org/software/make/manual/html_node/Special-Targets.html]]
.SECONDARY:

all: calculate.so calculate_dbg.so

%.o: %.c %.h
	${CXX} ${CFLAGS} -c ${<} -o ${@}

%_dbg.o: %.c %.h
	${CXX} $(filter-out -O3,${CFLAGS}) -c ${<} -o ${@}

%_wrapper.c: %.pyx ${HEADERS}
	cython -3 -a ${<} -o ${@}

%_dbg.pyx: %.pyx
	cp ${<} ${@}

%_dbg_wrapper.c: %_dbg.pyx ${HEADERS}
	cython -3 -a --gdb ${<} -o ${@}

%.so: %_wrapper.c ${SRC} ${HEADERS} ${OBJ}
	${CXX} ${CFLAGS_CYTHON} -o ${@} ${<} ${OBJ} ${PYLIBS}

%_dbg.so: %_dbg_wrapper.c ${SRC} ${HEADERS} ${OBJ_dbg}
	${CXX} -O0 $(filter-out -O3,${CFLAGS_CYTHON}) -o ${@} ${<} ${OBJ_dbg} ${PYLIBS}

.PHONY:
clean:
	git clean -fx
