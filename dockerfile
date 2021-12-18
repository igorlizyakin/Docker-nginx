#используем базовый образ centos 7;
FROM centos:7
#задаем временную зону внутри контейнера Europe/Moscow.
ENV TZ=Europe/Moscow
#устанавливаем epel-release и nginx;
RUN yum install -y epel-release && yum install -y nginx
#чистим систему от метаданных и кэша пакетов после установки;
RUN yum clean all
#указываем nginx запускаться на переднем плане (daemon off); 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#в индексном файле меняем первое вхождение nginx на docker-nginx;
#RUN sed -i "0,/nginx/s/nginx/docker-nginx/i" /usr/share/nginx/html/index.html
#запускаем nginx.
CMD [ "nginx" ]
