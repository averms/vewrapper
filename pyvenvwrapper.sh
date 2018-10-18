################################################################################
#   Python Venv Wrapper
################################################################################

# Variables and helper functions
if [ "${VENV_HOME:-}" = "" ]
then
    export VENV_HOME="$HOME/.venv" # default
fi

# create venv_home if it doesn't exist
[[ -d "$VENV_HOME" ]] || mkdir "$VENV_HOME"

# command to use to trash venvs
vw_trash() {
    command trash "$1"
}

vw_echoerr() {
    # print to stderr
    printf "%s\n" "$*" >&2;
}

actvenv() {
    [[ $# -eq 0 ]] && vw_echoerr "Please give the name of an environment."; return 1
    if [[ ! -d "$VENV_HOME/$1" ]]; then
        vw_echoerr "E: Environment '$VENV_HOME/$1' does not contain an activate script."
        return 1
    fi
    source "$VENV_HOME/$1/bin/activate"
}

lsvenv() {
    command ls "$VENV_HOME" | tr '\n' '\0' | xargs -0 -n 1 basename 2>/dev/null
}

mkvenv() {
    [[ $# -eq 0 ]] && vw_echoerr "Please give a name."; return 1
    if [[ -d "$VENV_HOME/$1" ]]; then
        vw_echoerr "$1 already exists in $VENV_HOME."
        return 1
    fi
    # safer to create venvs on system python only.
    deactivate

    python3 -m venv "$VENV_HOME/$1"
    source "$VENV_HOME/$1/bin/activate"
    [[ $? = 0 ]] && echo "Python venv created at $VENV_HOME/$1."
}

rmvenv() {
    if [[ $# -eq 0 || $1 == *.* ]]; then
        vw_echoerr "Please give the name of an environment."
        return 1
    fi
    if [[ ! -d "$VENV_HOME/$1" ]]; then
        vw_echoerr "E: Environment '$VENV_HOME/$1' does not exist."
        return 1
    fi
    [[ "$VIRTUAL_ENV" == "$VENV_HOME/$1" ]] && deactivate
    echo "yes"
    vw_trash "$VENV_HOME/$1"
    [[ $? = 0 ]] && echo "Python venv removed at $VENV_HOME/$1."
}

updvenv() {

    [[ $# -eq 0 ]] && vw_echoerr "Please give the name of an environment."; return 1
    if [[ ! -d "$VENV_HOME/$1" ]]; then
        vw_echoerr "E: Environment '$VENV_HOME/$1' does not exist."
        return 1
    fi
    # deactivate to make sure you are upgrading to system python.
    deactivate

    python3 -m venv --upgrade "$VENV_HOME/$1"
    [[ $? = 0 ]] && echo "Python venv upgraded at $VENV_HOME/$1."
}
