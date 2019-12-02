#!/usr/bin/env bash

# If there is a custom script, run it.
if [[ -x /var/www/node/node-custom.sh ]]
then
  /var/www/node/node-custom.sh
  exit 0
fi

# Otherwise, run our self made script to watch all Gulp-enabled folders.
export DISABLE_NOTIFIER=1
find . -name '*.theme' -exec sh -c 'gulp-watch.sh $@' -- {} \;
