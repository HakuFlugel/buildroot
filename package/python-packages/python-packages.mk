################################################################################
#
# python-packages
#
################################################################################

PYTHON_PACKAGES_VERSION = 0.1.0
PYTHON_PACKAGES_SOURCE = packages-$(PYTHON_PACKAGES_VERSION).tar.gz
PYTHON_PACKAGES_SITE = https://files.pythonhosted.org/packages/80/e5/d2357ad6c6ad75afb16629f6779d61d84305348f2fec4130042d8244bbf9
PYTHON_PACKAGES_SETUP_TYPE = setuptools
PYTHON_PACKAGES_LICENSE = 

$(eval $(python-package))
