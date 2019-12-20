
from libcpp cimport bool

include "physics.pxd"
include "vec2.pxd"

import pygame as pg

cdef class Player(Object):

    cdef texture
    cdef Physics physics

    def __init__(self, str texture_path):
        super().__init__()
        self.texture = pg.image.load(texture_path)
        self.physics = Physics()
        self.physics.gravity_multiplier = 0

    cpdef void control(self, size_t delta_t, Keys keys):
        pass
        # if keys.durations[pg.K_SPACE] == delta_t and delta_t is not 0:
        #     self.physics.force.y = -0.3
        # if keys.durations[pg.K_d] > 0:
        #     self.physics.velocity.x = 0.2
        # else:
        #     self.physics.velocity.x = 0
        # if keys.durations[pg.K_s] > 0:
        #     self.physics.velocity.y = 0.2
        # else:
        #     self.physics.velocity.y = 0


    cpdef void update(self, size_t delta_t, Keys keys):
        self.control(delta_t, keys)
        self.physics.update(delta_t, keys)

    cpdef void draw(self, screen):
        screen.blit(self.texture, (self.physics.position.x, self.physics.position.y))