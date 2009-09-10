#----- Begin from http://www.jgc.org/blog/cookbook-sample.pdf
# If you assume that GNU Make version numbers are always in the form X.YY.Z or
# X.YY (where X is a single digit and YY is always a pair) then the following
# fragment will set the ok variable to nonempty if the version mentioned in need
# is equal to or less than the running version of GNU Make.

need := 3.81
ok   := $(filter $(need),$(firstword $(sort $(MAKE_VERSION) $(need))))

# If ok is not blank (in fact if it's not blank it'll have the same value as
# $(need)) then at least the required version of GNU Make is being used; if it's
# blank then the version of GNU Make is too old.
#----- End from http://www.jgc.org/blog/cookbook-sample.pdf

$(if $(ok),,$(error Must use GNU Make $(need) or better))
