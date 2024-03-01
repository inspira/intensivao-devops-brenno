#!/bin/bash

### FRONTENT SETUP ###

cd frontend || exit

echo-e "Installing NVM \n\n"

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install

echo -e "\n\nInstalling YARN \n\n"

npm install --global yarn

echo -e "\n\nInstalling Frontend dependencies \n\n"

yarn install

### BACKEND SETUP ###

cd ../backend || exit

echo -e "\n\nInstalling Pipenv \n\n"

sudo apt install pipenv

echo -e "\n\nActivating Virtual Env\n\n"

pipenv shell

echo -e "\n\nInstalling Backend Dependencies\n\n"

pipenv install

cd ..
