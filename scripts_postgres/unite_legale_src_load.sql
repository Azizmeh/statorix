\echo "Date de début de traitement"
select now();

\echo "Chargement de la table unite_legale_src ~60min "
\copy unite_legale_src from '/home/aziz/app/statorix/data_sirene/StockUniteLegale_utf8.csv' delimiter ',' csv header;

\echo "Date de fin de traitement"
select now();