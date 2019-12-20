
IF CYTHON_FIGHTER_KEYS_PXD == 0:
    DEF CYTHON_FIGHTER_KEYS_PXD = 1


    import pygame as pg

    from libc.stdlib cimport calloc, free
    from libcpp cimport bool


    DEF NUMKEYS = 323


    cdef class Keys:

        cdef unsigned int* durations

        def __cinit__(self):
            self.durations = <unsigned int*>calloc(NUMKEYS, sizeof(unsigned int))

        def __dealloc__(self):
            free(self.durations)

        cpdef void update(self, size_t delta_t):
            cdef size_t i
            cdef bool[323] keys = pg.key.get_pressed()
            for i in range(NUMKEYS):
                if not keys[i]:
                    self.durations[i] = 0
                else:
                    self.durations[i] += delta_t
