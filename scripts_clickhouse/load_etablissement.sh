docker exec -i clickhouse clickhouse-client --user admin --password 'ERmpl??784' --database statorix --query "
INSERT INTO etablissement 
SETTINGS async_insert=0, format_csv_delimiter=';'
FORMAT CSVWithNames
" < /home/aziz/app/statorix/data_sirene/etablissement.csv
