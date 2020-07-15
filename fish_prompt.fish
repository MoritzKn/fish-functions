function fish_prompt --description 'Prompt ausgeben'
    set -l last_status $status

    set hn (hostname | cut -d . -f 1)

    set -l color_cwd
    set -l suffix
    switch $USER
    case root toor
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    case '*'
        set color_cwd $fish_color_cwd
        set suffix '>'
    end

    set -l status_warning ''
    if test $last_status -ne 0
        #tab-color "#c60337"
        set status_warning " ($last_status) "
    end

    set -x FORCE yes
    if pwd | grep backup > /dev/null
        tab-color "#63af49"
    else if pwd | grep service > /dev/null
        tab-color "#e3eeef"
    else if pwd | grep package > /dev/null
        tab-color "#663e0b"
    else if pwd | grep fish > /dev/null
        tab-color "#a7cfdf"
    else if pwd | grep '/private/' > /dev/null
        tab-color "#ec6cb9"
    else if pwd | grep -E 'terraform|tf' > /dev/null
        tab-color "#695de8"
    else if test -d .git
        tab-color "#f34e28"
    else if test -f docker-compose.yaml
        tab-color "#72abff"
    else
        tab-color
    end
    set -e FORCE

    # $USER
    echo -n -s [(date '+%H:%M')] ' ' $hn ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) $status_warning "$suffix "
end
