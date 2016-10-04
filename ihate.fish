function ihate --description 'Kill any process by its name'
	# use first argument as query
    set query $argv[1]
    
    # if there is more than one argument, bypass the other arguments to the kill command
    if [ (count argv) -gt "1" ]
        set killArgs $argv[2..-1]
    end
    
    # search for processes
    set hits (ps ax | grep $query)
    
    # output processes
    echo 'Killing:'
    echo (echo $hits | awk '{printf "- "$1": "$5" "$6" "$7; if ($8){printf " ..."}; print ""}');
    
    # kill the processes
    echo $hits | awk '{print $1}' | xargs kill $killArgs
end
