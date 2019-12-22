#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_OUTLINE_PXD == 0:
    DEF CYTHON_FIGHTER_OUTLINE_PXD = 1


    import pygame as pg
    import numpy as np

    from libcpp cimport bool


    cdef class Outline:

        cdef int weight
        cdef color


        def __init__(self, int weight, color):
            self.color = np.array([color.r, color.g, color.b])
            self.weight = weight

        def draw(self, screen, surface, double x, double y, flipx=False, flipy=False):
            # if this looks bad, try smoothscale
            # outline = surface
            # cdef double aspect_ratio = surface.get_width() / surface.get_height()
            # outline = pg.transform.scale(surface, (surface.get_width() + 2 * self.weight, surface.get_height() + round(2 * self.weight * aspect_ratio)))
            #
            # data = pg.surfarray.pixels3d(outline)
            # alphas = pg.surfarray.array_alpha(outline)
            #
            # cdef unsigned int i
            # cdef unsigned int j
            # for i in range(len(data)):
            #     for j in range(len(data[0])):
            #         # print(data[i][j])
            #         if alphas[i][j] != 0:
            #             data[i][j] = self.color
            #             # alphas[i][j] =











            # acquire the surface array and pad it with transparent pixels in all directions
            data = np.pad(pg.surfarray.pixels3d(surface), [[self.weight, self.weight], [self.weight, self.weight], [0, 0]], constant_values=0)
            pixels = []
            # print(len(data), len(data[0]))

            cdef int i
            cdef int j
            cdef bool pixel_done = False

            # print("irange:", self.weight, len(data) - self.weight)
            # print("jrange:", self.weight, len(data[0]) - self.weight)
            # print("krange:", -self.weight, self.weight + 1)

            # exit(0)

            # testarr = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
            # print(testarr)
            # print(testarr[0:2,0:2])

            # TODO: Fix
            # TODO: Performance!

            for i in range(len(data)):
                for j in range(len(data[0])):
                    bounds = (max(0, i - self.weight), min(len(data), i + self.weight + 1), max(0, j - self.weight), min(len(data), j + self.weight + 1))
                    if data[bounds[0]:bounds[1], bounds[2]:bounds[3]].any():
                        pixels.append((i, j))

            for (i, j) in pixels:
                data[i][j] = self.color

            screen.blit(pg.transform.flip(pg.surfarray.make_surface(data), flipx, flipy), (x - self.weight, y - self.weight))


