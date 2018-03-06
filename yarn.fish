function yarn
    if test (count $argv) -gt 0
        switch $argv[1]
            case 'start' 'dev'
                iterm-tab-color 36 136 182
        end
    end

    command yarn $argv
    iterm-tab-color
end
