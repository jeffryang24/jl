#!/usr/bin/env bash
# Do pylinting for PyCharm
#
# @author     : Jeffry Angtoni <jeffryangtoni24@gmail.com>
# @date       : 2018-07-18
# @version    : 0.1

help() {
  local _help
  _help="$(cat <<'EOF'
Pylint Charm
==============

Do pylint for a file or all files.

Usage
=======

$ ./pylint_charm.sh [filename] [--rcfile|-rc=pylintrc_location]

or for all files.

$ ./pylint_charm.sh all   # for all files.
$ ./pylint_charm.sh       # this also for all files.

Parameters
============
    --help, -h        => Show this help message.
    --rcfile=, -rc=   => Set .pylintrc location or another pylint configuration
                         file.
EOF
)"
  printf "%s\n" "${_help}"
}

main() {
  # Get current path.
  local _current_path
  _current_path="$(cd "$(dirname "$0")" && pwd)"

  # Default _rc_file is relative to current path.
  local _rc_file="${_current_path}/.pylintrc"

  # Save other arguments
  local -a _arguments=()

  # Parse arguments
  while [[ "$#" -gt 0 ]]; do
    local key="$1"

    case ${key} in
      --rcfile=*|-rc=*)
        _rc_file="${key#*=}"
        shift
        ;;

      --help|-h)
        help
        exit $?
        ;;

      *)
        _arguments+=("${key}")
        shift
        ;;
    esac
  done

  # Restore positional argument
  eval set -- "${_arguments[@]}"

  # Get pylint abs path
  local _pylint="pylint"
  if command -v pipenv >/dev/null 2>&1; then
    # If current directory is venv
    if pipenv --venv >/dev/null 2>&1; then
      _pylint="$(pipenv --venv)/bin/pylint"
    fi
  fi

  # Find python files
  local _files

  if [[ "$1" == "all" ]] || [[ -z "$1" ]]; then
    _files="*.py"
  else
    _files="$1"
  fi

  if [[ "${_files}" == "*.py" ]]; then
    printf "%s\n" "Do linting on all *.py files..."
  else
    printf "%s\n" "Do linting for ${_files}"
  fi
  # Do linting on current directory (multiple files)
  find . -type f -name "${_files}" -exec "${_pylint}" --rcfile="${_rc_file}" --output-format=colorized {} +
}

main "$@"
