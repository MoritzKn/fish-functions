function oiw --description 'Find a project/folder in your workspace and cd into it'
    function find_folders
        find -L $HOME \
            -mindepth 1 \
            -maxdepth 5 \
            '(' \
                -name 'node_modules' \
                -o -name '.*' \
                -o -name '_*' \
                -o -iname 'bin' \
                -o -iname 'lib' \
                -o -iname 'src' \
                -o -iname 'source' \
                -o -iname 'scripts' \
                -o -iname 'res' \
                -o -iname 'resources' \
                -o -iname 'out' \
                -o -iname 'dist' \
                -o -iname 'data' \
                -o -iname 'build' \
                -o -iname 'install' \
                -o -iname 'target' \
                -o -iname 'spec' \
                -o -iname 'benches' \
                -o -iname 'test' \
                -o -iname 'tests' \
                -o -iname 'test_data' \
                -o -iname 'doc' \
                -o -iname 'docs' \
                -o -iname 'help' \
                -o -iname 'man' \
                -o -iname 'po' \
                -o -iname 'i18n' \
                -o -iname 'fonts' \
                -o -iname 'img' \
                -o -iname 'assets' \
                -o -iname 'static' \
                -o -iname 'styles' \
                -o -iname 'icons' \
                -o -iname 'pixmaps' \
                -o -iname 'menus' \
                -o -iname 'keymaps' \
                -o -iname 'snippets' \
                -o -iname 'settings' \
                -o -iname 'grammars' \
                -o -iname 'client' \
                -o -iname 'server' \
                -o -iname 'backend' \
                -o -iname 'frontend' \
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

    if test ! -z "$shortest"
        cd $shortest
    else
        echo 'Could not find anything, sorry'
    end

    functions -e find_folders
end
