#!/bin/sh

# Repositories from Black-arch (pentesting and hacking utils)

echo -n "Do you want to have acces to Black-arch repositories ? [y/n] : "
read rep

if [[ rep = [Yy] ]];
then
echo "Installing acces to black arch repos..."
cd ~/.repos
mkdir black-arch && cd black-arch
curl -o https://blackarch.org/strap.sh
chmod +x strap.sh
sudo ./strap.sh
fi

