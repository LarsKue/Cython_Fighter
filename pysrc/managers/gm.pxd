#
# Created by Lars on 23/12/2019
#

IF CYTHON_FIGHTER_GM_PXD == 0:
    DEF CYTHON_FIGHTER_GM_PXD = 1


    from libcpp cimport bool

    include "am.pxd"


    cdef class OutlineData(AnimData):

        cdef public str color
        cdef public int weight
        cdef public bool fade

        def __init__(self, str color, int weight, bool fade, *args, **kwargs):
            super().__init__(*args, **kwargs)
            self.color = color
            self.weight = weight
            self.fade = fade


    cdef class GM(AM):
        # Glow Manager for texture and animation outlines and glows

        def __init__(self):
            super().__init__()

        cdef OutlineData add_outline(self, AnimData anim_data, str color, int weight, bool fade):
            cdef str filename = anim_data.filename.replace("assets", "assets/outlines").replace(".png", f".{weight}.{color}{'.fade' if fade else ''}.png")
            cdef surface = pg.image.load(filename).convert_alpha()
            cdef OutlineData data = OutlineData(color, weight, fade, surface, filename, anim_data.frames, surface.get_height() // anim_data.frames, anim_data.update_n)
            self.__add(data)
            return data


