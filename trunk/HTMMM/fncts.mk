# These functions are used by the subdir Makefiles and the macros in
# HTMMM/macrs.mk - edit accordingly.

# $(subdir)
# Evaluated after the parsing of each subdir Makefile to get the subdir name
# relative to the root dir (SRCDIR).  For example, this function will return
# foo/bar if the root-dir Makefile is in /a/b/c and the subdir Makefile is in
# /a/b/c/foo/bar.  This function also works for the extra Makefiles, i.e.,
# Makefile.[0-9]*.
subdir =                                      \
  $(patsubst $(SRCDIR)/%/Makefile,%,          \
    $(basename $(lastword $(MAKEFILE_LIST))))

# $(call get_gsrc,src)
# Used by load_macro in HTMMM/macrs.mk to generate a gsrc list from a source
# file list.
get_gsrc =                                \
  $(sort                                  \
    $(subst .x,.c,$(filter %.x,$1))       \
    $(subst .x,.h,$(filter %.x,$1))       \
    $(subst .xpp,.cpp,$(filter %.xpp,$1)) \
    $(subst .xpp,.h,$(filter %.xpp,$1))   \
    $(subst .y,.c,$(filter %.y,$1))       \
    $(subst .y,.h,$(filter %.y,$1))       \
    $(subst .l,.c,$(filter %.l,$1)))

# $(call get_objs,src)
# Used by load_macro in HTMMM/macrs.mk to generate an obj list from a source
# file list.
get_objs =                              \
  $(sort                                \
    $(subst .c,.o,$(filter %.c,$1))     \
    $(subst .cpp,.o,$(filter %.cpp,$1)) \
    $(subst .cc,.o,$(filter %.cc,$1))   \
    $(subst .x,.o,$(filter %.x,$1))     \
    $(subst .xpp,.o,$(filter %.xpp,$1)) \
    $(subst .y,.o,$(filter %.y,$1))     \
    $(subst .l,.o,$(filter %.l,$1)))

# $(call set_gsrc_deps_y,file)
# $(call set_gsrc_deps_x,file)
# $(call set_gsrc_deps_xpp,file)
# Used by load_macro in HTMMM/macrs.mk to set the gsrc dependencies that are
# needed for parallel Make (jobs).
set_gsrc_deps_y   = $(eval $1.h: $1.c)
set_gsrc_deps_x   = $(eval $1.h: $1.c)
set_gsrc_deps_xpp = $(eval $1.h: $1.cpp)

# $(call edit_flags,name)
# Used by load_macro and app_macro in HTMMM/macrs.mk to edit the
# directory-specific value of the flag specified by name arg.
edit_flags =                                            \
  $(if $(set_$1),                                       \
    $(set_$1),                                          \
    $(filter-out $(rem_$1),$($(call uc,$1)) $(add_$1)))

# $(call if_changed_dep,name)
# Execute the command cmd_name and also create the .d file from the .tmp file if
# there are prerequisites newer than the target or the command has changed.
if_changed_dep =                                   \
  $(if                                             \
    $(strip $?                                     \
      $(filter-out FORCE $(wildcard $^),$^)        \
      $(filter-out $(cmd_$1),$(cmd_$@))            \
      $(filter-out $(cmd_$@),$(cmd_$1))),          \
    @set -e;                                       \
    $(if $($(quiet)cmd_$1),                        \
      echo '$(subst ','\'',$($(quiet)cmd_$1))';)   \
    $(cmd_$1);                                     \
    $(FIXDEP)                                      \
      $*.tmp                                       \
      $@                                           \
      '$(subst $$,$$$$,$(subst ','\'',$(cmd_$1)))' \
      > $*.d;                                      \
    $(RM) $*.tmp)

# $(call if_Q,name)
# Execute the command cmd_name
if_Q =                                         \
  @set -e;                                     \
  $(if $($(quiet)cmd_$1),                      \
    echo '$(subst ','\'',$($(quiet)cmd_$1))';) \
  $(cmd_$1)
