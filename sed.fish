function sed
    if type -q gsed > /dev/null
        gsed $argv
    else
        command sed $argv
    end
end
