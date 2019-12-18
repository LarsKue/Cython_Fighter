
# TODO: come up with a better name for this

include "controller.pxd"
# include "om.pxd"
include "vec2.pxd"

cdef class Physics(Object):

    cdef Vec2[double] position
    cdef Vec2[double] velocity
    cdef Vec2[double] force

    def __init__(self):
        super().__init__()
        self.position = Vec2[double]()
        self.velocity = Vec2[double]()
        self.force = Vec2[double]()

    cpdef void update(self, size_t delta_t):
        # implicit euler integration
        self.velocity = self.velocity + self.force * delta_t
        self.position = self.position + self.velocity * delta_t