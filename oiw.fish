function oiw --description 'Find a folder in your workspace and cd into it'
	set where $HOME
    set query "$HOME/workspace*$argv*"

    set shortest (find $where -mindepth 1 -maxdepth 5 -type d \( -name 'node_modules' -o -name '.git' \) -prune -o -iwholename $query -print \
    | awk '{ print length($0) " " $0; }' \
    | sort -n \
    | cut -d ' ' -f 2- \
    | head -1)

    cd $shortest
end
