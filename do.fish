function do --description 'Do what I want'
    set -l subject "$argv"
    set -l command ''

    if test -z "$subject"
        set subject (xclip -o -selection clipboard)
        if test -z "$subject"
            set subject (xclip -o)
        end
    end

    switch $subject
        case 'git@*.git'
            set command 'git clone'
        case '*.tgz' '*.tbz' '*.tar' '*.tar.*' '*.zip' '*.rar'
            set command 'unpack'
        case '*'
            set command 'open'
    end

    echo Subject: $subject
    echo Command: $command

    eval $command $subject
end
