# vewrapper

A set of helper functions written in shell script that allow you to manage your Python 3
virtual environments in a convenient way.

## Requirements

- Python ≥ 3.5
- Bash or a Bash-like shell. It uses some advanced features that more minimal shells
  don't support like `[[` and [substring expansion]. It may work with Zsh or Mksh, but I
  haven't got around to testing them yet.

[substring expansion]: https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#Shell-Parameter-Expansion

## Installation

Since the script simply exposes some global functions into your session you can
pretty much do whatever you want to install it --- you just need to make sure that the file
gets run on every shell startup. Here are two options:

- Copy `vewrapper.bash` anywhere onto your machine, then source it in your
  `.bashrc`.

Or

- Copy the code in `vewrapper.bash` into your `.bashrc`.

Make sure you use the latest release and **not** master.

## Usage

All virtual environments are stored in `$VENV_HOME` folder. There is no default; you need
to export a `VENV_HOME` variable before sourcing the script. It needs to be an absolute
path (not symlinked), and it **can't end with a slash.** A good example would be:
```
export VENV_HOME="$HOME/.local/venv"
```
The `VENV_rm` variable is the command used to remove virtual environments. You can set
it to `rm -rf`, `gio trash` (default), `ktrash`, or whatever you want.

Also, don't put spaces in environment names. It breaks the autocompletion.

### Commands

#### `mkve [env-name]`

Creates a python virtual environment at `$VENV_HOME/[env-name]`.

#### `rmve [env-name]`

Deletes the python virtual environment at `$VENV_HOME/[env-name]`. Press tab to
autocomplete \[env-name\]

#### `acve [env-name]`

Activates the environment located at `$VENV_HOME/[env-name]`. Press tab to
autocomplete \[env-name\]

#### `upve [env-name]`

Updates the environment located at `$VENV_HOME/[env-name]` to the latest system python.
Press tab to autocomplete \[env-name\].

This will not update the packages, so if some are not compatible with newer versions of
Python, you will have to update them with `pip`.

#### `lsve`

Provides a list of environment names currently stored in `$VENV_HOME`.

## Authors

- **Aman Verma** - [a-vrma](https://github.com/a-vrma)
- **Christopher Sabater Cordero** - [cs-cordero](https://github.com/cs-cordero)
