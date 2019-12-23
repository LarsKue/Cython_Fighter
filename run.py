
from os import system

if system("python3 setup.py build_ext --inplace") is 0:
    import Cython_Fighter
    Cython_Fighter.main()
