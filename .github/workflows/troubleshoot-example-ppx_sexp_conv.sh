#!/bin/sh
#
# This script is an example for troubleshooting a GitHub CI action that is failing
# to build an Opam package (in this example the package is 'ppx_sexp_conv').
#
set -euf

echo 'Starting troubleshooting-example-ppx_sexp_conv.sh' >&2

# Basic diagnostics
pwd
which dune
which opam
opam env
env

# Ensure a clean directory (in case this script is called repeatedly)
install -d _ci/troubleshoot
rm -rf _ci/troubleshoot
install -d _ci/troubleshoot

# Remove trailing slashes, if any, from PATH which can be expanded to include double quotes that
# interfere with Microsoft's vsdevcmd.bat
PATH=$(echo "$PATH" | PATH="/usr/bin:/bin:$PATH" sed 's#/:#:#g; s#/$##')

# When called as a troubleshooting hook, then OPAMROOTDIR_BUILDHOST and OPAMSWITCHNAME_BUILDHOST will be set. Otherwise we are being
# called directly in a CI build.
if [ -n "${OPAMROOTDIR_BUILDHOST:-}" ] && [ -n "${OPAMSWITCHNAME_BUILDHOST:-}" ]; then
    # shellcheck disable=SC2046
    eval $(opam env --root "$OPAMROOTDIR_BUILDHOST" --switch "$OPAMSWITCHNAME_BUILDHOST" --set-root --set-switch | awk '{ sub(/\r$/,""); print }')
elif [ -z "${OPAMSWITCH:-}" ]; then
    # We are being called directly in a CI build.
    # Use the system switch as a pre-existing switch that has an installed OCaml compiler base package.
    # shellcheck disable=SC2046
    eval $(opam env --switch "$LOCALAPPDATA\\Programs\\DiskuvOCaml\\0\\system" --set-switch | awk '{ sub(/\r$/,""); print }')
fi
opam switch

# More diagnostics
which dune
which rsync
opam var
opam option

set +f # Turn on file globbing so we can do wildcards ('*').

# --------------------
# Real troubleshooting
# --------------------

# Windows binary that sets the MSVC compiler variables, among other things.
# All switches except "system" have `opam option wrap-{build|install|remove}-commands` that cause the dkml-opam-wrapper to be used.
# Include tracing so we can see what happens.
export DKML_BUILD_TRACE=ON
export DKML_BUILD_TRACE_LEVEL=2
WRAP="$LOCALAPPDATA\\Programs\\DiskuvOCaml\\0\\tools\\apps\\dkml-opam-wrapper.exe"
if [ -x /usr/bin/cygpath ]; then
    WRAP=$(/usr/bin/cygpath -au "$WRAP")
fi

set -x
cd _ci/troubleshoot
opam source ppx_sexp_conv                                       # Get the source code for package; version from the Opam switch (ex. pinned package)
cd ppx_sexp_conv.*
tail -v -n5000 ./*opam                                          # Pretty print all the Opam packages
opam install ./*opam --deps-only --yes                          # Install all the dependencies of the packages
"$WRAP" dune build -p ppx_sexp_conv -j1 --verbose               # This is the first statement in ppx_sexp_conv.opam build:[] block, except we want verbose to see what is happening

sed -i 's/"-p" name/"--verbose" "-p" name/g' ./*opam            # Force Dune commands to be verbose
sed -i 's/version: "v0.14.0"/version: "v0.14.3"/g' ./*opam      # Fix bug with .opam in the v0.14.3 https://github.com/fdopen/opam-repository-mingw/blob/opam2/packages/ppx_sexp_conv/ppx_sexp_conv.v0.14.3/opam being v0.14.0 instead of v0.14.3
opam install ./*opam --best-effort --yes  # Install the packages
