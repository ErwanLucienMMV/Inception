FROM debian:bookworm

RUN apt update

RUN apt-get install mariadb-server -y

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/start.sh ./start.sh

RUN chmod +x /start.sh

CMD ["./start.sh"]