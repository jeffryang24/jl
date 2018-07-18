#!/usr/bin/env bash

# Find files
FILES="${1:-"*.py"}"

# pylint
PYLINT="${2:-"pylint"}"

# Do linting
find . -type f -name "${FILES}" -exec "${PYLINT}" --rcfile=.pylintrc --output-format=colorized {} +
