function search
	open 'https://duckduckgo.com/?q='(echo $argv | tr ' ' '+')
end
