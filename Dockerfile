FROM ayushmaansingh/kube
COPY . /var/www/html/
ENTRYPOINT apachectl -D FOREGROUND
