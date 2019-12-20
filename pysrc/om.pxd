
include "keys.pxd"


cdef class Object:
    def __init__(self):
        pass

    cpdef void update(self, size_t delta_t, Keys keys):
        pass

    cpdef void draw(self, screen):
        pass


cdef class OM:

    cdef list objects
    cdef Keys keys

    def __init__(self):
        self.objects = []
        self.keys = Keys()

    cpdef void add_object(self, Object ob):
        self.objects.append(ob)

    cpdef void update(self, size_t delta_t):
        # we need to ensure the keys are updated prior to object updating
        self.keys.update(delta_t)

        cdef Object o
        for o in self.objects:
            o.update(delta_t, self.keys)

    cpdef void draw(self, screen):
        screen.fill((0, 0, 0))

        # draw objects here
        cdef Object o
        for o in self.objects:
            o.draw(screen)

        pg.display.update()
