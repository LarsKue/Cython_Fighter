
IF CYTHON_FIGHTER_ANIMATION_PXD == 0:
    DEF CYTHON_FIGHTER_ANIMATION_PXD = 1


    import pygame as pg

    include "om.pxd"


    cdef class Animation(Object):

        cdef image

        def __cinit__(self, filename):
            self.image = pg.image.load(filename)