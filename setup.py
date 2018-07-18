#!/usr/bin/env python
# JL Core Setup Script
#
# @author       : Jeffry Angtoni <jeffryangtoni24@gmail.com>
# @date         : July 18th, 2018
"""
JL Core Setup Script
"""

import os
from setuptools import setup

from jl_core.__pkginfo import (
    PACKAGE_AUTHOR,
    PACKAGE_AUTHOR_EMAIL,
    PACKAGE_DESCRIPTION,
    PACKAGE_LICENSE,
    PACKAGE_NAME,
    PACKAGE_URL,
    PACKAGE_VERSION
)

# current location
HERE = os.path.abspath(os.path.dirname(__file__))

# Requires python
PYTHON_REQUIRED = '>=3.5.0'

def long_description():
    """
    Get long description from README.rst.

    :return: README.rst content.
    """
    try:
        with open(os.path.join(HERE, 'README.rst'), encoding='utf-8') as fd_long_desc:
            return fd_long_desc.read()
    except FileNotFoundError:
        return 'If you see this message, then your README.rst file is missing.'

# Now the show...
setup(
    name=PACKAGE_NAME,
    version=PACKAGE_VERSION,
    description=PACKAGE_DESCRIPTION,
    long_description=long_description(),
    author=PACKAGE_AUTHOR,
    author_email=PACKAGE_AUTHOR_EMAIL,
    python_requires=PYTHON_REQUIRED,
    url=PACKAGE_URL,
    license=PACKAGE_LICENSE,

    packages=[PACKAGE_NAME],
    entry_points={
        'console_scripts': ['jtl=' + PACKAGE_NAME + '.jlco:main']
    },

    include_package_data=True,
    zip_safe=False
)
