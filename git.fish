function git
    if type -q hub >/dev/null
        hub $argv
    else
        command git $argv
    end
end
