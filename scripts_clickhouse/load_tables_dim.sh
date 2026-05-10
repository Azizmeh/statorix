docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO activite_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/activite.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO classe_activite_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/classe_activite.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO groupe_activite_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/groupe_activite.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO division_activite_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/division_activite.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO section_activite_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/section_activite.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO categorie_juridique_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/categorie_juridique.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO classe_categorie_juridique_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/classe_categorie_juridique.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO super_classe_categorie_juridique_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/super_classe_categorie_juridique.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO categorie_entreprise_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/categorie_entreprise.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO tranche_effectif_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/tranche_effectif.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO departement_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/departement.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO region_dim 
SETTINGS format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/region.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO pays_dim 
SETTINGS async_insert=0, format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/pays.csv

docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO activite_tree 
SETTINGS async_insert=0, format_csv_delimiter=';'
FORMAT CSVWithNames
" < ../data_ref/activite_tree.csv