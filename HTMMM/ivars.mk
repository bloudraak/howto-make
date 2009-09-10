# This file exists to consolidate inc_dirs variable names and values.
# The inc_dirs variables are used in the subdir Makefiles - edit accordingly.
#
# The private inc_dirs should be specified relative to the root dir (SRCDIR)
# since the "-I$(SRCDIR)/" prefix will be added by load_macro in HTMMM/macrs.mk.

# This file also gets the list of public include dirs, which is used for each
# app and lib (see load_macro in HTMMM/macrs.mk).  For external non-system
# header files, put links in $(SRCDIR)/inc/external, e.g.
#
#   # For external header files included as <foo.h>
#   $(SRCDIR)/inc/external/foo.h ->
#   /dir/subdir/foo.h
#
#   # For external header files included as <bar/foo.h>
#   $(SRCDIR)/inc/external/bar ->
#   /dir/subdir/bar/

public_idirs := $(addprefix -I,$(wildcard $(SRCDIR)/inc/internal) $(wildcard $(SRCDIR)/inc/external))
