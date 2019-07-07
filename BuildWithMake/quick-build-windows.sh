#!/bin/bash

# Copyright (c) Stanford University, The Regents of the University of
#               California, and others.
#
# All Rights Reserved.
#
# See Copyright-SimVascular.txt for additional details.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
# OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#export SV_EXTERNALS_VERSION_NUMBER=2019.02
export SV_EXTERNALS_VERSION_NUMBER=2019.06

export SV_BUILD_AGAINST_RELEASE_DATE=2019-07-05
export SV_BUILD_AGAINST_RELEASE_DATE_DOTS=2019.07.05

if [ $SV_EXTERNALS_VERSION_NUMBER == '2019.02' ]; then

  # use vs2015 compiler
  export EXTERNALS_PARENT_URL=http://simvascular.stanford.edu/downloads/public/simvascular/externals/2019.02/windows/windows/10.0/msvc/19.0/x64/release/2019.05.21
  export EXTERNALS_TAR_FILE_PREFIX=windows.10.0.msvc.19.0.x64.release.2019.05.21
  export INTERNALS_PARENT_URL=http://simvascular.stanford.edu/downloads/public/simvascular/internals/XXXXXXX

elif [ $SV_EXTERNALS_VERSION_NUMBER == '2019.06' ]; then

  # use vs2017 compiler
  export EXTERNALS_PARENT_URL=http://simvascular.stanford.edu/downloads/public/simvascular/externals/2019.06/windows/windows/10.0/msvc/19.16/x64/release/2019.07.05
  export EXTERNALS_TAR_FILE_PREFIX=windows.10.0.msvc.19.16.x64.release.2019.07.05
  export INTERNALS_PARENT_URL=http://simvascular.stanford.edu/downloads/public/simvascular/internals/2019.06/windows/windows/10.0/msvc/19.16/x64/release/$SV_BUILD_AGAINST_RELEASE_DATE_DOTS

fi

#
# internals
#

export INTERNALS_TOP=`pwd`/int

if [ -e $INTERNALS_TOP ];then /bin/rm -f $INTERNALS_TOP;fi
mkdir -p $INTERNALS_TOP
chmod -R a+rwx $INTERNALS_TOP
mkdir -p $INTERNALS_TOP/tarfiles

pushd $INTERNALS_TOP/tarfiles

wget $INTERNALS_PARENT_URL/simvascular-libs-headers-windows-x64.$SV_BUILD_AGAINST_RELEASE_DATE.tar.gz

popd

pushd $INTERNALS_TOP
  echo "untar simvascular-libs-headers-windows..."
  tar xzf tarfiles/simvascular-libs-headers-windows-x64.$SV_BUILD_AGAINST_RELEASE_DATE.tar.gz
popd

#
# externals
#

source $INTERNALS_TOP/SimVascularLibsAndHeaders/$SV_BUILD_AGAINST_RELEASE_DATE/BuildWithMake/MakeHelpers/2019.06/wget-externals.x64_cygwin.sh

#
# build it!  Build msi installer as well
#

export SV_TOP=$INTERNALS_TOP/SimVascularLibsAndHeaders/$SV_BUILD_AGAINST_RELEASE_DATE/BuildWithMake
export SV_TOP=`cygpath --windows -t mixed $SV_TOP`
echo "SV_TOP: $SV_TOP"

make

pushd Release

make

popd


