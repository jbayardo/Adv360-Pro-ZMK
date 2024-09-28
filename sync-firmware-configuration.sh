#!/usr/bin/env bash
git remote add kinesis https://github.com/KinesisCorporation/Adv360-Pro-ZMK.git
git pull kinesis
CURRENT_BRANCH=$(git branch | grep \* | cut -d ' ' -f2)
git merge kinesis/$CURRENT_BRANCH