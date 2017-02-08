# codeBeamer docker image

## What is codeBeamer?

![cblogo](https://codebeamer.com/cb/images/newskin/header/cblogo-xl.png)

https://codebeamer.com/cb/project/CB

**codeBeamer** ALM is a holistically integrated **Application Lifecycle Management platform** that offers all-round **Requirements**, **Development**, and **Testing & Quality Assurance** functionality.  
It provides seamless traceability, and powerful features that cover the entire product development lifecycle.

codeBeamer ALM allows you to simply streamline processes, reduce development costs, and increase product quality.

## How to use this image?

`$ docker run -d -p 8080:8080 --name some-codebeamer --link some-mysql:mysql cometkim/codebeamer-docker` 

This will run a single codeBeamer instance, that accessable via 8080 port on host. This need a mysql container to store codeBeamer data.

You can specify volume storage path
```
$ docker run -d -p 8080:8080 --name some-codebeamer --link some-mysql:mysql \
    --volume /your/codebeamer/config:/opt/codebeamer/tomcat/webapps/cb/WEB-INF/classes \
    --volume /your/codebeamer/logs:/opt/codebeamer/tomcat/logs \
    --volume /your/codebeamer/data:/opt/codebeamer/repository \
    cometkim/codebeamer-docker
```

This will store the codeBeamer data in `/your/codebeamer` on host.  
Ensure that `/your/codebeamer` is accessible or use `-u some_other_user` parameter with docker run.

### ...Via `docker-compose`

Example `docker-compose.yml` for codeBeamer:

```yaml
version: '2'
services:
  db:
    image: mariadb:10.1 
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=password
    volumes:
      - ./data/mysql:/var/lib/mysql
      - /etc/localtime:/etc/localtime:ro

  app:
    image: cometkim/codebeamer
    restart: always
    links:
      - db
    volumes:
      - ./data/codebeamer/conf:/opt/codebeamer/tomcat/webapps/cb/WEB-INF/classes
      - ./data/codebeamer/repository:/opt/codebeamer/repository
      - ./data/codebeamer/logs:/opt/codebeamer/tomcat/logs
      - /etc/localtime:/etc/localtime:ro

  web:
    image: nginx:latest
    restart: always
    ports:
      - "80:80"
      - "443:443"
    links:
      - app
    volumes:
      - ./data/nginx/logs:/var/log/nginx
      - ./data/nginx/conf:/etc/nginx/conf.d:ro
      - /etc/localtime:/etc/localtime:ro
```
