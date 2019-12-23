
# Generate outlines for textures and animations
# NOTE: Animations *must* have their number of frames in the filename as follows:
# path/to/image/filename.#frames.png
# Animations must also be in vertical format

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


def pad_image(image, weight):
    return np.pad(image, [[weight, weight], [weight, weight], [0, 0]])


def split_frames(image, frames):
    height = image.shape[0]
    if height % frames != 0:
        raise ValueError("Invalid Frames!")
    frameheight = height // frames
    for i in range(frames):
        yield image[i * frameheight: (i + 1) * frameheight]


def pad_frames(image, frames, weight):

    result = None

    # split the image into its frames
    for frame in split_frames(image, frames):
        # pad each frame with transparent pixels in all directions
        frame = pad_image(frame, weight)

        # put the image back together
        if result is None:
            result = frame
        else:
            result = np.concatenate([result, frame], axis=0)

    return result


def get_outline_pixels(image, weight, fill):
    for i in range(len(image)):
        for j in range(len(image[0])):
            if image[i][j].any():
                if fill:
                    yield (i, j)
                continue
            bounds = (
                max(0, i - weight), min(len(image), i + weight + 1), max(0, j - weight),
                min(len(image[0]), j + weight + 1))
            if image[bounds[0]:bounds[1], bounds[2]:bounds[3]].any():
                yield (i, j)


def get_outlines(image, weight, colors, fill):
    result = np.zeros_like(image)
    for color in colors:
        for (i, j) in get_outline_pixels(image, weight, fill):
            result[i][j] = color

        yield result


def unfill_image(image, orig_image, weight):
        for i in range(len(orig_image)):
            for j in range(len(orig_image[0])):
                if orig_image[i][j].any():
                    image[i + weight][j + weight] = [0, 0, 0, 0]


def main():
    weights = [1, 2, 3]
    colors = {"white": [255, 255, 255, 255], "orange": [255, 204, 0, 255], "cyan": [0, 204, 255, 255]}

    target_dir = pathlib.Path("assets/glow")

    # whether the outline will be filled
    fill = False

    # if True, deletes all images in glow prior to execution
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

            image = pad_frames(orig_image, frames, weight)

            for outline_image, colorname in zip(get_outlines(image, weight, colors.values(), fill), colors.keys()):
                Image.fromarray(outline_image).save(str(target_dir) + f"/{fne}.{weight}.{colorname}.png")


if __name__ == "__main__":
    main()
