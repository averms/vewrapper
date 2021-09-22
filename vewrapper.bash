#!/bin/bash
# -----------------------------------------------------------------------------
# vewrapper: shell functions that act as a wrapper for `python3 -m venv`
#
# Copyright © 2018 Christopher Sabater Cordero
# Copyright © 2018-2020 Aman Verma <https://aman.raoverma.com/contact.html>
# Distributed under the GNU General Public License v3.0 only,
# see LICENSE.md file for details.
# -----------------------------------------------------------------------------

# Variables and helper functions
if [[ -z ${VENV_HOME} ]] || [[ ${VENV_HOME: -1} == '/' ]]; then
    echo "Please set your VENV_HOME to a valid string" >&2
    echo "It needs to be non-empty, real (not a symlink), and not end with a slash" >&2
    # we return non-error cause we don't want to crash the shell if -e is on
    return 0
fi

# create venv_home if it doesn't exist
mkdir -p "$VENV_HOME"

# command to use to trash venvs
if [[ -z $VENV_rm ]]; then
    VENV_rm='trash-put'
fi
if [[ -z $VENV_use_virtualenv ]]; then
    VENV_command='python3 -m venv'
else
    VENV_command='virtualenv'
fi
# generic error message for when no environment name is given.
VENV_noenvname='Please give the name of an environment.'

acve() {
    if [[ $# -ne 1 ]]; then
        echo "$VENV_noenvname" >&2
        return 1
    fi
    if [[ ! -d $VENV_HOME/$1 ]]; then
        echo "E: '$1' does not exist." >&2
        return 1
    fi
    [[ -n $VIRTUAL_ENV ]] && deactivate

    source "$VENV_HOME/$1/bin/activate"
}

mkve() {
    if [[ $# -ne 1 ]]; then
        echo "$VENV_noenvname" >&2
        return 1
    fi
    if [[ -d $VENV_HOME/$1 ]]; then
        echo "E: '$1' already exists" >&2
        return 1
    fi
    # safer to create venvs on system python only.
    [[ -n $VIRTUAL_ENV ]] && deactivate

    $VENV_command "$VENV_HOME/$1"
    source "$VENV_HOME/$1/bin/activate" || return 1
    if [[ -z $VENV_use_virtualenv ]]; then
        # install if not using virtualenv, which has these by default.
        pip install -U pip setuptools wheel
    fi
    echo "'$1' was created"
}

upve() {
    if [[ $# -ne 1 ]]; then
        echo "$VENV_noenvname" >&2
        return 1
    fi
    if [[ -n $VENV_use_virtualenv ]]; then
        echo "E: virtualenv doesn't support upgrading." >&2
    fi
    if [[ ! -d $VENV_HOME/$1 ]]; then
        echo "E: '$1' does not exist." >&2
        return 1
    fi
    # deactivate to make sure you are upgrading to system python.
    [[ -n $VIRTUAL_ENV ]] && deactivate

    $VENV_command --upgrade "$VENV_HOME/$1" || return 1
    echo "'$1' was upgraded."
}

rmve() {
    if [[ $# -ne 1 ]]; then
        echo "$VENV_noenvname" >&2
        return 1
    fi
    if [[ ! -d $VENV_HOME/$1 || $1 == . ]]; then
        echo "E: '$1' does not exist." >&2
        return 1
    fi
    [[ $VIRTUAL_ENV == $VENV_HOME/$1 ]] && deactivate

    $VENV_rm "$VENV_HOME/$1" || { echo "Failed to remove $1, try doing it with rm -rf." >&2 && return 1; }
    echo "'$1' was removed."
}

lsve() {
    # better sorting (underscores are first).
    LC_COLLATE=C \ls -1 "$VENV_HOME"
}

complete -W "$(lsve)" acve
complete -W "$(lsve)" upve
complete -W "$(lsve)" rmve
