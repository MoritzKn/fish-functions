function tid --description 'Today I did -- Show what you did in the current git reop today'
    git log --author=(git config user.name) --since="4am" --oneline | sed \
        -e '/Kommentar/Id' \
        -e '/comment/Id' \
        -e '/typo/Id' \
        -e '/whitespace/Id' \
        -e '/white space/Id' \
        -e '/indent/Id' \
        -e '/Release/Id' \
        -e 's/[a-z0-9]*/-/'
end
