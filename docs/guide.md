# OCR-D Guide

> A practical guide to the [OCR-D framework](https://github.com/OCR-D/core)

## Introduction

This document, the "OCR-D guide" helps developers writing software and using
tools within the OCR-D ecosystem.

### Scope and purpose of the OCR-D guide

The OCR-D guide is a collection of concise recipes that provide pragmatic advise on how to

  * bootstrap a development environment, 
  * work with the `ocrd` command line tool,
  * manipulate METS and PAGE documents,
  * create [spec-compliant](https://ocr-d-github.com/) software

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

The `tools` section is an object with the key being the name of the executable described and the value being an object with the following properties (bold means required):

  * **`executable`**: Name of the exceutable. Must match the key and start with `ocrd-`.
  * `parameters`: Description of [the parameters this tool accepts](#metadata-about-parameters)
  * **`description`**: Concise description what the tool does
  * **`categories`**: Tools belong to this categories, representing modules within the OCR-D project structure, [list is part of the specs](https://ocr-d.github.io/ocrd_tool).
  * **`steps`**: This tool can be used at these steps in the OCR-D functional model, [list of values in the specs](https://ocr-d.github.io/ocrd_tool).

#### Metadata about parameters

Required properties are bold.

  * **`type`**: What kind of parameter this is, either a `string`, a `number` or a `boolean`.
  * `format`: Subtype defining the syntax of the value such as `float`/`integer` for numbers or `uri` for `string`
  * `required`: If true, this parameter must be provided by the user
  * `default`: Default value if not required
  * `enum`: List of possible values if a fixed list.

`required: true` and setting `default` are mutually exclusive.

### `Makefile`

All MP should provide a [Makefile](https://en.wikipedia.org/wiki/Makefile) with at least two targets: `deps` and `install`.

`make deps` should install any dependencies, such as required python modules.

`make install` should install the executable(s) into `$(PREFIX)/bin`.

`make test` should start the unit/regression test suite if provided.

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
