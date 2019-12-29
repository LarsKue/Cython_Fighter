#
# Created by Lars on 27/12/2019
#

IF CYTHON_FIGHTER_STATUS_PXD == 0:
    DEF CYTHON_FIGHTER_STATUS_PXD = 1


    cdef enum StatusType:
        statusDebuff,
        statusBuff


    cdef class Status:

        cdef StatusType stype


        def __init__(self, StatusType stype):
            self.stype = stype


        cpdef void update(self):
            pass

        cpdef void trigger(self):
            pass


    cdef class TimeStatus(Status):

        cdef int duration

        def __init__(self, StatusType stype, int duration):
            super().__init__(self, stype)
            self.duration = duration


        cpdef void update(self):
            self.duration -= 1
            if self.duration > 0:
                self.trigger()

