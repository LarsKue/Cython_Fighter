
include "controller.pxd"
include "vec2.pxd"

cdef class Player(Object):

    cdef texture
    cdef Vec2[float] position

    def __init__(self, str texture_path):
        super().__init__()
        self.position = Vec2[float]()
        self.texture = pg.image.load(texture_path)

    cpdef void update(self, size_t delta_t):
        pass

    cpdef void draw(self, screen):
        screen.blit(self.texture, (self.position.x, self.position.y))