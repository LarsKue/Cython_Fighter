
# Generate outlines for textures and animations
# NOTE: Animations *must* have their number of frames in the filename as follows:
# path/to/image/filename.#frames.png

from PIL import Image
import numpy as np

import pathlib
import os
from shutil import rmtree


def filename_no_ext(filename):
    return os.path.splitext(os.path.basename(str(filename)))[0]


def numframes(filename):
    fne = filename_no_ext(filename)
    return int(fne[fne.rfind(".") + 1:])


def pad_frames(image, frames, weight):
    height = image.shape[0]
    if height % frames != 0:
        raise ValueError("Invalid Frames!")
    frameheight = height // frames
    # image = np.pad(image, [[0, 0], [weight, weight], [0, 0]], constant_values=0)
    image = np.insert(image, [0, -1], [0], axis=1)
    image = np.insert(image, 2 * weight * [frameheight * i for i in range(frames + 1)], 0, axis=0)
    return image


def get_outline_pixels(image, weight):
    for i in range(len(image)):
        for j in range(len(image[0])):
            bounds = (
                max(0, i - weight), min(len(image), i + weight + 1), max(0, j - weight),
                min(len(image[0]), j + weight + 1))
            if image[bounds[0]:bounds[1], bounds[2]:bounds[3]].any():
                yield (i, j)


def add_outlines(image, weight, colors):
    for color in colors:
        for (i, j) in get_outline_pixels(image, weight):
            image[i][j] = color

        yield image


def unfill_image(image, orig_image, weight):
        for i in range(len(orig_image)):
            for j in range(len(orig_image[0])):
                if orig_image[i][j].any():
                    image[i + weight][j + weight] = [0, 0, 0, 0]


def main():
    weights = [1, 2, 3]
    colors = {"white": [255, 255, 255, 255], "orange": [255, 204, 0, 255], "cyan": [0, 204, 255, 255]}

    target_dir = pathlib.Path("assets\\glow")

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

    for filepath in (path for path in pathlib.Path("assets").rglob("*.png") if str(target_dir) not in str(path)):
        print(f"Generating outlines for {filepath}")
        orig_image = np.asarray(Image.open(filepath).convert("RGBA"))

        if "animations" in str(filepath):
            frames = numframes(filepath)
        else:
            frames = 1

        fne = filename_no_ext(filepath)

        for weight in weights:
            # copy and pad all frames with transparent pixels in all directions
            image = pad_frames(orig_image.copy(), frames, weight)

            # TODO: Process each frame individually? or account for the extra padding between frames
            # for n in range(frames):

            for outline_image, colorname in zip(add_outlines(image, weight, colors.values()), colors.keys()):
                if unfill:
                    unfill_image(outline_image, orig_image, weight)
                Image.fromarray(outline_image).save(str(target_dir) + f"\\{fne}.{weight}.{colorname}.png")


if __name__ == "__main__":
    main()