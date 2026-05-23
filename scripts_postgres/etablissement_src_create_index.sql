select now() as "Début de crétion des index sur la table etablissement_src";

ALTER TABLE etablissement_src
  ADD CONSTRAINT pk_etablissement PRIMARY KEY (siret);

CREATE INDEX idx_etatadmin_etablissement
  ON etablissement_src ("etatAdministratifEtablissement");  

CREATE INDEX idx_siren_etablissement
  ON etablissement_src (siren);

CREATE INDEX idx_dt_creat_etablissement
  ON etablissement_src ("dateCreationEtablissement");

CREATE INDEX idx_st_diffu_etablissement
  ON etablissement_src ("statutDiffusionEtablissement");

CREATE INDEX idx_tr_effect_etablissement
  ON etablissement_src ("trancheEffectifsEtablissement");

CREATE INDEX idx_code_postal_etablissement
  ON etablissement_src ("codePostalEtablissement");

CREATE INDEX idx_code_commune_etablissement
  ON etablissement_src ("codeCommuneEtablissement");

CREATE INDEX idx_activi_princ_etablissement
  ON etablissement_src ("activitePrincipaleEtablissement");

CREATE INDEX idx_code_pays_etr_etablissement
  ON etablissement_src ("codePaysEtrangerEtablissement");

select now() as "Début de crétion des index sur la table etablissement_src";
