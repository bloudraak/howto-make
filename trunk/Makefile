# Copyright 2006-2014, Steven A. Siano
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#----- Begin Summary
# Run "make" from this dir to build the entire tree or from a subdir to build
# the subtree and its prerequisites.
#
# Run "make clean" from this dir to clean the entire tree or from a subdir to
# clean the subtree.
#
# This dir is the root dir (SRCDIR).  The targets will be built in the OBJDIR,
# which by default is $(SRCDIR)/_<_ARCH>.O0.debug.  The default compiler flags
# are "-O0 -g".  _ARCH and the OBJDIR name format and default are defined in
# HTMMM/OBJDIR.mk (HTMMM is "How To Make Make Make").
#
# Parallel Make (jobs) is invoked by running Make with the "-j" flag, e.g.,
# "make -j4" on a system with two CPUs.
#
# The following commands (functions and aliases) are useful for changing to the
# OBJDIR subdir that corresponds to your current SRCDIR subdir.  The pushdo
# ("pushd OBJDIR") command can be used with popd and the cdo ("cd OBJDIR")
# command can be used with "cd -" to return to your SRCDIR subdir.  The commands
# also work from this dir.  In addition, each command can be used with arguments
# to specify the OBJDIR.  For example, in bash use "pushdo" to move to the
# default OBJDIR tree and "pushdo O=2" to move to the OBJDIR tree for
# optimization level 2 (optimization is described below).
#   pushdo () { d=`make CD=1 $* 2>/dev/null`; pushd $d; }    # sh  and bash
#   alias pushdo 'pushd `sh -c "make CD=1 \!* 2>/dev/null"`' # csh and tcsh
#   function cdo { cd `make CD=1 $* 2>/dev/null`; }          # ksh
#----- End Summary
#
#----- Begin Usage
# This dir is the root dir (SRCDIR).  The targets will be built in the OBJDIR.
# The dir structure in the OBJDIR will be a subset of that of the SRCDIR; if the
# SRCDIR subdir has a Makefile, then a corresponding subdir will be created in
# the OBJDIR.
#
# Use "make" for a full build ("make all" and "make apps" are equivalent).  In a
# subdir, "make" will do a "full" build, i.e., gsrc (generated source files),
# objs, libs, and apps, for the subdir and its prerequisites, as opposed to
# doing a full build of the entire tree.
#
# For a partial build,
#   make gsrc # make the gsrc
#   make objs # make the objs and their prerequisites (the gsrc)
#   make libs # make the libs and their prerequisites (the gsrc and objs)
# From a subdir, these commands only apply to the subdir and its prerequisites.
#
# If a subdir (or the root dir) does not contain any app dirs, then "make",
# "make all", "make apps", and "make libs" are all equivalent.
#
# Use "make clean" for a full clean.  In a subdir, "make clean" will do a "full"
# clean for the subdir, as opposed to doing a full clean of the entire tree.
#
# For a partial clean, without removing the dirs, use the clean variants
#   make clean.apps # clean apps
#   make clean.libs # clean apps, libs
#   make clean.objs # clean apps, libs, objs
#   make clean.gsrc # clean apps, libs, objs, gsrc
#   make clean.all  # clean apps, libs, objs, gsrc
# From a subdir, these commands only apply to the subdir.
#
# The deps files (*.d) are cleaned with the objs.
#
# For quiet mode, use "make Q=1"; for silent mode, use "make -s".
#
# For debug mode, use "make D=1", then "h" for help at the debugger break
# (debug mode is for debugging the Makefile system).  Also, for troubleshooting,
#   make .print.<var> # output the value of var,   e.g., make .print.apps
#   make .debug.<var> # output debug info for var, e.g., make .print.libs
#
# For optimization, use "make O=<level>", where level is 0, 1, 2, 3, or s.
#
# For debugging, use "make G=<level>", where level is the optimization level
# (not the debugging level).  Here, debugging refers to storing debugging
# information in object files.
#
# For profiling, use "make P=<level>", where level is the optimization level
# (not the profiling level).  Profiling implies debugging.
#
# For coverage testing, use "make CT=<level>", where level is the optimization
# level (not the coverage testing level).
#
# In short, from this dir or any subdir:
#   make [-j[N]] [gsrc|objs|libs|apps|all]   [Q=1|-s] [D=1] \
#        [O=<l>|G=<l>|P=<l>|CT=<l>] # where l is 0, 1, 2, 3, or s
#   make clean[.apps|.libs|.objs|.gsrc|.all] [Q=1|-s] [D=1]
#        [O=<l>|G=<l>|P=<l>|CT=<l>] # where l is 0, 1, 2, 3, or s
#   Also, see the explanation of T (for Type) below.
#
# By default, debugging is used, profiling and coverage testing are not used,
# and the optimization level is 0, i.e., "make" and "make G=0" are equivalent.
# For more details, see HTMMM/OBJDIR.mk and HTMMM/flags.mk.
#
# Optimization, debugging, profiling, and coverage testing as described above
# apply to the whole build, and each combination (O, G, P, or CT combined with
# 0, 1, 2, 3, or s) gets its own OBJDIR.  Be sure to specify O, G, P, or CT
# correctly when cleaning, e.g., "make clean O=2".
#
# This make is compiler-option-dependent.  This means that whenever the command
# options for an object (.o file) have changed, the object will be rebuilt, even
# if none of its prerequisites are newer.  The command options are changed by
# changing CPPFLAGS (C and C++), CFLAGS (C), CXXFLAGS (C++), or TARGET_ARCH (C
# and C++) from the make command, HTMMM/flags.mk, or the subdir Makefile (or by
# changing idirs through inc_dirs in the subdir Makefile).  Be sure to specify
# T=1 or T=3 (see below) if you are changing a command option from the make
# command and you do not want it to apply to prerequisites from other sections
# of the source tree.  Compiler-option-dependency does not result in a new
# OBJDIR.
#
# If each lib and each app has its own dir which contains all of its source
# files and a Makefile, then the source files will be determined automatically
# and the src variable should be left undefined (empty) in the subdir Makefiles.
# But a lib dir can contain multiple libs and an app dir can contain multiple
# apps (see HTMMM/README.src).  In this case, the src variable needs to be
# defined only in the dirs that contain multiple libs or apps.  In either case,
# a lib or app dir can also contain subdirs and non-source files.
#
# This file resides in the root dir of the source tree.  In the documentation,
# the file locations are written relative to the root dir, except for the subdir
# Makefiles, which are in the various lib and app dirs.
#
# In general, do not edit this file.  Instead, edit the HTMMM/*.mk's and the
# subdir Makefiles.
#
# The HTMMM/*.mk's each contain documentation.  The subdir Makefiles are
# documented in HTMMM/Makefile.README.  The make method is further documented in
# HTMMM/README.
#----- End Usage
#
#----- Begin Top Boilerplate (required for the OBJDIR feature)
ifndef _PARSE
include HTMMM/check.mk # Check the Make version
include HTMMM/chdir.mk # Implement the OBJDIR feature
else
include $(SRCDIR)/HTMMM/check.mk # Check the Make version
#----- End Top Boilerplate
#
#----- Begin Makefile
VPATH       := $(SRCDIR)
phony_build := all apps libs objs gsrc
phony_clean := clean clean.all clean.gsrc clean.objs clean.libs clean.apps
.DELETE_ON_ERROR:
.SUFFIXES:
.PHONY: $(phony_build) $(phony_clean)
all: apps

