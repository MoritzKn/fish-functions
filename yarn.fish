function yarn
    if test (count $argv) -gt 0
        switch $argv[1]
            case 'start' 'serve' 'build' 'depoy' 'dev' 'inspect'
                iterm-tab-color 36 136 182
        end
    end

    command yarn $argv
    set -l s $status
    iterm-tab-color
    return $s
end
