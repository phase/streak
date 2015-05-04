#!/bin/bash

#This is why you don't have a commit chart.
#      .--.
#     |o_o |
#     |:_/ |
#    //   \ \
#   (|     | )
#  /'\_   _/'\
#  \___)=(___/

read -p "What is your GitHub username?" username
read -p "What repo do you want to contribute to?" repo

url="https://github.com/$username/$repo"

#Create repos for pushing
git clone $url orig
git clone $url streak

cd streak

#Create fake date
read -d "What day do you want to start from?" date
read -d "How long do you want the streak to be?" streak
d=$(date -d "$d")
i=1

while [ $i -le $streak ]; do
  export GIT_AUTHOR_DATE="$d +0000" #Set commit date as fake date
  export GIT_COMMIT_DATE="$d +0000"
  
  #Get random commit message
  message=$(curl -sSL http://whatthecommit.com/index.txt)
  
  git commit --allow-empty -m "$message"
  
  e="$GIT_AUTHOR_DATE : $message"
  echo $e
  
  #Increment fake date
  d=$(date -d "$d 1 day")
  i=$(( $i+1 ))
done

git gc #Clean repo

git push $url master #Push fake commits
cd ../orig/
git push $url master -f #Remove previous commits
