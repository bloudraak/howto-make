# Strip the lists.
apps := $(strip $(apps))
libs := $(strip $(libs))
objs := $(strip $(objs))
gsrc := $(strip $(gsrc))
deps := $(strip $(deps))

# $(call fltr2_if_in_dir,file)
# Returns the filename if the file is in the dir.
fltr2_if_in_dir = $(if $(call seq,$(RELDIR)/,$(dir $1)),$1)

# Filter the lists if T is 2 or 4.
ifeq ($(call seq,$(T),2),$(true))
  apps := $(call map,fltr2_if_in_dir,$(apps))
  libs := $(call map,fltr2_if_in_dir,$(libs))
  objs := $(call map,fltr2_if_in_dir,$(objs))
  gsrc := $(call map,fltr2_if_in_dir,$(gsrc))
else ifeq ($(call seq,$(T),4),$(true))
  apps := $(filter $(RELDIR)/%,$(apps))
  libs := $(filter $(RELDIR)/%,$(libs))
  objs := $(filter $(RELDIR)/%,$(objs))
  gsrc := $(filter $(RELDIR)/%,$(gsrc))
endif
