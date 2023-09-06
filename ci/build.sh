#!/bin/bash

VERSION=1.0
RPMBUILD_ROOT=~/rpmbuild

set -e

# Generate source tarball
ln -s . secvarctl-${VERSION}
tar czf secvarctl-${VERSION}.tar.gz secvarctl-${VERSION}/*
mkdir -p ${RPMBUILD_ROOT}/SOURCES
cp secvarctl-${VERSION}.tar.gz /root/rpmbuild/SOURCES
 
# Run Build
if [[ "x86_64" == $(uname -m) ]]; then
  # Only one srpm is needed, so just arbitrarily pick the faster x86_64 build to do it
  rpmbuild --root ${RPMBUILD_ROOT} -ba secvarctl.spec
else
  rpmbuild --root ${RPMBUILD_ROOT} -bb secvarctl.spec
fi

# Move generated RPMs out of container
mkdir -p rpms
cp ${RPMBUILD_ROOT}/RPMS/*/*.rpm rpms/
if [[ "x86_64" == $(uname -m) ]]; then
  # Only the x86_64 build generates the srpm
  cp ${RPMBUILD_ROOT}/SRPMS/*.rpm rpms/
fi

# Note: srpm s the same for all arches, so really only the first to complete needs to be done