function vercel-switch
  echo "====="
  echo "\$ vercel link -p $argv" --scope forsuxess --yes
  vercel link -p $argv --scope forsuxess --yes

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
