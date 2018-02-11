function weather
    curl http://wttr.in/Köln 2> /dev/null | head -n-3 $argv
end
