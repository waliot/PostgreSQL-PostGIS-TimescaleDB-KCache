FROM timescale/timescaledb-postgis:1.7.1-pg12

MAINTAINER Ilya Gehrman "gehrman.ilya@gmail.com"

RUN apk update && apk add --no-cache \
    git \
    make \
    gcc \
    libc-dev \
    clang \
    llvm

RUN git clone https://github.com/powa-team/pg_stat_kcache.git &&\
    cd pg_stat_kcache &&\
    git checkout REL2_1_1 &&\
    make &&\
    make install

RUN sed -r -i "s/[#]*\s*(shared_preload_libraries)\s*=\s*'(.*)'/\1 = 'pg_stat_statements,pg_stat_kcache,\2'/;s/,'/'/" /usr/local/share/postgresql/postgresql.conf.sample

COPY ./create_extensions.sh /docker-entrypoint-initdb.d/create_extensions.sh