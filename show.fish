function show --description 'Show content of a file'
    for file in $argv
        switch $file
            case '*.json'
                cat $file | jq
            case '*'
                cat $file
        end
    end
end
