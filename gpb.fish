# Defined in - @ line 1
function gpb --description 'alias gpb git push --set-upstream origin (git branch --show-current)'
	git push --set-upstream origin (git branch --show-current) $argv;
end
