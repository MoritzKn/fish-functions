#
# In the cloud we have cattles but it's nice to have a pet cat too...
#

set host mo@puss
set size_slug_min s-1vcpu-1gb
set size_slug_okay c-4
set size_slug_big c-16
set size_slug_huge c-32

function __puss_update_info
    doctl compute droplet list -o json | jq '.[] | select(.name=="puss")' > /tmp/dropletInfo
end

function __puss_print_info
    set -l price_hourly (cat /tmp/dropletInfo | jq .size.price_hourly -r)
    set -l price_monthly (cat /tmp/dropletInfo | jq .size.price_monthly -r)

    echo "Status:" (cat /tmp/dropletInfo | jq .status -r)
    echo "CPUs:" (cat /tmp/dropletInfo | jq .vcpus -r)
    echo "Memory:" (cat /tmp/dropletInfo | jq .memory -r)"mb"
    echo "Disk:" (cat /tmp/dropletInfo | jq .disk -r)"gb"
    echo "Price: \$$price_monthly/mo, \$$price_hourly/hr"
end

function __puss_get_id
    cat /tmp/dropletInfo | jq .id -r
end

function __puss_escape_path
    echo $argv[1] | sed -E -e 's/\\//\\\\\\//g'
end

function __puss_remote_path
    # absolute
    echo "mo@puss:"(realpath $argv[1] | \
        # remove home prefix
        sed -E -e 's/'(__puss_escape_path $HOME)'\///g')"/"
end

function puss
    tab-color "#f49eca"

    set -l dropletId (__puss_get_id)

    if test (count $argv) = '0'
        echo "Login $host"
        command ssh $host
        return
    end

    switch $argv[1]
    case "info"
        __puss_update_info
        __puss_print_info

    case "bind"
        fish -c "ssh $host -N -L $argv[2]:localhost:$argv[2]" &

    case "off"
        __puss_update_info
        set -l state (cat /tmp/dropletInfo | jq .status -r)
        if test "$state" != "active"
            echo "Expected status active, was $state"
            return
        end
        echo "Status: $state"

        echo "* Action: power-off"
        doctl compute droplet-action power-off $dropletId --wait

    case "on"
        __puss_update_info
        set -l state (cat /tmp/dropletInfo | jq .status -r)
        if test "$state" != "off"
            echo "Expected status off, was $state"
            return
        end
        echo "Status: $state"

        echo "* Action: power-on"
        doctl compute droplet-action power-on $dropletId --wait

    case "push"
        set -l local $argv[2]
        set -l remote $argv[3]
        if test -z "$remote"
            if test ! -e "$local"
                echo "$local dose not exist"
                return
            end
            set remote (__puss_remote_path $local)
        end

        echo "Upload $local -> $remote"
        rsync --cvs-exclude -a $local $remote

    case "pull"
        set -l remote $argv[2]
        set -l local $argv[3]
        if test -z "$local"
            if test ! -e "$remote"
                echo "$remote dose not exist"
                return
            end
            set tmp $remote
            set remote (__puss_remote_path $tmp)
            set local $tmp
        end

        echo "Download $remote -> $local"
        rsync --cvs-exclude -a $remote $local

    case "resize"
        echo "Current:"
        __puss_update_info
        __puss_print_info
        echo


        set -l size_slug_new $size_slug_min
        if test -n "$argv[2]"
            switch $argv[2]
            case "min"
                set size_slug_new $size_slug_min
            case "okay"
                set size_slug_new $size_slug_okay
            case "big"
                set size_slug_new $size_slug_big
            case "huge"
                set size_slug_new $size_slug_huge
            case "*-*"
                set size_slug_new $argv[2]
            case "*"
                echo "Invalud size: $argv[2]"
                return
            end
        else
            set -l size_slug_current (cat /tmp/dropletInfo | jq .size.slug -r)
            if test "$size_slug_current" = "$size_slug_min"
                set size_slug_new $size_slug_okay
            end
        end

        echo "Resizing to $size_slug_new..."

        puss off

        echo "* Action: resize"
        doctl compute droplet-action resize $dropletId --size $size_slug_new --wait

        puss on

        echo "New"
        __puss_update_info
        __puss_print_info
    end
end
