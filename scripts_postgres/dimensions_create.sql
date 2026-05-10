\set chemin_data '/home/aziz/b2bref/db/data/'

\echo "Création de la table naf"
CREATE TABLE naf
(
    code character varying(10),
    nomenclature character varying(10),
    libelle character varying(200),
    code_parent character varying(10)
)
TABLESPACE pg_default;

\echo "Chargement de la table naf"
\copy naf from '/home/aziz/b2bref/db/data/naf.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table naf"
ALTER TABLE naf
    ADD CONSTRAINT naf_pkey PRIMARY KEY (code, nomenclature);

ALTER TABLE naf
    ADD CONSTRAINT fk_naf_parent FOREIGN KEY (code, nomenclature)
    REFERENCES naf (code, nomenclature);

\echo "Création de la table activite"
CREATE TABLE activite(
    code character varying,
    libelle character varying,
    code_parent character varying
);

\echo "Chargement de la table activite"
\copy "activite" from '/home/aziz/b2bref/db/data/activite.csv' delimiter ',' csv header;

alter table activite add constraint pk_activite primary key(code);
alter table activite add constraint fk_activite_parent foreign key(code_parent) references activite(code);
create index idx_activite_code_parent on activite(code_parent);
create index idx_activite_libelle on activite(libelle);

\echo "Création de la table pays"
CREATE TABLE pays
(
	code character varying,
	nom character varying
)
TABLESPACE pg_default;

\echo "Chargement de la table pays"
\copy "pays" from '/home/aziz/b2bref/db/data/pays.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table pays"
alter table pays add constraint pk_pays primary key(code);
create unique index idx_nom_pays on pays(nom);



\echo "Création de la table region"
CREATE TABLE region
(
	code character varying,
	nom character varying,
    code_pays character varying
)
TABLESPACE pg_default;

\echo "Chargement de la table region"
\copy "region" from '/home/aziz/b2bref/db/data/region.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table region"
alter table region add constraint pk_region primary key(code);
create unique index idx_nom_region on region(nom);

\echo "Création de la table departement"
CREATE TABLE departement
(
	code character varying,
	nom character varying,
	code_region character varying
)
TABLESPACE pg_default;

\echo "Chargement de la table departement"
\copy departement from '/home/aziz/b2bref/db/data/departement.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table departement"
alter table departement add constraint pk_departement primary key(code);
alter table departement add constraint fk_dept_region foreign key(code_region) references region(code);
create index idx_dept_code_region on departement(code_region);
create unique index idx_dept_nom on departement(nom);

\echo "Création de la table commune"
CREATE TABLE commune
(
	code character varying,
	nom character varying,
	code_departement character varying
)
TABLESPACE pg_default;

\echo "Chargement de la table commune"
\copy commune from '/home/aziz/b2bref/db/data/commune.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table commune"
ALTER TABLE commune ADD CONSTRAINT pk_commune primary key(code);
alter TABLE commune ADD CONSTRAINT fk_commune_dept foreign key (code_departement) references departement(code);
ALTER TABLE commune ALTER COLUMN nom SET NOT NULL;
CREATE INDEX idx_commune_nom on commune(nom); 

\echo "Création de la table lieu_dit"
CREATE TABLE lieu_dit
(
 	code_commune character varying,
	code_postal character varying,
	lib_acheminement character varying,
	nom character varying
);

\echo "Chargement de la table lieu_dit"
\copy lieu_dit from '/home/aziz/b2bref/db/data/lieu_dit.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table lieu_dit"
alter table lieu_dit add constraint pk_lieu_dit primary key (code_commune, code_postal,lib_acheminement, nom);
create index idx_lieu_dit_code_commune on lieu_dit (code_commune);

\echo "Création de la table categorie_juridique"
CREATE TABLE categorie_juridique
(
    code character varying COLLATE pg_catalog."default" NOT NULL,
    libelle character varying COLLATE pg_catalog."default" NOT NULL,
    code_parent character varying
)
TABLESPACE pg_default;

\echo "Chargement de la table categorie_juridique"
\copy categorie_juridique from '/home/aziz/b2bref/db/data/categorie_juridique.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table categorie_juridique"
ALTER TABLE categorie_juridique
    ADD CONSTRAINT categorie_juridique_pkey PRIMARY KEY (code);

ALTER TABLE categorie_juridique
    ADD CONSTRAINT fk_code_parent FOREIGN KEY (code_parent)
    REFERENCES categorie_juridique (code);
    
create index idx_cj_libelle on categorie_juridique(libelle);

\echo "Création de la table categorie_entreprise"
create table categorie_entreprise (
	code character varying,
	libelle character varying
);

\echo "Chargement de la table categorie_entreprise"
\copy categorie_entreprise from '/home/aziz/b2bref/db/data/categorie_entreprise.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table categorie_entreprise"
alter table categorie_entreprise add constraint pk_categorie_entreprise primary key (code);

\echo "Création de la table tranche_effectifs"
create table tranche_effectifs(
	code character varying,
	libelle character varying
);

\echo "Chargement de la table tranche_effectifs"
\copy tranche_effectifs from '/home/aziz/b2bref/db/data/tranche_effectifs.csv' delimiter ',' csv header;

\echo "Création des contraintes et index sur la table tranche_effectifs"
alter table tranche_effectifs add constraint pk_tranche_affectifs primary key (code);

