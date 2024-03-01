#!/bin/bash

### TURN ON FRONTEND ###

echo -e "echo Turning Frontend On\n\n"

cd frontend || exit
yarn start &

if [ $? -eq 0 ]; then
    echo "Frontend is on."
else
    echo "An error occurred while turning Frontend on."
    exit 1
fi

echo -e "-------------------------------------------------------------------\n\n"

### TURN ON BACKEND ###


echo Turning Backend On \n\n

cd ../backend || exit
pipenv shell
pipenv install
uvicorn main:app --reload &

if [ $? -eq 0 ]; then
    echo "Backend is on."
else
    echo "An error occurred while turning Backend on."
    exit 1
fi

cd ..
