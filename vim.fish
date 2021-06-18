function vim
    tab-color "#2b8800"

    if test -e $argv[1]; and not test -w $argv[1]
        Echo "WARN: $argv[1] not writable, sudoing.."
        sudo vim $argv
    else
        command vim $argv
    end

    tab-color
end
