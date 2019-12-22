
IF CYTHON_FIGHTER_COLOR_PXD == 0:
    DEF CYTHON_FIGHTER_COLOR_PXD = 1


    # cdef class Color:
    #     cdef unsigned char r
    #     cdef unsigned char g
    #     cdef unsigned char b
    #     cdef unsigned char a
    #
    #     def __init__(self, unsigned char r = 0, unsigned char g = 0, unsigned char b = 0, unsigned char a = 255):
    #         self.r = r
    #         self.g = g
    #         self.b = b
    #         self.a = a
    #
    #     cdef (unsigned char, unsigned char, unsigned char, unsigned char) get(self):
    #         return (self.r, self.g, self.b, self.a)


    cdef class Colors:
        DEF black = (0, 0, 0)
        DEF white = (255, 255, 255)