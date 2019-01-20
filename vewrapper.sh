#!/bin/sh
# -----------------------------------------------------------------------------
# Shell functions to act as wrapper for `python3 -m venv`
# POSIX compatible version, technically not multibyte compatible,
# but it only checks if equal to '/' from the end so it still works
#
# Authors:
#   - a-vrma
# -----------------------------------------------------------------------------

# Variables and helper functions
if [ -z "${VENV_HOME}" ] || [ "$(printf "%s" "$VENV_HOME" | tail -c 1)" = '/' ]; then
    # the tail command goes by bytes not characters but it still works in our case
	printf "%s\n%s\n" "Please set your VENV_HOME to a valid string" \
		"It needs to be non-empty, real (not a symlink), and not end with a slash"
	# we return non-error cause we don't want to crash the shell if -e is on
	return 0
fi

# create venv_home if it doesn't exist
mkdir -p "$VENV_HOME"

# command to use to trash venvs
VW_RM='command trash'

VW_ECHOERR() {
    # print to stderr
    printf "%s\n" "$*" >&2
}

acve() {
    [ $# -eq 0 ] && VW_ECHOERR "Please give the name of an environment." && return 1
    if [ ! -d "$VENV_HOME/$1" ]; then
        VW_ECHOERR "E: Environment '$VENV_HOME/$1' does not contain an activate script."
        return 1
    fi
    . "$VENV_HOME/$1/bin/activate"
}

lsve() {
	command ls -1 "$VENV_HOME"
}

mkve() {
    [ $# -eq 0 ] && VW_ECHOERR "Please give a name." && return 1
    if [ -d "$VENV_HOME/$1" ]; then
        VW_ECHOERR "$1 already exists in $VENV_HOME"
        return 1
    fi
    # safer to create venvs on system python only.
    deactivate 2> /dev/null

    python3 -m venv "$VENV_HOME/$1"
    . "$VENV_HOME/$1/bin/activate" || return 1
    pip install -U pip setuptools
    echo "Python venv created at $VENV_HOME/$1"
}

rmve() {
    if [ $# -eq 0 ]; then
        VW_ECHOERR "Please give the name of an environment."
        return 1
    fi
    if [ ! -d "$VENV_HOME/$1" ]; then
        VW_ECHOERR "E: Environment '$VENV_HOME/$1' does not exist."
        return 1
    fi
    [ "$VIRTUAL_ENV" = "$VENV_HOME/$1" ] && deactivate
    $VW_RM "$VENV_HOME/$1" || return 1
    echo "Python venv removed at $VENV_HOME/$1"
}

upve() {
    if [ $# -eq 0 ]; then
        VW_ECHOERR "Please give the name of an environment."
        return 1
    fi
    if [ ! -d "$VENV_HOME/$1" ]; then
        VW_ECHOERR "E: Environment '$VENV_HOME/$1' does not exist."
        return 1
    fi

    # deactivate to make sure you are upgrading to system python.
    deactivate
    python3 -m venv --upgrade "$VENV_HOME/$1" || return 1
    echo "Python venv upgraded at $VENV_HOME/$1"
}
