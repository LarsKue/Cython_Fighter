from distutils.core import setup
from Cython.Build import cythonize
from distutils.extension import Extension

# Build With: python setup.py build_ext --inplace

import os
from glob import glob


def glob_files(*args, **kwargs):
    return list(filter(os.path.isfile, glob(*args, **kwargs)))


module_name = "Cython_Fighter"

# create the run.py file
if not os.path.isfile("run.py"):
    with open("run.py", "w+") as runfile:
        runfile.write(f"\nfrom os import system\n\nif system(\"python setup.py build_ext --inplace\") is 0:\n    import {module_name}\n    {module_name}.main()\n")

# create cppsrc directory because git doesn't like empty directories
if not os.path.isdir("cppsrc/"):
    os.mkdir("cppsrc/")

python_sources = glob_files("pysrc/**.pyx", recursive=True)
cpp_sources = glob_files("cppsrc/**.cpp", recursive=True)

print("Python Sources:", python_sources)
print("C++ Sources:   ", cpp_sources)

extensions = [Extension(module_name, python_sources + cpp_sources, include_dirs=["cppsrc/"])]

setup(
    name=module_name,
    ext_modules=cythonize(extensions,
                          annotate=True,
                          compiler_directives={"language_level": "3"},
                          force=True  # for debugging, forces recompiling all files
                          ),
    requires=["Cython"]
)
