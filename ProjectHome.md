A Full-Featured Makefile System that Enables Quick, Accurate Incremental Builds

  * Fully-accurate incremental builds (the build is nonrecursive and uses a single dependency graph).

  * Fully-automatic dependency generation (a separate "make depends" step is not required).

  * Compiler-option dependency (recompiles an object if its compiler options change).

  * The OBJDIR feature (all targets are built in the OBJDIR; none are built in the SRCDIR), which enables simultaneous multi-architecture builds from the same source tree.

  * Error-free parallel Make (jobs), even for builds with nonstandard generated source (gsrc) rules.

  * Partial Builds
    * Partial builds based on target type (gsrc, objs, libs, or apps) or location (entire tree, subtree, or subdir), with these two constraints working together.  The subtree partial build feature allows developers to invoke the nonrecursive Make from a subdir in the familiar way that they invoke a recursive Make.
    * Partial cleans based on target type, location, or both.
    * Filtered builds, which accelerate the Makefile parsing phase of subtree and subdir builds within huge source trees.

  * Additional Features
    * Optimization, debug, profiling, and coverage testing builds (implemented by extending the OBJDIR feature).
    * Command-echo management (quiet and silent modes).
    * Debug mode using the GMD (GNU Make Debugger).
    * Versioning of shared libs.
    * Easy navigation between the corresponding subdirs of the SRCDIR and the OBJDIR using a "pushdo" command that interacts with the Makefile system.

  * Easy Implementation and Maintenance
    * The Makefiles are clear and concise since all of the dependencies are autogenerated.
    * It is easy to add new source files, libs, and apps and to reorganize the source tree.
    * No environment variables.
    * Extensive documentation.

  * Speed
    * Developers can do fully-accurate incremental builds instead of clean builds.
    * The error-free parallel Make greatly speeds-up incremental and clean builds.
    * Supports the use of distcc to further speed-up incremental and clean builds.
    * Supports the use of ccache to further speed-up clean builds.
    * Supports the simultaneous use of distcc and ccache.

  * Includes an RPM packaging system
    * There is no "make install" step or subdir install targets (the package contents are defined in a single location).
    * The package dependencies are autogenerated from the list of package contents.
    * Can be used as a basis for developing your own packaging system.

  * Includes demo apps to help you get started
    * C, C++, lex, and yacc.
    * Set up for the Linux, Cygwin, and MinGW architectures.

This Makefile system facilitates an approach in which each lib and each app has its own dir which contains all of its source files and a Makefile (the dir can also contain subdirs and non-source files).  This approach results in a well-designed source tree and eliminates the need to list the source files explicitly, as can be seen in the Makefile below for an app named CD.  However, this Makefile system does support multiple libs in a lib dir, multiple apps in an app dir, and the combination of libs and apps in the same dir.
```
# For help, see HTMMM/Makefile.README
 
# Do Not Edit
ifndef _PARSE
srchup = $(or $(wildcard $1/$2),$(if $(notdir $(abspath $1)),$(call srchup,../$1,$2),$(info $2 not found.)))
include $(call srchup,.,HTMMM/chdir.mk)
endif
 
# Edit Values Only (all of this dir's source files are used if src is undefined)
type     := app
name     := CD
src      :=
inc_dirs :=
use_libs := -lcaseCD -lcaseG
 
# Add, Remove, and Edit Directory-Specific Variables and Values
add_cflags := -fno-builtin
```

This Makefile system does not incorporate autoconf, so it is currently most useful for projects with a known set of target architectures.