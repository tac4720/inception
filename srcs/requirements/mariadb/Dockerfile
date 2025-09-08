FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/initial_db.sh /tmp/

RUN chmod +x /tmp/initial_db.sh

ENTRYPOINT [ "/tmp/initial_db.sh" ]

CMD [ "mysqld_safe" ]
