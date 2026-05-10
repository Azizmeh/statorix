\copy
(
SELECT  
siret, 
etat,
"dateCreation" as "dateCreation", 
"anneeCreation", 
"moisCreation", 
case when "trancheEffectif" is not null then "trancheEffectif" else 'Non renseigné' end as "trancheEffectif", 
case when "etablissementSiege" is true then 1 else 0 end as "etablissementSiege", 
case when "codePostal" is not null then "codePostal" else 'Non renseigné' end as "codePostal", 
"codeCommune", 
commune, 
"codeDepartement",
departement, 
"codeRegion", 
region, 
pays, 
case when activite is not null then activite else 'Non renseigné' end as activite, 
case when "classeActivite" is not null then "classeActivite" else 'Non renseigné' end as "classeActivite", 
case when "groupeActivite" is not null then "groupeActivite" else 'Non renseigné' end as "groupeActivite", 
case when "divisionActivite" is not null then "divisionActivite" else 'Non renseigné' end as "divisionActivite", 
case when "sectionActivite" is not null then "sectionActivite" else 'Non renseigné' end as "sectionActivite", 
case when "categorieJuridique" is not null then "categorieJuridique" else 'Non renseigné' end as "categorieJuridique", 
case when "classeCategorieJuridique" is not null then "classeCategorieJuridique" else 'Non renseigné' end as "classeCategorieJuridique", 
case when "superClasseCategorieJuridique" is not null then "superClasseCategorieJuridique" else 'Non renseigné' end as "superClasseCategorieJuridique", 
case when "categorieEntreprise" is not null then "categorieEntreprise" else 'Non renseigné' end as "categorieEntreprise",
"dateCloture", 
"anneeCloture", 
"moisCloture"
FROM public.v_etablissement
)
to etablissement.csv csv HEADER delimiter ';'
;