\echo "Création de la table attribut_etablissement"
CREATE TABLE attribut_etablissement
(
    nom character varying,
    libelle character varying,
    longueur integer,
    type character varying,
    ordre integer
);

\copy attribut_etablissement from '/home/aziz/b2bref/db/data/attribut_etablissement.csv' delimiter ',' csv header;


CREATE TABLE attribut_unite_legale
(
    nom character varying,
    libelle character varying,
    longueur integer,
    type character varying,
    ordre integer
);

\copy attribut_unite_legale from '/home/aziz/b2bref/db/data/attribut_unite_legale.csv' delimiter ',' csv header;


CREATE TABLE d_date
(
  date_dim_id              INT NOT NULL,
  date_actual              DATE NOT NULL,
  epoch                    BIGINT NOT NULL,
  day_suffix               VARCHAR(4) NOT NULL,
  day_name                 VARCHAR(9) NOT NULL,
  day_of_week              INT NOT NULL,
  day_of_month             INT NOT NULL,
  day_of_quarter           INT NOT NULL,
  day_of_year              INT NOT NULL,
  week_of_month            INT NOT NULL,
  week_of_year             INT NOT NULL,
  week_of_year_iso         CHAR(10) NOT NULL,
  month_actual             INT NOT NULL,
  month_name               VARCHAR(9) NOT NULL,
  month_name_abbreviated   CHAR(3) NOT NULL,
  quarter_actual           INT NOT NULL,
  quarter_name             VARCHAR(9) NOT NULL,
  year_actual              INT NOT NULL,
  first_day_of_week        DATE NOT NULL,
  last_day_of_week         DATE NOT NULL,
  first_day_of_month       DATE NOT NULL,
  last_day_of_month        DATE NOT NULL,
  first_day_of_quarter     DATE NOT NULL,
  last_day_of_quarter      DATE NOT NULL,
  first_day_of_year        DATE NOT NULL,
  last_day_of_year         DATE NOT NULL,
  mmyyyy                   CHAR(6) NOT NULL,
  mmddyyyy                 CHAR(10) NOT NULL,
  weekend_indr             BOOLEAN NOT NULL
);

\echo "Chargement de la table d_date"
INSERT INTO d_date
SELECT TO_CHAR(datum, 'yyyymmdd')::INT AS date_dim_id,
       datum AS date_actual,
       EXTRACT(EPOCH FROM datum) AS epoch,
       TO_CHAR(datum, 'fmDDth') AS day_suffix,
       TO_CHAR(datum, 'TMDay') AS day_name,
       EXTRACT(ISODOW FROM datum) AS day_of_week,
       EXTRACT(DAY FROM datum) AS day_of_month,
       datum - DATE_TRUNC('quarter', datum)::DATE + 1 AS day_of_quarter,
       EXTRACT(DOY FROM datum) AS day_of_year,
       TO_CHAR(datum, 'W')::INT AS week_of_month,
       EXTRACT(WEEK FROM datum) AS week_of_year,
       EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, '"-W"IW-') || EXTRACT(ISODOW FROM datum) AS week_of_year_iso,
       EXTRACT(MONTH FROM datum) AS month_actual,
       TO_CHAR(datum, 'TMMonth') AS month_name,
       TO_CHAR(datum, 'Mon') AS month_name_abbreviated,
       EXTRACT(QUARTER FROM datum) AS quarter_actual,
       CASE
           WHEN EXTRACT(QUARTER FROM datum) = 1 THEN 'First'
           WHEN EXTRACT(QUARTER FROM datum) = 2 THEN 'Second'
           WHEN EXTRACT(QUARTER FROM datum) = 3 THEN 'Third'
           WHEN EXTRACT(QUARTER FROM datum) = 4 THEN 'Fourth'
           END AS quarter_name,
       EXTRACT(YEAR FROM datum) AS year_actual,
       datum + (1 - EXTRACT(ISODOW FROM datum))::INT AS first_day_of_week,
       datum + (7 - EXTRACT(ISODOW FROM datum))::INT AS last_day_of_week,
       datum + (1 - EXTRACT(DAY FROM datum))::INT AS first_day_of_month,
       (DATE_TRUNC('MONTH', datum) + INTERVAL '1 MONTH - 1 day')::DATE AS last_day_of_month,
       DATE_TRUNC('quarter', datum)::DATE AS first_day_of_quarter,
       (DATE_TRUNC('quarter', datum) + INTERVAL '3 MONTH - 1 day')::DATE AS last_day_of_quarter,
       TO_DATE(EXTRACT(YEAR FROM datum) || '-01-01', 'YYYY-MM-DD') AS first_day_of_year,
       TO_DATE(EXTRACT(YEAR FROM datum) || '-12-31', 'YYYY-MM-DD') AS last_day_of_year,
       TO_CHAR(datum, 'mmyyyy') AS mmyyyy,
       TO_CHAR(datum, 'mmddyyyy') AS mmddyyyy,
       CASE
           WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE
           ELSE FALSE
           END AS weekend_indr
FROM (SELECT '1900-01-01'::DATE + SEQUENCE.DAY AS datum
      FROM GENERATE_SERIES(0, 55151) AS SEQUENCE (DAY)
      GROUP BY SEQUENCE.DAY) DQ
ORDER BY 1;

\echo "Création des contraintes et index de la table d_date"
ALTER TABLE public.d_date ADD CONSTRAINT d_date_date_dim_id_pk PRIMARY KEY (date_dim_id);

CREATE INDEX d_date_date_actual_idx
  ON d_date(date_actual);
