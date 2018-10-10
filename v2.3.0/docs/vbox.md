# OCR-D Virtualbox

<!-- BEGIN-MARKDOWN-TOC -->
* [Deployment Infos](#deployment-infos)
	* [Base System](#base-system)
	* [Terminal setup](#terminal-setup)
	* [Tesseract](#tesseract)
	* [Python](#python)
		* [Install virtualenv](#install-virtualenv)
		* [Default to venv3](#default-to-venv3)
	* [Bootstrap ocrd](#bootstrap-ocrd)

<!-- END-MARKDOWN-TOC -->

## Deployment Infos

- Based on Xubuntu 18.04

Username: **`ocrd`**
Password: **`ocrd`**

### Base System

```sh
# Install packages
sudo apt install git curl vim-gtk3 make zsh htop xclip apt-file silversearcher-ag clipit terminator

# Remove cruft
rm -rf $HOME/{Music,Pictures,Public,Templates,Videos}
sudo apt remove libreoffice-{core,writer,calc} thunderbird pidgin-data libflite1

# Upgrade
sudo apt update
sudo apt upgrade
```

### Terminal setup

```sh
# Install dotfiles
git clone https://github.com/kba/dotfiles
cd dotfiles
echo "" > REPOLIST
echo home-bin >> REPOLIST
echo shcolor >> REPOLIST
echo zsh-config >> REPOLIST
echo vim-config >> REPOLIST
echo git-config >> REPOLIST
./dotfiles.sh clone
./dottfiles.sh init

# Set zsh
chsh -s /bin/zsh

# Download a nice font from http://nerdfonts.com and set up in terminal emulator

# --> Reboot
```

### Tesseract

```sh
sudo apt install libtesseract{4,-dev} tesseract-ocr{,-eng,-deu}
```

Einige Tools benötigen aber für die nahe Zukunft noch Versionen der alten
`3.0x`-Versionsreihe ohne neuronale Netze und Trainingstools.

Es sind sowohl die Version `3.05.00` (in `$HOME/.local`) als auch `4.0.0-beta1`
(systemweit) installiert. 

Um zwischen den beiden Versionen zu wechseln:

```sh
$ source /home/ocrd/tess4/bin/activate 
Switched from 'tesseract 4.0.0-beta.1' to 'tesseract 4.0.0-beta.1. TESSDATA_PREFIX=/usr/share/tesseract-ocr/4.00

$ source /home/ocrd/tess3/bin/activate
Switched from 'tesseract 4.0.0-beta.1' to 'tesseract 3.05.02. TESSDATA_PREFIX=/home/ocrd/tess3
```

### Python

#### Install virtualenv

```sh
sudo apt install python3-virtualenv python-virtualenv
cd $HOME
virtualenv -p python3.6 venv3
virtualenv -p python2.7 venv2
```

#### Default to venv3

```sh
echo "source $HOME/venv3/bin/activate" > ~/.zshrc.local
```

**NOTE** Use `source $HOME/venv2/bin/activate` to use Python2. Only for ocrd_ocropy.

### Bootstrap ocrd

```sh
# Clone the repo
git clone https://github.com/kba/ocrd-docs build/docs

# Setup makefile
ln -sr build/docs/vbox/Makefile

# Clone repos
make clone

# Install 'em
make install
```
