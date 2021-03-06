#!/usr/bin/env bash

PHP_TIMEZONE="Australia/Brisbane"

# Update the box release repositories
# -----------------------------------
apt-get update


# APACHE
# ------
# Prevent from existing custom "000-default.conf"
rm -rf /etc/apache2/sites-available/000-default.conf
apt-get install -y apache2
# Add ServerName to httpd.conf for localhost
echo "ServerName localhost" > /etc/apache2/httpd.conf
# Enable "mod_rewrite"
a2enmod rewrite
# Finally, restart apache
service apache2 restart


# PHP 5.x (last official release)
# See: https://launchpad.net/~ondrej/+archive/php5
# ------------------------------------------------
apt-get install -y libapache2-mod-php5
# Install "add-apt-repository" binaries
apt-get install -y python-software-properties
# Install PHP 5.6.x
# Use "ppa:ondrej/php5-oldstable" for old and stable release
add-apt-repository ppa:ondrej/php5-5.6
# Update repositories
apt-get update

# PHP tools
apt-get install -y php5-cli php5-mysql php5-curl php5-mcrypt php5-gd php-pear php5-xdebug php5-intl
# APC (only with PHP < 5.5.0, use the "opcache" if >= 5.5.0)
apt-get install -y php-apc
# Setting the timezone
sed 's#;date.timezone\([[:space:]]*\)=\([[:space:]]*\)*#date.timezone\1=\2\"'"$PHP_TIMEZONE"'\"#g' /etc/php5/apache2/php.ini > /etc/php5/apache2/php.ini.tmp
mv /etc/php5/apache2/php.ini.tmp /etc/php5/apache2/php.ini
sed 's#;date.timezone\([[:space:]]*\)=\([[:space:]]*\)*#date.timezone\1=\2\"'"$PHP_TIMEZONE"'\"#g' /etc/php5/cli/php.ini > /etc/php5/cli/php.ini.tmp
mv /etc/php5/cli/php.ini.tmp /etc/php5/cli/php.ini
# Showing error messages
sed 's#display_errors = Off#display_errors = On#g' /etc/php5/apache2/php.ini > /etc/php5/apache2/php.ini.tmp
mv /etc/php5/apache2/php.ini.tmp /etc/php5/apache2/php.ini
sed 's#display_startup_errors = Off#display_startup_errors = On#g' /etc/php5/apache2/php.ini > /etc/php5/apache2/php.ini.tmp
mv /etc/php5/apache2/php.ini.tmp /etc/php5/apache2/php.ini
sed 's#error_reporting = E_ALL & ~E_DEPRECATED & ~E_STRICT#error_reporting = E_ALL#g' /etc/php5/apache2/php.ini > /etc/php5/apache2/php.ini.tmp
mv /etc/php5/apache2/php.ini.tmp /etc/php5/apache2/php.ini


# Essential packages
# ------------------
apt-get install -y build-essential git-core vim curl

# Apache VHOST
# ------------
cp /etc/apache2/sites-available/000-default.conf.dist /etc/apache2/sites-available/000-default.conf

rm -rf /var/www
ln -fs /vagrant /var/www