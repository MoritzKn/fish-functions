function tab-color
    if test -z "$ITERM_SESSION_ID"
        # No an iTerm session
        return 1
    end

    if not isatty stdout && test "$FORCE" != 'yes'
        # Not a tty
       return
    end

    # Init RGB (red, green, blue) values
    set -l r $argv[1]
    set -l g $argv[2]
    set -l b $argv[3]

    # Parse hex string
    if string match '#*' $argv[1] > /dev/null
        set -l hex $argv[1]
        switch (string length $hex)
            case 4
                set -l tmp (string sub -s 2 -l 1 $hex)
                set r (printf "%d\n" 0x$tmp$tmp)
                set -l tmp (string sub -s 3 -l 1 $hex)
                set g (printf "%d\n" 0x$tmp$tmp)
                set -l tmp (string sub -s 4 -l 1 $hex)
                set b (printf "%d\n" 0x$tmp$tmp)
            case 7
                set r (printf "%d\n" 0x(string sub -s 2 -l 2 $hex))
                set g (printf "%d\n" 0x(string sub -s 4 -l 2 $hex))
                set b (printf "%d\n" 0x(string sub -s 6 -l 2 $hex))
            case '*'
                echo 'Invalid hex code'
                return 1
        end
    end

    if test -n "$argv"
        echo -ne "\033]6;1;bg;red;brightness;$r\a"
        echo -ne "\033]6;1;bg;green;brightness;$g\a"
        echo -ne "\033]6;1;bg;blue;brightness;$b\a"
    else
        # Reset to default color
        echo -ne "\033]6;1;bg;*;default\a"
    end
end
