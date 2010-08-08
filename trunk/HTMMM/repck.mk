# $(call check_for_reps,list_name)
# If replicates are found, call show_reps and set reps to 1.
check_for_reps =                                                          \
  $(if $(call lne,$(call uniq,$(strip $($1))),$(strip $($1))),            \
      $(info Following are the $1 replicates with number of occurrences:) \
      $(call show_reps,$(sort $($1)),$($1))                               \
      $(eval reps := 1))

# $(call show_reps,sorted_list,list)
# Shows each replicate in list preceded by its number of occurrences.  The
# replicates are shown in sort order since the first arg is a sorted list.  The
# sort function also removes replicates, which is required for this function to
# work.
show_reps =                                                 \
  $(foreach element,$1,                                     \
    $(if $(call sne,$(words $(filter $(element),$2)),1),    \
      $(info $(words $(filter $(element),$2)) $(element))))

# Check for replicates if efls were found.
ifdef efls
  $(call map,check_for_reps,gsrc objs libs apps)
  $(if $(reps),$(info Illegal replicates found during parsing.))
  $(call assert,$(call seq,$(reps),),For help see HTMMM/repck.mk)
endif
