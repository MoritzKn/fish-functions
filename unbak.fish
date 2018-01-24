function unbak --desc "Removes the sufix '.bak' (backup) from files"
    for file in $argv
        if begin; test ! -f $file; and test -f $file.bak; end
            set file $file.bak
        end

        set new_name (string replace '.bak' '' $file)
        mv $file $new_name
    end
end
