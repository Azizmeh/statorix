## Création et chargement des tables dimension
psql -d b2bref -f dimensions_create.sql &> log/dimensions_create.sql.log

## Création de la vue activite_hierarchie_view
psql -d b2bref -f views/activite_hierarchie_view.sql &> log/activite_hierarchie_view.sql.log

## Création de la vue categorie_juridique_hierarchie_view
psql -d b2bref -f views/categorie_juridique_hierarchie_view.sql &> log/categorie_juridique_hierarchie_view.sql.log

## Création et chargement de la table unite_legale
psql -d b2bref -f unite_legale.sql &> log/unite_legale.sql.log
psql -d b2bref -f unite_legale_load.sql &> log/unite_legale_load.sql.log
psql -d b2bref -f unite_legale_index.sql &> log/unite_legale_index.sql.log

## Création et chargement de la table etabblissement
psql -d b2bref -f etablissement.sql &> log/etablissement.sql.log
psql -d b2bref -f etablissement_load.sql &> log/etablissement_load.sql.log
psql -d b2bref -f etablissement_index.sql &> log/etablissement_index.sql.log
psql -d b2bref -f etablissement_update.sql &> log/etablissement_update.sql.log

## Création des vues matérialisées
psql -d b2bref -f mat_views/etab_actif_pays_etranger.sql &> log/etab_actif_pays_etranger.sql.log
psql -d b2bref -f mat_views/etab_actif_pays_etranger_idx.sql &> log/etab_actif_pays_etranger_idx.sql.log
psql -d b2bref -f mat_views/etab_actif.sql &> log/etab_actif.sql.log
psql -d b2bref -f mat_views/etab_actif_idx.sql &> log/etab_actif_idx.sql.log
psql -d b2bref -f mat_views/etab_actif_dep_acti_cj_ce.sql &> log/etab_actif_dep_acti_cj_ce.sql.log
