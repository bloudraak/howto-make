# The clean phony targets used by the developers are defined in the root-dir
# Makefile.
#
.PHONY: clean.apps.upto clean.libs.upto clean.objs.upto clean.gsrc.upto
.PHONY: clean.apps.only clean.libs.only clean.objs.only clean.gsrc.only

ifeq ($(or $(call seq,$(T),1),$(call seq,$(T),2)),$(true))
  descend := without descending ...
else
  descend := and below ...
endif

ifdef RELDIR
  CLNDIR := $(OBJDIR)/$(RELDIR)
else
  CLNDIR := $(OBJDIR)
endif

clean:
ifeq ($(or $(call seq,$(T),1),$(call seq,$(T),2)),$(true))
	@echo Cleaning $(CLNDIR) $(descend)
	$(Q)[ ! -e $(CLNDIR) ] || $(FIND) $(CLNDIR) -maxdepth 1 -type f -exec $(RM) {} \;
	$(Q)[ ! -e $(CLNDIR) ] || $(FIND) $(CLNDIR) -maxdepth 1 -type l -exec $(RM) {} \;
else ifeq ($(or $(call seq,$(T),3),$(call seq,$(T),4)),$(true))
	@echo Cleaning $(CLNDIR) $(descend)
	$(Q)$(RM) -r $(CLNDIR)
else
	@echo Cleaning $(CLNDIR) $(descend)
	$(Q)$(RM) -r $(CLNDIR)/*
endif
	@echo

clean.all:       clean.gsrc.upto
clean.apps:      clean.apps.upto
clean.libs:      clean.libs.upto
clean.objs:      clean.objs.upto
clean.gsrc:      clean.gsrc.upto
clean.apps.upto: clean.apps.only
clean.libs.upto: clean.apps.upto clean.libs.only
clean.objs.upto: clean.libs.upto clean.objs.only
clean.gsrc.upto: clean.objs.upto clean.gsrc.only

clean.apps.only:
	@echo Cleaning applications from $(CLNDIR) $(descend)
	$(Q)$(RM) $(sort $(apps))
	@echo
clean.libs.only:
	@echo Cleaning libraries from $(CLNDIR) $(descend)
	$(Q)$(RM) $(sort $(patsubst %.so,%.so*,$(libs)))
	@echo
clean.objs.only:
	@echo Cleaning objects \(and dependency files\) from $(CLNDIR) $(descend)
	$(clean_objs)
	@echo
clean.gsrc.only:
	@echo Cleaning generated source files from $(CLNDIR) $(descend)
	$(Q)$(RM) $(sort $(gsrc))
	@echo

max_objs_length := 10

# $(clean_objs)
# If the number of objs after filtering is greater than $(max_objs_length), then
# use a command with the "*" wildcard.  Otherwise, output a list of the files
# that are being removed.
clean_objs =                                                 \
  $(if $(call gt,$(call length,$(objs)),$(max_objs_length)), \
    $(clean_objs_wcrd),                                      \
    $(clean_objs_list))

# $(clean_objs_wcrd)
# Output a "wildcard" clean command based on the value of $(T).
clean_objs_wcrd =                                                                 \
  $(if $(or $(call seq,$(T),1),$(call seq,$(T),2)),                               \
    $(Q)$(RM) $(CLNDIR)/*.[od],                                                   \
    $(Q)[ ! -e $(CLNDIR) ] || $(FIND) $(CLNDIR) -name '*.[od]' -exec $(RM) {} \;)

# $(clean_objs_list)
# Output the "list" clean command.
clean_objs_list = $(Q)$(RM) $(sort $(patsubst %.o,%.[od],$(objs)))
