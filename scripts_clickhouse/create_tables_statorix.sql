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

    dateCreation Date,
    anneeCreation UInt16,
    moisCreation UInt8,

    trancheEffectif LowCardinality(String),
    etablissementSiege UInt8,

    codePostal String,
    codeCommune String,
    commune LowCardinality(String),
    codeDepartement LowCardinality(String),
    departement LowCardinality(String),
    codeRegion LowCardinality(String),
    region LowCardinality(String),
    pays LowCardinality(String),

    activite LowCardinality(String),
    classeActivite LowCardinality(String),
    groupeActivite LowCardinality(String),
    divisionActivite LowCardinality(String),
    sectionActivite LowCardinality(String),

    categorieJuridique LowCardinality(String),
    classeCategorieJuridique LowCardinality(String),
    superClasseCategorieJuridique LowCardinality(String),

    categorieEntreprise LowCardinality(String),

    dateCloture Nullable(Date),
    anneeCloture Nullable(UInt16),
    moisCloture Nullable(UInt8)
)
ENGINE = MergeTree
ORDER BY (dateCreation)
SETTINGS index_granularity = 8192;

CREATE TABLE etablissement_actif_date_stats
(
    date Date,
    etablissementSiege Bool,
    codeDepartement LowCardinality(String),
    departement LowCardinality(String),
    codeRegion LowCardinality(String),
    region LowCardinality(String),
    pays LowCardinality(String),

    activite LowCardinality(String),
    classeActivite LowCardinality(String),
    groupeActivite LowCardinality(String),
    divisionActivite LowCardinality(String),
    sectionActivite LowCardinality(String),

    categorieJuridique LowCardinality(String),
    classeCategorieJuridique LowCardinality(String),
    superClasseCategorieJuridique LowCardinality(String),

    categorieEntreprise LowCardinality(String),
    trancheEffectif LowCardinality(String),

    nbActifs UInt32
)
ENGINE = MergeTree()
PARTITION BY toYear(date)
ORDER BY (
    date,
    pays,
    activite,
    region,
    departement
);

CREATE TABLE etablissement_actif_stats
(
    etablissementSiege Bool,
    codeDepartement LowCardinality(String),
    departement LowCardinality(String),
    codeRegion LowCardinality(String),
    region LowCardinality(String),
    pays LowCardinality(String),

    activite LowCardinality(String),
    classeActivite LowCardinality(String),
    groupeActivite LowCardinality(String),
    divisionActivite LowCardinality(String),
    sectionActivite LowCardinality(String),

    categorieJuridique LowCardinality(String),
    classeCategorieJuridique LowCardinality(String),
    superClasseCategorieJuridique LowCardinality(String),

    categorieEntreprise LowCardinality(String),
    trancheEffectif LowCardinality(String),

    nbActifs UInt32
)
ENGINE = MergeTree()
ORDER BY (
    pays,
    activite,
    region,
    departement
);

CREATE TABLE etablissement_stats
(
    date Date,
    type LowCardinality(String),
    etablissementSiege Bool,
    codeDepartement LowCardinality(String),
    departement LowCardinality(String),
    codeRegion LowCardinality(String),
    region LowCardinality(String),
    pays LowCardinality(String),

    activite LowCardinality(String),
    classeActivite LowCardinality(String),
    groupeActivite LowCardinality(String),
    divisionActivite LowCardinality(String),
    sectionActivite LowCardinality(String),

    categorieJuridique LowCardinality(String),
    classeCategorieJuridique LowCardinality(String),
    superClasseCategorieJuridique LowCardinality(String),

    categorieEntreprise LowCardinality(String),
    trancheEffectif LowCardinality(String),

    nb UInt32
)
ENGINE = SummingMergeTree()
ORDER BY (
    date,
    type,
    region,
    departement,
    activite
);

