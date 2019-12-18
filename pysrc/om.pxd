

import pygame as pg

# cdef extern from "Object.h" nogil:
#     cdef cppclass Object:
#         Object()
#
#         void update(self, size_t delta_t)
#         void draw(self)

cdef class Object:
    def __init__(self):
        pass

    cpdef void update(self, size_t delta_t):
        pass

    cpdef void draw(self, screen):
        pass

cdef class OM:

    cdef objects
    cdef screen

    def __init__(self):
        self.objects = []

    cpdef void add_object(self, ob):
        self.objects.append(ob)

    cpdef void update(self, size_t delta_t):
        for o in self.objects:
            o.update(delta_t)

    cpdef void draw(self, screen):
        screen.fill((0, 0, 0))

        # draw objects here
        for o in self.objects:
            o.draw(screen)

        pg.display.update()