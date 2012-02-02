

# only build the driver if explicity told to
ifeq ($(BOARD_PREBUILT_GPU_DRIVER), false)



include $(CLEAR_VARS)

# All projects are in the src subdirectory
# Each have their own makefile
# called from the base makefile in the src directory

include $(call all-named-subdir-makefiles, src)


endif
