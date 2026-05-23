\copy
(
SELECT  
siret, 
etat,
"dateCreationEtablissement",
"anneeCreationEtablissement", 
"moisCreationEtablissement",
case when "trancheEffectifsEtablissement" is not null then "trancheEffectifsEtablissement" else 'Non renseigné' end as "trancheEffectifsEtablissement", 
case when "trancheEffectifsUniteLegale" is not null then "trancheEffectifsUniteLegale" else 'Non renseigné' end as "trancheEffectifsUniteLegale", 
case when "etablissementSiege" is true then 1 else 0 end as "etablissementSiege", 
case when "codePostalEtablissement" is not null then "codePostalEtablissement" else 'Non renseigné' end as "codePostalEtablissement", 
"codeCommuneEtablissement", 
"communeEtablissement", 
"codeDepartementEtablissement",
"departementEtablissement", 
"codeRegionEtablissement", 
"regionEtablissement", 
"paysEtablissement", 
case when "activitePrincipaleEtablissement" is not null then "activitePrincipaleEtablissement" else 'Non renseigné' end as "activitePrincipaleEtablissement", 
case when "sectionActivitePrincipaleEtablissement" is not null then "sectionActivitePrincipaleEtablissement" else 'Non renseigné' end as "sectionActivitePrincipaleEtablissement",
case when "activitePrincipaleUniteLegale" is not null then "activitePrincipaleUniteLegale" else 'Non renseigné' end as "activitePrincipaleUniteLegale",
case when "sectionActivitePrincipaleUniteLegale" is not null then "sectionActivitePrincipaleUniteLegale" else 'Non renseigné' end as "sectionActivitePrincipaleUniteLegale",
case when "categorieJuridiqueUniteLegale" is not null then "categorieJuridiqueUniteLegale" else 'Non renseigné' end as "categorieJuridiqueUniteLegale", 
case when "classeCategorieJuridiqueUniteLegale" is not null then "classeCategorieJuridiqueUniteLegale" else 'Non renseigné' end as "classeCategorieJuridiqueUniteLegale",
case when "categorieEntreprise" is not null then "categorieEntreprise" else 'Non renseigné' end as "categorieEntreprise",
"dateClotureEtablissement", 
"anneeClotureEtablissement", 
"moisClotureEtablissement"
FROM public.v_etablissement
)
to /home/aziz/app/statorix/data_sirene/etablissement.csv csv HEADER delimiter ';'
;


