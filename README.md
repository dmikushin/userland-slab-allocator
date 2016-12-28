## CPU/CUDA Slab Allocator for userspace

This fork provides a basic implementation of Slab Allocator on CPU in
userspace as well as on CUDA GPUs on top of preallocated GPU memory space.

Usage:

```
$ make
$ ./slab cpu
$ ./slab gpu
```

On CPU implementation relies on anonymous `mmap(2)` page allocations,
or occassionally on `posix_memalign(3)` for larger objects.

On GPU slabs are created in memory space preallocated with `cudaMalloc`.

Bit-vectors are used to indicate whether the corresponding slots are free
and that makes the allocations and deallocations very quick most of the time.

When allocating an object, a 64-bit unsigned integer is scanned for its first
set bit (this usually translates to a single `BSF` instruction on x86).

When deallocating an object, the location of the corresponding slab is quickly
found by masking the passed object pointer with the alignment mask of the
corresponding slab chain.

![alt tag](https://raw.github.com/dmikushin/userland-slab-allocator/master/screenshot.png)

## License

You may freely modify and redistribute the code as long as you preserve the
link in the source code to this repository.
