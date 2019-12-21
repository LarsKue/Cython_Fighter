#
# Created by Lars on 21/12/2019
#

IF CYTHON_FIGHTER_MANAGERS_PXD == 0:
    DEF CYTHON_FIGHTER_MANAGERS_PXD = 1
    
    include "om.pxd"
    include "sm.pxd"
    include "am.pxd"