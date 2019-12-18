
include "om.pxd"

cdef class Controller(Object):

    cdef dict actions

    # def __init__(self, dict actions):
    def __init__(self, actions):
        super().__init__()
        self.actions = actions

    cpdef void update(self, size_t delta_t):
        keys = pg.key.get_pressed()
        for key, pressed in enumerate(keys):
            if key in self.actions:
                self.actions[key](delta_t, pressed)


