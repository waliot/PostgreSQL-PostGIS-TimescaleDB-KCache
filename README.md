# PostgreSQL-PostGIS-TimescaleDB-KCache

`PostgreSQL + PostGIS + TimescaleDB + KCache` ready-to-use docker image.

## Docker

How to build:

```bash
$ docker build -t waliot/postgresql-postgis-timescaledb-kcache .
```

How to run:

```bash
$ docker run --name postgres \
    -e POSTGRES_PASSWORD=postgres \ 
    -d waliot/postgresql-postgis-timescaledb-kcache
```

## Docker Compose

Build & run:

```bash
$ docker-compose build
$ docker-compose up -d
```
