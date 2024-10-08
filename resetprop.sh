check_resetprop(){
    local VALUE="$(resetprop -v "$1")"
    [ ! -z "$VALUE" ] && [ "$VALUE" != "$2" ] && resetprop -v -n "$1" "$2"
}

maybe_resetprop(){
    local VALUE="$(resetprop -v "$1")"
    [ ! -z "$VALUE" ] && echo "$VALUE" | grep -q "$2" && resetprop -v -n "$1" "$3"
}

replace_value_resetprop(){
    local VALUE="$(resetprop -v "$1")"
    [ -z "$VALUE" ] && return
    local VALUE_NEW="$(echo -n "$VALUE" | sed "s|${2}|${3}|g")"
    [ "$VALUE" == "$VALUE_NEW" ] || resetprop -v -n "$1" "$VALUE_NEW"
}

delete_prop_with_name_resetprop(){
    for PROP in $(resetprop | grep "$1" | cut -d ';' -f1 | cut -d '[' -f2 | cut -d ']' -f1); do
        resetprop -d $PROP
    done
}
