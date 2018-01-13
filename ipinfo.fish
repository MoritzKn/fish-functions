function ipinfo
    curl http://ipinfo.io/ -s | perl -n -e '/"(.*?)": "(.*?)"/ && print "$1: $2\\n"'
end
