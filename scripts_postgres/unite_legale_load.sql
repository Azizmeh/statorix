\echo "Date de début de traitement"
select now();

\echo "Chargement de la table unite_legale ~60min "
\copy unite_legale from '/home/aziz/b2bref_data/insee/StockUniteLegale_utf8.csv' delimiter ',' csv header;

\echo "Date de fin de traitement"
select now();