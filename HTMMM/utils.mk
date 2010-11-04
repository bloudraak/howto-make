# This file is used to set the utilities for the entire build - edit
# accordingly.
#
# The default value of $(RM) is "rm -f".
#
FIND     := $(SRCDIR)/HTMMM/Utils/wcfind
FIXDEP   := $(SRCDIR)/HTMMM/Utils/fixdepS
GREP     := $(SRCDIR)/HTMMM/Utils/wcgrep
LDCONFIG := /sbin/ldconfig -n .
LEX      := $(lex)
LN       := ln -sf
MV       := mv -f
RPCGEN   := rpcgen

# Build fixdep if it does not exist; exit if this fails.
fixdep  := $(or $(wildcard $(FIXDEP) $(FIXDEP).exe),$(shell $(CC) $(FIXDEP).c -o $(FIXDEP)))
#fixdep := $(or $(wildcard $(FIXDEP) $(FIXDEP).exe),        $(error Error: the fixdep build failed))
fixdep  := $(or $(call seq,$(shell ls $(FIXDEP)),$(FIXDEP)),$(error Error: the fixdep build failed))

# The previous command uses an ls because the wildcard in the commented-out
# version above it does not return a value if fixdep was just built.  This
# occurs because GNU make has a directory cache which is used for a significant
# performance advantage.  For more information, see
# http://savannah.gnu.org/bugs/?443, http://savannah.gnu.org/bugs/?14617, and
# http://savannah.gnu.org/bugs/?21231.
#
# Also, in the Cygwin and MinGW environments, the ls in the previous command
# returns $(FIXDEP), so the seq comparison is still accurate even though the
# executable is named $(FIXDEP).exe.  In these environments, "ls $(FIXDEP).exe"
# would return $(FIXDEP).exe.
