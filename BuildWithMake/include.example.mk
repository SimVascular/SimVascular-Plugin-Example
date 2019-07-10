# Hey emacs, this is a -*- makefile -*-

# Copyright (c) Stanford University, The Regents of the University of
#               California, and others.
#
# All Rights Reserved.
#
# See Copyright-SimVascular.txt for additional details.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject
# to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
# OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# used by include.target.mk
BUILDWITHMAKE_DIR = $(EXAMPLE_PLUGIN_TOP)

# optionally override with cluster options
# -----------------------------------------------------------------------

ifeq ($(LOCAL_DIR_CLUSTER_OVERRIDES),1)
-include cluster_overrides.example.mk
else
-include $(EXAMPLE_PLUGIN_TOP)/cluster_overrides.example.mk
endif

# if you need to override anything above for a given site, do it here
# -----------------------------------------------------------------------

ifeq ($(LOCAL_DIR_SITE_OVERRIDES),1)
-include site_overrides.example.mk
else
-include $(EXAMPLE_PLUGIN_TOP)/site_overrides.example.mk
endif

SV_USE_EXAMPLE=1

# if you need to override anything above, stuff it in global_overrides.example.mk
# -----------------------------------------------------------------------

ifeq ($(LOCAL_DIR_GLOBAL_OVERRIDES),1)
-include global_overrides.example.mk
else
-include $(EXAMPLE_PLUGIN_TOP)/global_overrides.example.mk
endif

# Note: advanced usage.  Special case of needing to include
# another (e.g. FOO) plugin when building current plugin.
#ifeq ($(SV_USE_FOO),1)
#  include $(FOO_PLUGIN_TOP)/include.foo.mk
#  # need to fix since this was overridden in parasolid include
#  BUILDWITHMAKE_DIR = $(EXAMPLE_PLUGIN_TOP)
#endif

# access to the example exports headers
LOCAL_INCDIR += -I$(EXAMPLE_PLUGIN_TOP)/../Code/Source/Include/Make

# include path to find libs when linking
ifeq ($(CLUSTER), x64_cygwin)
  EXAMPLE_PLUGIN_TOP_WIN_PATH=$(shell cygpath -m $(EXAMPLE_PLUGIN_TOP))
  LFLAGS 	 += $(LIBPATH_COMPILER_FLAG)$(EXAMPLE_PLUGIN_TOP_WIN_PATH)/Lib/$(LIB_BUILD_DIR)
else
  LFLAGS 	 += $(LIBPATH_COMPILER_FLAG)$(EXAMPLE_PLUGIN_TOP)/Lib/$(LIB_BUILD_DIR)
endif

#
# SV library naming
#
SV_LIB_MODULE_EXAMPLE_NAME=_simvascular_module_example
SV_PLUGIN_HELLO_NAME=org_sv_gui_qt_hello

# here's your chance to override package locations
# ------------------------------------------------

ifeq ($(LOCAL_DIR_PKG_OVERRIDES),1)
-include pkg_overrides.example.mk
else
-include $(EXAMPLE_PLUGIN_TOP)/pkg_overrides.example.mk
endif
