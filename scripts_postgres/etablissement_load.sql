\echo "Date de début de traitement"
select now();

\echo "Chargement de la table etablissement ~60min "
\copy etablissement from '/home/aziz/b2bref_data/insee/StockEtablissement_utf8.csv' delimiter ',' csv header;

\copy etablissement_historique from '/home/aziz/b2bref_data/etablissement/StockEtablissementHistorique_utf8.csv' delimiter ',' csv header;

\echo "Date de fin de traitement"
select now();