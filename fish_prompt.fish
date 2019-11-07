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
        #iterm-tab-color 198 3 55
        set status_warning " ($last_status) "
    end

    if pwd | grep backup > /dev/null
        iterm-tab-color 99 175 73
    else if pwd | grep service > /dev/null
        iterm-tab-color 227 238 239
    else if pwd | grep package > /dev/null
        iterm-tab-color 102 62 11
    else if pwd | grep fish > /dev/null
        iterm-tab-color 167 207 223
    else if pwd | grep '/private/' > /dev/null
        iterm-tab-color 236 108 185
    else if pwd | grep -E 'terraform|tf' > /dev/null
        iterm-tab-color 105 93 232
    else if test -d .git
        iterm-tab-color 243 78 40
    else if test -f docker-compose.yaml
        iterm-tab-color 114 171 255
    else
        iterm-tab-color
    end

    # $USER
    echo -n -s [(date '+%H:%M')] ' ' $hn ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) $status_warning "$suffix "
end
