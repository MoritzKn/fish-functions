function do --description 'Do what I want'
    function add_to_history --arg cmd
        set -l time (date +%s)
        echo -e "- cmd: $cmd\n  when: $time" >> ~/.local/share/fish/fish_history
    end

    function do_action
        set -l action "$argv"
        eval $action
        add_to_history $action
        history merge
    end

    function main
        set -l arg_count (count $argv)
        if test "$arg_count" -gt 1
            for i in (seq 1 $arg_count)
                do $argv[$i]
            end
            return
        end

        set -l subject "$argv"

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
            case 'https://github.com/*/*/pull/*'
                echo "Checkout PR: $subject"
                do_action hub checkout $subject

            case 'git@*.git' 'https://*.git' 'git://*' 'https://github.com/*/*'
                set -l repo (string match -r '/([a-zA-Z_-]+)/?(?:\\.git)?$' $subject | sed -n 2p)

                if begin; test -n "$repo"; and string match -e 'github.com' $subject > /dev/null; end
                    set -l owner (string match -r '(?:/|:)([a-zA-Z_-]+)/[a-zA-Z_-]+/?(?:\\.git)?$' $subject | sed -n 2p)
                    set -l api_url https://api.github.com/repos/$owner/$repo
                    set -l info (curl $api_url -s)

                    if test -n "$info"
                        set -l ssh_url (echo $info | jq .ssh_url -r)

                        if test (echo $info | jq .fork -r) = true
                            set -l remote (git config --get remote.origin.url)
                            set -l parent_git_url (echo $info | jq .parent.git_url -r)
                            set -l parent_ssh_url (echo $info | jq .parent.ssh_url -r)
                            set -l parent_https_url (echo $info | jq .parent.clone_url -r)
                            set -l parent_name (echo $info | jq .parent.name -r)
                            set -l add_remote

                            if test -z "$remote"
                                echo "Clone parent repo: $parent_ssh_url"
                                do_action git clone $parent_ssh_url; or return 1
                                do_action cd $parent_name
                                set add_remote yes

                            else if test "$remote" = "$parent_git_url" -o \
                                "$remote" = "$parent_ssh_url" -o \
                                "$remote" = "$parent_https_url"

                                set add_remote yes
                            end

                            if test -n "$add_remote"
                                set -l new_remote
                                if test -n "$ssh_url"
                                    set new_remote $ssh_url
                                else
                                    set new_remote $subject
                                end

                                echo "Add fork as remote: $new_remote"
                                do_action git remote add fork $new_remote
                                do_action atom -a .
                                return
                            end
                        else if test -n "$ssh_url"
                            echo "Clone repo (ssh): $subject"
                            do_action git clone $subject; or return 1
                            do_action cd $repo
                            do_action atom -a .
                            return
                        end
                    end
                end

                echo "Clone repo: $subject"
                do_action git clone $subject; or return 1

                if test -n "$repo"
                    do_action cd $repo
                    do_action atom -a .
                end
                return

            case 'feature/*'
                echo "Checkout feature: $subject"
                do_action git checkout $subject
                return

            case 'http://*' 'https://*'
                echo "Download: $subject"
                do_action curl -LO $subject
                return

            case '*.tgz' '*.tbz' '*.tar' '*.tar.*' '*.zip' '*.rar' '*gz'
                echo "Unpack: $subject"
                do_action unpack $subject
                return

            case '*://*'
                echo "Open: $subject"
                do_action open $subject
                return
        end

        if set -l path (string replace -a '~' ~ $subject)
            if test -e $path
                set subject $path
            end
        end

        if test -e $subject
            if test -d $subject
                echo "Cd into: $subject"
                do_action cd $subject
                return
            end

            if test -x $subject
                echo "Execute: $subject"
                do_action $subject
                return
            end

            set -l type (xdg-mime query filetype $subject)

            if string match 'text/*' $type > /dev/null
                set -l editor
                if test -n "$EDITOR"
                    set editor $EDITOR
                else if test -n "$VISUAL"
                    set editor $VISUAL
                else
                    set editor vim
                end

                if test -w $subject
                    echo "Edit: $subject"
                    do_action "$editor $subject"
                    return
                else
                    echo "Edit as root: $subject"
                    do_action sudo $editor $subject
                    return
                end
            end

            echo "Open: $subject"
            do_action open $subject
            return
        end

        if which (string split ' ' $subject)[1] > /dev/null ^/dev/null
            echo "Execute: $subject"
            do_action $subject
            return
        end

        echo "Can't do anything with: $subject"
    end

    main
    set -l main_status $status

    functions -e do_action
    functions -e add_to_history
    functions -e main

    return $main_status
end
