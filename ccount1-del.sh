#!/bin/bash

usernames=$(cat account1.txt)

for username in $usernames
do
    echo "userdel -r $username"
	userdel -r $username
done

