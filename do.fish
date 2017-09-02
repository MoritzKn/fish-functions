function do --description 'Do what I want'
    set -l subject "$argv"
    set -l command ''

    if test -z "$subject"
        if which xclip > /dev/null
            set subject (xclip -o -selection clipboard)
            if test -z "$subject"
                set subject (xclip -o)
            end
        else if which pbpaste > /dev/null
            set subject (pbpaste)
        end
    end

    set subject (string trim $subject)

    if test -z "$subject"
        echo 'Nothing to do'
        exit
    end

    switch "$subject"
        case 'git@*.git' 'https://*.git' 'git://*'
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
