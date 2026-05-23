\echo "Date de début de traitement"
select now();

\echo "Chargement de la table etablissement_src ~60min "
\copy etablissement_src from '/home/aziz/app/statorix/data_sirene/StockEtablissement_utf8.csv' delimiter ',' csv header;

\echo "Date de fin de traitement"
select now();