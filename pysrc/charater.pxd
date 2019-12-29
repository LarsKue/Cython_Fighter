#
# Created by Lars on 27/12/2019
#

IF CYTHON_FIGHTER_CHARACTER_PXD == 0:
    DEF CYTHON_FIGHTER_CHARACTER_PXD = 1


    include "managers/managers.pxd"
    include "utility/physics.pxd"


    cdef class Character(Object):

        cdef dict animations
        cdef Physics physics

        def __init__(self, dict animations):
            super().__init__()
            self.animations = animations






