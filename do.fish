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
            set -l repo (string match -r '/([a-zA-Z_-]+)/?(?:\\.git)?$' $subject | sed -n 2p)

            if begin; test -n "$repo"; and string match -e github $subject; end
                set -l owner (string match -r '(?:/|:)([a-zA-Z_-]+)/[a-zA-Z_-]+/?(?:\\.git)?$' $subject | sed -n 2p)
                set -l url https://api.github.com/repos/$owner/$repo
                set -l info (curl $url -s)

                if test -n "$info" -a (echo $info | jq .fork -r) = true
                    set -l remote (git config --get remote.origin.url)
                    set -l git_url (echo $info | jq .parent.git_url -r)
                    set -l ssh_url (echo $info | jq .parent.ssh_url -r)
                    set -l https_url (echo $info | jq .parent.clone_url -r)
                    set -l parent_name (echo $info | jq .parent.name -r)

                    if test -z "$remote"
                        echo "Clone parent ($ssh_url) and add fork ($subject) as remote"
                        git clone $ssh_url
                        cd $parent_name
                        git remote add fork $subject
                        atom -a .
                        return
                    end

                    if test "$remote" = "$git_url" -o "$remote" = "$ssh_url" -o "$remote" = "$https_url"
                        echo "Add remote: $subject"
                        git remote add fork $subject
                        return
                    end
                end
            end

            echo "Clone repo: $subject"
            git clone $subject

            if test -n "$repo"
                cd $repo
                atom -a .
            end

        case 'feature/*'
            echo "Checkout feature: $subject"
            git checkout $subject

        case 'https://github.com/*/*/pull/*'
            echo "Checkout PR: $subject"
            hub checkout $subject

        case 'http://*' 'https://*'
            echo "Download: $subject"
            curl -LO $subject

        case '*.tgz' '*.tbz' '*.tar' '*.tar.*' '*.zip' '*.rar' '*gz'
            echo "Unpack: $subject"
            unpack $subject

        case '*'
            echo "Open: $subject"
            open $subject
    end
end
