JSON=`curl -s 'http://mapix-data.ixxi.net/infos/info.prod.json'`

VERSION=`echo $JSON | jq '.version'`
URL=`echo $JSON | jq -r '.url'`

echo "Version $VERSION @ $URL"

# Downloading referential.
wget -q -N --tries=3 $URL

FILENAME=$(basename "$URL")
if hash gunzip 2>/dev/null; then
  gunzip "$FILENAME"
elif hash gzip 2>/dev/null; then
  gzip -d "$FILENAME"
else
  echo "Requires 'gunzip' or 'gzip' command"
  exit 1
fi
