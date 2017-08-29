function oiw --description 'Find a project/folder in your workspace and cd into it'
    function find_folders
        find $HOME \
            -mindepth 1 \
            -maxdepth 5 \
            '(' \
                -name 'node_modules' \
                -o -name '.git' \
                -o -name 'src' \
                -o -name 'source' \
                -o -name 'res' \
                -o -name 'resources' \
                -o -name 'out' \
                -o -name 'lib' \
                -o -name 'spec' \
                -o -name 'Assets' \
            ')' \
            -prune \
            -o '(' \
                -type d \
                '(' \
                    -iwholename "$HOME/workspace*$argv*" \
                    -o -iwholename "$HOME/code/*$argv*" \
                ')' \
            ')' \
            -print
    end

    find_folders $argv \
        | awk '{ print length($0) " " $0; }' \
        | sort -n \
        | cut -d ' ' -f 2- \
        | head -1 \
        | read shortest

    cd $shortest

    functions -e findFolders
end
