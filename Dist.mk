# To make a distribution:
#   make -f Dist.mk [rel=<rel>]
#
# For parallel Make (jobs) of the builds (not the packaging or the dist), set J
# on the command line instead of using the -j flag, as in the example below.
# The value is passed to the build through the rpmbuild command in Package.mk.
#   make -f Dist.mk [rel=<rel>] J=4
#
# The following can be used from the command line to affect the builds (for more
# information see the top-level Makefile):
#   O  optimization level
#   G  debugging
#   P  profiling
#   CT coverage testing
#   Q  quiet
# For example, to make the packages with optimization level 3 and debugging in
# quiet mode, and then produce a dist from these packages:
#   make -f Dist.mk [rel=<rel>] G=3 Q=1
# This works because Make passes variables from the command line to sub-makes
# through the environment.
#
# The default is equivalent to
#   make -f Dist.mk package rel=0.0.0 G=0
#
# For debug mode, use D=1, then "h" for help at the debugger break.
#
# The packages are built in $(RPMTOPDIR), which is based on the use of O, G, P,
# and CT.
#
export J := 1

# Do not edit the following files.
include HTMMM/gmsl     # GNU Make Standard Library 1.0.11
include HTMMM/gmd      # GNU Make Debugger 1.0.2
# In general, do not edit the following file.
include HTMMM/check.mk # Checks the Make version

# Dist Release
rel ?= 0.0.0

# Dirs
SRCDIR     := $(CURDIR)
include HTMMM/OBJDIR.mk # Set and export the OBJDIR name
OBJDIRBASE := $(subst $(SRCDIR)/,,$(OBJDIR))
RPMTOPDIR  := rpm/$(OBJDIRBASE)

# Phony Targets
.PHONY: all package dist clean

all: dist

package:
	$(MAKE) -f Package.mk NAME=htmmm-case     VER=1.0.0 REL=1 ARCH=x86_64
	$(MAKE) -f Package.mk NAME=htmmm-gSrc     VER=1.0.0 REL=1 ARCH=x86_64
	$(MAKE) -f Package.mk NAME=htmmm-helloCPP VER=1.0.0 REL=1 ARCH=x86_64

dist: package
	@echo Begin preparing the Release $(rel) distribution here ...

clean:
	$(RM) $(RPMTOPDIR)/RPMS/*/*

# Set a debugger break at the end of parsing.
ifeq ($(D),1)
  $(__BREAKPOINT)
endif
