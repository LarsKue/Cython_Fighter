#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_SM_PXD == 0:
    DEF CYTHON_FIGHTER_SM_PXD = 1


    import pygame as pg

    cdef enum SurfaceID:
        sPlayer,


    cdef class SM:
        # Surface Manager for static textures

        cdef dict __surfaces

        def __init__(self):
            self.__surfaces = {}

        cdef void add(self, str filename, SurfaceID surface_id):
            if surface_id in self.__surfaces:
                raise ValueError(f"\nDuplicate Surface ID: {surface_id}\n"
                                 f"File: {filename}")
            self.__surfaces[surface_id] = pg.image.load(filename).convert()

        cdef object get(self, SurfaceID surface_id):
            return self.__surfaces[surface_id]

        cdef void remove(self, SurfaceID surface_id):
            del self.__surfaces[surface_id]
