function dbs --argument name --description 'Grep databases from `sql`'
    echo "show databases like \"%$name%\"" | sql | tail -n+2
end
