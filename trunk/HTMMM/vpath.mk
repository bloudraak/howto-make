# Set the search paths for the use_libs specified with the "-l" notation in the
# subdir Makefiles.  The built libs are in the OBJDIR lib dirs.  The libs that
# are not built but are under source code control are in the SRCDIR lib dirs.
# The external libs are linked to from $(SRCDIR)/lib/external, e.g.,
#   $(SRCDIR)/lib/external/libfoo.a ->
#   /dir/subdir/libfoo.a
#
# The x86_64 system library paths are appended to the vpath directives here
# since there is currently no easy way to set these in Make (see
# http://savannah.gnu.org/bugs/?16276).
# The following two lines show one way to put libs in the app dir:
#OBJDIRlibDirs  := $(shell $(FIND) lib -type d)
#OBJDIRlibDirs  += app/case/HI/lib
# The following two lines show a second way to put libs in the app dir:
#OBJDIRlibDirs  := $(shell $(FIND) lib -type d)
#OBJDIRlibDirs  += $(shell $(FIND) app -type d -name lib)
# The following two lines show a third way to put libs in the app dir:
OBJDIRlibDirs  := $(shell $(FIND) lib -type d)
OBJDIRlibDirs  += $(subst ../,,$(dir $(shell $(GREP) -l '^type \+:= \+lib$$' ../app)))
SRCDIRlibDirs  :=
externalLibDir := $(SRCDIR)/lib/external
x86_64LibDirs  := /lib64 /usr/lib64 /usr/local/lib64
ifeq (x86_64,$(shell uname -i))
  vpath %.$(shared) $(OBJDIRlibDirs) $(SRCDIRlibDirs) $(externalLibDir) $(x86_64LibDirs)
  vpath %.a         $(OBJDIRlibDirs) $(SRCDIRlibDirs) $(externalLibDir) $(x86_64LibDirs)
else
  vpath %.$(shared) $(OBJDIRlibDirs) $(SRCDIRlibDirs) $(externalLibDir)
  vpath %.a         $(OBJDIRlibDirs) $(SRCDIRlibDirs) $(externalLibDir)
endif
