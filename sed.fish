function sed
    if type -q gsed
        gsed $argv
    else
        command sed $argv
    end
end
