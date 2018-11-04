# pyvenvwrapper

A set of helper functions written in Bash that allow you to manage your python3 virtual
environments in a convenient way.  These functions are small improvements over similar bash
scripts floating around the internet.

## Requirements

* `python3` >= `3.5`
* A UNIX shell with some standard programs/commands, i.e., `command`, `basename`, `mkdir`, `ls`.

## Installation

Since the script simply exposes some global functions into your bash session you can
pretty much do whatever you want to install it -- you just need to make sure that the file
gets `source`d somehow.  Here are two options:

* Copy `pyvenvwrapper.sh` anywhere onto your machine, then add `source
  /path/to/pyvenvwrapper.sh` to your `.bashrc` or `.bash_profile`.

Or

* Copy the source code in `pyvenvwrapper.sh` into your `.bashrc` or
  `.bash_profile` file.

## Usage

All virtual environments are stored in a `$HOME/.venv` folder by default.
You can change this folder to whichever folder you prefer by exporting a `VENV_HOME`
variable _before_ sourcing `pyvenvwrapper.sh`.
By default, the script uses [`trash-cli`](https://github.com/sindresorhus/trash-cli) to
remove venvs. This can be changed by editing the `vw_trash` function.

### Commands

#### `mkvenv [env-name]`
Creates a python virtual environment at `$VENV_HOME/[env-name]`.

#### `rmvenv [env-name]`
Deletes a python virtual environment at `$VENV_HOME/[env-name]`.

#### `lsvenv`
Provides a list of environment names currently stored in `$VENV_HOME`.

#### `actvenv [env-name]`
Activates the environment located at `$VENV_HOME/[env-name]`.

#### `updvenv [env-name]`
Updates the environment located at `$VENV_HOME/[env-name]` to the latest system python.

#### `deactivate`
Deactivates the currently active environment (if any).

## Authors

* **Aman** - [a-vrma](https://github.com/a-vrma)
* **Christopher Sabater Cordero** - [cs-cordero](https://github.com/cs-cordero)

