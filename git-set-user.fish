function git-set-user --description "Sets the local git user config"
    set -l domain "gmx.de";
    set -l flags

    for arg in $argv
        switch $arg
        case '--help'
            echo "slu -- Sets the local git user config"
            echo
            echo "Usage:"
            echo "  slu [options]"
            echo
            echo "Options:"
            echo "  --help       Show this screen"
            echo "  -g --global  Set global config"
            echo "  <domain>     The email domain to use [default: $domain]"
            return 0

        case '--global' "-g"
            set flags $flags "--global"
        case '-*'
            echo "No such option:" $arg
            return 1
        case '*'
            set domain $arg[1]
        end
    end

    git config $flags user.email "moritz.kneilmann@"$domain
    git config $flags user.name "Moritz Kneilmann"
end
