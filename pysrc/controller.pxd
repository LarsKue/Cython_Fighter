
include "om.pxd"

from libc.stdlib cimport calloc, free
from libcpp cimport bool


cdef class Controller(Object):

    cdef unsigned int* keydurations

    def __cinit__(self):
        super().__init__()
        self.keydurations = <unsigned int*>calloc(323, sizeof(unsigned int))

    def __dealloc__(self):
        free(self.keydurations)

    cpdef void update(self, size_t delta_t):
        cdef size_t i
        cdef bool[323] keys = pg.key.get_pressed()
        for i in range(323):
            if not keys[i]:
                self.keydurations[i] = 0
            else:
                self.keydurations[i] += delta_t


