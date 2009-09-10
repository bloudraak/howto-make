# This file consolidates the architecture-specific variables.
ifeq ($(_ARCH),Linux.x86_64)
  # rules.mk, vpath.mk, and the lib subdir Makefiles
  shared   := so
  # flags.mk
  ansi     := -ansi
  pedantic := -pedantic
  std      := -std=c99
  fPIC     := -fPIC
  pthread  := -pthread
  # utils.mk
  lex      := lex
else ifeq ($(_ARCH),CYGWIN_NT-5.1.i686)
  # rules.mk, vpath.mk, and the lib subdir Makefiles
  shared   := dll
  # flags.mk
  ansi     := -ansi
  pedantic := -pedantic
  std      :=
  fPIC     :=
  pthread  :=
  # utils.mk
  lex      := flex
else ifeq ($(_ARCH),MINGW32_NT-5.1.i686)
  # rules.mk, vpath.mk, and the lib subdir Makefiles
  shared   := dll
  # flags.mk
  ansi     :=
  pedantic :=
  std      :=
  fPIC     :=
  pthread  :=
  # utils.mk
  lex      := flex
else
  # rules.mk, vpath.mk, and the lib subdir Makefiles
  shared   := so
  # flags.mk
  ansi     := -ansi
  pedantic := -pedantic
  std      := -std=c99
  fPIC     := -fPIC
  pthread  := -pthread
  # utils.mk
  lex      := lex
endif
