function vercel-switch
  echo "====="
  echo "\$ vercel link -p $argv"
  vercel link -p $argv

  and echo "====="
  echo "\$ vercel env pull"
  vercel env pull


  and echo "====="
  echo "\$ sed -i '/VERCEL_URL=""/d' .env"
  sed -i '/VERCEL_URL=""/d' .env

  and echo "====="
  echo "\$ npm run dev"
  npm run dev
end
