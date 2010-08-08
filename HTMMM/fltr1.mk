# $(call fltr1_if_in_dir,file)
# Returns the filename if the file is in the dir.
fltr1_if_in_dir = $(if $(call seq,$(SRCDIR)/$(RELDIR)/,$(dir $1)),$1)

# Filter the Makefiles and extra Makefiles if T is 1 or 3.
ifeq ($(call seq,$(T),1),$(true))
  mfls := $(call map,fltr1_if_in_dir,$(mfls))
  efls := $(call map,fltr1_if_in_dir,$(efls))
else ifeq ($(call seq,$(T),3),$(true))
  mfls := $(filter $(SRCDIR)/$(RELDIR)/%,$(mfls))
  efls := $(filter $(SRCDIR)/$(RELDIR)/%,$(efls))
endif
