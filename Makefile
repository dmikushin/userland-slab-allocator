all: slab

slab: slab.cu slab.h
	nvcc -g -O3 -std=c++11 -D_ISOC11_SOURCE -D_POSIX_C_SOURCE=200809L -D_BSD_SOURCE  $< -o $@

clean:
	rm -rf slab

