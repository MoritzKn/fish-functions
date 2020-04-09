function git-version-history --description 'Show the commits for each package.json version change'
    if test ! -e package.json
        echo "No package.json"
        return 1
    end

    set -l pointer HEAD

    while test -n $pointer
        set -l line (git blame package.json $pointer | grep 'version'); or return 1

        set -l commit (string trim (echo $line | cut -d '(' -f 1))
        set -l info (string trim (echo $line | cut -d '(' -f 2 | cut -d ')' -f 1 | rev | cut -d ' ' -f 2- | rev))
        set -l vers (echo $line | cut -d ')' -f 2- | string match -r '"version":\s*"([^"]*)"' | tail -1)
        set -l vers_pad (echo "          $ver" | tail -c 10)

        echo $commit $vers_pad "($info)"

        if string match '^*' $commit > /dev/null
            set pointer ""
        else
            set pointer "$commit^1"
        end
    end
end
