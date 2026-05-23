create table activite_dim 
(activite String, classeActivite String, groupeActivite String, divisionActivite String, sectionActivite String) 
ENGINE = MergeTree
ORDER BY activite;

create table classe_activite_dim 
(classeActivite String, groupeActivite String, divisionActivite String, sectionActivite String)
ENGINE = MergeTree
ORDER BY classeActivite;

create table groupe_activite_dim 
(groupeActivite String, divisionActivite String, sectionActivite String)
ENGINE = MergeTree
ORDER BY groupeActivite;

create table division_activite_dim 
(divisionActivite String, sectionActivite String)
ENGINE = MergeTree
ORDER BY divisionActivite;

create table section_activite_dim 
(sectionActivite String)
ENGINE = MergeTree
ORDER BY sectionActivite;

create table categorie_juridique_dim 
(categorieJuridique String, classeCategorieJuridique String, superClasseCategorieJuridique String)
ENGINE = MergeTree
ORDER BY categorieJuridique;

create table classe_categorie_juridique_dim 
(classeCategorieJuridique String, superClasseCategorieJuridique String)
ENGINE = MergeTree
ORDER BY classeCategorieJuridique;

create table super_classe_categorie_juridique_dim 
(superClasseCategorieJuridique String)
ENGINE = MergeTree
ORDER BY superClasseCategorieJuridique;

create table categorie_entreprise_dim 
(categorieEntreprise String)
ENGINE = MergeTree
ORDER BY categorieEntreprise;

create table tranche_effectif_dim 
(trancheEffectif String, ordre UInt8)
ENGINE = MergeTree
ORDER BY trancheEffectif;

create table departement_dim 
(departement String, region String, pays String)
ENGINE = MergeTree
ORDER BY departement;

create table region_dim 
(region String, pays String)
ENGINE = MergeTree
ORDER BY region;

create table pays_dim 
(pays String)
ENGINE = MergeTree
ORDER BY pays;

CREATE TABLE data_periode
(
    dateDebut Date,
    dateFin Date
)
ENGINE = MergeTree;

CREATE TABLE activite_tree
(
    code String,
    libelle String,
    code_parent String
)
ENGINE = MergeTree;

CREATE TABLE etablissement
(
    siret String,
    etat LowCardinality(String),

    dateCreationEtablissement Date,
    anneeCreationEtablissement UInt16,
    moisCreationEtablissement UInt8,

    trancheEffectifsEtablissement LowCardinality(String),
    trancheEffectifsUniteLegale LowCardinality(String),
    etablissementSiege UInt8,

    codePostalEtablissement String,
    codeCommuneEtablissement String,
    communeEtablissement LowCardinality(String),
    codeDepartementEtablissement LowCardinality(String),
    departementEtablissement LowCardinality(String),
    codeRegionEtablissement LowCardinality(String),
    regionEtablissement LowCardinality(String),
    paysEtablissement LowCardinality(String),

    activitePrincipaleEtablissement LowCardinality(String),
    sectionActivitePrincipaleEtablissement LowCardinality(String),
    activitePrincipaleUniteLegale LowCardinality(String),
    sectionActivitePrincipaleUniteLegale LowCardinality(String),

    categorieJuridiqueUniteLegale LowCardinality(String),
    classeCategorieJuridiqueUniteLegale LowCardinality(String),

    categorieEntreprise LowCardinality(String),

    dateClotureEtablissement Nullable(Date),
    anneeClotureEtablissement Nullable(UInt16),
    moisClotureEtablissement Nullable(UInt8)
)
ENGINE = MergeTree
ORDER BY (dateCreationEtablissement)
SETTINGS index_granularity = 8192;

CREATE TABLE etablissement_actif_date_stats
(
    date Date,
    etablissementSiege Bool,
    codeDepartementEtablissement LowCardinality(String),
    departementEtablissement LowCardinality(String),
    codeRegionEtablissement LowCardinality(String),
    regionEtablissement LowCardinality(String),
    paysEtablissement LowCardinality(String),

    activitePrincipaleEtablissement LowCardinality(String),
    sectionActivitePrincipaleEtablissement LowCardinality(String),
    activitePrincipaleUniteLegale LowCardinality(String),
    sectionActivitePrincipaleUniteLegale LowCardinality(String),

    categorieJuridiqueUniteLegale LowCardinality(String),
    classeCategorieJuridiqueUniteLegale LowCardinality(String),

    categorieEntreprise LowCardinality(String),
    trancheEffectifsEtablissement LowCardinality(String),
    trancheEffectifsUniteLegale LowCardinality(String),

    nbActifs UInt32
)
ENGINE = MergeTree()
PARTITION BY toYear(date)
ORDER BY (
    date,
    paysEtablissement,
    activitePrincipaleEtablissement,
    regionEtablissement,
    departementEtablissement
);

CREATE TABLE etablissement_actif_stats
(
    etablissementSiege Bool,
    codeDepartementEtablissement LowCardinality(String),
    departementEtablissement LowCardinality(String),
    codeRegionEtablissement LowCardinality(String),
    regionEtablissement LowCardinality(String),
    paysEtablissement LowCardinality(String),

    activitePrincipaleEtablissement LowCardinality(String),
    sectionActivitePrincipaleEtablissement LowCardinality(String),
    activitePrincipaleUniteLegale LowCardinality(String),
    sectionActivitePrincipaleUniteLegale LowCardinality(String),

    categorieJuridiqueUniteLegale LowCardinality(String),
    classeCategorieJuridiqueUniteLegale LowCardinality(String),

    categorieEntreprise LowCardinality(String),
    trancheEffectifsEtablissement LowCardinality(String),
    trancheEffectifsUniteLegale LowCardinality(String),

    nbActifs UInt32
)
ENGINE = MergeTree()
ORDER BY (
    paysEtablissement,
    activitePrincipaleEtablissement,
    regionEtablissement,
    departementEtablissement
);

CREATE TABLE etablissement_event_stats
(
    date Date,
    type LowCardinality(String),
    etablissementSiege Bool,
    codeDepartementEtablissement LowCardinality(String),
    departementEtablissement LowCardinality(String),
    codeRegionEtablissement LowCardinality(String),
    regionEtablissement LowCardinality(String),
    paysEtablissement LowCardinality(String),

    activitePrincipaleEtablissement LowCardinality(String),
    sectionActivitePrincipaleEtablissement LowCardinality(String),
    activitePrincipaleUniteLegale LowCardinality(String),
    sectionActivitePrincipaleUniteLegale LowCardinality(String),

    categorieJuridiqueUniteLegale LowCardinality(String),
    classeCategorieJuridiqueUniteLegale LowCardinality(String),

    categorieEntreprise LowCardinality(String),
    trancheEffectifsEtablissement LowCardinality(String),
    trancheEffectifsUniteLegale LowCardinality(String),

    nb UInt32
)
ENGINE = SummingMergeTree()
ORDER BY (
    date,
    type,
    regionEtablissement,
    departementEtablissement,
    activitePrincipaleEtablissement
);

