#!/bin/bash

### TURN ON FRONTEND ###

cd frontend || exit
yarn start &

### TURN ON BACKEND ###

cd ../backend || exit
pipenv shell
uvicorn main:app --reload &

cd ..
