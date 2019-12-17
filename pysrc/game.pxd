
from libcpp cimport bool

cdef class Game:

    def __init__(self, config, screen):
        self.config = config
        self.screen = screen

    cdef run(self, exit_condition):
        while not exit_condition():
            pass
