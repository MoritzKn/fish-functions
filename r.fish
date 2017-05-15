function r --description 'Print a row as seperator'
    printf '-%.s' (seq 0 (tput cols))
end