# Do not edit the following files.
include $(SRCDIR)/HTMMM/gmsl     # GNU Make Standard Library 1.0.11
include $(SRCDIR)/HTMMM/gmd      # GNU Make Debugger 1.0.2
# Edit the following file to customize the build.
include $(SRCDIR)/HTMMM/_arch.mk # Architecture-specific variables
# In general, do not edit the following files.
include $(SRCDIR)/HTMMM/fncts.mk # Functions
include $(SRCDIR)/HTMMM/macrs.mk # Macros
include $(SRCDIR)/HTMMM/rules.mk # Rules
include $(SRCDIR)/HTMMM/clean.mk # Clean targets and rules
include $(SRCDIR)/HTMMM/quiet.mk # Quiet and silent modes
# Edit the following files and the subdir Makefiles to customize the build.
include $(SRCDIR)/HTMMM/cplrs.mk # Compilers
include $(SRCDIR)/HTMMM/flags.mk # Command flags
include $(SRCDIR)/HTMMM/ivars.mk # inc_dirs variable names and values
include $(SRCDIR)/HTMMM/lvars.mk # use_libs variable names and values
include $(SRCDIR)/HTMMM/utils.mk # Utilities

# Check T and RELDIR (these are set in HTMMM/chdir.mk when doing a partial build
# from a subdir).
$(if $(T),$(call assert,$(filter 1 2 3 4 5,$(T)),If T is set it must equal 1 2 3 4 or 5))
$(if $(RELDIR),$(call assert,$(filter 1 2 3 4,$(T)),Must set T to 1 2 3 or 4 when RELDIR is set))
$(if $(filter 1 2 3 4,$(T)),$(call assert,$(RELDIR),Must set RELDIR when T is 1 2 3 or 4))

