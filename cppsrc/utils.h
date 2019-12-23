//
// Created by Lars on 18/12/2019
//

#ifndef CYTHON_FIGHTER_UTILS_H
#define CYTHON_FIGHTER_UTILS_H

#include <algorithm>

template<typename T>
T square(const T& x) {
    return x * x;
}

template<typename T>
T constrain(const T& val, const T& min, const T& max) {
    return std::min(std::max(val, min), max);
}

#endif //CYTHON_FIGHTER_UTILS_H