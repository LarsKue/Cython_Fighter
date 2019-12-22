
IF CYTHON_FIGHTER_MAIN_PXD == 0:
    DEF CYTHON_FIGHTER_MAIN_PXD = 1


    from libcpp cimport bool

    import pygame as pg
    import configparser

    include "game.pxd"

    include "utility/color.pxd"


    cpdef int main():

        # Read the Config
        config = configparser.ConfigParser()
        config.read("config.ini")

        # Initialize PyGame
        pg.init()

        # Set up the Window
        pg.display.set_caption("Cython Fighter")

        # icon = pg.image.load("resources/default_icon.png")
        # pg.display.set_icon(icon)

        cdef bool fullscreen = config.getboolean("WINDOW", "fullscreen")
        cdef int window_width = config.getint("WINDOW", "width")
        cdef int window_height = config.getint("WINDOW", "height")

        hide_mouse = config.getboolean("WINDOW", "hide_mouse") \
                     or (config.getboolean("WINDOW", "hide_mouse_if_fullscreen") and fullscreen)
        pg.mouse.set_visible(not hide_mouse)

        if fullscreen:
            screen = pg.display.set_mode((window_width, window_height), pg.FULLSCREEN)
        else:
            screen = pg.display.set_mode((window_width, window_height))


        game = Game(config, screen)

        game.run()

        pg.quit()

        return 0
