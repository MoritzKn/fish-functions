function unpack
	switch $argv[1]
        case '*.zip'
            unzip $argv
        case '*.tar.gz' '*.tgz'
            untargz $argv
        case '*.tar.bz2' '*.tbz' '*.tar.bz'
            untarbz $argv
        case '*.tar'
            untar $argv
        case '*.rar'
            unrar e $argv
    end
end
