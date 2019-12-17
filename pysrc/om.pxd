
from libcpp.vector cimport vector

import pygame as pg
include "enums.pxd"

cdef extern from "Object.h":
    cdef cppclass Object:
        Object()

        void update(size_t delta_t)
        void draw()

cdef class om:

    cdef objects
    cdef screen

    def __init__(self, screen):
        self.objects = []
        self.screen = screen

    cpdef void update(self, size_t delta_t):
        print("dt =", delta_t)

    cpdef void draw(self):
        self.screen.fill(Color.black)

        # draw objects here

        pg.display.update()