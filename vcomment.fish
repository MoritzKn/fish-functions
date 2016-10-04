function vcomment --description 'Version comment -- list commits since the last git tag'
	git log (git describe --tags --abbrev=0 HEAD^)..HEAD --oneline | sed -e 's/^[^ ]*/-/'
end
