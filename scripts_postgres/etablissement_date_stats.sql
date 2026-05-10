DROP TABLE etablissement_date_stats;
CREATE TABLE etablissement_date_stats
(
    date Date,
    etablissementSiege Bool,
    departement varchar,
    region varchar,
    pays varchar,

    activite varchar,
    classeActivite varchar,
    groupeActivite varchar,
    divisionActivite varchar,
    sectionActivite varchar,

    categorieJuridique varchar,
    classeCategorieJuridique varchar,
    superClasseCategorieJuridique varchar,

    categorieEntreprise varchar,
    trancheEffectif varchar,

    nbCreations int,
    nbClotures int,
    nbActifs int
)
ENGINE = SummingMergeTree()
ORDER BY (
    date,
    region,
    departement,
    activite
);

INSERT INTO etablissement_date_stats
(
    date,
    etablissementSiege,
    departement,
    region,
    pays,
    activite,
    classeActivite,
    groupeActivite,
    divisionActivite,
    sectionActivite,
    categorieJuridique,
    classeCategorieJuridique,
    superClasseCategorieJuridique,
    categorieEntreprise,
    trancheEffectif
)
SELECT 
    dateCreation AS date,
    etablissementSiege,
    departement,
    region,
    pays,
    activite,
    classeActivite,
    groupeActivite,
    divisionActivite,
    sectionActivite,
    categorieJuridique,
    classeCategorieJuridique,
    superClasseCategorieJuridique,
    categorieEntreprise,
    trancheEffectif
FROM etablissement
GROUP BY 
    dateCreation,
    etablissementSiege,
    departement,
    region,
    pays,
    activite,
    classeActivite,
    groupeActivite,
    divisionActivite,
    sectionActivite,
    categorieJuridique,
    classeCategorieJuridique,
    superClasseCategorieJuridique,
    categorieEntreprise, 
    trancheEffectif
;

update etablissement_date_stats eds
set 
nbCreations = 
(select count(*) from etablissement e 
where e.dateCreation=eds.date
and e.etablissementSiege=eds.etablissementSiege
and e.departement=eds.departement
and e.region=eds.region
and e.pays=eds.pays
and e.activite=eds.activite
and e.classeActivite=eds.classeActivite
and e.groupeActivite=eds.groupeActivite
and e.divisionActivite=eds.divisionActivite
and e.sectionActivite=eds.sectionActivite
and e.categorieJuridique=eds.categorieJuridique
and e.classeCategorieJuridique=eds.classeCategorieJuridique
and e.superClasseCategorieJuridique=eds.superClasseCategorieJuridique
and e.categorieEntreprise=eds.categorieEntreprise
and e.trancheEffectif=eds.trancheEffectif
)
;
