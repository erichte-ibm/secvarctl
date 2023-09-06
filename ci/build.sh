#!/bin/bash

VERSION=1.0


if [[ $(cat /etc/os-relase | grep "^ID=") == *"suse"* ]]; then
  RPMBUILD_ROOT=/usr/src/packages
else
  RPMBUILD_ROOT=/root/rpmbuild
fi

set -e

# Generate source tarball
ln -s . secvarctl-${VERSION}
tar czf secvarctl-${VERSION}.tar.gz secvarctl-${VERSION}/*
mkdir -p ${RPMBUILD_ROOT}/SOURCES
cp secvarctl-${VERSION}.tar.gz ${RPMBUILD_ROOT}/SOURCES
 
# Run Build
if [[ "x86_64" == $(uname -m) ]]; then
  # Only one srpm is needed, so just arbitrarily pick the faster x86_64 build to do it
  rpmbuild -ba secvarctl.spec
else
  rpmbuild -bb secvarctl.spec
fi

# Move generated RPMs out of container
mkdir -p rpms
cp ${RPMBUILD_ROOT}/RPMS/*/*.rpm rpms/
if [[ "x86_64" == $(uname -m) ]]; then
  # Only the x86_64 build generates the srpm
  cp ${RPMBUILD_ROOT}/SRPMS/*.rpm rpms/
fi

# Note: srpm s the same for all arches, so really only the first to complete needs to be done