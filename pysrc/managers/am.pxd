#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_AM_PXD == 0:
    DEF CYTHON_FIGHTER_AM_PXD = 1


    import pygame as pg

    include "../math/utils.pxd"

    
    cdef enum AnimationID:
        aPlayer,


    cdef class AnimData:
        cdef surface
        cdef unsigned int frames
        cdef unsigned int frameheight
        cdef unsigned int update_n

        def __init__(self, surface, unsigned int frames, unsigned int frameheight, unsigned int update_n):
            self.surface = surface
            self.frames = frames
            self.frameheight = frameheight
            self.update_n = update_n


    cdef class AM:
        # Animation Manager for animated textures

        cdef dict __animations

        def __init__(self):
            self.__animations = {}


        cdef AnimData add(self, str filename, AnimationID animation_id, unsigned int frames, unsigned int update_n):
            if animation_id in self.__animations:
                raise ValueError(f"\nDuplicate Animation ID: {animation_id}\n"
                                 f"filename  : {filename}\n"
                                 f"frames    : {frames}\n"
                                 f"update_n  : {update_n}")

            surface = pg.image.load(filename).convert()
            cdef (size_t, size_t) size = surface.get_rect().size
            if not size[1] % frames == 0:
                raise ValueError("\nInvalid Source Image given for Animation:\n"
                                 f"Image : {filename}\n"
                                 f"Height: {size[1]}\n"
                                 f"Frames: {frames}\n"
                                 f"Closest Valid Height: {closest_multiple(size[1], frames)}\n"
                                 f"Closest Valid Frame#: {closest_divisor(size[1], frames)}\n")

            cdef AnimData data
            data = AnimData(surface, frames, size[1] // frames, update_n)
            self.__animations[animation_id] = data
            return data



        cdef object get(self, AnimationID animation_id):
            return self.__animations[animation_id]

        cdef void remove(self, AnimationID animation_id):
            del self.__animations[animation_id]