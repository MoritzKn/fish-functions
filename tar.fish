function tar
    if type -q gtar > /dev/null
        gtar $argv
    else
        command tar $argv
    end
end
