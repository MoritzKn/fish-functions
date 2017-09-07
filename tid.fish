function tid --description 'Today I did -- Show what you did in the current git reop today'
    # Use GNU sed if available. Other versione (e.g. BSG / Mac) may not support
    # the I (ignore case) regex flag.
    function mysed
        if which gsed > /dev/null
            gsed $argv
        else
            sed $argv
        end
    end

    git log --author=(git config user.name) --since="4am" --oneline | mysed \
        -e '/kommentar/Id' \
        -e '/comment/Id' \
        -e '/typo/Id' \
        -e '/whitespace/Id' \
        -e '/white space/Id' \
        -e '/indent/Id' \
        -e '/release/Id' \
        -e 's/^[^ ]*/-/'

    set -e mysed
end
