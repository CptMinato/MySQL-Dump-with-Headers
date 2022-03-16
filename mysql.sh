#!/bin/sh
echo "Enter Database name:"
read dbname
echo "Enter Database username:"
read dbuser
echo "Enter Database password:"
read dbpass
echo "Enter Table name:"
read table
#currentdate=$(date +%d%m%Y%H%M%S)
sudo echo "select * from $table limit 1" | mysql -u$dbuser -p$dbpass $dbname | head -1 | sed 's/\t/;/g' > $table.csv
mysqldump -t -T/var/lib/mysql-files $dbname $table --fields-terminated-by=';' --fields-enclosed-by '"' --fields-escaped-by '\' --no-create-info
cat /var/lib/mysql-files/$table.txt >> $table.csv
rm /var/lib/mysql-files/$table*