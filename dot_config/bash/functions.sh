# Silent pushd/popd functions for bash
# Usage: spushd <directory> - silently push directory onto stack
#        spopd - silently pop directory from stack
spushd() {
  pushd "$@" > /dev/null
}

spopd() {
  popd > /dev/null
}
