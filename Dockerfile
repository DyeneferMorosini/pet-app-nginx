FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

RUN printf '%s\n' \
'server {' \
'    listen 80;' \
'    server_name _;' \
'' \
'    root /var/www/html/public;' \
'    index index.php index.html;' \
'' \
'    location / {' \
'        try_files $uri $uri/ /index.php?$query_string;' \
'    }' \
'' \
'    location ~ \.php$ {' \
'        include fastcgi_params;' \
'        fastcgi_pass pet-app-api:9000;' \
'        fastcgi_index index.php;' \
'' \
'        fastcgi_param SCRIPT_FILENAME $realpath_root$fastcgi_script_name;' \
'        fastcgi_param DOCUMENT_ROOT $realpath_root;' \
'    }' \
'' \
'    location ~ /\. {' \
'        deny all;' \
'    }' \
'}' \
> /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
