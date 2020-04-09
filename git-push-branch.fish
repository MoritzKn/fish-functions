function git-push-branch --description 'Push the current branch upstream'
	git push --set-upstream origin (git branch --show-current) $argv;
end
