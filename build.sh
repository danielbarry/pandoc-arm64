#/bin/bash

ROOT="$(pwd)"

# rebuild()
#
# Rebuild a given package and install it.
#
# @param $1 The directory of the package to be rebuilt.
function rebuild {
  echo ">>>> Rebuilding $1"
  cd $1
  rm *.pkg.tar.xz
  makepkg -ACcsf
  sudo pacman --noconfirm -U *.pkg.tar.xz
  cd $ROOT
  echo "<<<< Finished rebuilding $1"
}

# Grab latest from repository
git fetch
git pull

# Build cmark library
cd cmark-gfm
  mkdir build
  cd build
  cmake ..
  make
  make test
  sudo make install
cd $ROOT

# Rebuild packages
rebuild libbibutils7/
rebuild libpcre3/
rebuild libghc-pandoc-citeproc-data/
rebuild pandoc-citeproc/
rebuild pandoc-data/
rebuild pandoc/
