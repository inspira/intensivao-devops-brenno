#!/bin/bash

### FRONTENT SETUP ###

cd frontend || exit

echo Installing NVM \n\n

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install

echo \n\nInstalling YARN \n\n

npm install --global yarn

echo \n\nInstalling Frontend dependencies \n\n

yarn install

### BACKEND SETUP ###

cd ../backend || exit

echo \n\nInstalling Pipenv \n\n

sudo apt install pipenv

echo \n\nActivating Virtual Env\n\n

pipenv shell

echo \n\nInstalling Backend Dependencies\n\n

pipenv install

cd ..
