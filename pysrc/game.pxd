
from libcpp cimport bool

import pygame as pg

include "enums.pxd"
include "om.pxd"

cdef class Game:

    cdef config
    cdef screen
    cdef __om
    cdef clock
    cdef size_t maxfps

    def __init__(self, config, screen, *, maxfps=0):
        self.config = config
        self.screen = screen
        self.__om = om(screen)
        self.clock = pg.time.Clock()
        self.maxfps = self.config.getint("WINDOW", "maxfps")

    cdef void run(self):


        while True:
            dt = self.clock.tick(self.maxfps)
            events = pg.event.get()

            for event in events:
                if event.type == pg.QUIT:
                    return

            self.__om.update(dt)






