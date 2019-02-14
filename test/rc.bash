# do:
#   bash --init-file rc.bash
#   . tester.bash >/dev/null 2>&1

PS1='[\W] $ '
export VENV_HOME="$(dirname "$(realpath $0)")"/venv
# reset state
trash "$VENV_HOME"

source ../vewrapper.bash
# vim:ft=sh
