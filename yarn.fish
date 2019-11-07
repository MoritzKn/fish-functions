function yarn
    if test (count $argv) -gt 0
        switch $argv[1]
            case 'start' 'serve' 'build' 'depoy' 'dev' 'inspect'
                tab-color "#2488b6"
        end
    end

    command yarn $argv
    set -l s $status
    tab-color
    return $s
end
