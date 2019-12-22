
# Generate outlines for textures and animations
# WARNING: Animations *must* have their number of frames in the filename as follows:
# path/to/image/filename.#frames.png

from PIL import Image
import numpy as np

import pathlib
import os
from shutil import rmtree

target_dir = pathlib.Path("assets\\glow")

weights = [1, 2, 3]
colors = [[255, 255, 255, 255], [255, 204, 0, 255], [0, 204, 255, 255]]

# turning this off will require always rendering the outlines behind the objects they should outline
# but may greatly speed up the generation process
# will decolor any pixels that aren't transparent in the original image
unfill = True

reset_all = True

if reset_all:
    if target_dir.exists():
        rmtree(target_dir)

if not target_dir.exists():
    target_dir.mkdir()


def filename_no_ext(filename):
    return os.path.splitext(os.path.basename(str(filename)))[0]


def numframes(filename):
    fne = filename_no_ext(filename)
    return int(fne[fne.rfind(".") + 1:])


def pad_frames(image, frames, weight):
    print(image.shape)
    height = image.shape[0]
    if height % frames != 0:
        raise ValueError("Invalid Frames!")
    frameheight = height // frames
    # image = np.pad(image, [[0, 0], [weight, weight], [0, 0]], constant_values=0)
    image = np.insert(image, [0, -1], [0], axis=1)
    print(image.shape)
    image = np.insert(image, 2 * weight * [frameheight * i for i in range(frames + 1)], 0, axis=0)
    print(image.shape)
    return image


for filepath in (path for path in pathlib.Path("assets").rglob("*.png") if str(target_dir) not in str(path)):
    print(f"Generating outlines for {filepath}")
    origimage = np.asarray(Image.open(filepath).convert("RGBA"))

    if "animations" in str(filepath):
        frames = numframes(filepath)
        print(frames)
    else:
        frames = 1

    for weight in weights:
        # copy and pad all frames with transparent pixels in all directions
        # image = np.pad(origimage.copy(), [[weight, weight], [weight, weight], [0, 0]], constant_values=0)
        image = pad_frames(origimage.copy(), frames, weight)
        # TODO: Process each frame individually? or account for the extra padding between frames
        for n in range(frames):


        pixels = []

        for i in range(len(image)):
            for j in range(len(image[0])):
                bounds = (max(0, i - weight), min(len(image), i + weight + 1), max(0, j - weight), min(len(image[0]), j + weight + 1))
                if image[bounds[0]:bounds[1], bounds[2]:bounds[3]].any():
                    pixels.append((i, j))

        fne = filename_no_ext(filepath)

        for color in colors:
            for (i, j) in pixels:
                image[i][j] = color

            if unfill:
                for i in range(len(origimage)):
                    for j in range(len(origimage[0])):
                        if origimage[i][j].any():
                            image[i + weight][j + weight] = [0, 0, 0, 0]

            Image.fromarray(image).save(str(target_dir) + f"\\{fne}.{weight}.{color[0]}.{color[1]}.{color[2]}.{color[3]}.png")


