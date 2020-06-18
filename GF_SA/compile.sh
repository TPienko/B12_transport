#!/bin/bash 

# Tcl needs to be compiled with --enable-shared
swig -c++ -tcl8 vectors.i
icc -fpic -std=c++11 -c vectors.cxx vectors_wrap.cxx -I${tcl_dir}/include
icc -std=c++11 -shared vectors.o vectors_wrap.o -o vectors.so
