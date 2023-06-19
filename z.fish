function z --description 'Find a project/folder in your workspace and cd into it'
    if test (count $argv) -eq 0
        echo Please provide a query
        return
    end

    function find_folders
        find -L $HOME/Code \
            -mindepth 1 \
            -maxdepth 5 \
            '(' \
                -iname '_*' \
                -o -iname '.*' \
                -o -iname '*.bak' \
                -o -iname 'assets' \
                -o -iname 'backend' \
                -o -iname 'benches' \
                -o -iname 'bin' \
                -o -iname 'build' \
                -o -iname 'client' \
                -o -iname 'config' \
                -o -iname 'data' \
                -o -iname 'dist' \
                -o -iname 'doc' \
                -o -iname 'docs' \
                -o -iname 'etc' \
                -o -iname 'fonts' \
                -o -iname 'frontend' \
                -o -iname 'grammars' \
                -o -iname 'help' \
                -o -iname 'i18n' \
                -o -iname 'icons' \
                -o -iname 'img' \
                -o -iname 'install' \
                -o -iname 'keymaps' \
                -o -iname 'lib' \
                -o -iname 'Library' \
                -o -iname 'libs' \
                -o -iname 'man' \
                -o -iname 'menus' \
                -o -iname 'node_modules' \
                -o -iname 'out' \
                -o -iname 'pictures' \
                -o -iname 'pixmaps' \
                -o -iname 'po' \
                -o -iname 'res' \
                -o -iname 'resources' \
                -o -iname 'scripts' \
                -o -iname 'server' \
                -o -iname 'settings' \
                -o -iname 'snippets' \
                -o -iname 'source' \
                -o -iname 'spec' \
                -o -iname 'src' \
                -o -iname 'static' \
                -o -iname 'styles' \
                -o -iname 'target' \
                -o -iname 'test_data' \
                -o -iname 'test' \
                -o -iname 'tests' \
                -o -iname 'vendor' \
                -o -iname 'deps' \
            ')' \
            -prune \
            -o '(' \
                -type d \
                '(' \
                    -iwholename "$HOME/code/*$argv*" \
                ')' \
            ')' \
            -print
    end

    set -l query (string join '*' $argv)

    find_folders $query \
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
