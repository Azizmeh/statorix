select now() as "Début de crétion des index sur la table etablissement";

ALTER TABLE etablissement
  ADD CONSTRAINT pk_etablissement PRIMARY KEY (siret);

CREATE INDEX idx_etatadmin_etablissement
  ON etablissement ("etatAdministratifEtablissement");  

CREATE INDEX idx_siren_etablissement
  ON etablissement (siren);

CREATE INDEX idx_dt_creat_etablissement
  ON etablissement ("dateCreationEtablissement");

CREATE INDEX idx_st_diffu_etablissement
  ON etablissement ("statutDiffusionEtablissement");

CREATE INDEX idx_tr_effect_etablissement
  ON etablissement ("trancheEffectifsEtablissement");

CREATE INDEX idx_code_postal_etablissement
  ON etablissement ("codePostalEtablissement");

CREATE INDEX idx_code_commune_etablissement
  ON etablissement ("codeCommuneEtablissement");

CREATE INDEX idx_activi_princ_etablissement
  ON etablissement ("activitePrincipaleEtablissement");

CREATE INDEX idx_code_pays_etr_etablissement
  ON etablissement ("codePaysEtrangerEtablissement");

select now() as "Début de crétion des index sur la table etablissement";
