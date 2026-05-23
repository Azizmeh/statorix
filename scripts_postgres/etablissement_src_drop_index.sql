select now() as "Début de suppression des index de la table etablissement_src";

ALTER TABLE etablissement_src
  DROP CONSTRAINT pk_etablissement;

DROP INDEX idx_etatadmin_etablissement;  

DROP INDEX idx_siren_etablissement;

DROP INDEX idx_dt_creat_etablissement;

DROP INDEX idx_st_diffu_etablissement;

DROP INDEX idx_tr_effect_etablissement;

DROP INDEX idx_code_postal_etablissement;

DROP INDEX idx_code_commune_etablissement;

DROP INDEX idx_activi_princ_etablissement;

DROP INDEX idx_code_pays_etr_etablissement;

select now() as "Fin de suppression des index de la table etablissement_src";
