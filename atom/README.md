Run `install-packages.sh` on Linux or `install-packages.bat` on windows.

linter-php requires php

```
sudo apt-get install php
```

php-cs-fixer requires php-cs-fixer

```
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
composer global require fabpot/php-cs-fixer
```
