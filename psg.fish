function psg --description 'grep from ps aux'
	#ps aux | awk "NR==1 || (/$argv/ && !/awk/)"
	ps aux | begin
		read first_line
		echo $first_line
		grep -v grep | grep $argv
	end
end
