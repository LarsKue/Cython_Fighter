
IF CYTHON_FIGHTER_PHYSICS_PXD == 0:
    DEF CYTHON_FIGHTER_PHYSICS_PXD = 1


    import math

    from libcpp cimport bool

    include "../managers/om.pxd"
    include "Vec2.pxd"


    cdef class Physics(Object):

        cdef Vec2[bool] orientation
        cdef Vec2[double] position
        cdef Vec2[double] velocity
        cdef Vec2[double] force

        cdef double gravity_multiplier

        def __init__(self):
            super().__init__()
            self.position = Vec2[double]()
            self.velocity = Vec2[double]()
            self.force = Vec2[double]()
            self.orientation = Vec2[bool]()

            self.gravity_multiplier = 1

        cpdef void update(self, size_t delta_t, Keys keys):
            # implicit euler integration
            self.velocity = self.velocity + delta_t * self.force + (delta_t * self.gravity_multiplier) * Vec2[double](0, 0.001)
            self.position = self.position + delta_t * self.velocity
            self.force = Vec2[double]()

            if not math.isclose(self.velocity.x, 0):
                self.orientation.x = self.velocity.x < 0

            if not math.isclose(self.velocity.y, 0):
                self.orientation.y = self.velocity.y < 0
