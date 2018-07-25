# OCR-D Cookbook

:fire: TODO :fire: TODOs ausräumen

> A set of recipes for common tasks and solutions for common problems developing and using software within OCR-D.

<!-- BEGIN-MARKDOWN-TOC -->
* [Introduction](#introduction)
	* [Scope and purpose of the OCR-D cookbook](#scope-and-purpose-of-the-ocr-d-cookbook)
	* [Notation](#notation)
	* [Other OCR-D documentation ](#other-ocr-d-documentation-)
* [Bootstrapping](#bootstrapping)
	* [Ubuntu Linux](#ubuntu-linux)
	* [Essential system packages](#essential-system-packages)
	* [Python API and CLI](#python-api-and-cli)
	* [Python setup](#python-setup)
		* [Create virtualenv](#create-virtualenv)
		* [Activate virtualenv](#activate-virtualenv)
		* [Install `ocrd` in virtualenv from pypi](#install-ocrd-in-virtualenv-from-pypi)
	* [Generic setup](#generic-setup)
	* [Setup from source](#setup-from-source)
	* [Verify setup](#verify-setup)
* [Anatomy of an OCR-D module project (MP)](#anatomy-of-an-ocr-d-module-project-mp)
	* [`ocrd-tool.json`](#ocrd-tooljson)
		* [Mechanics of the `ocrd-tool.json`](#mechanics-of-the-ocrd-tooljson)
		* [Metadata about the module project](#metadata-about-the-module-project)
		* [Metadata about the tools](#metadata-about-the-tools)
	* [`Makefile`](#makefile)
		* [`Makefile` for python MP](#makefile-for-python-mp)
		* [`Makefile` for generic MP](#makefile-for-generic-mp)
	* [`ocrd-tool` -- Working with ocrd-tool.json](#ocrd-tool----working-with-ocrd-tooljson)
		* [`ocrd-tool validate`](#ocrd-tool-validate)
* [`ocrd workspace` - Working with METS](#ocrd-workspace---working-with-mets)
	* [Workspace](#workspace)
		* [Git similarity intended](#git-similarity-intended)
		* [Set the workspace to work on](#set-the-workspace-to-work-on)
		* [Use another name than `mets.xml`](#use-another-name-than-metsxml)
	* [Creating an empty workspace](#creating-an-empty-workspace)
	* [Load an existing METS as a workspace](#load-an-existing-mets-as-a-workspace)
	* [Load an existing METS and referenced files as a workspace](#load-an-existing-mets-and-referenced-files-as-a-workspace)
	* [Searching the files in a METS](#searching-the-files-in-a-mets)
	* [Downloading/Copying files to the workspace](#downloadingcopying-files-to-the-workspace)
	* [Adding files to the workspace](#adding-files-to-the-workspace)
	* [Validating OCR-D compliant METS](#validating-ocr-d-compliant-mets)
* [From image to transcription](#from-image-to-transcription)
	* [OCR-D workflow](#ocr-d-workflow)
	* [KRAKEN, OLENA, TESSEROCR, OCROPY](#kraken-olena-tesserocr-ocropy)
* [Workflows](#workflows)
	* [Binarize one image without existing METS file.](#binarize-one-image-without-existing-mets-file)
	* [Binarize all images of a METS file.](#binarize-all-images-of-a-mets-file)
	* [Binarize one image of a METS file.](#binarize-one-image-of-a-mets-file)
	* [Get Ground Truth from OCR-D](#get-ground-truth-from-ocr-d)
	* [Installing a MP executable](#installing-a-mp-executable)
	* [Tools for MP](#tools-for-mp)
		* [Getting files referenced inside METS](#getting-files-referenced-inside-mets)
		* [Getting files referenced inside METS](#getting-files-referenced-inside-mets-1)
* [FAQ](#faq)
	* [How do I get help on specific CLI commands?](#how-do-i-get-help-on-specific-cli-commands)
	* [How do I turn off logging](#how-do-i-turn-off-logging)

<!-- END-MARKDOWN-TOC -->

## Introduction

This document, the "OCR-D cookbook" helps developers writing software and using
tools within the OCR-D ecosystem.

OCR-D is an initiative to improve text recognition within the context of mass digitization in cultural heritage institutions, with a strong focus on historical documents (16th - 19th century).

### Scope and purpose of the OCR-D cookbook

The OCR-D cookbook is a collection of concise recipes that provide pragmatic advise on how to

  * bootstrap a development environment, 
  * work with the `ocrd` command line tool,
  * manipulate METS and PAGE documents,
  * create [spec](https://ocr-d-github.com)

### Notation

Lines in code examples

  * starting with `# ` are comments;
  * starting with `$ ` are typed shell input (everything after `$ ` is);
  * are output otherwise.

Words in ALL CAPS with a preprended `$` are variable names:

  * `$METS_URL`: URL or file path to a `mets.xml` file, e.g.
     * `https://github.com/OCR-D/assets/raw/master/data/kant_aufklaerung_1784/mets.xml`

  * `$WORKSPACE_DIR`: File path of the workspace created, e.g.
     * `$WORKSPACE_DIR`
     * `/data/ocrd-workspaces/kant-aufklaerung-2018-07-11`

When referring to a "`something` command", it is actually `ocrd something` on
the command line.

### Other OCR-D documentation 

  * [Specification](https://ocr-d.github.io): Formal specifications
  * [Glossary](https://ocr-d.github.io/glossary): A glossary of terms in the OCR
    domain as used throughout our documenation

## Bootstrapping

### Ubuntu Linux

OCR-D development is targeted towards Ubuntu Linux >= 18.04 since it is free,
widely used and well-documented.

Most of the setup will be the same for other Debian-based Linuxes and older
Ubuntu versions. You might run into problems with outdated system packages
though.

In particular, it can be tricky at times to install `tesseract` at the right
version. Try [alex-p's PPA](https://launchpad.net/~alex-p/+archive/ubuntu/tesseract-ocr) or build
tesseract from source.

### Essential system packages

```sh
sudo apt install \
  git \
  build-essential \
  python python-pip \
  python3 python3-pip \
  libimage-exiftool-perl \
  libxml2-utils
```

  * `git`: Version control, [OCR-D uses git extensively](https://github.com/OCR-D)
  * `build-essential`: Installs `make` and C/C++ compiler
  * `python`: Python 2.7 for legacy applications like `ocropy`
  * `python3`: Current version of Python on which [the OCR-D software core stack](https://github.com/OCR-D/core) is built
  * `pip`/`pip3`: Python package management

### Python API and CLI

The OCR-D toolkit is based on a [Python API](https://ocr-d.github.io/core) that
you can reuse [if you are developing software in Python](#python-setup).

This API is exposed via a command line tool `ocrd`. This CLI offers much of the
same functionality of the API without the need to write Python code and can be readily
integrated into shell scripts and external command callouts in your code.

So, If you [do not intend to code in Python](#generic-setup) or want to wrap
existing/legacy tools, a major part of the functionality of the API is
available as a command line tool `ocrd`.

### Python setup

#### Create virtualenv

We strongly recommend using `virtualenv` (or similar tools if they are more
familiar to you) over system-wide installation of python packages. It reduces
the amount of pain supporting multiple Python versions and allows you to test
your software in various configurations while you develop it, spinning up and
tearing down environments as necessary.

```sh
sudo apt install \
  python3-virtualenv \
  python-virtualenv # If you require Python2 compat
```

Create a `virtualenv` in an easy to remember or easy-to-search-shell-history-for location:

```sh
$ virtualenv -p python3.6 $HOME/ocrd-venv3
$ virtualenv -p python2.7 $HOME/ocrd-venv2 # If you require Python2 compat
```

#### Activate virtualenv

You need to activate this virtual environment whenever you open a new terminal:

```sh
$ source $HOME/ocrd-venv3/bin/activate
```

If you tend to forget sourcing the script before working on your code, add
`source $HOME/ocrd-venv3` to the end of your `.bashrc`/`.zshrc` file and log
out and back in.

#### Install `ocrd` in virtualenv from pypi

Make sure, the [`virtualenv` is activated](#activate-virtualenv) and install [`ocrd`](https://pypi.org/projects/ocrd) with pip:

```sh
$ pip install ocrd
```

### Generic setup

In this variant, you still need to install the `ocrd` Python package but since
it's only used for its CLI (and as a depencency for Python-based OCR-D
software), you can install it system-wide:

```sh
$ sudo pip install ocrd
```

### Setup from source

If you want to build the `ocrd` package [from
source](https://github.com/OCR-D/core) to stay up-to-date on unreleased changes
or to contribute code, you can clone the repository and build from source:

```sh
$ git clone https://github.com/OCR-D/core
$ cd core
```

If you are using the [python setup](#python-setup):

```sh
$ pip install -r requirements.txt
$ pip install -e .
```

If you are using the [generic setup](#generic-setup):

```sh
$ sudo pip install -r requirements.txt
$ sudo pip install .
```

### Verify setup

After setting up, check that these commands do not throw errors and have the
minimum version:

```sh
$ git --version
# Version 1.7 or higher?

$ make --version
# Version 9.0.1 or higher?

$ ocrd --version
# ocrd, version 0.4.0
```

## Anatomy of an OCR-D module project (MP)

MP are [git repositories](TODO spec) with at least a description of the MP and
its provided tools ([`ocrd-tool.json`](#ocrd-tooljson) and a
[`Makefile`](#makefile) for installing the MP into a [suitable OS](#bootstrapping).

### `ocrd-tool.json`

This is a JSON file that describes the software of a particular MP. It serves
mainly three purposes:

  1. providing a machine-actionable description of MP and the bundled tools and
     their parameters 
  2. concise human-targeted descriptions as the foundation for the [application
     documentation](TODO)
  3. ensuring compatible definitions and interfaces, which is essential for
     sustainable, scalable workflows

The main focus for the purpose of this document is the first point.

The structure and syntax of the `ocrd-tool.json` is [defined by a JSON
Schema](https://ocr-d.github.io/ocrd_tool#definition) and exepcts JSON Schema
for the parameter definitions. In addition to the schema, the `ocrd` command
line tool can help you [validate the ocrd-tool.json](#validating-ocr-d-tool-json)

#### Mechanics of the `ocrd-tool.json`

:fire: TODO :fire:

> [kba] Wir brauchen einen besseren Namen, ich kann das schon nicht mehr
> schreiben dauernd, `ocrd-tool.json`. Vielleicht einfach `manifest.json` oder
> `package.json` oder `tool-desc` odr irgendwas.

:fire: TODO :fire:

The `ocrd-tool.json` has two conceptual levels:

  * [Information about the MP](#information-about-the-mp) as a whole and the
    people and processes involved
  * Technical metadata on the [level of the individual tools](#metadata-about-the-tools)

Beyond the `ocrd-tool.json` file, it is part of the requirements that the tools
can provide the section of the `ocrd-tool.json` about 'themselves' at runtime
with the [`-J`/`--dump-json` flags](#https://ocr-d.github.io/cli#-j---dump-json).

The reason for this redundancy is to make the tools inspectable at runtime and
to prevent "feature drift" where the  software evolves to the point where the
description/documentation is out-of-date with the actual implementation.

From a developer's perspective, the easiest way to handle this is by bundling
the `ocrd-tool.json` into your software, e.g. by the following pattern:

  1. Store the `ocrd-tool.json` at a location where it is easy to deploy and
     access [after installation](#makefile)
  2. Symlink it to the root of the repository: `ln -sr src/ocrd-tool.json .`
  3. Handle `--dump-json` by parsing the `ocrd-tool.json` and sending out the
     relevant section
  4. Validate input and [provide defaults](#ocrd-tool-tool-parse-params) based
     on the JSON schema mechanics

#### Metadata about the module project

Required properties are bold.

  * **`version`**: Version of the tool, [adhering to Semantic
    Versioning](https://semver.org/)
  * **`git_url`**: URL of the Github
  * **`tool`**: See [next section](#metadata-about-the-tools)
  * `dockerhub`: The project's [DockerHub](https://hub.docker.com) URL
  * `creators`: :rotating_light: TODO  :rotating_light::
  * `institution`: :rotating_light: TODO  :rotating_light::
  * `synopsis`: :rotating_light: TODO  :rotating_light::

Example:

```json
{
  "version": "0.0.1",
  "name": "ocrd-blockissifier",
  "synopsis": "Tools for reasoning about how these blocks fit on this here page",
  "git_url": "https://githbub.com/johndoe/ocrd_blocksifier",
  "dockerhub": "https://hub.docker.com/r/johndoe/ocrd_blocksifier",
  "authors": [{
    "name": "John Doe",
    "email": "johndoe@ocr-corp.com",
    "url": "johndoe.github.io"
  }],
  "bugs": {
    "url": "https://github.com/sindresorhus/temp-dir/issues"
  },
  "tools": {
      /* see next section */
    }

}
```

#### Metadata about the tools

:fire: TODO :fire:

### `Makefile`

:fire: TODO :fire:

#### `Makefile` for python MP

:fire: TODO :fire:

#### `Makefile` for generic MP

:fire: TODO :fire:

### `ocrd-tool` -- Working with ocrd-tool.json

:fire: TODO :fire:

#### `ocrd-tool validate`

:fire: TODO :fire:

## `ocrd workspace` - Working with METS

METS is the container format of choice for OCR-D because it is widely used in
digitzation workflows in cultural heritage institutions.

A METS file references files in file groups and can contain a variety of
metadata, the details can [be found in the specs](https://ocr-d.github.io).

### Workspace

Within the OCR-D toolkit, we use the term "workspace", a folder containing a
file `mets.xml` and any number of the files referenced by the METS.

One can think of the `mets.xml` as the MANIFEST of a JAR or the `.git` folder
of a git repository.

The `workspace` command of the `ocrd` tool allows various manipulations of
workspaces and therefore METS files.

#### Git similarity intended

The `workspace` command's syntax and mechanics are strongly inspired by
[`git`]() so if you know `git`, this should be familiar.

| `git`      | `ocrd workspace`  |
|------------|-------------------|
| `init`     | `init`            |
| `clone`    | `clone`           |
| `add`      | `add`             |
| `ls-files` | `find`            |
| `fetch`    | `find --download` |
| `archive`  | `pack`            |

#### Set the workspace to work on

For most commands, `workspace` assumes the workspace is the *current working
directory*. If you want to use a different directory, use the `-d / --directory` option

```sh
# Listing files in the workspace at $PWD
$ ocrd workspace find

# Listing files in the workspace at $WORKSPACE_DIR
$ ocrd workspace -d $WORKSPACE_DIR find
```

#### Use another name than `mets.xml`

According to [convention](TODO), the METS of a workspace is named `mets.xml`.

To select a different basename for that file, use the `-M / --mets-basename` option:

```sh
# Assume this workspace structure
$ find $WORKSPACE_DIR
$WORKSPACE_DIR
$WORKSPACE_DIR/mets3000.xml

# This will fail in a loud and unpleasant manner
$ ocrd workspace -d $WORKSPACE_DIR find

# This will not
$ ocrd workspace -d $WORKSPACE_DIR -M mets3000.xml find
```

### Creating an empty workspace

To create an empty workspace for you to add files to, use the `workspace init` command

```sh
$ ocrd workspace init ws1
/home/ocr/ws1
```

### Load an existing METS as a workspace

To create a workspace and save a METS file, use the `workspace clone` command:

```sh
$ ocrd workspace clone $METS_URL new-workspace
/home/ocr/new-workspace

$ find new-workspace
new-workspace
new-workspace/mets.xml
```

### Load an existing METS and referenced files as a workspace

To not only [clone the METS](#load-an-existing-mets-as-a-workspace) but also
download the contained files, use `workspace clone` with the `--download` flag:

```sh
$ ocrd workspace clone --download $METS_URL $WORKSPACE_DIR

$ find $WORKSPACE_DIR
$WORKSPACE_DIR
$WORKSPACE_DIR/mets.xml
$WORKSPACE_DIR/OCR-D-GT-ALTO
$WORKSPACE_DIR/OCR-D-GT-ALTO/kant_aufklaerung_1784_0020.xml
$WORKSPACE_DIR/OCR-D-GT-PAGE
$WORKSPACE_DIR/OCR-D-GT-PAGE/kant_aufklaerung_1784_0020.xml
$WORKSPACE_DIR/OCR-D-IMG
$WORKSPACE_DIR/OCR-D-IMG/kant_aufklaerung_1784_0020.tif
```

**NOTE**: This will download **all** files, which can mean hundreds of
high-resolution images. If you want more fine-grained control,
[clone the bare workspace](#load-an-existing-mets-as-a-workspace)
and then 
[use the `workspace find` command with the `download` flag](downloading-copying-files-to-the-workspace)

### Searching the files in a METS

You can search the files in a METS file with the `workspace find` command.

  * All files: `ocrd workspace find`
  * All TIFF files: `ocrd workspace find --mimetype image/tiff`
  * All TIFF files in the OCR-D-IMG-BIN group: `ocrd workspace find --mimetype image/tiff --file-grp OCR-D-IMG-BIN`

See `ocrd workspace --find` for the full range of selection options

### Downloading/Copying files to the workspace

To download remote or copy local files referenced in the `mets.xml` to the
workspace, append the `--download` flag to the [`workspace find`
command](#searching-the-files-in-a-mets):

```sh
# Clone Bare workspace:
$ ocrd workspace clone $METS_URL

$ find $WORKSPACE_DIR
$WORKSPACE_DIR
$WORKSPACE_DIR/mets.xml

# Download all files in the `OCR-D-IMG` file group
$ ocrd workspace -d $WORKSPACE_DIR find --file-grp OCR-D-IMG --download
[...]

$ find $WORKSPACE_DIR
$WORKSPACE_DIR
$WORKSPACE_DIR/mets.xml
$WORKSPACE_DIR/OCR-D-IMG
$WORKSPACE_DIR/OCR-D-IMG/kant_aufklaerung_1784_0020.tif
```

The convention is that files will be downloaded to `$WORKSPACE_DIR/$FILE_GROUP/$BASENAME` where

  * `$FILE_GROUP` is the `@USE` attribute of the `mets:fileGrp`
  * `$BASENAME` is the last URL segment of the `@xlink:href` attribute of the `mets:FLocat`

**NOTE** Downloading a file not only copies the file to the `$WORKSPACE_DIR`
but also changes the URL of the file from its original to the absolute file
path of the downloaded file.

### Adding files to the workspace

When running a module project, new files are created (PAGE XML, images ...). To
register these new files, they need to be added to the `mets.xml` as a
`mets:file` with a `mets:FLocat` within a `mets:fileGrp`, each with the right
attributes. The `workspace add` command makes this possible:


```sh
$ ocrd workspace -d $WORKSPACE_DIR find -k local_filename
$WORKSPACE_DIR/OCR-D-IMG/page0013.tif

$ ocrd workspace -d $WORKSPACE_DIR add \
  --file-grp OCR-D-IMG-BIN \
  --file-id PAGE-0013-BIN \
  --mimetype image/png \
  --group-id PAGE-0013 \
  page0013binarized.png

$ ocrd workspace -d $WORKSPACE_DIR find -k local_filename
$WORKSPACE_DIR/OCR-D-IMG/page0013.tif
$WORKSPACE_DIR/OCR-D-IMG-BIN/page0013binarized.tif
```

### Validating OCR-D compliant METS

To ensure a METS file and the workspace it describes adheres to the [OCR-D
specs](https://ocr-d.github.io/mets), use the `workspace validate` command:

```sh
# Create a bare workspace
ocrd workspace init $WORKSPACE_DIR

# Validate
<report valid="false">
  <error>METS has no unique identifier</error>
  <error>No files</error>
</report>

# Oops, let's set the identifier ...
$ ocrd workspace -d $WORKSPACE_DIR set-id 'scheme://my/identifier/syntax/kant_aufklaerung_1784'

# ... and add a file
$ ocrd workspace -d $WORKSPACE_DIR add -G OCR-D-IMG-BIN -i PAGE-0013-BIN -m image/png -g PAGE-0013 page0013binarized.png

# Validate again
<report valid="true">
</report>
```

## ocrd-kraken

### Clone a workspace

```
$ ocrd workspace clone --download 'https://github.com/OCR-D/assets/raw/master/data/column-samples/mets.xml' ws1
```

### Binarize all images

We'll reuse the downloaded workspace `ws1`:

```
$ ocrd-kraken-binarize -w ws1 -m ws1/mets.xml
```

## From image to transcription

### OCR-D workflow

The workflow consists of several steps from the image with some additional
metadata to the textual content of the image. The tools used to generate the
text are divided in the following categories:

- Image preprocessing
- Layout analysis
- Text recognition and optimization
- Model training
- Long-term preservation
- Quality assurance

The workflow may be divided in the following steps:

- preprocessing/characterization
- preprocessing/optimization
- preprocessing/optimization/cropping
- preprocessing/optimization/deskewing
- preprocessing/optimization/despeckling
- preprocessing/optimization/dewarping
- preprocessing/optimization/binarization
- preprocessing/optimization/grayscale_normalization
- layout/segmentation
- layout/segmentation/region
- layout/segmentation/line
- layout/segmentation/word
- layout/segmentation/classification
- layout/analysis
- recognition/text-recognition
- recognition/font-identification

### KRAKEN, OLENA, TESSEROCR, OCROPY

```sh
# Step 0: Check/Install git and dependencies
```

See subsection [Bootstrapping](#bootstrapping)

```sh
# Step 1: Clone repositories
# Step 1a: KRAKEN
$ cd ~/projects/OCR-D
$ git clone https://github.com/OCR-D/ocrd_kraken
$ cd ocrd_kraken/
$ make deps-pip
$ make install
# Step 1b: Test installation
$ ocrd-kraken-binarize --version
Version 0.0.1, ocrd/core 0.4.0
```

## Workflows

### Binarize one image without existing METS file.

```sh
# Step 0: Create Workspace & METS file
# ------------------------
# Step 0a: Create directory for workshop
$ mkdir -p ~/projects/OCR-D/workshop/2018_06_26/workspaces
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces
# Step 0b: Create workspace including METS file in subdir `./emptyWorkspace`
$ ocrd workspace init emptyWorkspace
$ cd emptyWorkspace
$ ocrd workspace validate
$ cd ws1  
# Step 0c: Validate workspace
<report valid="false">
  <error>METS has no unique identifier</error>
  <error>No files</error>
</report>
# Step 0d: Add identifier to METS file
$ ocrd workspace set-id 'http://resolver.staatsbibliothek-berlin.de/SBB0000F29300000000'
$ ocrd workspace validate
<report valid="false">
  <error>No files</error>
</report>

# Step 1: Download tiff image
# ---------------------------
$ wget -O PPN767137728_00000005.tif "http://ngcs.staatsbibliothek-berlin.de/?action=metsImage&format=tif&metsFile=PPN767137728&divID=PHYS_0005&original=true"


# Step 2: Add image to METS
# -------------------------
# Be aware, that the ID and the GROUPID have to identical if the referenced image represents the original image
$ ocrd workspace add --file-grp OCR-D-IMG --file-id OCR-D-IMG_0001 --group-id OCR-D-IMG_0001 --mimetype image/tiff PPN767137728_00000005.tif

# Step 3: Validate workspace
# --------------------------
$ ocrd workspace validate
<report valid="true">
</report>

# Step 3a: Clone workspace (optional)
# -----------------------------------
# Create new directory and clone workspace to this directory
$ ocrd workspace clone --download mets.xml ../cloneEmptyWorkspace
$ cd ../cloneEmptyWorkspace
# Show all files (use --help to see all parameters)
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/cloneEmptyWorkspace/PPN767137728_00000005.tif

# Step 4: Execute binarization of image
# -------------------------------------
```

See subsection [Bootstrapping](#bootstrapping)

```sh
# Step 4a: Install KRAKEN see [Installation KRAKEN] (#KRAKEN, OLENA, TESSEROCR, OCROPY)
```

See subsection [Install KRAKEN](#KRAKEN-OLENA-TESSEROCR-OCROPY)

```sh
# Step 4b: List all available tools
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json list-tools
  ocrd-kraken-binarize
  ocrd-kraken-ocr
  ocrd-kraken-segment
# Step 4c: List attributes of 'ocrd-kraken-binarize'
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json tool ocrd-kraken-binarize description
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json tool ocrd-kraken-binarize categories
Binarize images with kraken
  Image preprocessing
$ ocrd ocrd-tool   ~/projects/OCR-D/ocrd_kraken/ocrd-tool.json tool ocrd-kraken-binarize steps
  preprocessing/optimization/binarization

# Step 4d: Binarize Image with KRAKEN
# Binarize all images inside fileGrp 'OCR-D-IMG'
$ ocrd-kraken-binarize --input-file-grp OCR-D-IMG --output-file-grp OCR-D-IMG-KRAKEN-BIN --group-id OCR-D-IMG_0001 --working-dir ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeEmptyWorkspace --mets mets.xml
# Check result
$ firefox ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeEmptyWorkspace/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
# That's it
```

### Binarize all images of a METS file.


```sh
# Step 0: Create Workspace & METS file
# ------------------------
# Step 0a: Create workspace including METS file
$ ocrd workspace init ~/projects/OCR-D/workshop/2018_06_26/workspaces/multipleImages
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/multipleImages
# Step 0b: Validate workspace
$ ocrd workspace validate
<report valid="false">
  <error>METS has no unique identifier</error>
  <error>No files</error>
</report>
# Step 0c: Add identifier to METS file
$ ocrd workspace set-id http://resolver.staatsbibliothek-berlin.de/SBB0000F29300000000
# <mods:mods xmlns:mods="http://www.loc.gov/mods/v3">
#   <mods:identifier type="purl">http://resolver.staatsbibliothek-berlin.de/SBB0000F29300000000</mods:identifier>
# </mods:mods>
$ ocrd workspace validate
<report valid="false">
  <error>No files</error>
</report>
# Step 1: Download tiff images
# ----------------------------
$ wget -O PPN767137728_00000005.tif "http://ngcs.staatsbibliothek-berlin.de/?action=metsImage&format=jpg&metsFile=PPN767137728&divID=PHYS_0005&original=true"
$ wget -O PPN767137728_00000006.tif "http://ngcs.staatsbibliothek-berlin.de/?action=metsImage&format=jpg&metsFile=PPN767137728&divID=PHYS_0006&original=true"    


# Step 2: Add images to METS
# --------------------------
# Be aware, that the ID and the GROUPID have to identical if the referenced image represents the original image
$ ocrd workspace add --file-grp OCR-D-IMG --file-id OCR-D-IMG_0001 --group-id OCR-D-IMG_0001 --mimetype image/tiff PPN767137728_00000005.tif
$ ocrd workspace add --file-grp OCR-D-IMG --file-id OCR-D-IMG_0002 --group-id OCR-D-IMG_0002 --mimetype image/tiff PPN767137728_00000006.tif

# Step 3: Validate workspace
# --------------------------
$ ocrd workspace validate
<report valid="true">
</report>

# Step 3a: Clone workspace (optional)
# -----------------------------------
# Create new directory and clone workspace to this directory
$ ocrd workspace clone --download $OLDPWD/mets.xml workspace3
# Show all files (use --help to see all parameters)
$ cd workspace3
$ ocrd workspace find
file:///path/to/new/workspace/OCR-D-IMG/PPN767137728_00000005.tif
file:///path/to/new/workspace/OCR-D-IMG/PPN767137728_00000006.tif

# Step 4: Binarize Image with KRAKEN
# ----------------------------------
$ ocrd-kraken-binarize --input-file-grp OCR-D-IMG --output-file-grp OCR-D-IMG-KRAKEN-BIN --working-dir ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages --mets /tmp/pyocrd-'xyz'/mets.xml
# Check result
$ firefox ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# That's it
```

### Binarize one image of a METS file.

For preparing workspace see subsection [Binarize all images of a METS file](#binarize-all-images-of-a-mets-file) (Step 0 - 3)

```sh
# Step 0: Reuse existing workspace
# --------------------------------
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/multipleImages

# Step 0b: Validate workspace
# --------------------------
$ ocrd workspace validate
<report valid="true">
</report>

# Step 1: Clone workspace (optional)
# -----------------------------------
# This step creates a temporal directory (/tmp/pyocrd-'xyz')
$ ocrd workspace clone --download mets.xml ../selectOneImage
# Change directory
$ cd ../selectOneImage
# Show all files (use --help to see all parameters)
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/selectOneImage/OCR-D-IMG/PPN767137728_00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/selectOneImage/OCR-D-IMG/PPN767137728_00000006.tif

# Step 2: Binarize Image with KRAKEN
# ----------------------------------
# Step 2a: List all GROUPIDs.
§ ocrd workspace find --output-field groupId
OCR-D-IMG_0001
OCR-D-IMG_0002
Step 2b: Binarize image from a chosen GROUPID
$ ocrd-kraken-binarize --input-file-grp OCR-D-IMG --output-file-grp OCR-D-IMG-KRAKEN-BIN --group-id OCR-D-IMG_0001 --working-dir ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeSelectedImage --mets mets.xml
# Check result
$ firefox ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeSelectedImage/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
# That's it
```

### Get Ground Truth from OCR-D

```sh
# Create data directory
$ mkdir -p ~/projects/OCR-D/data/groundTruth
$ cd ~/projects/OCR-D/data/groundTruth
# Download GT from OCR-D
$ wget http://ocr-d.de/sites/all/GTDaten/blumenbach_anatomie_1805.zip
$ unzip blumenbach_anatomie_1805.zip

# Step 1: Clone workspace from METS
$ mkdir -p ~/projects/OCR-D/workshop/2018_06_26/workspaces/; cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/
$ ocrd workspace clone --download ~/projects/OCR-D/data/groundTruth/blumenbach_anatomie_1805/blumenbach_anatomie_1805/mets.xml blumenbach_anatomie_1805
$ cd blumenbach_anatomie_1805/
```

### Installing a MP executable

```bash=
$ mkdir ~/projects/OCR-D/modules
$ cd ~/projects/OCR-D/modules
$ git clone https://github.com/OCR-D/ocrd_kraken
$ cd ocrd_kraken
$ sudo make install
```

### Tools for MP

#### Getting files referenced inside METS

The command 'ocrd workspace find' supports several options.

```sh
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages
# List all files.
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000006.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# List all files inside a fileGrp
§ ocrd workspace find --file-grp OCR-D-IMG-KRAKEN-BIN
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# List all files of a GROUPID
$ ocrd workspace find --group-id  OCR-D-IMG_0001
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
# See 'ocrd workspace find --help' for further information
```

#### Getting files referenced inside METS

The command 'ocrd workspace find' supports several options.

```sh
$ cd ~/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages
# List all files.
$ ocrd workspace find
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000006.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# List all files inside a fileGrp
§ ocrd workspace find --file-grp OCR-D-IMG-KRAKEN-BIN
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0002.bin.png
# List all files of a GROUPID
$ ocrd workspace find --group-id  OCR-D-IMG_0001
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/PPN767137728.00000005.tif
file:///home/ocrd/projects/OCR-D/workshop/2018_06_26/workspaces/binarizeAllImages/OCR-D-IMG-KRAKEN-BIN/OCR-D-IMG-KRAKEN-BIN_0001.bin.png
```

## FAQ

### How do I get help on specific CLI commands?

Every command and subcommand supports the `--help` option to print a description, arguments and options:

```sh
ocrd --help
ocrd workspace --help
ocrd workspace add --help
```

### How do I turn off logging

:rotating_light: TODO
