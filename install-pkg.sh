# Utility script to install wally packages and patch them with types
wally install
rojo sourcemap -o sourcemap.json
wally-package-types --sourcemap sourcemap.json Packages