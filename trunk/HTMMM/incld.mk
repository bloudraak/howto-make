# $(call include_mfl,mfl)
# Include a subdir Makefile in between pre- and post-processing.
define include_mfl
  $(eval $(clear_dir_vars))
  $(eval include $1)
  $(if $(type),$(eval sd := $(subdir)) $(eval $(load_macro)) $(eval $($(type)_macro)))
endef

# Include the subdir Makefiles, each with pre- and post-processing.
$(call map,include_mfl,$(mfls))
