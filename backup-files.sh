# File Backup Script
# Version 1.0
# Alex Suter

# Param 1 = folder to backup (from)
# Param 2 = folder to store the backup (to)
# Param 3 = count of days, how many backup to holds

# Read Parameter
backupfolder_from=$1
backupfolder_to=$2
countsave=$3

# Create Filename
now="$(date +'%Y-%m-%d-%H-%M-%S')"
filename=backup-${now}-files.gz
backupfile=${backupfolder_to}/${filename}

# Tar
echo "create tar archive from ${backupfolder_from} to ${backupfile}"
tar -czPf "${backupfile}" "${backupfolder_from}"

# Delete a number of old backups
if [ ${countsave} != "0" ]; then
    echo "delete files all files older than ${countsave} days"
	find ${backupfolder_to} -name "backup*" -mtime +${countsave} -exec rm {} \;
fi

#End
exit 0
