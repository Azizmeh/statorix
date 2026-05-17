echo "Début traitement $(date)" > logs/refresh.log 2>&1

mkdir logs

psql -d b2bref -f unite_legale_src_drop.sql &> logs/unite_legale_src_drop.sql.log
psql -d b2bref -f unite_legale_src_create.sql &> logs/unite_legale_src_create.sql.log
unzip -p /home/aziz/app/statorix/data_sirene/StockUniteLegale_utf8.zip \
| psql -d b2bref -c "\copy unite_legale_src FROM STDIN DELIMITER ',' CSV HEADER" &> logs/unite_legale_src_copy.sql.log
psql -d b2bref -f unite_legale_src_create_index.sql &> logs/unite_legale_src_create_index.sql.log

psql -d b2bref -f etablissement_src_drop.sql &> logs/etablissement_src_drop.sql.log
psql -d b2bref -f etablissement_src_create.sql &> logs/etablissement_src_create.sql.log
unzip -p /home/aziz/app/statorix/data_sirene/StockEtablissement_utf8.zip \
| psql -d b2bref -c "\copy etablissement_src FROM STDIN DELIMITER ',' CSV HEADER" &> logs/etablissement_src_copy.sql.log
psql -d b2bref -f etablissement_src_create_index.sql &> logs/etablissement_src_create_index.sql.log

psql -d b2bref -f etablissement_historique_src_drop.sql &> logs/etablissement_historique_src_drop.sql.log
psql -d b2bref -f etablissement_historique_src_create.sql &> logs/etablissement_historique_src_create.sql.log
unzip -p /home/aziz/app/statorix/data_sirene/StockEtablissementHistorique_utf8.zip \
| psql -d b2bref -c "\copy etablissement_historique_src FROM STDIN DELIMITER ',' CSV HEADER" &> logs/etablissement_historique_src_copy.sql.log
psql -d b2bref -f etablissement_historique_src_create_index.sql &> logs/etablissement_historique_src_create_index.sql.log

psql -d b2bref -f etablissement_transform.sql &> logs/etablissement_transform.sql.log
psql -d b2bref -f etablissement_extract.sql &> logs/etablissement_extract.sql.log

echo "Fin traitement $(date)" >> logs/refresh.log 2>&1