#!/bin/sh
#
# This script is an example for troubleshooting a GitHub CI action that is failing
# to build an Opam package (in this example the package is 'ppx_sexp_conv').
#
set -euf

echo 'Starting buildconfig/troubleshooting-ppx_sexp_conv.sh' >&2
set -x

# Basic diagnostics
pwd
opam env

# Use the system switch since as a pre-existing switch that has an installed OCaml compiler base package.
# shellcheck disable=SC2046
eval $(opam env --switch "$LOCALAPPDATA\\Programs\\DiskuvOCaml\\0\\system" --set-switch)
opam switch

# Use a clean directory
export TOPDIR
TOPDIR="$(pwd)"
install -d _ci/troubleshoot
cd _ci/troubleshoot

set +f # Turn on file globbing so we can do wildcards ('*').

# --------------------
# Real troubleshooting
# --------------------

opam source ppx_sexp_conv
cd ppx_sexp_conv.*
tail -v -n5000 ./*opam                             # Pretty print all the Opam packages
opam install ./*opam --deps-only --with-test --yes # Install all the dependencies of the packages
dune build -p ppx_sexp_conv -j1 --verbose          # This is the first statement in ppx_sexp_conv.opam build:[] block, except we want verbose to see what is happening
