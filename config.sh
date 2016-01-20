#!/bin/bash

# ====================================
# To manipulate a configuration file in INI format into a shell script
#
# @author: Rodrigue <rodnsi@hotmail.com>
# @date: 2016/01/08
# 
# Ex:
# = config.ini =
# ---------------------
# [main]
# ; comment
# home=/home/foo/directory/
# logfile=/home/foo/foo.log
# [database]
# server=my_server
# db=my_database
# ....
# ---------------------
# = command line  =
# ---------------------
# $ source config.sh; parseConfig; get main home;
# /home/toto/directory/
# $ destroyConfig;
# $
# ---------------------
# = shell script =
# ---------------------
# INI="config.ini"
# source config.sh/config.sh
# parseConfig "$INI"
# HOME=$(get main home)
# parseConfig 'another.cfg'
# FOO=$(get database foo)
# destroyConfig
# echo $FOO
# echo $HOME
# ---------------------


declare -A cfg


function get() {
    # Allows to recover an element of a configuration file
    # Ex: get main home
    #     get database server
    echo ${cfg[$1\:\:$2]}
}


function clearConfig() {
    for key in ${!cfg[@]}
    do
        unset cfg[$key]
    done
}


function destroyConfig() {
    unset -v cfg
    unset get
    unset clearConfig
    unset parseConfig
    unset destroyConfig
}


function parseConfig() {
    # Reads the configuration file and put the information in a array
    clearConfig; # clear
    section="_"
    if [[ -z "$1" ]]; then
        file="config.ini"
    else
        file=$1
    fi
    while IFS== read key value
    do
        # remove BOM (Byte-order mark)
        k=$(echo $key | sed -e "s/^\xef\xbb\xbf//g"| sed -e"s/ //g")
        case $k in
            "")   ;;  ## empty, do nothing
            \#*)  ;;  ## ignore commented lines
            \;*)  ;;  ## ignore commented lines
            "["*) 
              section=`echo "$k" | sed -rn 's/\[(.+)\]/\1/p'`
              ;;
            *)
              cfg[${section}::$k]="$value"
              ;;
        esac
    done < "$file"
    # # this expands to all elements. If unquoted, both subscripts * and @
    # # expand to
    # # the same result, if quoted, @ expands to all elements individually
    # # quoted,
    # # * expands to all elements quoted as a whole. 
    # echo ${cfg[*]} 
    # echo ${!cfg[*]} # Expands to the indexes in ARRAY since BASH 3.0
    # # Ex: /home/toto/toto.log my_server
    # # Ex: main::logfile database::server
}
