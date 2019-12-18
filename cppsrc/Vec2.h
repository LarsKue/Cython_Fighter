//
// Created by Lars on 18/12/2019
//

#ifndef CYTHON_FIGHTER_VEC2_H
#define CYTHON_FIGHTER_VEC2_H

#include "utils.h"

template<typename T>
class Vec2 {

    public:

    T x = 0;
    T y = 0;

    Vec2() = default;
    Vec2(const T& x, const T& y) : x(x), y(y) {}

    template<typename O>
    T sq_dist(const Vec2<O>& o) const {
        return static_cast<T>(square(o.x - x) + square(o.y - y));
    }


};

#endif //CYTHON_FIGHTER_VEC2_H