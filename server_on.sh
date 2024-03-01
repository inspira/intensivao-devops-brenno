#!/bin/bash

### TURN ON FRONTEND ###

echo -e "==============================================================="
echo Turning Frontend On
echo -e "===============================================================\n"

cd frontend || exit
yarn start &

if [ $? -eq 0 ]; then
    echo "Frontend is on."
else
    echo "An error occurred while turning Frontend on."
    exit 1
fi

### TURN ON BACKEND ###

echo -e "==============================================================="
echo Turning Backend On
echo -e "===============================================================zn"

cd ../backend || exit
source sum-numbers/bin/activate
uvicorn main:app --reload &

if [ $? -eq 0 ]; then
    echo "Backend is on."
else
    echo "An error occurred while turning Backend on."
    exit 1
fi

cd ..
