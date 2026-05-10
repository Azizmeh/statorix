
ALTER TABLE unite_legale
  ADD CONSTRAINT pk_unite_legale PRIMARY KEY (siren);

CREATE INDEX idx_etatadmin_unite_legale
  ON unite_legale ("etatAdministratifUniteLegale");  

