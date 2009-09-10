# For a full install:  make -f Install.mk PKG=<name>
# For a single dir  :  make -f Install.mk PKG=<name> <dir>
#
# PKG and RPM_BUILD_ROOT must be defined.  Typically, this Makefile is run as
# part of the %install section of a .spec file, PKG is obtained from the command
# line, and RPM_BUILD_ROOT is obtained from the environment.
#
# When installing directly with this Makefile, optimization level, debugging,
# profiling, and coverage testing can be set from the command line using the O,
# G, P, and CT variables as described in the top-level Makefile.  For example,
# to do a full install of a package with optimization level 3 and debugging:
#   make -f Install.mk PKG=<name> G=3
#
# The default is equivalent to
#   make -f Install.mk PKG=<name> G=0
#
# For debug mode, use D=1, then "h" for help at the debugger break.

# Do not edit the following files.
include HTMMM/gmsl     # GNU Make Standard Library 1.0.11
include HTMMM/gmd      # GNU Make Debugger 1.0.2
# In general, do not edit the following files.
include HTMMM/check.mk # Checks the Make version
include HTMMM/instl.mk # Functions

# Dirs
SRCDIR := $(CURDIR)
include HTMMM/OBJDIR.mk # Set and export the OBJDIR name

# Get the list of target dirs from the file list.
vars1 := $(.VARIABLES)
include Install/$(PKG).files # Edit the .files file to customize the install
vars2 := $(.VARIABLES)
dirs  := $(sort $(filter-out $(vars1) vars1,$(vars2)))

# Commands
cmd_dirs  := install -d
cmd_files := install -p

# Exit if the package name or the installation root dir are not defined.
$(if $(PKG),,$(error PKG not defined))
$(if $(RPM_BUILD_ROOT),,$(error RPM_BUILD_ROOT not defined))

# Phony Targets
.PHONY: install $(dirs)

# Install into all of the target dirs unless a single dir is specified.
install: $(dirs)

# Rules
$(dirs):
	$(cmd_dirs) $(RPM_BUILD_ROOT)/$@
	$(if $($@),$(cmd_files) $($@) $(RPM_BUILD_ROOT)/$@)

# Extra Install Commands
-include Install/$(PKG).cmds # Edit the .cmds file to customize the install

# Set a debugger break at the end of parsing.
ifeq ($(D),1)
  $(__BREAKPOINT)
endif
