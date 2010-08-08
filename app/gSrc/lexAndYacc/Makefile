# For help, see HTMMM/Makefile.README

# Do Not Edit
ifndef _PARSE
srchup = $(or $(wildcard $1/$2),$(if $(notdir $(abspath $1)),$(call srchup,../$1,$2),$(info $2 not found.)))
include $(call srchup,.,HTMMM/chdir.mk)
endif

# Edit Values Only (all of this dir's source files are used if src is undefined)
type     := app
name     := calc
src      :=
inc_dirs :=
use_libs := -ly -lfl

# Add, Remove, and Edit Directory-Specific Variables and Values
rem_cflags := $(rem_cflags_for_lex) -Wshadow
