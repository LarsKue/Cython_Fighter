
cdef extern from "Vec2.h" nogil:
    cdef cppclass Vec2[T]:
        T x
        T y

        Vec2()
        Vec2(T x, T y)

        T sq_dist[O](const Vec2[O]& o) const