#
# Created by Lars on 20/12/2019
#

IF CYTHON_FIGHTER_UTILS_PXD == 0:
    DEF CYTHON_FIGHTER_UTILS_PXD = 1


    cdef int __closest_divisor(int num, int den, branch = None):
        if num % den == 0:
            return den
        cdef int lower = 0
        cdef int upper = 0
        if branch is not None:
            if branch:
                # branch up and return
                return __closest_divisor(num, den + 1, True)
            else:
                # branch down and return
                return __closest_divisor(num, den - 1, False)
        else:
            # branch in both directions because this is the original call
            upper = __closest_divisor(num, den + 1, True)
            lower = __closest_divisor(num, den - 1, False)

        # in the original call, return the value that is closer to den
        if abs(lower - den) <= abs(upper - den):
            return lower
        return upper
    
    cdef unsigned int closest_divisor(unsigned int num, unsigned int den):
        return __closest_divisor(num, den)


    cdef unsigned int closest_multiple(unsigned int num, unsigned int den):
        cdef unsigned int mod
        mod = num % den
        if mod > den / 2:
            return num + den - mod
        else:
            return num - mod