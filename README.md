# PostgreSQL-PostGIS-TimescaleDB-KCache

PostgreSQL + PostGIS + TimescaleDB + KCache ready-to-use docker image

How to build:

```bash
$ docker build -t waliot/postgresql-postgis-timescaledb-kcache .
```

How to run:

```bash
$ docker run -d --name postgres -e POSTGRES_PASSWORD=postgres waliot/postgresql-postgis-timescaledb-kcache
```