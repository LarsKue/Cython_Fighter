
IF CYTHON_FIGHTER_PHYSICS_PXD == 0:
    DEF CYTHON_FIGHTER_PHYSICS_PXD = 1


    from libcpp cimport bool

    include "om.pxd"
    include "vec2.pxd"


    cdef class Physics(Object):

        cdef Vec2[double] position
        cdef Vec2[double] velocity
        cdef Vec2[double] force

        cdef double gravity_multiplier

        def __init__(self):
            super().__init__()
            self.position = Vec2[double]()
            self.velocity = Vec2[double]()
            self.force = Vec2[double]()

            self.gravity_multiplier = 1

        cpdef void update(self, size_t delta_t, Keys keys):
            # implicit euler integration
            self.velocity = self.velocity + self.force * delta_t + Vec2[double](0, 0.001) * (delta_t * self.gravity_multiplier)
            self.position = self.position + self.velocity * delta_t
            self.force = Vec2[double]()
