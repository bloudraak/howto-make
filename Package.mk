# To make a package:
#   make -f Package.mk NAME=<name> VER=<version> REL=<release> ARCH=<buildarch>
#
# For parallel Make (jobs) of the build (not the packaging), set J on the
# command line instead of using the -j flag, as in the example below.  The value
# is passed to the build through the rpmbuild command in the $(pkg) rule below.
#   make -f Package.mk NAME=<name> VER=<version> REL=<release> \
#                      ARCH=<buildarch> J=4
#
# The following can be used from the command line to affect the build (for more
# information see the top-level Makefile):
#   O  optimization level
#   G  debugging
#   P  profiling
#   CT coverage testing
#   Q  quiet
# For example, to make the package with optimization level 3 and debugging in
# quiet mode:
#   make -f Package.mk NAME=<name> VER=<version> REL=<release> \
#                      ARCH=<buildarch> G=3 Q=1
# This works because Make passes variables from the command line to sub-makes
# through the environment.
#
# The default is equivalent to
#   make -f Package.mk NAME=<name> VER=<version> REL=<release> \
#                      ARCH=<buildarch> G=0
#
# For debug mode, use D=1, then "h" for help at the debugger break.
#
# The package is built in $(RPMTOPDIR), which is based on the use of O, G, P,
# and CT.
#
J := $(if $(J),$(J),1)

# Do not edit the following files.
include HTMMM/gmsl     # GNU Make Standard Library 1.0.11
include HTMMM/gmd      # GNU Make Debugger 1.0.2
# In general, do not edit the following files.
include HTMMM/check.mk # Checks the Make version
include HTMMM/instl.mk # Functions

# Dirs
SRCDIR     := $(CURDIR)
include HTMMM/OBJDIR.mk # Set and export the OBJDIR name
OBJDIRBASE := $(subst $(SRCDIR)/,,$(OBJDIR))
RPMTOPDIR  := rpm/$(OBJDIRBASE)

# Get the list of target dirs from the file list.
vars1 := $(.VARIABLES)
include Install/$(NAME).files # Edit the .files file to customize the install
vars2 := $(.VARIABLES)
dirs  := $(sort $(filter-out $(vars1) vars1,$(vars2)))

# The following files are renamed by Install.mk.  These files are prerequisites
# for the packages, but are not determined automatically.  Thus, these lists
# must be updated whenever a rename is added to an Install/*.cmds file.
ifeq ($(NAME),htmmm-case)
else ifeq ($(NAME),htmmm-gSrc)
  renames += $(OBJDIR)/app/gSrc/lexAndYacc/calc
  renames += app/gSrc/lex/README
  renames += app/gSrc/lexAndYacc/README
else ifeq ($(NAME),htmmm-helloCPP)
endif

# Exit if the package NAME, VER, REL, or ARCH are not defined.
$(if $(NAME),,$(error NAME not defined))
$(if $(VER),,$(error VER not defined))
$(if $(REL),,$(error REL not defined))
$(if $(ARCH),,$(error ARCH not defined))

# Rules
# $(deps) is the list of files to be included in the package.  It is obtained
# using computed variables.
pkg  := $(RPMTOPDIR)/RPMS/$(ARCH)/$(NAME)-$(VER)-$(REL).$(ARCH).rpm
deps := $(foreach dir,$(dirs),$($(dir)))
$(pkg): $(deps) $(wildcard Install/$(NAME).*) rpm/SPECS/$(NAME).spec $(renames)
	@mkdir -p $(RPMTOPDIR)/BUILD
	@mkdir -p $(RPMTOPDIR)/RPMS
# The buildsubdir define in the rpmbuild commands below trigger the creation of
# debuginfo RPMs even though we are not building from pristince source (there is
# no %setup macro in the %prep section of the .spec file).  Note that we can
# still use the -bb rpmbuild flag since we are not building src RPMs.
ifdef O
	cd $(RPMTOPDIR); rpmbuild \
	    --define 'version $(VER)' \
	    --define 'release $(REL)' \
	    --define 'buildarch $(ARCH)' \
	    --define 'jobs $(J)' \
	    -bb ../SPECS/$(NAME).spec
else ifdef G
	cd $(RPMTOPDIR); rpmbuild \
	    --define 'version $(VER)' \
	    --define 'release $(REL)' \
	    --define 'buildarch $(ARCH)' \
	    --define 'jobs $(J)' \
	    --define 'buildsubdir %{nil}' \
	    -bb ../SPECS/$(NAME).spec
else ifdef P
	cd $(RPMTOPDIR); rpmbuild \
	    --define 'version $(VER)' \
	    --define 'release $(REL)' \
	    --define 'buildarch $(ARCH)' \
	    --define 'jobs $(J)' \
	    --define 'buildsubdir %{nil}' \
	    -bb ../SPECS/$(NAME).spec
else ifdef CT
	cd $(RPMTOPDIR); rpmbuild \
	    --define 'version $(VER)' \
	    --define 'release $(REL)' \
	    --define 'buildarch $(ARCH)' \
	    --define 'jobs $(J)' \
	    -bb ../SPECS/$(NAME).spec
else # The default is equivalent to "make G=0"
	cd $(RPMTOPDIR); rpmbuild \
	    --define 'version $(VER)' \
	    --define 'release $(REL)' \
	    --define 'buildarch $(ARCH)' \
	    --define 'jobs $(J)' \
	    --define 'buildsubdir %{nil}' \
	    -bb ../SPECS/$(NAME).spec
endif
$(call uniq,$(deps)): ;
$(renames): ;

# Set a debugger break at the end of parsing.
ifeq ($(D),1)
  $(__BREAKPOINT)
endif
