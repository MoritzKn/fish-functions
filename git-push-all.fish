function git-push-all --description "Pull origin and push all other remotes"
    set -l diff (git diff --stat)
    if test "$diff" != ''
      echo "Working tree not clean"
    end

    echo "-- Pull origin --"
    git pull -r origin


    for remote in (git remote)
        echo "-- Push $remote --"
        git push "$remote"
    end
end
