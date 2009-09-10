# These two functions generate file lists for use with the install utility.
# Symbolic links are not included in the lists because install does not
# reproduce the link, but instead just copies the linked file (still preserving
# the link name).  By not including links, the user is forced to deal with them
# (copy the linked file or recreate the link in the install dir).

# $(call get_wildcard_files,wildcard)
# Returns the files, but not the dirs, that match the wildcard pattern.
get_wildcard_files =                                      \
  $(shell for file in $(wildcard $1);                     \
    do                                                    \
      [[ -f $$file ]] && [[ ! -L $file ]] && echo $$file; \
    done)

# $(call get_dir_files,dir)
# Returns the files, but not the subdirs, that are contained in the dir.
get_dir_files =                                           \
  $(shell for file in $(wildcard $1/*);                   \
    do                                                    \
      [[ -f $$file ]] && [[ ! -L $file ]] && echo $$file; \
    done)
