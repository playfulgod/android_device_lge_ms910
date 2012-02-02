



# Build the GLES 1.1 shared library
include $(call all-named-subdir-makefiles, GLES1)

# Build the GLES 2.0 shared library
include $(call all-named-subdir-makefiles, GLES2)

# Build the EGL shared library
include $(call all-named-subdir-makefiles, libegl)

# Build the GSL shared library
include $(call all-named-subdir-makefiles, libsgl)


