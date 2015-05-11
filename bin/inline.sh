#!/bin/bash
################################################################################
#
# A utility script to write (nested) include statements
# into the equivalent single config file.
#
################################################################################

PROGNAME=${0##*/}
PROGDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
VERSION="0.1"
FILES=()

error_exit() {
  echo -e "${PROGNAME}: ${1:-"Unknown Error"}" >&2
  exit 1
}

graceful_exit() {
    exit
}

usage() {
    echo -e "Usage: $PROGNAME [-h|--help] file.conf"
}

help_message() {
  cat <<- _EOF_
  $PROGNAME ver. $VERSION
  Replace include statements with the included files

  The primary use of this script is for debugging nginx
  config files, or to provide a single config file for
  distribution/deployment.

  $(usage)

  Example:
    cd /etc/nginx
    $PROGNAME h5bp/basic.conf
    ### h5bp/basic.conf START

    ### h5bp/directive-only/x-ua-compatible.conf START
    add_header "X-UA-Compatible" "IE=Edge";
    ....

  Options:
  -h, --help  Display this help message and exit.

_EOF_
  return
}

function main {
    echo "### $1 START"
    while read line
    do
        if [[ $line =~ "#" ]];
        then
            # skip comments
            continue
        elif [[ $line =~ "^ *$" ]];
        then
            # skip blank lines
            continue
        elif [[ $line =~ ^(\s*)include\s*(.*)\; ]];
        then
            main ${BASH_REMATCH[2]}
        else
            echo "$line"
        fi
    done < $1
    echo "### $1 END"
}

# Parse command-line
while [[ -n $1 ]]; do
  case $1 in
    -h | --help)
      help_message; graceful_exit ;;
    -* | --*)
      usage
      error_exit "Unknown option $1" ;;
    *)
      FILES+=($1);;
  esac
  shift
done

if [ ${#FILES[@]} -eq 0 ];
then
      usage;
      graceful_exit;
fi

main $FILES
