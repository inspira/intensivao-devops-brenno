#!/bin/bash

### FRONTENT SETUP ###

cd frontend || exit

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

nvm install
yarn install

yarn start &

### BACKEND SETUP ###

cd ../backend || exit

pipenv shell
pipenv install

uvicorn main:app --reload &
