FROM ubuntu:16.04

MAINTAINER Ilya Gehrman "gehrman.ilya@gmail.com"

RUN apt-get update &&\
    apt-get dist-upgrade &&\
    apt-get install -y build-essential lsb-core wget &&\
    apt-get autoremove

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list &&\
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
    apt-get update &&\
    apt-get install -y postgresql-12 postgresql-contrib-12 postgresql-server-dev-12

RUN apt-get install -y locales &&\
    locale-gen en_US.UTF-8 &&\
    update-locale LANG=en_US.UTF-8

RUN apt-get install -y git cmake libssl-dev &&\
    git clone https://github.com/timescale/timescaledb.git &&\
    cd timescaledb &&\
    git checkout 2.3.0 &&\
    ./bootstrap -DREGRESS_CHECKS=OFF &&\
    cd build &&\
    make &&\
    make install

RUN apt-get install -y autoconf automake libtool curl make g++ unzip libxml2-dev libgeos-dev libproj-dev libgdal-dev libjson-c-dev &&\
    wget https://download.osgeo.org/postgis/source/postgis-3.1.4.tar.gz &&\
    tar -xvzf postgis-2.5.4.tar.gz &&\
    cd postgis-2.5.4 &&\
    ./configure &&\
    make &&\
    make install

RUN git clone https://github.com/powa-team/pg_stat_kcache.git &&\
    cd pg_stat_kcache &&\
    git checkout REL2_2_0 &&\
    make &&\
    make install

RUN echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/12/main/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /etc/postgresql/12/main/postgresql.conf

RUN sed -r -i "s/[#]*\s*(shared_preload_libraries)\s*=\s*'(.*)'/\1 = 'timescaledb,pg_stat_statements,pg_stat_kcache,\2'/;s/,'/'/" /etc/postgresql/12/main/postgresql.conf

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER postgres
ENV LANG en_US.UTF-8

EXPOSE 5432
ENTRYPOINT ["entrypoint.sh"]
