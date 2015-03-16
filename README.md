# PDF making tools

[![MIT LICENSE](http://img.shields.io/badge/license-MIT-yellowgreen.svg?style=flat-square)](https://github.com/egel/pdf-making-tools/blob/master/LICENSE)

> This repo contains simple tools for quick and efficent making your own PDF file from images.

## Table of content

  - [Installation](#installation)
  - [Convert images to one file format](#convert-images-to-one-file-format)
  - [Rename and sort files](#rename-and-sort-files)
  - [Rotate images](#rotate-images)
  - [Cropping and aligning all images](#cropping-and-aligning-all-images)
  - [Search an image with the lowest resolution and width](#search-an-image-with-the-lowest-resolution-and-width)
  - [Weight reduction and image quality (optional)](#weight-reduction-and-image-quality-optional)
  - [Verification of compliance of the order and the parties](#verification-of-compliance-of-the-order-and-the-parties)
  - [Convert images to a PDF](#convert-images-to-a-pdf)

### Installation

For almost every step we will need to use `imagemagick` and partly `awk`. To install it on Debian based distros use:

    sudo apt-get install imagemagick awk


### Convert images to one file format
If you have different formats of files it's recommended to convert it for one common (ex: `PNG`).

    mogrify -format jpg *.png

### Rename and sort files
To achieve this task you can use `renaming_files.sh` and `extending_filename.sh`

##### Renaming
First one, trim names of scanned files to one general convention. For example: `Picture.png`, `Picture (2).png`, `Picture (3).png`, ... , `Picture (100).png` you can change in one second into: `1.png`, `2.png`, `3.png`, ... , `100.png`


##### Sorting
Bash a bit different recognise the list of elements. The order of files in bash console can be present like this: `1.jpg`, `10.jpg`, `100.jpg`, `2.jpg`, ..., `99.jpg`. We will change it into: `001.jpg`, `002.jpg`, `010.jpg`, ..., `099.jpg`, `100.jpg`.

### Rotate images
Sometimes images are saved with wrong angle (90, 180 or 270 degree). To solve this unconvenient problem you can use `rotate_images.sh` script.

It helps to handle with massive rotating images stored in folder. Sometimes scanned images are in oposite rotations 0 and 180, or 90 and 270. This script can be easly set commands for even and odd images for easy detection.

##### Contrast
In some cases (RGB) rotating the image increase its contrast (Like cover). To reduce this you can change task to `rotate_images.sh` for increase contrast for those images which have less contrast to others.

Example command:

    convert "${TEMP_ARRAY[i]}.$EXT" -contrast -contrast "${TEMP_ARRAY[i]}.$EXT"

### Cropping and aligning all images
Usualy it is a manual step. Need to look through all the files and correct. Best tool for this step (and all others if you need) is just `Shotwell Viewer`. Yeah as simple as you see, you do not need any extra program (in fact it's usually preinstalled in most new distros).

Use Shotwell `aligning` feature to adjust images to proper angle (it usualy a small corrections for images).

### Search an image with the lowest resolution and width
To have best quality of PDF you need to equalize all images to the lowest.

Below script help you with finding lowers resolution from all images you have.

> This script can take a while in fact that retriving data from images is slow process ;)
> 200 images = ~2min

    identify -verbose *.png | egrep -wi --color "Image:|Resolution:|Geometry:|Filesize:|Colorspace:" > images_stats.txt

And sample output:

    ...

    Image: 204.png
      Geometry: 1763x2496+0+0
      Resolution: 72x72
      Colorspace: Gray
      Filesize: 157KB

    ...

    Image: 211.png
      Geometry: 1789x2458+0+0
      Resolution: 72x72
      Colorspace: Gray
      Filesize: 131KB
    Image: 212.png
      Geometry: 1942x2745+0+0
      Resolution: 72x72
      Colorspace: Gray
      Filesize: 1.972MB



The `Resolution` and first value of `Geometry` parameter (the width of image). It should be the same for all images. To achieve that, we need to find the lowest value of first `Geometry` parameter.

Use below command to find the lowes value into previously generated `images_stats.txt` file:

    cat images_stats.txt | grep "Geometry:" | awk -F"x" '{print $1}' | awk -F" " 'NR == 1 || $2 < min { line =$0; min =$2}; END {print line}'

The result should be like this below (keep it in mind):

    Geometry: 1757

We should do the same with `Resolution`

    cat images_stats.txt | grep "Resolution:" | awk -F"x" '{print $1}' | awk -F" " 'NR == 1 || $2 < min { line =$0; min =$2}; END {print line}'

Sample result:

    Resolution: 72

> This 2 factors (`Resolution` and `Geometry` width) for all files should be the same!!!


### Weight reduction and image quality (optional)
According to results, we need to run commad to equalize Geometry width for all images:

> **Note:** Changes images done on current photographs!!!
> So let's make a copy to a new folder and work on it.

    mogrify -geometry 1757x *.png

### Verification of compliance of the order and the parties
Now left the final step before the conversion - verification of our files.

By verification I mean a simple check of correct numbering of subsequent pages and thus whether I made a PDF file.

> Pay attention to the numbering of the pages to agree with the parties elected PDF search engine (go to page).


### Convert images to a PDF

To convert just run below command into folder with images:

> It also can take a while. It depends on computer parameters.

    convert * .png ksiazka.pdf


**The End :)**


