#!/bin/bash

# copy css
cp node_modules/materialize-css/dist/css/materialize.min.css ../priv/static/css

# copy js
cp node_modules/jquery/dist/jquery.min.js ../priv/static/js
cp node_modules/materialize-css/dist/js/materialize.min.js ../priv/static/js

# copy fonts
cp -R node_modules/materialize-css/dist/fonts/ ../priv/static/fonts