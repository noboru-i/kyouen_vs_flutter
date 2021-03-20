#! /bin/bash

# https://qiita.com/tetsufe/items/3f2257ac12f812d3f2d6
if [[ $BUILD_ENV == *"dev"* ]]; then
  cp $PRODUCT_NAME/Firebase/GoogleService-Info-Dev.plist $PRODUCT_NAME/GoogleService-Info.plist
elif [[ $BUILD_ENV == *"prod"* ]]; then
  cp $PRODUCT_NAME/Firebase/GoogleService-Info-Prod.plist $PRODUCT_NAME/GoogleService-Info.plist
else
  echo "configuration didn't match to Development."
  echo $BUILD_ENV
  exit 1
fi
