#!/bin/bash

echo "###################################"
echo "#  Welcome to the Hive Wizzard  #"
echo " (Docker service must be running) "
echo "###################################"
echo 

echo "###################################"
unset $start_docker_hive
while [[ ! "$start_docker_hive" =~ ^[1-2]$ ]]; 
do 
read  -p "Ready to start Hive, it will delete ~/data folder and re create it  ?  [1 = YES, 2 = NO]: " start_docker_hive; 
done
echo

case $start_docker_hive in
    1)  echo "Ok, let's go "
        echo

        echo "###################################"
        echo "Delete ~/data and recreate it"
        echo "###################################"
        echo
        rm -rf ./data
        mkdir data
        sleep 1

        echo "###################################"
        echo "Stop all current Docker containers"
        echo "###################################"
        echo
        docker container stop $(docker ps -q)
        #docker container prune


        echo "###################################"
        echo "Get Dataset and unzip it"
        echo "###################################"
        echo
        # download file and unzip
        wget https://datasets.imdbws.com/name.basics.tsv.gz && gunzip -k name.basics.tsv.gz 
        mv name.basics.tsv ./data/name.basics.tsv
        rm name.basics.tsv.gz 

        wget https://datasets.imdbws.com/title.akas.tsv.gz && gunzip -k title.akas.tsv.gz 
        mv title.akas.tsv ./data/title.akas.tsv
        rm title.akas.tsv.gz 

        wget https://datasets.imdbws.com/title.basics.tsv.gz && gunzip -k title.basics.tsv.gz 
        mv title.basics.tsv ./data/title.basics.tsv
        rm title.basics.tsv.gz 
 
        wget https://datasets.imdbws.com/title.crew.tsv.gz && gunzip -k title.crew.tsv.gz 
        mv title.crew.tsv ./data/title.crew.tsv
        rm title.crew.tsv.gz 
    
        wget https://datasets.imdbws.com/title.episode.tsv.gz && gunzip -k title.episode.tsv.gz 
        mv title.episode.tsv ./data/title.episode.tsv
        rm title.episode.tsv.gz 
  
        wget https://datasets.imdbws.com/title.principals.tsv.gz && gunzip -k title.principals.tsv.gz 
        mv title.principals.tsv ./data/title.principals.tsv
        rm title.principals.tsv.gz 
  
        wget https://datasets.imdbws.com/title.ratings.tsv.gz && gunzip -k title.ratings.tsv.gz 
        mv title.ratings.tsv ./data/title.ratings.tsv
        rm title.ratings.tsv.gz 
  
        sleep 1

        echo "###################################"
        echo "Download ressource for Docker containers"
        echo "###################################"
        echo
        # get docker containers 
        wget https://dst-de.s3.eu-west-3.amazonaws.com/hadoop_hive_fr/docker-compose.yml -O ./docker-compose.yml
        wget https://dst-de.s3.eu-west-3.amazonaws.com/hadoop_hive_fr/hadoop-hive.env  -O ./hadoop-hive.env
        sleep 1

        echo "###################################"
        echo "Stop all current Docker containers"
        echo "###################################"
        echo
        docker container stop $(docker ps -q)

        echo "###################################"
        echo "Initialize Docker compose"
        echo "###################################"
        echo
        # intialize docker containers and links
        docker-compose up -d
        sleep 1


        echo "###################################"
        echo "Autorize Script execution"
        echo "###################################"
        echo

        chmod +x ./data/docker.sh

        echo "###################################"
        echo "Enter container in Bash mode"
        echo "###################################"
        echo
        docker exec -it hive-server bash  


        ;;
    2) echo "Ok, maybe later "
       exit 1;;
   
    *) echo "Sorry you must choose 1 or 2";;
esac