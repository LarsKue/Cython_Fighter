
from libcpp cimport bool

include "physics.pxd"
include "vec2.pxd"

cdef class Player(Object):

    cdef texture
    cdef Controller controller
    cdef Physics physics

    def __init__(self, str texture_path):
        super().__init__()
        self.texture = pg.image.load(texture_path)

        self.physics = Physics()

        def w(size_t delta_t, bool state):
            nonlocal self
            self.physics.velocity.y = -0.5 * state

        def a(size_t delta_t, bool state):
            nonlocal self
            self.physics.velocity.x = -0.5 * state

        def s(size_t delta_t, bool state):
            nonlocal self
            self.physics.velocity.y = 0.5 * state


        def d(size_t delta_t, bool state):
            nonlocal self
            self.physics.velocity.x = 0.5 * state


        self.controller = Controller(actions={pg.K_w: w, pg.K_a: a, pg.K_s: s, pg.K_d: d})

    cpdef void update(self, size_t delta_t):
        self.controller.update(delta_t)
        self.physics.update(delta_t)
        # TODO: find better controller method or something

    cpdef void draw(self, screen):
        screen.blit(self.texture, (self.physics.position.x, self.physics.position.y))