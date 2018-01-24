function bak --desc "Adds the sufix '.bak' (backup) to files"
    for file in $argv
        mv $file $file.bak
    end
end
