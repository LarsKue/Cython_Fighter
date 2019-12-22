
IF CYTHON_FIGHTER_VEC2_PXD == 0:
    DEF CYTHON_FIGHTER_VEC2_PXD = 1


    cdef extern from "Vec2.h" nogil:
        cdef cppclass Vec2[T]:
            T x
            T y

            Vec2()
            Vec2(T x, T y)

            T sq_dist[O](const Vec2[O]& o) const

            Vec2[T] operator+(const Vec2[T]& vec) const
            Vec2[T] operator-(const Vec2[T]& vec) const

            Vec2[T] operator*[M](const M multiplier) const

        Vec2[T] operator*[T, M](const M multiplier, const Vec2[T]& vec)
