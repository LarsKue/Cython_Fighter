# distutils: language = c++

from libcpp cimport bool

import pygame as pg
import configparser

include "enums.pxd"
include "game.pxd"

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

    if fullscreen == fullscreenmode.fullscreen:
        screen = pg.display.set_mode((window_width, window_height), pg.FULLSCREEN)
    else:
        screen = pg.display.set_mode((window_width, window_height))


    game = Game(config, screen)

    game.run(lambda : False)

    return 0
