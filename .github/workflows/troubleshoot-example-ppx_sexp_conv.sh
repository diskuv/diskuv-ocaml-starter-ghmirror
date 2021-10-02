#!/bin/sh
#
# This script is an example for troubleshooting a GitHub CI action that is failing
# to build an Opam package (in this example the package is 'ppx_sexp_conv').
#
set -euf

echo 'Starting troubleshooting-example-ppx_sexp_conv.sh' >&2
set -x

# Basic diagnostics
pwd
which dune
which opam
opam env

# Remove trailing slashes, if any, from PATH which can be expanded to include double quotes that
# interfere with Microsoft's vsdevcmd.bat
PATH=$(echo "$PATH" | PATH="/usr/bin:/bin:$PATH" sed 's#/:#:#g; s#/$##')

# When called as a troubleshooting hook, then OPAMROOTDIR_BUILDHOST and OPAMSWITCHNAME_BUILDHOST will be set. Otherwise we are being
# called directly in a CI build.
if [ -n "${OPAMROOTDIR_BUILDHOST:-}" ] && [ -n "${OPAMSWITCHNAME_BUILDHOST:-}" ]; then
    # shellcheck disable=SC2046
    eval $(opam env --root "$OPAMROOTDIR_BUILDHOST" --switch "$OPAMSWITCHNAME_BUILDHOST" --set-root --set-switch)
elif [ -z "${OPAMSWITCH:-}" ]; then
    # We are being called directly in a CI build.
    # Use the system switch as a pre-existing switch that has an installed OCaml compiler base package.
    # shellcheck disable=SC2046
    eval $(opam env --switch "$LOCALAPPDATA\\Programs\\DiskuvOCaml\\0\\system" --set-switch)
fi
opam switch

# Use a clean directory
install -d _ci/troubleshoot
cd _ci/troubleshoot

set +f # Turn on file globbing so we can do wildcards ('*').

# --------------------
# Real troubleshooting
# --------------------

opam source ppx_sexp_conv
cd ppx_sexp_conv.*
tail -v -n5000 ./*opam                    # Pretty print all the Opam packages
opam install ./*opam --deps-only --yes    # Install all the dependencies of the packages
dune build -p ppx_sexp_conv -j1 --verbose # This is the first statement in ppx_sexp_conv.opam build:[] block, except we want verbose to see what is happening
