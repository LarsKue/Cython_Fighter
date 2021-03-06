
IF CYTHON_FIGHTER_GAME_PXD == 0:
    DEF CYTHON_FIGHTER_GAME_PXD = 1


    import pygame as pg

    from libcpp cimport bool

    include "managers/managers.pxd"
    include "player.pxd"


    cdef class Game:

        cdef config
        cdef screen
        cdef OM om  # Object Manager
        cdef SM sm  # Surface Manager
        cdef AM am  # Animation Manager
        cdef GM gm  # Outline Manager
        cdef clock
        cdef size_t maxfps

        def __init__(self, config, screen, *, maxfps=0):
            self.config = config
            self.screen = screen
            self.om = OM()
            self.sm = SM()
            self.am = AM()
            self.gm = GM()
            self.clock = pg.time.Clock()
            self.maxfps = self.config.getint("WINDOW", "maxfps")

        cpdef void run(self):

            player_animation = self.am.add("assets/animations/player_idle.8.png", 10)
            player_outline = self.gm.add_outline(player_animation, "cyan", 3, True)
            self.om.add(Player(player_animation, player_outline))


            cdef size_t i = 0
            cdef size_t t = 0
            cdef size_t dt
            cdef list events
            cdef bool display_fps = self.config.getboolean("STATISTICS", "display_fps")
            while True:
                dt = self.clock.tick(self.maxfps)
                i += 1
                t += dt
                if t >= 1000 and display_fps:
                    print("FPS: {:.2f}".format(i * 1000 / t, 2))
                    i = 0
                    t = 0

                events = pg.event.get()

                for event in events:
                    if event.type == pg.QUIT:
                        return
                    if event.type == pg.KEYDOWN:
                        if event.key == pg.K_ESCAPE:
                            return

                self.om.update(dt)
                self.om.draw(self.screen)
