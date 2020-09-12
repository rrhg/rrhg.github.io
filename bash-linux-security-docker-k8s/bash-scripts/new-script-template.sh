#!/usr/bin/env bash
    
    # https://news.ycombinator.com/item?id=24401085
    
    ### Bash Environment Setup
    # http://redsymbol.net/articles/unofficial-bash-strict-mode/
    # https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
    # set -o xtrace
    set -o errexit
    set -o errtrace
    set -o nounset
    set -o pipefail
    IFS=$'\n'

    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
