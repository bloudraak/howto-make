# These macros are called by the subdir Makefiles - edit accordingly.

# $(eval $(clear_dir_vars))
# This macro is evaluated before the parsing of each subdir Makefile.  It clears
# all of the directory-specific variables so that a value from a previous dir is
# not used when a new value is not assigned.  The list of variables must be
# comprehensive.  It should include every directory-specific variable from every
# subdir Makefile.
define clear_dir_vars
  type          :=
  name          :=
  src           :=
  inc_dirs      :=
  use_libs      :=
  other_gsrc    :=
  C             :=
  set_c         :=
  add_lflags    :=
  rem_lflags    :=
  set_lflags    :=
  add_yflags    :=
  rem_yflags    :=
  set_yflags    :=
  add_cppflags  :=
  rem_cppflags  :=
  set_cppflags  :=
  add_cflags    :=
  rem_cflags    :=
  set_cflags    :=
  add_cxxflags  :=
  rem_cxxflags  :=
  set_cxxflags  :=
  add_ldflags   :=
  rem_ldflags   :=
  set_ldflags   :=
  add_ldlibs    :=
  rem_ldlibs    :=
  set_ldlibs    :=
  set_sover     :=
  set_sorealver :=
endef

# $(eval $(load_macro))
# This macro is evaluated after the parsing of each subdir Makefile.  It appends
# the names of the gsrc and objs to the lists defined in the root-dir Makefile.
# This macro also sets directory-specific variables.
define load_macro
  local_src  := $$(if $(src),                                                                             \
                  $$(addprefix $(sd)/,$(src)),                                                            \
                  $$(patsubst $(SRCDIR)/%,%,                                                              \
                    $$(wildcard $(SRCDIR)/$(sd)/*.[clxy] $(SRCDIR)/$(sd)/*.[cx]pp $(SRCDIR)/$(sd)/*.cc)))
  local_gsrc := $$(call get_gsrc,$$(local_src))
  local_objs := $$(call get_objs,$$(local_src))
  gsrc       += $$(local_gsrc)
  objs       += $$(local_objs)
  $$(call map,set_gsrc_deps_y,$$(patsubst %.y,%,$$(filter %.y,$$(local_src))))
  $$(call map,set_gsrc_deps_x,$$(patsubst %.x,%,$$(filter %.x,$$(local_src))))
  $$(call map,set_gsrc_deps_xpp,$$(patsubst %.xpp,%,$$(filter %.xpp,$$(local_src))))
  $$(local_objs): $$(local_gsrc) $$(other_gsrc)
  $$(local_objs): override C        := $$(if $(set_c),$(set_c),$$(if $$(filter %.cpp %.cc,$$(local_src)),$(CXX),$(CC)))
  $$(local_objs): override LFLAGS   := $(call edit_flags,lflags)
  $$(local_objs): override YFLAGS   := $(call edit_flags,yflags)
  $$(local_objs): override CPPFLAGS := $(call edit_flags,cppflags)
  $$(local_objs): override CFLAGS   := $(call edit_flags,cflags)
  $$(local_objs): override CXXFLAGS := $(call edit_flags,cxxflags)
  $$(local_objs): idirs := -I$(OBJDIR)/$(sd) $$(addprefix -I$(SRCDIR)/,$(sd) $(inc_dirs)) $(public_idirs)
endef

# $(eval $(app_macro))
# This macro is evaluated after the parsing of each app's subdir Makefile.  It
# appends the name of the app to the list defined in the root-dir Makefile.
# This macro also sets directory-specific variables and sets the obj and lib
# prerequisites for the app.
define app_macro
  local_app := $(sd)/$(name)
  apps += $$(local_app)
  $$(local_app): override C       := $$(if $(set_c),$(set_c),$$(if $$(filter %.cpp %.cc,$$(local_src)),$(CXX),$(CC)))
  $$(local_app): override LDFLAGS := $(call edit_flags,ldflags)
  $$(local_app): override LDLIBS  := $(call edit_flags,ldlibs)
  $$(local_app): $$(local_objs) $$(use_libs) ; $$(call if_Q,ld_app_o)
endef

# $(eval $(lib_macro))
# This macro is evaluated after the parsing of each lib's subdir Makefile.  It
# appends the name of the lib to the list defined in the root-dir Makefile.
# This macro also sets directory-specific variables and sets the obj and lib
# prerequisites for the lib.
define lib_macro
  local_lib := $(sd)/$(name)
  libs += $$(local_lib)
  $$(local_lib): override C         := $$(if $(set_c),$(set_c),$$(if $$(filter %.cpp %.cc,$$(local_src)),$(CXX),$(CC)))
  $$(local_lib): override SOVER     := $(if $(set_sover),$(set_sover),$(SOVER))
  $$(local_lib): override SOREALVER := $(if $(set_sorealver),$(set_sorealver),$(SOREALVER))
  $$(local_lib): $$(local_objs) $$(use_libs)
endef
