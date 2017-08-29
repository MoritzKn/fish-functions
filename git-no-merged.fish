function git-no-merged --argument branch
    if test -z "$branch"
        set -l branch (git rev-parse --abbrev-ref HEAD)
    end
    git branch --no-merged $branch
end
