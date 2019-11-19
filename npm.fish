function npm
    if test (count $argv) -gt 0
        switch $argv[1]
            case 'start' 'run'
                tab-color "#b9171d"
        end
    end

    command npm $argv
    set -l s $status
    tab-color
    return $s
end
