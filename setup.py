from distutils.core import setup
from Cython.Build import cythonize
from distutils.extension import Extension

# Build With: python setup.py build_ext --inplace

import os
from pathlib import Path


module_name = "Cython_Fighter"

module_name = module_name.replace(".", "_").replace("-", "_")

# create the run.py file
if not os.path.isfile("run.py"):
    with open("run.py", "w+") as runfile:
        runfile.write(f"\nfrom os import system\n\nif system(\"python setup.py build_ext --inplace\") is 0:\n    import {module_name}\n    {module_name}.main()\n")

# create cppsrc directory because git doesn't like empty directories
if not os.path.isdir("cppsrc/"):
    os.mkdir("cppsrc/")

# we need to do some hacky file exclusions to freely include pxd's everywhere
# so generate a main file
python_definitions = list(str(x) for x in Path("pysrc").rglob("*.pxd"))

with open("pysrc/main.pyx", "w+") as mainfile:
    mainfile.write("# distutils: language = c++\n\n")
    for filepath in python_definitions:
        filename = os.path.basename(filepath)
        mainfile.write("DEF " + module_name.upper() + "_" + filename.replace(".", "_").upper() + " = 0\n")

    mainfile.write("\n")
    mainfile.write("include \"main.pxd\"")
    mainfile.write("\n")

python_sources = list(str(x) for x in Path("pysrc").rglob("*.pyx"))
cpp_sources = list(str(x) for x in Path("cppsrc").rglob("*.cpp"))

print("Python Sources:", python_sources)
print("C++ Sources:   ", cpp_sources)

extensions = [Extension(module_name, python_sources + cpp_sources, include_dirs=["cppsrc/"])]

setup(
    name=module_name,
    version="0.0.1",
    url="https://github.com/LarsKue/Cython_Fighter",
    ext_modules=cythonize(extensions,
                          annotate=True,
                          compiler_directives={"language_level": "3", "profile": "False", "linetrace": "False"},
                          force=True  # for debugging, forces recompiling all files
                          ),
    requires=["Cython", 'pygame']
)
