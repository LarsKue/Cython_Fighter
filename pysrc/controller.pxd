
include "om.pxd"

cdef class Controller(Object):

    cdef dict actions

    # def __init__(self, dict actions):
    def __init__(self):
        super().__init__()
        # self.actions = actions

    cpdef void update(self, size_t delta_t):
        events = pg.event.get()
        for event in events:
            print(type(event))
            print(event)
            # if event in self.actions:
            #     self.actions[event](delta_t)