# Check that only one of O, G, P, and CT are defined.
$(call assert,$(call eq,1,$(words $(O) $(G) $(P) $(CT))),Must only set one of O G P CT)

# Get the lists of Makefiles and extra Makefiles.
mfls := $(sort $(shell $(FIND) $(SRCDIR)/app $(SRCDIR)/lib -name Makefile))
efls := $(sort $(shell $(FIND) $(SRCDIR)/app $(SRCDIR)/lib -name 'Makefile.[0-9]*'))
include $(SRCDIR)/HTMMM/fltr1.mk # Filter the Makefiles if T is 1 or 3

# Make the dirs in $(OBJDIR), and use these dirs to set vpath directives, unless
# the goal (the command-line target) is clean or one of its variants.
ifeq (,$(filter $(phony_clean),$(MAKECMDGOALS)))
  mods := $(patsubst %/Makefile,%,$(patsubst $(SRCDIR)/%,%,$(mfls)))
  dirs := $(shell for mod in $(mods); do mkdir -p $$mod; done)
  # Edit the following file to customize the build.
  include $(SRCDIR)/HTMMM/vpath.mk # vpath directives for the libs
endif

# Collect the lists of apps, libs, objs, and gsrc by including the subdir
# Makefiles.  The subdir Makefiles also set the obj and lib prerequisites for
# each app and the obj prerequisites for each lib.
apps :=
libs :=
objs :=
gsrc :=
include $(SRCDIR)/HTMMM/incld.mk # Process the subdir Makefiles
include $(SRCDIR)/HTMMM/repck.mk # Check for replicates if efls were found

# Include the deps files unless the goal (the command-line target) is clean or
# one of its variants.
deps := $(subst .o,.d,$(objs))
ifeq (,$(filter $(phony_clean),$(MAKECMDGOALS)))
  -include $(deps)
endif

# Use these targets to do a partial build.  However, the prerequisites of the
# files in the lists are not defined here.  The prerequisites were defined
# earlier by including the subdir Makefiles and deps files, or they will be
# determined by a rule.
include $(SRCDIR)/HTMMM/fltr2.mk # Filter the lists if T is 2 or 4
apps: $(if $(apps),$(apps),$(libs))
libs: $(libs)
objs: $(objs)
gsrc: $(gsrc)

# Set a debugger break at the end of parsing.
ifeq ($(D),1)
  $(__BREAKPOINT)
