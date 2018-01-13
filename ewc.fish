function ewc --description 'exit with code'
    node -e "process.exit(parseInt('$argv[1]', 10))"
end
