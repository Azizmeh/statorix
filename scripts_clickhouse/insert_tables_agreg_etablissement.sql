truncate table etablissement_stats;
truncate table etablissement_actif_date_stats;
truncate table etablissement_actif_stats;

INSERT INTO etablissement_event_stats
SELECT 
    toLastDayOfMonth(dateCreationEtablissement) AS date,
    'Création' AS type,
    etablissementSiege,
    codeDepartementEtablissement,
    departementEtablissement,
    codeRegionEtablissement,
    regionEtablissement,
    paysEtablissement,
    activitePrincipaleEtablissement,
    sectionActivitePrincipaleEtablissement,
    activitePrincipaleUniteLegale,
    sectionActivitePrincipaleUniteLegale,
    categorieJuridiqueUniteLegale,
    classeCategorieJuridiqueUniteLegale,
    categorieEntreprise,
    trancheEffectifsEtablissement,
    trancheEffectifsUniteLegale,
    count(*) AS nb
FROM etablissement
GROUP BY 
    toLastDayOfMonth(dateCreationEtablissement),
    etablissementSiege,
    codeDepartementEtablissement,
    departementEtablissement,
    codeRegionEtablissement,
    regionEtablissement,
    paysEtablissement,
    activitePrincipaleEtablissement,
    sectionActivitePrincipaleEtablissement,
    activitePrincipaleUniteLegale,
    sectionActivitePrincipaleUniteLegale,
    categorieJuridiqueUniteLegale,
    classeCategorieJuridiqueUniteLegale,
    categorieEntreprise, 
    trancheEffectifsEtablissement,
    trancheEffectifsUniteLegale

UNION ALL

SELECT 
    toLastDayOfMonth(dateClotureEtablissement) AS date,
    'Clôture' AS type,
    etablissementSiege,
    codeDepartementEtablissement,
    departementEtablissement,
    codeRegionEtablissement,
    regionEtablissement,
    paysEtablissement,
    activitePrincipaleEtablissement,
    sectionActivitePrincipaleEtablissement,
    activitePrincipaleUniteLegale,
    sectionActivitePrincipaleUniteLegale,
    categorieJuridiqueUniteLegale,
    classeCategorieJuridiqueUniteLegale,
    categorieEntreprise,
    trancheEffectifsEtablissement,
    trancheEffectifsUniteLegale,
    count(*) AS nb
FROM etablissement
WHERE dateClotureEtablissement IS NOT NULL
GROUP BY 
    toLastDayOfMonth(dateClotureEtablissement),
    etablissementSiege,
    codeDepartementEtablissement,
    departementEtablissement,
    codeRegionEtablissement,
    regionEtablissement,
    paysEtablissement,
    activitePrincipaleEtablissement,
    sectionActivitePrincipaleEtablissement,
    activitePrincipaleUniteLegale,
    sectionActivitePrincipaleUniteLegale,
    categorieJuridiqueUniteLegale,
    classeCategorieJuridiqueUniteLegale,
    categorieEntreprise,
    trancheEffectifsEtablissement,
    trancheEffectifsUniteLegale 
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
    e.codeDepartementEtablissement,
    e.departementEtablissement,
    e.codeRegionEtablissement,
    e.regionEtablissement,
    e.paysEtablissement,
    e.activitePrincipaleEtablissement,
    e.sectionActivitePrincipaleEtablissement,
    e.activitePrincipaleUniteLegale,
    e.sectionActivitePrincipaleUniteLegale,
    e.categorieJuridiqueUniteLegale,
    e.classeCategorieJuridiqueUniteLegale,
    e.categorieEntreprise,
    e.trancheEffectifsEtablissement,
    e.trancheEffectifsUniteLegale,
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
    ON e.dateCreationEtablissement <= d.date
    AND (e.dateClotureEtablissement IS NULL OR e.dateClotureEtablissement > d.date)

GROUP BY
    d.date,
    e.etablissementSiege,
    e.codeDepartementEtablissement,
    e.departementEtablissement,
    e.codeRegionEtablissement,
    e.regionEtablissement,
    e.paysEtablissement,
    e.activitePrincipaleEtablissement,
    e.sectionActivitePrincipaleEtablissement,
    e.activitePrincipaleUniteLegale,
    e.sectionActivitePrincipaleUniteLegale,
    e.categorieJuridiqueUniteLegale,
    e.classeCategorieJuridiqueUniteLegale,
    e.categorieEntreprise,
    e.trancheEffectifsEtablissement,
    e.trancheEffectifsUniteLegale;

INSERT INTO etablissement_actif_stats
SELECT
    e.etablissementSiege,
    e.codeDepartementEtablissement,
    e.departementEtablissement,
    e.codeRegionEtablissement,
    e.regionEtablissement,
    e.paysEtablissement,
    e.activitePrincipaleEtablissement,
    e.sectionActivitePrincipaleEtablissement,
    e.activitePrincipaleUniteLegale,
    e.sectionActivitePrincipaleUniteLegale,
    e.categorieJuridiqueUniteLegale,
    e.classeCategorieJuridiqueUniteLegale,
    e.categorieEntreprise,
    e.trancheEffectifsEtablissement,
    e.trancheEffectifsUniteLegale,

    count() AS nbActifs
from etablissement e
where etat='A'
GROUP BY
    e.etablissementSiege,
    e.codeDepartementEtablissement,
    e.departementEtablissement,
    e.codeRegionEtablissement,
    e.regionEtablissement,
    e.paysEtablissement,
    e.activitePrincipaleEtablissement,
    e.sectionActivitePrincipaleEtablissement,
    e.activitePrincipaleUniteLegale,
    e.sectionActivitePrincipaleUniteLegale,
    e.categorieJuridiqueUniteLegale,
    e.classeCategorieJuridiqueUniteLegale,
    e.categorieEntreprise,
    e.trancheEffectifsEtablissement,
    e.trancheEffectifsUniteLegale
    ;