# do:
#   bash --init-file rc.bash
#   . tester.bash >/dev/null 2>&1

PS1='$ '
export VENV_HOME="$(dirname "$(realpath $0)")"/venvs
# reset state
rm -rf "$VENV_HOME"

source ../vewrapper.bash
# vim:ft=sh
