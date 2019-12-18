//
// Created by Lars on 17/12/2019.
//

#ifndef CYTHON_FIGHTER_OBJECT_H
#define CYTHON_FIGHTER_OBJECT_H

#include <cstddef>


class Object {

    public:

    Object() = default;

    void update(std::size_t delta_t) {}

    void draw() {}

};

#endif //CYTHON_FIGHTER_OBJECT_H