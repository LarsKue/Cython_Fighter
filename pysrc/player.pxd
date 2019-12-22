
IF CYTHON_FIGHTER_PLAYER_PXD == 0:
    DEF CYTHON_FIGHTER_PLAYER_PXD = 1


    import pygame as pg

    include "managers/managers.pxd"
    include "utility/physics.pxd"
    include "animation.pxd"
    include "outline.pxd"


    cdef class Player(Object):

        cdef animation
        cdef outline
        cdef Physics physics

        def __init__(self, AnimData animation_data):
            super().__init__()
            # self.animation = Animation(texture_path, 8, 1000 // 8)
            self.animation = Animation(animation_data)
            self.physics = Physics()
            self.physics.gravity_multiplier = 0
            self.outline = Outline(1, pg.Color(255, 0, 255, 255))

        cpdef void control(self, size_t delta_t, Keys keys):
            self.physics.velocity.x = -0.2 * keys.pressed(pg.K_a) + 0.2 * keys.pressed(pg.K_d)
            self.physics.velocity.y = -0.2 * keys.pressed(pg.K_w) + 0.2 * keys.pressed(pg.K_s)


        cpdef void update(self, size_t delta_t, Keys keys):
            self.control(delta_t, keys)
            self.physics.update(delta_t, keys)
            self.animation.update(delta_t)

        cpdef void draw(self, screen):
            self.outline.draw(screen, self.animation.get_current_frame(), self.physics.position.x, self.physics.position.y, flipx=self.physics.orientation.x)
            self.animation.draw(screen, self.physics.position.x, self.physics.position.y, flipx=self.physics.orientation.x)
