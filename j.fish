function j --description "j for jump"
    switch "$argv"
        case 'ff'
            cd ~/.config/fish/functions
            return
        case 'ssr'
            z 'hub*service*ssr'
            return
        case 'mono'
            z 'hubs'
            return
        case 'hub'
            z 'hub*apps*living'
            return
        case 'index' 'indexer'
            z 'elasticsearch-indexer'
            return
        case 'content'
            z 'hub-content-api'
            return
        case 'docker'
            z 'hub*setup*docker'
            return
    end

    z $argv
end
