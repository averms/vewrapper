# vewrapper

A set of helper functions written in shell script that allow you to manage your Python 3
virtual environments in a convenient way.

## Requirements

- Python >= 3.5
- A bash-like shell with some standard programs/builtins/keywords, i.e.,
  `mkdir`, `command`, `[[`.

## Installation

There are two scripts, one for bash/zsh ~~and one for any POSIX compliant shell~~.
The following instructions are for bash/zsh.

**NOTE: The POSIX-compatible script is not maintained anymore, but you can find it in the git history.**

Since the script simply exposes some global functions into your session you can
pretty much do whatever you want to install it -- you just need to make sure that the file
gets `source`d somehow.  Here are two options:

- Copy `vewrapper.bash` from the latest release anywhere onto your machine, then source it in your
  `.bashrc`.

Or

- Copy the source code in `vewrapper.bash` from the latest release into your `.bashrc`.

## Usage

All virtual environments are stored in `$VENV_HOME` folder. There is no default; you need
to export a `VENV_HOME` variable before sourcing the script. It needs to be an absolute
path (not symlinked), and it **can't end with a slash.** A good example would be:
```
export VENV_HOME="$HOME/.local/venv"
```
The `VENV_rm` variable is the command used to remove virtual environments. You can set
it to `rm -rf`, `gio trash` (default), `ktrash`, or whatever you want.

### Commands

#### `mkve [env-name]`
Creates a python virtual environment at `$VENV_HOME/[env-name]`.

#### `rmve [env-name]`
Deletes the python virtual environment at `$VENV_HOME/[env-name]`.

#### `lsve`
Provides a list of environment names currently stored in `$VENV_HOME`.

#### `acve [env-name]`
Activates the environment located at `$VENV_HOME/[env-name]`.

#### `upve [env-name]`
Updates the environment located at `$VENV_HOME/[env-name]` to the latest system python.

## Authors

- **Aman** - [a-vrma](https://github.com/a-vrma)
- **Christopher Sabater Cordero** - [cs-cordero](https://github.com/cs-cordero)
