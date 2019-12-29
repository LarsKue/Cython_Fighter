#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_AM_PXD == 0:
    DEF CYTHON_FIGHTER_AM_PXD = 1


    import os
    import pygame as pg
    from sortedcontainers import SortedSet

    include "../utility/utils.pxd"


    cdef class AnimData:
        cdef public surface
        cdef public str filename
        cdef public unsigned int frames
        cdef public unsigned int frameheight
        cdef public unsigned int update_n

        def __init__(self, surface, str filename, unsigned int frames, unsigned int frameheight, unsigned int update_n):
            self.surface = surface
            self.filename = filename
            self.frames = frames
            self.frameheight = frameheight
            self.update_n = update_n




    cdef class AM:
        # Animation Manager for animated textures

        cdef __animations

        def __init__(self):
            self.__animations = SortedSet(key=lambda x: x.filename)


        cdef AnimData add(self, str filename, unsigned int update_n):
            cdef unsigned int frames = AM.__get_frames(filename)
            surface = pg.image.load(filename).convert_alpha()
            cdef (size_t, size_t) size = surface.get_size()
            if size[1] % frames != 0:
                raise ValueError("\nSource Image Specifies Invalid Number of Frames:\n"
                                 f"Image : {filename}\n"
                                 f"Height: {size[1]}\n"
                                 f"Frames: {frames}\n"
                                 f"Closest Valid Height: {closest_multiple(size[1], frames)}\n"
                                 f"Closest Valid Frame#: {closest_divisor(size[1], frames)}\n")

            cdef AnimData data
            data = AnimData(surface, filename, frames, size[1] // frames, update_n)
            self.__animations.add(data)
            return data

        cdef void __add(self, AnimData data):
            self.__animations.add(data)


        cdef object get(self, str filename):
            return self.__animations[filename]

        cdef void remove(self, str filename):
            del self.__animations[filename]

        @staticmethod
        cdef unsigned int __get_frames(str filename):
            filename = os.path.splitext(os.path.basename(filename))[0]
            return int(filename[filename.rfind(".") + 1:])