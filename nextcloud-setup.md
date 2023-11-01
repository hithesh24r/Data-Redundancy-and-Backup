### Updating and Installing needed dependancies
```
sudo apt update
sudo apt upgrade
sudo apt install apache2 mariadb-server libapache2-mod-php php-gd php-json php-mysql php-curl php-mbstring php-intl php-imagick php-xml php-zip
```

### Creating a Database
```
sudo mysql -u root -p
```

```
CREATE DATABASE nextcloud;
CREATE USER 'nextclouduser'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextclouduser'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### Downloading and Installing Nextcloud
```
cd /var/www/html
sudo wget https://download.nextcloud.com/server/releases/latest.tar.bz2
sudo tar -xvf latest.tar.bz2
sudo chown -R www-data:www-data nextcloud
```

# Configuring the Web Server for NextCloud
```
sudo nano /etc/apache2sites-available/nextcloud.conf
```

- Add the following content in there:
```
<VirtualHost *:80>
    ServerAdmin admin@example.com
    DocumentRoot /var/www/html/nextcloud
    ServerName your-domain.com

    <Directory /var/www/html/nextcloud/>
        Options +FollowSymlinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

</VirtualHost>
```

```
sudo a2ensite nextcloud.conf
sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo systemctl restart apache2
```

### Setting Trusted Domains on Nextcloud (if domain name is present)
- open the NextCloud config file from ```/var/www/html/nextcloud/config/config.php```

- Change the following from:
```
'trusted_domains' =>
  array (
    0 => '192.168.0.29',
  ),
```
- Change to:
```
 'trusted_domains' =>
  array (
    0 => '192.168.0.29',
    1 => 'cloud.example.com',
  ),
```
- Updating nextcloud config file,
```
sudo -u www-data php /var/www/nextcloud/occ config:system:set trusted_domains 1 --value=your-domain.com
sudo systemctl restart apache2
```

### Setting up HTTPS (TLS/SSL certificates) on the domain for nextcloud
```
sudo apt update
sudo apt install certbot python3-certbot-apache
sudo certbot --apache -d your-domain.com
```
- open the file _**/var/www/html/nextcloud/config/config.php**_ and include the following lines
```
'overwriteprotocol' => 'https',
'overwrite.cli.url' => 'https://your-domain.com/nextcloud',
```
- Restart the apache server
```
sudo systemctl restart apache2
```

### Configuring External Storage (S3) on NextCloud
- First, create the users in the NextCloud
- Then enable Server-side encryption" and "external storage" apps from disabled apps in administrator settings of admin account login
- Enable server side encryption from security under administrator settings
- Go to external storage tab and create a folder and select S3 bucket
- Give the details and confirm, then the bucket is connected to the selected user
- Give one S3 bucket to one user to make sure the data security aspect is taken care

