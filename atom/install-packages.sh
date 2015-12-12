#todo update this to read packages.txt

while read PACKAGE
do
  if [ ! -d "packages/$PACKAGE" ]; then
    apm install $PACKAGE
  fi
done < packages.txt
