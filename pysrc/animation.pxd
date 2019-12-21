#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_ANIMATION_PXD == 0:
    DEF CYTHON_FIGHTER_ANIMATION_PXD = 1


    from libcpp cimport bool

    include "managers.pxd"
    include "vec2.pxd"


    cdef class Animation:

        cdef AnimData data
        cdef unsigned int frame
        cdef unsigned int __n

        def __init__(self, AnimData data):
            super().__init__()
            self.data = data
            self.frame = 0
            self.__n = 0

        cpdef void update(self, size_t delta_t):
            self.__n += 1
            if self.__n == self.data.update_n:
                self.__n = 0
                self.frame += 1
                self.frame %= self.data.frames

        cpdef void draw(self, screen, double x, double y, bool flipx = False, bool flipy = False):
            screen.blit(pg.transform.flip(self.data.surface, flipx, flipy), (x, y), area=(0, self.frame * self.data.frameheight, self.data.surface.get_rect().w, self.data.frameheight))
    