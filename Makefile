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
# Diskuv OCaml supports windows_x86 (32-bit Windows) and windows_x86_64 (64-bit Windows).
# The list of platforms may expand in the future.
DKML_PLATFORMS = windows_x86 windows_x86_64

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
