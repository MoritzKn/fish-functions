function dotenv --description 'Load environment variables from .env file'
  set -l envfile ".env"
  if [ (count $argv) -gt 0 ]
    set envfile $argv[1]
  end

  if test ! -e $envfile
      exit 1
  end

  for line in (cat $envfile)
    set line (string trim $line)

    if test -n $line; and not string match '#*' $line > /dev/null
      set -l value (echo $line | cut -d = -f 2-)
      set -l name (string trim (echo $line | cut -d = -f 1))

      echo set -xg $name $value
    end
  end
end
