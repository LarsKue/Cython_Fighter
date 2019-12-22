
IF CYTHON_FIGHTER_OM_PXD == 0:
    DEF CYTHON_FIGHTER_OM_PXD = 1


    import pygame as pg

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

        cpdef void add(self, Object ob):
            self.objects.append(ob)

        cpdef void remove(self, Object ob):
            self.objects.remove(ob)

        # TODO: dirty rects (see https://www.pygame.org/docs/tut/newbieguide.html )
        cpdef void update(self, size_t delta_t):
            # we need to ensure the keys are updated prior to object updating
            self.keys.update(delta_t)

            cdef Object o
            for o in self.objects:
                o.update(delta_t, self.keys)

        cpdef void draw(self, screen):
            screen.fill((125, 255, 0))

            # draw objects here
            cdef Object o
            for o in self.objects:
                o.draw(screen)

            pg.display.flip()
