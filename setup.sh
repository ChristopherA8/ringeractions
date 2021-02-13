#!/bin/bash

export ringeractionsdir=$PWD
echo $ringeractionsdir
git clone https://github.com/SparkDev97/libSparkAppList.git
cd libSparkAppList
sudo mv headers/*.h $THEOS/include
sudo mv lib/libsparkapplist.dylib $THEOS/lib
cd $ringeractionsdir
rm -rf libSparkAppList
echo "All set up."