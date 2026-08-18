FROM debian:bookworm

RUN apt update

RUN apt-get install mariadb-server -y

RUN rm -rf /var/lib/mysql/*

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/start.sh ./start.sh

RUN chmod +x /start.sh

CMD ["./start.sh"]