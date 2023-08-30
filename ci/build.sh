#!/bin/bash

VERSION=1.0

set -e

# if [ -z ${ARCH}]; then
#   echo "ARCH must be set to a valid rpm build architecture"
#   exit 1
# fi

# Generate source tarball
ln -s . secvarctl-${VERSION}
tar czf secvarctl-${VERSION}.tar.gz secvarctl-${VERSION}/*
mkdir -p /root/rpmbuild/SOURCES
cp secvarctl-${VERSION}.tar.gz /root/rpmbuild/SOURCES
 
# Run Build
rpmbuild -ba secvarctl.spec

# Move generated RPMs out of container
mkdir -p rpms
cp /root/rpmbuild/RPMS/*/*.rpm rpms/
cp /root/rpmbuild/SRPMS/*.rpm rpms/
# Note: srpm s the same for all arches, so really only the first to complete needs to be done