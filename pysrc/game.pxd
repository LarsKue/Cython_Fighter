
from libcpp cimport bool

import pygame as pg

# from om cimport OM

include "player.pxd"

cdef class Game:

    cdef config
    cdef screen
    cdef OM om
    cdef clock
    cdef size_t maxfps

    def __init__(self, config, screen, *, maxfps=0):
        self.config = config
        self.screen = screen
        self.om = OM()
        self.clock = pg.time.Clock()
        self.maxfps = self.config.getint("WINDOW", "maxfps")

    cpdef void run(self):

        player = Player("assets/textures/player.png")
        self.om.add_object(player)

        i = 0
        t = 0
        while True:
            dt = self.clock.tick(self.maxfps)
            i += 1
            t += dt
            if t >= 1000:
                print("FPS:", i)
                i = 0
                t = 0
            events = pg.event.get()

            for event in events:
                if event.type == pg.QUIT:
                    return

            self.om.update(dt)
            self.om.draw(self.screen)






