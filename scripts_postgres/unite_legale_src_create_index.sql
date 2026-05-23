
ALTER TABLE unite_legale_src
  ADD CONSTRAINT pk_unite_legale_src PRIMARY KEY (siren);

CREATE INDEX idx_etatadmin_unite_legale
  ON unite_legale_src ("etatAdministratifUniteLegale");  

