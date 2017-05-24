function treei
    if test -f .gitignore
        tree -I (cat .gitignore | tr '\n' '|' | sed 's/|$/\n/') $argv
    else
        tree $argv
    end
end
