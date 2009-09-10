# Define the format of the OBJDIR name and the default OBJDIR name.  Please
# update the documentation in this file, HTMMM/flags.mk, and the top-level
# Makefile when changing the defaults.
ifndef _ARCH
  export _ARCH := $(shell $(SRCDIR)/HTMMM/Utils/get_arch)
endif
# Optimization (O), debugging (G), profiling (P), and coverage testing (CT).
ifdef O
  export OBJDIR := $(SRCDIR)/_$(_ARCH).O$(O)
else ifdef G
  export OBJDIR := $(SRCDIR)/_$(_ARCH).O$(G).debug
else ifdef P
  export OBJDIR := $(SRCDIR)/_$(_ARCH).O$(P).gprof
else ifdef CT
  export OBJDIR := $(SRCDIR)/_$(_ARCH).O$(CT).gcovt
else # The default is equivalent to "make G=0"
  export G := 0
  export OBJDIR := $(SRCDIR)/_$(_ARCH).O0.debug
endif
# NOTE:  If the default is equivalent to "make G=0", then "make O=0" should be
# used for a non-debug build at optimization level 0.

# Support for 32-bit/64-bit cross-compilation, e.g., "make BIT=32" and "make
# clean BIT=32".  The BIT variable can be used with all of the other variables,
# e.g., from a subdir "make objs Q=1 BIT=64".  $(MBIT) is used in HTMMM/flags.mk
# and HTMMM/rules.mk.  Please update the documentation in the top-level Makefile
# if you plan to use this feature.
ifdef BIT
  export OBJDIR := $(OBJDIR).$(BIT)bit
  export MBIT   := -m$(BIT)
endif
