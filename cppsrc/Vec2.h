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

    /// math operators ///
    Vec2<T>& operator=(const Vec2<T>& vec) {
        // enables copying of same type Vectors
        this->x = vec.x;
        this->y = vec.y;
        return *this;
    }

    Vec2<T>& operator+=(const Vec2<T>& vec) {
        this->x += vec.x;
        this->y += vec.y;
        return *this;
    }

    Vec2<T> operator+(const Vec2<T>& vec) const {
        Vec2 v;
        v.x = this->x + vec.x;
        v.y = this->y + vec.y;
        return v;
    }

    Vec2<T>& operator-=(const Vec2<T>& vec) {
        this->x -= vec.x;
        this->y -= vec.y;
        return *this;
    }

    Vec2<T> operator-(const Vec2<T>& vec) const {
        Vec2 v;
        v.x = this->x - vec.x;
        v.y = this->y - vec.y;
        return v;
    }
    
    template<typename M>
    const Vec2<T> operator*(const M& multiplier) const {
        return {this->x * multiplier, this->y * multiplier};
    }


};

// number times vector, for convenience
template<typename M, typename U>
const Vec2<U> operator*(const M multiplier, const Vec2<U>& vec) {
    return vec * multiplier;
}

#endif //CYTHON_FIGHTER_VEC2_H