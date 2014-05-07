# This file is used to set command flags for the entire build - edit
# accordingly.

# These flags are not changed in the subdir Makefiles.
TARGET_ARCH :=
LOADLIBES   :=

# These flags are not changed in the subdir Makefiles because they are
# components of CFLAGS and CXXFLAGS.  These flags are for standards, warnings,
# optimization, debugging, profiling, coverage testing, and extras,
# respectively, for C and C++.
SFLAGS    := $(ansi) $(pedantic) $(std)
WFLAGS    := -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror
OFLAGS    :=
GFLAGS    :=
PFLAGS    :=
CTFLAGS   :=
EFLAGS    := $(fPIC) $(pthread)
SXXFLAGS  := $(ansi) $(pedantic)
WXXFLAGS  := -Wall -W -Wconversion -Wshadow -Wcast-qual -Wwrite-strings -Werror
OXXFLAGS  :=
GXXFLAGS  :=
PXXFLAGS  :=
CTXXFLAGS :=
EXXFLAGS  := $(fPIC) $(pthread)

# Use the subdir Makefiles to add or remove directory-specific values for these
# flags or to set them to a directory-specific value.  An add_, rem_, and set_
# version of each of these variables must be cleared in clear_dir_vars in
# HTMMM/macrs.mk.  For the $(edit_flags) function in HTMMM/fncts.mk to work
# properly, always specify the flags without spaces, for example, as
# "-Dfoo=app1_cppflags" instead of "-D foo=app1_cppflags".
LFLAGS   :=
YFLAGS   := -d
CPPFLAGS :=
LDFLAGS  :=
LDLIBS   :=
# Optimization (O), debugging (G), profiling (P), and coverage testing (CT).
ifdef O
  OFLAGS    += -O$(O)
  OXXFLAGS  += -O$(O)
  LDFLAGS   += $(pthread)
else ifdef G
  OFLAGS    += -O$(G)
  OXXFLAGS  += -O$(G)
  GFLAGS    += -g
  GXXFLAGS  += -g
  LDFLAGS   += $(pthread)
else ifdef P
  OFLAGS    += -O$(P)
  OXXFLAGS  += -O$(P)
  GFLAGS    += -g
  GXXFLAGS  += -g
  PFLAGS    += -pg
  PXXFLAGS  += -pg
  LDFLAGS   += $(pthread) -pg
else ifdef CT
  OFLAGS    += -O$(CT)
  OXXFLAGS  += -O$(CT)
  CTFLAGS   += -fprofile-arcs -ftest-coverage
  CTXXFLAGS += -fprofile-arcs -ftest-coverage
  LDFLAGS   += $(pthread)
  LDLIBS    += -lgcov
else # The default is equivalent to "make G=0"
  OFLAGS    += -O0
  OXXFLAGS  += -O0
  GFLAGS    += -g
  GXXFLAGS  += -g
  LDFLAGS   += $(pthread)
endif
CFLAGS   := $(SFLAGS) $(WFLAGS) $(OFLAGS) $(GFLAGS) $(PFLAGS) $(TFLAGS) $(EFLAGS)
CXXFLAGS := $(SXXFLAGS) $(WXXFLAGS) $(OXXFLAGS) $(GXXFLAGS) $(PXXFLAGS) $(TXXFLAGS) $(EXXFLAGS)

# Support for 32-bit/64-bit cross-compilation (see HTMMM/OBJDIR.mk for more
# information).
ifdef BIT
  CFLAGS   += $(MBIT)
  CXXFLAGS += $(MBIT)
  LDFLAGS  += $(MBIT)
endif

# Use the subdir Makefiles to set these flags to a directory-specific value.  A
# set_ version of each of these variables must be cleared in clear_dir_vars in
# HTMMM/macrs.mk.
SOVER     := 0
SOREALVER := 0.0

# This section exists to consolidate flag variable names and values.  The flag
# variables are used in the subdir Makefiles - edit accordingly.
# LFLAGS
# YFLAGS
# CPPFLAGS
# CFLAGS
rem_cflags_for_lex := -std=c99 -Wall -Wconversion -Werror
# CXXFLAGS
# LDFLAGS
# LDLIBS
