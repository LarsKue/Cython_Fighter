
cdef class om:

    def __init__(self):
        self.objects = []
        pass

    cdef update(self, int delta_t):
        pass

    cdef draw(self):
        pass