//
// Created by Lars on 21/12/2019
//

#ifndef CYTHON_FIGHTER_POINT_H
#define CYTHON_FIGHTER_POINT_H

#include "utils.h"

class CPoint {

public:

    double x = 0;
    double y = 0;


    CPoint() = default;
    CPoint(double x, double y) : x(x), y(y) {}

    double sq_dist(const CPoint& other) const {
        return square(x - other.x) + square(y - other.y);
    }

    CPoint operator+(const CPoint& other) const {
        return CPoint(x + other.x, y + other.y);
    }

    CPoint operator-(const CPoint& other) const {
        return CPoint(x - other.x, y - other.y);
    }

    template<typename T>
    CPoint operator*(const T& other) const {
        return {x * other, y * other};
    }

};

template<typename T>
CPoint operator*(const T& multiplier, const CPoint& p) {
    return p * multiplier;
}

#endif //CYTHON_FIGHTER_POINT_H