function wether
    curl http://wttr.in/Montabaur 2> /dev/null | head -n-3 $argv
end
