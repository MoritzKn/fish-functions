function psg --description='grep from ps aux'
    ps aux | grep $argv
end
