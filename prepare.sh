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

echo -e "\n\nInstalling YARN \n\n"

npm install --global yarn

echo -e "==============================================================="
echo -e "\n\nInstalling Frontend dependencies"
echo -e "===============================================================\n"

yarn install

### BACKEND SETUP ###

cd ../backend || exit

echo -e "==============================================================="
echo -e "\n\nInstalling Pipenv"
echo -e "===============================================================\n"

python3 -m venv sum-numbers

echo -e "==============================================================="
echo -e "Activating Virtual Env"
echo -e "===============================================================\n"

source sum-numbers/bin/activate

echo -e "==============================================================="
echo -e "\n\nInstalling Backend Dependencies"
echo -e "===============================================================\n"

pip install -r requirements.txt

cd ..
