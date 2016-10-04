function tid --description 'Today I did -- Show what you did in the current git reop today'
	git log --author=(git config user.name) --since=(date -d 'yesterday 13:00 ' '+%Y-%m-%d') --oneline | sed -e 's/[a-z0-9]*/-/'
end
