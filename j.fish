function j --description "j for jump"
    # Jump around in your projects

    switch "$argv"
        case 'ff'
            cd ~/.config/fish/functions
        case '*'
            z $argv
    end
end
