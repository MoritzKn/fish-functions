function patchdb --description 'Get all changes on SQL files since the last tag in a Git Repo'
	git diff (git describe --abbrev=0) **.sql $argv
end
