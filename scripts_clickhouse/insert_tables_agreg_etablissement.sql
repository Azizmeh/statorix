truncate table etablissement_stats;
truncate table etablissement_actif_date_stats;
truncate table etablissement_actif_stats;

INSERT INTO etablissement_stats
SELECT 
    toLastDayOfMonth(dateCreation) AS date,
    'Création' AS type,
    etablissementSiege,
    codeDepartement,
    departement,
    codeRegion,
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
    trancheEffectif,
    count(*) AS nb
FROM etablissement
GROUP BY 
    toLastDayOfMonth(dateCreation),
    etablissementSiege,
    codeDepartement,
    departement,
    codeRegion,
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

UNION ALL

SELECT 
    toLastDayOfMonth(dateCloture) AS date,
    'Clôture' AS type,
    etablissementSiege,
    codeDepartement,
    departement,
    codeRegion,
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
    trancheEffectif,
    count(*) AS nb
FROM etablissement
WHERE dateCloture IS NOT NULL
GROUP BY 
    toLastDayOfMonth(dateCloture),
    etablissementSiege,
    codeDepartement,
    departement,
    codeRegion,
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

INSERT INTO etablissement_actif_date_stats

WITH
    assumeNotNull(
        (SELECT dateDebut FROM data_periode LIMIT 1)
    ) AS dateDebut,

    assumeNotNull(
        (SELECT dateFin FROM data_periode LIMIT 1)
    ) AS dateFin

SELECT
    d.date,
    e.etablissementSiege,
    e.codeDepartement,
    e.departement,
    e.codeRegion,
    e.region,
    e.pays,
    e.activite,
    e.classeActivite,
    e.groupeActivite,
    e.divisionActivite,
    e.sectionActivite,
    e.categorieJuridique,
    e.classeCategorieJuridique,
    e.superClasseCategorieJuridique,
    e.categorieEntreprise,
    e.trancheEffectif,
    count() AS nbActifs

FROM
(
    SELECT
        toLastDayOfMonth(addMonths(dateDebut, number)) AS date
    FROM numbers(
        toUInt64(dateDiff('month', dateDebut, dateFin) + 1)
    )
) d

INNER JOIN etablissement e
    ON e.dateCreation <= d.date
    AND (e.dateCloture IS NULL OR e.dateCloture > d.date)

GROUP BY
    d.date,
    e.etablissementSiege,
    e.codeDepartement,
    e.departement,
    e.codeRegion,
    e.region,
    e.pays,
    e.activite,
    e.classeActivite,
    e.groupeActivite,
    e.divisionActivite,
    e.sectionActivite,
    e.categorieJuridique,
    e.classeCategorieJuridique,
    e.superClasseCategorieJuridique,
    e.categorieEntreprise,
    e.trancheEffectif;

INSERT INTO etablissement_actif_stats
SELECT
    e.etablissementSiege,
    e.codeDepartement,
    e.departement,
    e.codeRegion,
    e.region,
    e.pays,
    e.activite,
    e.classeActivite,
    e.groupeActivite,
    e.divisionActivite,
    e.sectionActivite,
    e.categorieJuridique,
    e.classeCategorieJuridique,
    e.superClasseCategorieJuridique,
    e.categorieEntreprise,
    e.trancheEffectif,

    count() AS nbActifs
from etablissement e
where etat='A'
GROUP BY
    e.etablissementSiege,
    e.codeDepartement,
    e.departement,
    e.codeRegion,
    e.region,
    e.pays,
    e.activite,
    e.classeActivite,
    e.groupeActivite,
    e.divisionActivite,
    e.sectionActivite,
    e.categorieJuridique,
    e.classeCategorieJuridique,
    e.superClasseCategorieJuridique,
    e.categorieEntreprise,
    e.trancheEffectif
    ;