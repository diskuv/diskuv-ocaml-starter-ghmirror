#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#                      RESERVED FOR DISKUV OCAML                        #
#                         BEGIN CONFIGURATION                           #
#                                                                       #
#     Place this section before the first target (typically 'all:')     #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

# The subdirectory for the 'diskuv-ocaml' git submodule
DKML_DIR = vendor/diskuv-ocaml

# Verbose tracing of each command. Either ON or OFF
DKML_BUILD_TRACE = OFF

# The platforms your OCaml application (or library) supports.
# Diskuv OCaml supports windows_x86_64 (64-bit Windows).
# There is no support for windows_x86 (32-bit Windows), darwin_x86_64 (Mac Intel),
# and darwin_arm64 (Mac M1), although those platforms may work with some packages.
# The list of platforms may expand in the future.
DKML_PLATFORMS = windows_x86_64 windows_x86 darwin_x86_64 darwin_arm64

# Use vcpkg for non-Windows operating systems. vcpkg is always used for Windows.
# Enabling vcpkg will make sure consistent versions of libraries are used across
# all operating systems, rather relying on the build system installed version.
# For example, the library `libffi` is vended by vcpkg, and with this option enabled
# all builds on all operating systems will use the version of `libffi` vended by
# vcpkg rather than, for example, whatever version is vended by Ubuntu 18.04.
# Either ON or OFF
DKML_VENDOR_VCPKG = ON

# The names of the Opam packages (without the .opam suffix). No platform-specific packages belongs here.
OPAM_PKGS_CROSSPLATFORM = starter

# The source directories. No platform-specific source code belongs here.
OCAML_SRC_CROSSPLATFORM = bin lib

# The test directories. No platform-specific source code belongs here.
OCAML_TEST_CROSSPLATFORM = test

# The names of the Windows-specific Opam packages (without the .opam suffix), if any.
OPAM_PKGS_WINDOWS =

# The source directories containing Windows-only source code, if any.
OCAML_SRC_WINDOWS =

# The test directories for Windows source code, if any.
OCAML_TEST_WINDOWS =

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#                          END CONFIGURATION                            #
#                      RESERVED FOR DISKUV OCAML                        #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

.PHONY: all
all: build-dev

.PHONY: clean
clean:
	rm -rf build _build

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#                      RESERVED FOR DISKUV OCAML                        #
#                            BEGIN TARGETS                              #
#                                                                       #
#         Place this section anywhere after the `all` target            #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#

include $(DKML_DIR)/runtime/unix/standard.mk

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
#                             END TARGETS                               #
#                      RESERVED FOR DISKUV OCAML                        #
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
