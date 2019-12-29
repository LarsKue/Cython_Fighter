#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_ANIMATION_PXD == 0:
    DEF CYTHON_FIGHTER_ANIMATION_PXD = 1


    from libcpp cimport bool

    include "managers/managers.pxd"
    include "utility/vec2.pxd"


    cdef class Animation:

        cdef public AnimData data
        cdef public OutlineData odata
        cdef unsigned int frame
        cdef unsigned int __n

        cdef bool __outline
        cdef int __weight
        cdef str __color

        def __init__(self, AnimData data):
            super().__init__()
            self.data = data
            self.frame = 0
            self.__n = 0
            self.odata = None

        cpdef void set_outline(self, OutlineData odata):
            self.odata = odata

        cpdef void update(self, size_t delta_t):
            self.__n += 1
            if self.__n == self.data.update_n:
                self.__n = 0
                self.frame += 1
                self.frame %= self.data.frames

        cpdef void draw(self, screen, double x, double y, bool flipx = False, bool flipy = False):
            if self.odata:
                screen.blit(pg.transform.flip(self.odata.surface, flipx, flipy), (x - self.odata.weight, y - self.odata.weight), area=(0, self.frame * self.odata.frameheight, self.odata.surface.get_width(), self.odata.frameheight))
            screen.blit(pg.transform.flip(self.data.surface, flipx, flipy), (x, y), area=(0, self.frame * self.data.frameheight, self.data.surface.get_width(), self.data.frameheight))


        cpdef object get_current_frame(self):
            return self.data.surface.subsurface(pg.Rect(0, self.frame * self.data.frameheight, self.data.surface.get_width(), self.data.frameheight)).copy()

    