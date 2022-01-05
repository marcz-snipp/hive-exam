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
        rm -rf /home/ubuntu/data
        mkdir /home/ubuntu/data
        sleep 1

        echo "###################################"
        echo "Download Custom scripts "
        echo "###################################"
        echo
        wget -O docker.sh https://raw.githubusercontent.com/marcz-snipp/hive-exam/main/docker.sh
        mv docker.sh /home/ubuntu/data/docker.sh
        chmod +x /home/ubuntu/data/docker.sh

        wget -O init-db-full.hql https://raw.githubusercontent.com/marcz-snipp/hive-exam/main/init-db-full.hql
        mv init-db-full.hql /home/ubuntu/data/init-db-full.hql

        wget -O init-db-lite.hql https://raw.githubusercontent.com/marcz-snipp/hive-exam/main/init-db-lite.hql
        mv init-db-lite.hql /home/ubuntu/data/init-db-lite.hql

        wget -O testing-queries.hql https://raw.githubusercontent.com/marcz-snipp/hive-exam/main/testing-queries.hql
        mv testing-queries.hql /home/ubuntu/data/testing-queries.hql
                

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
        mv name.basics.tsv /home/ubuntu/data/name.basics.tsv
        rm name.basics.tsv.gz 

        wget https://datasets.imdbws.com/title.akas.tsv.gz && gunzip -k title.akas.tsv.gz 
        mv title.akas.tsv /home/ubuntu/data/title.akas.tsv
        rm title.akas.tsv.gz 

        wget https://datasets.imdbws.com/title.basics.tsv.gz && gunzip -k title.basics.tsv.gz 
        mv title.basics.tsv /home/ubuntu/data/title.basics.tsv
        rm title.basics.tsv.gz 
 
        wget https://datasets.imdbws.com/title.crew.tsv.gz && gunzip -k title.crew.tsv.gz 
        mv title.crew.tsv /home/ubuntu/data/title.crew.tsv
        rm title.crew.tsv.gz 
    
        wget https://datasets.imdbws.com/title.episode.tsv.gz && gunzip -k title.episode.tsv.gz 
        mv title.episode.tsv /home/ubuntu/data/title.episode.tsv
        rm title.episode.tsv.gz 
  
        wget https://datasets.imdbws.com/title.principals.tsv.gz && gunzip -k title.principals.tsv.gz 
        mv title.principals.tsv /home/ubuntu/data/title.principals.tsv
        rm title.principals.tsv.gz 
  
        wget https://datasets.imdbws.com/title.ratings.tsv.gz && gunzip -k title.ratings.tsv.gz 
        mv title.ratings.tsv /home/ubuntu/data/title.ratings.tsv
        rm title.ratings.tsv.gz 
  
        sleep 1

        echo "###################################"
        echo "Download ressource for Docker containers"
        echo "###################################"
        echo
        # get docker containers 
        wget https://dst-de.s3.eu-west-3.amazonaws.com/hadoop_hive_fr/docker-compose.yml -O /home/ubuntu/docker-compose.yml
        wget https://dst-de.s3.eu-west-3.amazonaws.com/hadoop_hive_fr/hadoop-hive.env  -O /home/ubuntu/hadoop-hive.env
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
        echo "Enter container in Bash mode"
        echo "###################################"
        echo
        docker exec -it hive-server bash  


        ;;
    2) echo "Ok, maybe later "
       exit 1;;
   
    *) echo "Sorry you must choose 1 or 2";;
esac