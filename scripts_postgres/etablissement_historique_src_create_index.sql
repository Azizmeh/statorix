CREATE INDEX idx_ch_etat_admi ON etablissement_historique_src USING btree ("changementEtatAdministratifEtablissement");
CREATE INDEX idx_dt_fin ON etablissement_historique_src USING btree ("dateFin");
CREATE INDEX idx_etat_admi ON etablissement_historique_src USING btree ("etatAdministratifEtablissement");
CREATE INDEX idx_eth_siret ON etablissement_historique_src USING btree (siret);
CREATE INDEX idx_hist_filtre ON etablissement_historique_src USING btree (siret) WHERE ((("etatAdministratifEtablissement")::text = 'F'::text) AND ("changementEtatAdministratifEtablissement" IS TRUE));
CREATE INDEX idx_hist_siret_etat ON etablissement_historique_src USING btree (siret, "etatAdministratifEtablissement", "changementEtatAdministratifEtablissement");