# A little helper for man/alias/function info
# http://brettterpstra.com/2016/05/18/shell-tricks-halp-a-universal-help-tool/

halp() {
    local YELLOW="\033[0;33m" DEFAULT="\033[0;39m"
    local apro=0 helpstring="Usage: halp COMMAND"

    OPTIND=1
    while getopts "kh" opt; do
        case $opt in
            k) apro=1 ;;
            h) echo -e $helpstring; return;;
            *) return 1;;
        esac
    done
    shift $((OPTIND-1))

    if [ $# -ne 1 ]; then
        echo -e $helpstring
        return 1
    fi

    local helpresult cmd=$1
    local cmdtest=$(type -t ${cmd})

    if [ -z "$cmdtest" ]; then
        echo -e "${YELLOW}Not a command$DEFAULT"
        if [[ $apro == 1 ]]; then
            man -k $cmd
        else
            return 1
        fi
    fi

    if [[ $cmdtest == "file" ]]; then
        man $cmd
    elif [[ $cmdtest == "builtin" ]]; then
        man $cmd
    elif [[ $cmdtest == "alias" ]]; then
        echo -ne "$YELLOW$cmd is an alias:  $DEFAULT"
        alias ${cmd}|sed -E "s/alias $cmd='(.*)'/\1/"
    elif [[ $cmdtest == "function" ]]; then
        echo -e "$YELLOW$cmd is a function:  $DEFAULT"
        type $cmd | tail -n +2
    fi
}
