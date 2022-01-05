# copie to HDFS database_file
echo "#############################"
echo "@@@@   COPY FILES TO HDFS @@@"
echo "#############################"
echo 
echo "########### COPY /name.basics.tsv ############"
hdfs dfs -put /data/name.basics.tsv /name.basics.tsv

echo 
echo "########### COPY /title.akas.tsv ############"
hdfs dfs -put /data/title.akas.tsv /title.akas.tsv

echo 
echo "########### COPY title.basics.tsv ############"
hdfs dfs -put /data/title.basics.tsv /title.basics.tsv

echo 
echo "########### COPY title.crew.tsv ############"
hdfs dfs -put /data/title.crew.tsv /title.crew.tsv

echo 
echo "########### COPY title.episode.tsv ############"
hdfs dfs -put /data/title.episode.tsv /title.episode.tsv

echo 
echo "########### COPY title.principals.tsv ############"
hdfs dfs -put /data/title.principals.tsv /title.principals.tsv

echo 
echo "########### title.ratings.tsv ############"
hdfs dfs -put /data/title.ratings.tsv /title.ratings.tsv

echo "###################################"
unset $delete_source_files
while [[ ! "$delete_source_files" =~ ^[1-2]$ ]]; 
do 
read  -p "Delete source files from /data  ?  [1 = YES, 2 = NO]: " delete_source_files; 
done

case $delete_source_files in
    1)  echo "Ok, deleting files "
        rm /data/name.basics.tsv
        rm /data/title.akas.tsv
        rm /data/title.basics.tsv
        rm /data/title.crew.tsv
        rm /data/title.episode.tsv
        rm /data/title.principals.tsv
        rm /data/title.ratings.tsv
        ;;
    2) exit 1;;
esac


hive -v –f /data/init-db.hql

# lancement HIVE
#hive