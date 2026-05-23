\echo "Date de début de traitement"
select now();

\echo "Chargement de la table etablissement_historique_src ~60min "
\copy etablissement_historique_src from '/home/aziz/app/statorix/data_sirene/StockEtablissementHistorique_utf8.zip' delimiter ',' csv header;

\echo "Date de fin de traitement"
select now();