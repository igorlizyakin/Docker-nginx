#используем базовый образ centos 7;
FROM centos:7

#задаем временную зону внутри контейнера Europe/Moscow.
ENV TZ=Europe/Moscow
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# проверяем работу кайтейнера созданием файлв txt
RUN echo "test create docker" > /test.txt

#апдейт системы
RUN apt-get update -y && apt-get install -y python3-pip python3-dev

#устанавливаем epel-release и nginx;
RUN yum install -y epel-release && yum install -y nginx

#чистим систему от метаданных и кэша пакетов после установки;
RUN yum clean all

#устанавливаем рабочую дирректорию и копируем директорию в докер контейнер
COPY ./requirements.txt /requirements.txt
WORKDIR /
RUN pip3 install -r requirements.txt
COPY . /

#указываем nginx запускаться на переднем плане (daemon off); 
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#в индексном файле меняем первое вхождение nginx на docker-nginx;
#RUN sed -i "0,/nginx/s/nginx/docker-nginx/i" /usr/share/nginx/html/index.html
ENTRYPOINT ["python3"]
#запускаем nginx.
CMD [ "nginx" ]
CMD ["index.py"]
