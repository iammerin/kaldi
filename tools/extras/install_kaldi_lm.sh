#!/bin/bash

# The script downloads and installs kaldi_lm

GIT=${GIT:-git}

set -e

# Make sure we are in the tools/ directory.
if [ `basename $PWD` == extras ]; then
  cd ..
fi

! [ `basename $PWD` == tools ] && \
   echo "You must call this script from the tools/ directory" && exit 1;

echo "Installing kaldi_lm"

if [ ! -d "kaldi_lm" ]; then
  $GIT clone https://github.com/danpovey/kaldi_lm.git || exit 1
fi

cd kaldi_lm
make || exit 1;
cd ..

(
  set +u

  wd=`pwd`
  echo "export PATH=\$PATH:$wd/kaldi_lm"
) >> env.sh

echo >&2 "Installation of kaldi_lm finished successfully"
echo >&2 "Please source tools/env.sh in your path.sh to enable it"
