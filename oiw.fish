function oiw --description 'Find a folder in your workspace and cd into it'
	set where ~
    set level 1
    set query "/workspace*$argv"
    set res (find -L $where -mindepth $level -maxdepth (math $level+1) -type d -iwholename "*$query*" -print)
    set shortest (echo $res | sed -e 's/\s\+/\n/g'| awk '{ print length($0) " " $0; }' | sort -n | cut -d ' ' -f 2- | head -1)
    cd $shortest
end
