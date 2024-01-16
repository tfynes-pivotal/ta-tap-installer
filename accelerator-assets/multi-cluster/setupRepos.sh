#!/bin/bash

# create deliveries repo
cd sample-demos
git init -b main
git add .
git commit -am "."
gh repo create DEFAULT-WORKLOADS-REPO-NAME --private
git remote add origin DEFAULT-WORKLOADS-REPO-URL
git branch -M main
git push -u origin main

# create deliverables repo
gh repo create DELIVERABLES-REPO-NAME --private

# create workload repo's per namespace
gh repo create DELIVERIES-REPO-NAME --private



git init -b main
git add .
git commit -am "."
gh repo create tap-gitops-a3full2 --private
git remote add origin https://github.com/tfynes-pivotal/tap-gitops-a3full2
git branch -M main
git push -u origin main