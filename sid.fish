function sid --description 'Some day I did -- Show what you did in the current git repo since a specific day'
	git log --author=(git config user.name) --since=$argv[1] --oneline | sed -e 's/[a-z0-9]*/-/'
end
