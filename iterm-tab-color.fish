function iterm-tab-color
    if test -z "$ITERM_SESSION_ID"
        return 1
    end

    if test -n "$argv"
        echo -ne "\033]6;1;bg;red;brightness;$argv[1]\a"
        echo -ne "\033]6;1;bg;green;brightness;$argv[2]\a"
        echo -ne "\033]6;1;bg;blue;brightness;$argv[3]\a"
    else
        echo -ne "\033]6;1;bg;*;default\a"
    end
end
