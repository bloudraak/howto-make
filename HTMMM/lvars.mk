# This file exists to consolidate use_libs variable names and values.
# The use_libs variables are used in the subdir Makefiles - edit accordingly.
#
# Libs should be specified with the "-l" notation.  For example, if use_libs is
# "-lhello", this Make will search for libhello.so in the current dir, then the
# dirs specified by the vpath directives in HTMMM/vpath.mk, and then the
# standard locations, and then do the same for libhello.a if libhello.so is not
# found.  The current dir is the root of the OBJDIR, which will not contain any
# libs, but will contain the lib subdirs (see OBJDIRlibDirs in HTMMM/vpath.mk).
#
# This Make will use the path for the found lib when setting the lib as a
# prerequisite to an app (see app_macro HTMMM/macrs.mk).  You can also specify
# libs using their absolute path.  In all cases, since the lib prerequisite is
# specified with its path, you do not need to use LDFLAGS to set the -L linker
# flag.
#
# Finally, you can also edit the directory-specific LDLIBS variable, e.g., using
# add_ldlibs in a subdir Makefile, to specify additional libs.
#
ABG := -lcaseAB -lcaseG
