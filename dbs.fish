function dbs --description 'Grep databases from `sql`'
	echo "show databases like \"%$argv%\"" | sql | tail -n+2
end
