#Installing and Configuring MDADM arrays on Raspberry Pi
# - This is the Step-1 of the whole process
# - Multi Disk and Device Management (MDADM) tool is installed on ubuntu (on RPi4)
# - A RAID 10 Array is configured using mdadm by implementing two RAID 0 Arrays and implementing a RAID 1 array over these two created RAOD 0 arrays


# Installing MDADM on Ubuntu (on RPi4)
sudo apt update && sudo apt upgrade -y 
sudo apt install mdadm -y

# Creating mdadm RAID 10 array
## replace the disk name with something like "/dev/md0" or "/dev/md1"
## Before doing this, 4 usb drives has to be connected to Raspberry Pi 4
## name of the disk looks something like "/dev/sdX1"

yes | sudo mdadm --create --verbose <DISK_NAME1> --level=0 --raid-devices=2 <DISK1> <DISK2>
yes | sudo mdadm --create --verbose <DISK_NAME2> --level=0 --raid-devices=2 <DISK3> <DISK4>
yes | sudo mdadm --create --verbose <DISK_NAME3> --level=1 --raid-devices=2 <DISK_NAME1> <DISK_NAME2>

# MOUNTPATH = Mount path for RAID 10 Array created above
sudo mkfs.ext4 /dev/md10
sudo mkdir <MOUNTPATH>
sudo mount /dev/md10 <MOUNTPATH>
