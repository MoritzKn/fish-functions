function ipinfo
    curl http://ipinfo.io/$argv[1] -s | perl -n -e '/"(.*?)": "(.*?)"/ && print "$1: $2\\n"'
end
