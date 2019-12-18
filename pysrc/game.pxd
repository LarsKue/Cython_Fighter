
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


        while True:
            dt = self.clock.tick(self.maxfps)
            events = pg.event.get()

            for event in events:
                if event.type == pg.QUIT:
                    return

            self.om.update(dt)
            self.om.draw(self.screen)






