# For help, see HTMMM/Makefile.README

# Do Not Edit
ifndef _PARSE
srchup = $(or $(wildcard $1/$2),$(if $(notdir $(abspath $1)),$(call srchup,../$1,$2),$(info $2 not found.)))
include $(call srchup,.,HTMMM/chdir.mk)
endif
