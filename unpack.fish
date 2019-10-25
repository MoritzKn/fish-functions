function unpack
    switch $argv[1]
    case '*.tgz' '*.tbz' '*.tar' '*.tar.*'
        untar $argv
    case '*.zip'
        unzip $argv
    case '*.rar'
        unrar x $argv
    case '*.gz'
        gzip -d $argv
    case '*.bz2'
        bzip2 -dk $argv
    end
end
