function unpack
	switch $argv[1]
        case '*.zip'
            unzip $argv
        case '*.tar.gz'
            untargz $argv
        case '*.tag.bz'
            untarbz
        case '*.tar'
            untar $argv
    end
end