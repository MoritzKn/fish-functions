function tar
    if type -q gtar
        gtar $argv
    else
        command tar $argv
    end
end
