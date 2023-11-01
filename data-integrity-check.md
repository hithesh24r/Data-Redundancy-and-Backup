# Checking Data Integrity after creating the RAID Array
- Data Integrwty is checked on the RAID array by wanted failing the disk from one of the four disks in the array
- The files in the mount path before and after the failure of disk are checked
- If there is no file missing even after failure of disk, then the RAID array is working properly
- Then, the disk is rmeoved and re-added into the array to make sure that the files are still intact even when the RAID array is rebuilt

### To check the files in the mount path
```
ls <MOUNTPATH>
# where MOUNTPATH is the mount path of the main RAID 10 array
```
### To get the list of all the arrays in the Raspberry Pi
```
cat /proc/mdstat
```
### To get the details of specific RAID array
```
mdadm --detail <ARRAYNAME>
# ARRAYNAME is the name which is given  while creating the array like /dev/md0
```
### To fail a disk from the array
```
mdadm --manage <ARRAYNAME> --fail <DISKNAME>

# the disk which will be mentioned should be the part of the array mentioned
## If the first RAID 0 array is made up of /dev/sda1 & /dev/sdb1 => /dev/md0
## And the second RAID 0 array is made up of /dev/sdc1 & /dev/sdd1 => /dev/md1
## Then RAID 1 is created using /dev/md0 & /dev/md1 => /dev/md10
## Now if the disk mentioned in the above code is /dev/sda1, then as this belongs to /dev/md0, we have to mention ARRAYNAME as /dev/md0
```
### To remove a disk from the array
```
mdadm --manage <ARRAYNAME> --remove <DISKNAME>
```
### To re-add the disk to the array
```
mdadm --manage <ARRAYNAME> --add <DISKNAME>
```
