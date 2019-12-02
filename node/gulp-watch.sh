#!/usr/bin/env bash
path=`dirname "$@"`
if [[ -f $path/gulpfile.js ]]
then
  cd $path
  npm install
  ./node_modules/gulp/bin/gulp.js build
  ./node_modules/gulp/bin/gulp.js watch &
  cd -
fi
