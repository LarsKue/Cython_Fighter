
include "controller.pxd"
include "vec2.pxd"

cdef class Player(Object):

    cdef texture
    cdef Vec2[float] position
    cdef Controller controller

    def __init__(self, str texture_path):
        super().__init__()
        self.position = Vec2[float]()
        self.texture = pg.image.load(texture_path)
        self.controller = Controller()

    cpdef void update(self, size_t delta_t):
        self.controller.update(delta_t)
        # TODO: find better controller method or something

    cpdef void draw(self, screen):
        screen.blit(self.texture, (self.position.x, self.position.y))