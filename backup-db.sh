# MySQL-DB Backup Script
# Version 1.0
# Alex Suter

# Param 1 = name of database
# Param 2 = folder to backup
# Param 3 = count of days, how many backup to holds

# Constants
dbuser=<PARAMUSER>
dbpw=<PARAMPW>
dbhost=<PARAMHOST>

# Read Parameter
dbname=$1
backupfolder=$2
countsave=$3

# Create Filename
now="$(date +'%Y-%m-%d-%H-%M-%S')"
filename=backup-${now}-db-${dbname}.gz
backupfile=${backupfolder}/${filename}

# Dump
echo "create mysql dump ${dbname} to ${backupfile}"
/usr/local/bin/mysqldump --quick --quote-names --single-transaction --user=${dbuser} --password=${dbpw} --host=${dbhost} --default-character-set=utf8 ${dbname} | gzip > ${backupfile}

# Delete a number of old backups
if [ ${countsave} != "0" ]; then
    echo "delete files all files older than ${countsave} days"
    find ${backupfolder} -name "backup*" -mtime +${countsave} -exec rm {} \;
fi

# End
exit 0
