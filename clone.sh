# This script will check out the needed sources from mercurial.

VERSION=`hg id -b`
VERSION=""
if [ ! $VERSION ]
then
    VERSION=5.4
fi

echo "Updating for version: " $VERSION

for x in nuxeo-common nuxeo-runtime nuxeo-core \
    nuxeo-services nuxeo-theme nuxeo-webengine nuxeo-jsf \
    nuxeo-features nuxeo-dm nuxeo-distribution
do
    if [ ! -e $x ]
    then
        hg clone https://hg.nuxeo.org/nuxeo/$x $x
    fi
done

if [ ! -e addons ]
then
    hg clone https://hg.nuxeo.org/addons addons
fi

. scripts/hgfunctions.sh

hgf pull
hgf up $VERSION
( cd addons ; hg pull ; hg up $VERSION )
( cd addons ; ./clone.py $VERSION )

