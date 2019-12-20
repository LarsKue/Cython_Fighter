import pstats
import cProfile

# if you want to profile, first build the project with profile or linetrace enabled
import Cython_Fighter

cProfile.runctx("Cython_Fighter.main()", globals(), locals(), "Profile.prof")

s = pstats.Stats("Profile.prof")
s.strip_dirs().sort_stats("time").print_stats()