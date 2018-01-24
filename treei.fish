function treei --description 'tree but ignore everything in .gitignore'
    if test -f .gitignore
        tree -I (cat .gitignore | tr '\n' '|' | sed -e 's/|$/\n/' -e 's/\///g') $argv
    else
        tree $argv
    end
end
