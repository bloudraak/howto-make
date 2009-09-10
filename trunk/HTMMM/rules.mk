# These rules affect the entire build - edit accordingly.
.LIBPATTERNS := lib%.$(shared) lib%.a
FORCE   : ;
%.c     : %.l
	$(call if_Q,lex_c_l)
%.c     : %.y
	$(call if_Q,yacc_c_h_y)
	$(Q)$(MV) $(@D)/y.tab.c $*.c
	$(Q)$(MV) $(@D)/y.tab.h $*.h
%.c     : %.x
	$(call if_Q,rg_c_x)
	$(call if_Q,rg_h_x)
%.cpp   : %.xpp
	$(call if_Q,rgxx_cpp_xpp)
	$(call if_Q,rgxx_h_xpp)
%.o     : %.c   FORCE
	$(call if_changed_dep,cc_o_c)
%.o     : %.cpp FORCE
	$(call if_changed_dep,cxx_o_cpp)
%.o     : %.cc  FORCE
	$(call if_changed_dep,cxx_o_cc)
%.a     :
	$(call if_Q,ar_a_o)
%.so    :
	$(call if_Q,c_so_o)
	$(Q)cd $(@D); $(LDCONFIG)
	$(Q)cd $(@D); $(LN) $(@F).$(SOVER) $(@F)
%.dll   :
	$(call if_Q,c_dll_o)
%       : %.o
	$(call if_Q,ld_app_o)
.print.%:
	@echo $($(*F))
.debug.%:
	@echo -n
	$(info $(*F) has value '$($(*F))')
	$(info $(*F) came from $(origin $(*F)))
	$(info $(*F) is defined as '$(value $(*F))')

cmd_lex_c_l            = $(LEX) $(LFLAGS) -t $< > $@
quiet_cmd_lex_c_l      = [LEX]  $@
cmd_yacc_c_h_y         = $(YACC) $(YFLAGS) -b $(@D)/y $<
quiet_cmd_yacc_c_h_y   = [YACC] $@ $*.h
cmd_rg_c_x             = cd $(SRCDIR)/$(@D); $(RM) $(OBJDIR)/$*.c; $(RPCGEN) -c $(*F).x -o $(OBJDIR)/$*.c
quiet_cmd_rg_c_x       = [RG]   $@
cmd_rg_h_x             = cd $(SRCDIR)/$(@D); $(RM) $(OBJDIR)/$*.h; $(RPCGEN) -h $(*F).x -o $(OBJDIR)/$*.h
quiet_cmd_rg_h_x       = [RG]   $*.h
cmd_rgxx_cpp_xpp       = cd $(SRCDIR)/$(@D); $(RM) $(OBJDIR)/$*.cpp; $(RPCGEN) -c $(*F).xpp -o $(OBJDIR)/$*.cpp
quiet_cmd_rgxx_cpp_xpp = [RGXX] $@
cmd_rgxx_h_xpp         = cd $(SRCDIR)/$(@D); $(RM) $(OBJDIR)/$*.h  ; $(RPCGEN) -h $(*F).xpp -o $(OBJDIR)/$*.h
quiet_cmd_rgxx_h_xpp   = [RGXX] $*.h
cmd_cc_o_c             = $(C) -MMD -MF $*.tmp $(CPPFLAGS) $(CFLAGS) $(TARGET_ARCH) $(idirs) -c $< -o $@
quiet_cmd_cc_o_c       = [CC]   $@
cmd_cxx_o_cpp          = $(C) -MMD -MF $*.tmp $(CPPFLAGS) $(CXXFLAGS) $(TARGET_ARCH) $(idirs) -c $< -o $@
quiet_cmd_cxx_o_cpp    = [CXX]  $@
cmd_cxx_o_cc           = $(C) -MMD -MF $*.tmp $(CPPFLAGS) $(CXXFLAGS) $(TARGET_ARCH) $(idirs) -c $< -o $@
quiet_cmd_cxx_o_cc     = [CXX]  $@
cmd_ar_a_o             = $(AR) $(ARFLAGS) $@ $?
quiet_cmd_ar_a_o       = [AR]   $@
cmd_c_so_o             = $(C) $(MBIT) -shared -Wl,-soname,$(@F).$(SOVER) -o $@.$(SOREALVER) $+
quiet_cmd_c_so_o       = [SO]   $@
cmd_c_dll_o            = $(C) $(MBIT) -shared -o $@ $+
quiet_cmd_c_dll_o      = [DLL]  $@
cmd_ld_app_o           = $(C) $(LDFLAGS) $(TARGET_ARCH) $+ $(LOADLIBES) $(LDLIBS) -o $@
quiet_cmd_ld_app_o     = [LD]   $@
