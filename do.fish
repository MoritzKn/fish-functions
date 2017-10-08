function do --description 'Do what I want'
    set -l subject "$argv"
    set -l command ''

    if test -z "$subject"
        if type -q xclip
            set subject (xclip -o -selection clipboard)
            if test -z "$subject"
                set subject (xclip -o)
            end
        else if type -q pbpaste
            set subject (pbpaste)
        else
            echo 'No clipboard utility found'
            return
        end
    end

    set subject (string trim $subject)

    if test -z "$subject"
        echo 'Nothing to do'
        return
    end

    switch "$subject"
        case 'git@*.git' 'https://*.git' 'git://*'
            set command 'git clone'
        case 'http://*' 'https://*'
            set command 'curl -L -O '
        case '*.tgz' '*.tbz' '*.tar' '*.tar.*' '*.zip' '*.rar' '*gz'
            set command 'unpack'
        case '*'
            set command 'open'
    end

    echo Subject: $subject
    echo Command: $command

    eval $command $subject
end
