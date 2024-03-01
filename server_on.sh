#!/bin/bash

### TURN ON FRONTEND ###

echo Turning Frontend On \n\n

cd frontend || exit
yarn start &

### TURN ON BACKEND ###


echo Turning Backend On \n\n

cd ../backend || exit
pipenv shell
uvicorn main:app --reload &

cd ..
