#!/bin/bash

### FRONTENT SETUP ###

cd frontend || exit

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install
npm install --global yarn
yarn install

### BACKEND SETUP ###

cd ../backend || exit

sudo apt install pipenv
pipenv shell
pipenv install

cd ..
