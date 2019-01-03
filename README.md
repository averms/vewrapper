# vewrapper

A set of helper functions written in POSIX sh / bash that allow you to manage your python3
virtual environments in a convenient way. These functions are small improvements over
similar shell scripts floating around the internet.

## Requirements

* python >= 3.5
* A POSIX-compliant shell with some standard programs/builtins, i.e.,
  `command`, `basename`, `mkdir`, `ls`.

## Installation

There are two scripts, one for bash and one for any POSIX compliant shell.
The following instructions are for bash.

Since the script simply exposes some global functions into your session you can
pretty much do whatever you want to install it -- you just need to make sure that the file
gets `source`d somehow.  Here are two options:

- Copy `vewrapper.bash` anywhere onto your machine, then source it in your
  `.bashrc`.

Or

- Copy the source code in `vewrapper.bash` into your `.bashrc` or
  `.bash_profile`.

## Usage

All virtual environments are stored in `$VENV_HOME` folder. There is no default, you need
to export a `VENV_HOME` variable _before_ sourcing the script. It needs to be an absolute
path (not symlinked), and it **can't end with a slash.** A good example would be:
```
export VENV_HOME="$HOME/.local/venv"
```
By default, the script uses [`trash-cli`](https://github.com/sindresorhus/trash-cli) to
remove venvs. This can be changed by editing the `VW_RM` variable.

### Commands

#### `mkve [env-name]`
Creates a python virtual environment at `$VENV_HOME/[env-name]`.

#### `rmve [env-name]`
Deletes a python virtual environment at `$VENV_HOME/[env-name]`.

#### `lsve`
Provides a list of environment names currently stored in `$VENV_HOME`.

#### `acve [env-name]`
Activates the environment located at `$VENV_HOME/[env-name]`.

#### `upve [env-name]`
Updates the environment located at `$VENV_HOME/[env-name]` to the latest system python.

#### `deactivate`
Deactivates the currently active environment (if any).

## Authors

* **Aman** - [a-vrma](https://github.com/a-vrma)
* **Christopher Sabater Cordero** - [cs-cordero](https://github.com/cs-cordero)

