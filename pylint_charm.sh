#!/usr/bin/env bash

CURRENT_PATH="$(cd "$(dirname "$0")" && pwd)"

# pylint
PYLINT="${1:-"pylint"}"

# Find files
FILES="${2:-"*.py"}"

# Do linting
find . -type f -name "${FILES}" -exec "${PYLINT}" --rcfile="${CURRENT_PATH}/.pylintrc" --output-format=colorized {} +
