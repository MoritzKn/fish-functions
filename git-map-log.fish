function git-map-log
    if test ! -d ".git"
      echo "Must be run from within a git repository"
      return 1
    end

    if test -z "$argv"
      echo "Please specify a command to execute for each commit"
      return 1
    end

    set tmp (mktemp -d -q)
    set repo (pwd)

    # clone the git repository
    pushd $tmp
    git clone $repo > /dev/null 2>&1
    cd (basename $repo)

    for commit in (git log --oneline)
        echo "$commit:"
        git checkout (echo $commit | cut -d ' ' -f 1) > /dev/null 2>&1
        eval "$argv"
    end

    popd

    rm -rf $tmp
end
