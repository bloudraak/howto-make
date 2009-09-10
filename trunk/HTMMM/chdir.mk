# Set MFNAME to the name of the root-dir Makefile.
MFNAME        := Makefile
export SRCDIR := $(subst /HTMMM/chdir.mk,,$(abspath $(lastword $(MAKEFILE_LIST))))
export _PARSE := 1
phony_build   := all apps libs objs gsrc
phony_clean   := clean clean.all clean.gsrc clean.objs clean.libs clean.apps
phony_goals   := $(filter     $(phony_build) $(phony_clean),$(MAKECMDGOALS))
real_goals    := $(filter-out $(phony_build) $(phony_clean),$(MAKECMDGOALS))
real_goals    := $(abspath $(real_goals))
real_goals    := $(subst $(SRCDIR)/,,$(real_goals))
ifneq ($(CURDIR),$(SRCDIR))
  export T := 4
  ifeq ($(T),$(filter 1 2 3 4,$(T)))
    RELDIR := $(subst $(SRCDIR)/,,$(CURDIR))
    export RELDIR
  endif
endif
# NOTE:  Please update the documentation in the top-level Makefile if you change
# the default value of T from 4 to a lower value.

# The method below invokes make from the OBJDIR whenever the developer runs make
# from the root dir (SRCDIR) or any subdir of the root dir with any variables,
# phony goals, or real goals.
.SUFFIXES:

# Set and export the OBJDIR name.
include $(SRCDIR)/HTMMM/OBJDIR.mk

# Print the SRCDIR subdir's corresponding OBJDIR subdir to STDOUT and exit.  The
# STDOUT can be used by aliased commands for changing to the corresponding
# OBJDIR subdir (the STDERR should be discarded).
ifeq ($(CD),1)
  $(info $(OBJDIR)/$(RELDIR))
  $(error CD=1)
endif

MAKETARGET = $(MAKE) --no-print-directory -C $@ -f $(SRCDIR)/$(MFNAME) \
             $(phony_goals) $(real_goals)

.PHONY: $(OBJDIR)
$(OBJDIR):
	+@[ -d $@ ] || mkdir -p $@
	+@$(MAKETARGET)

Makefile : ;
%.mk :: ;

% :: $(OBJDIR) ; @true
