# For quiet mode, use make Q=1.
ifeq ($(Q),1)
  quiet      := quiet_
  override Q := @
  ARFLAGS    := r
else
  quiet      :=
  override Q :=
  ARFLAGS    := rv
endif

# If the user is running make -s (silent mode), suppress the echoing of
# commands (unset Q so that -s takes precedence over Q=1).
ifneq ($(findstring s,$(MAKEFLAGS)),)
  quiet      := silent_
  override Q :=
  ARFLAGS    := r
endif
