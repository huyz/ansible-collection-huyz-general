#shellcheck shell=bash

    # This is to handle direct installation (as opposed to Homebrew)
    export PYENV_ROOT=~/.pyenv
    command -v pyenv &>/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"

    # Homebrew pyenv
    if whence -p pyenv &>/dev/null; then
      #eval "$(pyenv init --path)"
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
    fi
