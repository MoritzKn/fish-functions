function unlock --description 'Unlocks your eclipse workspace'
	if test -f ../.metadata/.lock
        rm ../.metadata/.lock
    else if test -f .metadata/.lock
        rm .metadata/.lock
    end
end
