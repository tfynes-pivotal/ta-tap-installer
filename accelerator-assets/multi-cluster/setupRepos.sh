#!/bin/bash

# create deliveries repo
cd sample-demos
git init -b main
git add .
git commit -am "."
gh repo create DEFAULT-LOCAL-SERVICES-REPO-NAME --private
git remote add origin DEFAULT-LOCAL-SERVICES-REPO-URL
git branch -M main
git push -u origin main
