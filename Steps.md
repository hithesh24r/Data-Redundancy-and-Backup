Steps involved in making the solution

## Steps included in Data Redundancy:
- Setting up Raspberry Pi with the Operating System
- Installing and confugiring mdadm on Raspberry Pi
- Checking the working of RAID Arrays and setting up monitoring on the RAID array
- Installing and configuring Nextcloud on Raspberry Pi for local network-wide access of files
- Configuring external storage with AWS S3 (different for different users)
- Configuring multi-AZ replication on AWS S3 buckets (optional)

## Steps included in Cloud BAckup System:
- Creating a EC2 instance and installing nextcloud on it
- Configuring HTTPS on nextcloud for internet access
- Configuring external storage with same S3 buckets (previously created for rpi backup) for the users in public nextcloud