endif
#----- End Makefile
#
#----- Begin Bottom Boilerplate (required for the OBJDIR feature)
endif
#----- End Bottom Boilerplate
#
#----- Begin Documentation
# This make is nonrecursive.  This means that only one dependency graph
# (directed acyclic graph) is used for the entire source tree.  Thus, the file
# locations are specified relative to the root dir, although this is generally
# hidden from the user (for an example, look at one of the auto-generated .d
# dependency files).  Also, there is only one invocation of make, unlike the
# recursive method in which make calls make for each subdir.
#
# This make method supports five types of builds, which are designated with the
# T (for Type) and RELDIR variables.  Normally, you will not set T or RELDIR.
# Instead these are set in HTMMM/chdir.mk when doing a partial build from a
# subdir.
#
# The five types of builds can be summarized as follows:
#
#                  Do Prerequisites From
#      What Gets   Other Sections of the  Filtered   Filtered
#   T  Built       Source Tree Get Built  Makefiles  Lists
#   -  ----------  ---------------------  ---------  --------
#   1  dir         N                      Y          N
#   2  dir         Y                      N          Y
#   3  subtree     N                      Y          N
#   4  subtree     Y                      N          Y
#   5  whole tree  NA                     N          N
#
# The Makefiles that are filtered are the subdir Makefiles from the $(mfls) list
# and the subdir extra Makefiles from the $(efls) list.  These are filtered in
# HTMMM/fltr1.mk.  The lists that are filtered are $(apps), $(libs), $(objs),
# and $(gsrc).  These are filtered in HTMMM/fltr2.mk.  Filtering the Makefiles
# also results in filtered lists, i.e., the lists will not contain the values
# from the dirs that were not parsed.
#
# From a subdir, RELDIR and a default value of T are set automatically, so you
# will normally only use "make" and "make T=5".
#
# From the root dir, you will normally only use "make" (by default T will be set
# to 5 and RELDIR will not be set).
#
# For a partial build that is limited to a section of the source tree but that
# *does not* make the prerequisites from other sections of the tree, set T to 1
# or 3 and set RELDIR to the relative path to the dir.  For example, from the
# root dir
#   make T=1 RELDIR=app/case/AB # make everything in app/case/AB
#   make T=3 RELDIR=app/case/AB # make everything in app/case/AB and below
# or from the app/case/AB subdir
#   make T=1                    # make everything in app/case/AB
#   make T=3                    # make everything in app/case/AB and below
# This is useful with huge source trees.  It works by filtering the list of
# subdir Makefiles that are parsed, thereby speeding up the parsing phase of the
# make.  This solves the problem of Make taking a long time to figure out what
# it needs to do when working in the subdir of a huge tree.  This is also useful
# for limiting the effects of compiler-option-dependency.  For example, from
# app/case/AB
#   make O=0 CFLAGS='-O0 -g' T=1 # make a debug app in app/case/AB
# This links a debug version of the app in app/case/AB against non-debug libs in
# the O=0 OBJDIR.  This may be preferable to doing a "make G=0" in app/case/AB,
# which would link a debug version of the app against debug libs in the G=0
# OBJDIR.  Without the "T=1", all of the prerequisites from other sections of
# the tree would be rebuilt because CFLAGS had changed.  The next "make O=0"
# that affects app/case/AB will build a non-debug version of the app since the
# compiler-option-dependency feature will pick up that CFLAGS has changed back
# to its default value.
#
# For a partial build that is limited to a section of the source tree but that
# *does* make the prerequisites from other sections of the tree, set T to 2 or 4
# and set RELDIR to the relative path to the dir.  For example, from the root
# dir
#   make T=2 RELDIR=app/case/AB # make everything in app/case/AB
#   make T=4 RELDIR=app/case/AB # make everything in app/case/AB and below
# or from the app/case/AB subdir
#   make T=2                    # make everything in app/case/AB
#   make T=4                    # make everything in app/case/AB and below
# Both of these examples also make the prerequisites from other sections of the
# source tree (for example, the libs).  This allows you to check out your entire
# source tree and then directly begin working on your app without having to
# build the entire tree.
#
# For a small to large tree, the default from the subdirs should be T=4 (this is
# set in HTMMM/chdir.mk).  For a huge tree, the default from the subdirs should
# be T=3.  For any size tree, the default from the top dir is T=5.
#
# The two types of partial builds can be combined (this also works with the
# clean goals).  For example, from the root dir
#   make objs T=3 RELDIR=app/case # make the gsrc and objs in app/case
# or from the app/case subdir
#   make objs T=3                 # make the gsrc and objs in app/case
#
# From the root dir, goals must be specified relative to the root dir, for
# example
#   make app/case/AB/AB app/case/CD/CD # make the AB and CD apps
# From a subdir, goals must be specified relative to the subdir, for example,
# from the app/case/AB dir
#   make AB ../../case/CD/CD           # make the AB and CD apps
# This example also makes the prerequisites from other sections of the tree.
#
# Finally, note that you are allowed to specify more than one phony_goal, but it
# only makes sense to specify a single phony_goal.  For example, it does not
# make sense to run "make objs gsrc" since the gsrc will be made when you run
# "make objs".
#
# NOTE:  Some parts of this Makefile system and documentation assume that the
# GNU Compiler Collection (GCC) is being used.  Please modify the Makefiles and
# documentation for other compilers.
#----- End Documentation
