function add-date-prefix
    for f in $argv
      if test -f $f
        # lol
        set date (node -r fs -p "fs.statSync('$f').ctime.toJSON().split('T')[0]")
        set new_name (echo $f | tr ' ' '-')
        mv $f "$date"_"$new_name"
      end
    end
end
