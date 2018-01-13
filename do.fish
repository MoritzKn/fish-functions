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

    echo Subject: $subject

    switch "$subject"
        case 'git@*.git' 'https://*.git' 'git://*'
            git clone $subject
            set -l name (string match -r '/([a-zA-Z_-]+)/?(?:\\.git)?$' $subject | sed -n 2p)
            if test -n $name
                cd $name
                atom -a .
            end

        case 'http://*' 'https://*'
            curl -LO $subject

        case '*.tgz' '*.tbz' '*.tar' '*.tar.*' '*.zip' '*.rar' '*gz'
            unpack $subject

        case '*'
            open $subject
    end
end
