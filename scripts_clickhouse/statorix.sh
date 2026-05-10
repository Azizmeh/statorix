CREATE USER admin
IDENTIFIED BY 'ERmpl??784'
HOST LOCAL;

CREATE USER admin
IDENTIFIED WITH sha256_password BY 'ERmpl??784';

CREATE DATABASE statorix;

REVOKE ALL ON *.* FROM admin;
GRANT ALL ON statorix.* TO admin;

docker exec -i clickhouse \
  clickhouse-client --user admin --password 'ERmpl??784' < create_tables_dim.sql
  
  
docker exec -i clickhouse \
clickhouse-client \
--user admin \
--password 'ERmpl??784' \
--database statorix \
< create_tables_dim.sql


docker exec -i clickhouse \
clickhouse-client \
--user admin \
--password 'mon mot de passe' \
--database statorix \
< create_tables_dim.sql

create table categorie_entreprise_dim 
(categorieEntreprise String)
ENGINE = MergeTree
ORDER BY categorieEntreprise
;