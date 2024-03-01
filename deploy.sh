#!/bin/bash

### FRONTENT SETUP ###

cd frontend || exit

echo -e "==============================================================="
echo -e "Installing NVM"
echo -e "===============================================================\n"

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install

echo -e "==============================================================="
echo -e "Installing YARN"
echo -e "===============================================================\n"

npm install --global yarn

echo -e "==============================================================="
echo -e "Installing Frontend dependencies"
echo -e "===============================================================\n"

yarn install


echo -e "==============================================================="
echo -e "Building frontend"
echo -e "===============================================================\n"

yarn build:deploy

### BACKEND SETUP ###

cd ../backend || exit

echo -e "==============================================================="
echo -e "Installing Backend Dependencies"
echo -e "===============================================================\n"

pip install -r requirements.txt

cd ..

### NGINX SETUP ###

echo -e "==============================================================="
echo -e "Installing NGINX"
echo -e "===============================================================\n"

sudo apt update
sudo apt install nginx

echo -e "==============================================================="
echo -e "Configuring Server"
echo -e "===============================================================\n"

cp -f nginx_config /etc/nginx/sites-available/sum-numbers
sudo ln -s /etc/nginx/sites-available/sum-numbers /etc/nginx/sites-enabled/

echo -e "==============================================================="
echo -e "Starting nginx"
echo -e "===============================================================\n"

sudo nginx -t

if [ $? -eq 0 ]; then
    sudo systemctl reload nginx
    echo "Server is on."
else
    echo "An error occurred while turning the server on."
    exit 1
fi
