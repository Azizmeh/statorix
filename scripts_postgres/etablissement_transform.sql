drop view v_etablissement ;
drop table tmp_cloture ;
drop table etablissement_ferme;
drop table etablissement_actif;

CREATE TABLE tmp_cloture AS
SELECT
  siret,
  "dateDebut"
FROM etablissement_historique_src
WHERE "changementEtatAdministratifEtablissement" IS TRUE
  AND "etatAdministratifEtablissement" = 'F'
  AND "dateFin" IS null
  and "dateDebut" >= to_date('20200101','yyyymmdd');

CREATE unique INDEX idx_tmp_cloture ON tmp_cloture(siret);

CREATE TABLE etablissement_ferme AS
SELECT 
  e.siret,
  e."dateCreationEtablissement" as "dateCreationEtablissement",
  date_part('year',e."dateCreationEtablissement")::int as "anneeCreationEtablissement",
  date_part('month',e."dateCreationEtablissement")::int as "moisCreationEtablissement",
  te.libelle as "trancheEffectifsEtablissement",
  teul.libelle as "trancheEffectifsUniteLegale",
  e."etablissementSiege" as "etablissementSiege",
  e."codePostalEtablissement" as "codePostalEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('COM', p.code)
  else c.code
  end as "codeCommuneEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Commune générique pour ', p.nom)
  else c.nom 
  end as "communeEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('DEP', p.code)
  else d.code 
  end as "codeDepartementEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Département générique pour ', p.nom)
  else d.nom 
  end as "departementEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('REG', p.code)
  else r.code
  end as "codeRegionEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Région générique pour ', p.nom)
  else r.nom 
  end as "regionEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then p.nom
  else 'France' 
  end as "paysEtablissement",
  a.libelle as "activitePrincipaleEtablissement",
  a4.libelle as "sectionActivitePrincipaleEtablissement",
  aul.libelle as "activitePrincipaleUniteLegale",
  aul4.libelle as "sectionActivitePrincipaleUniteLegale",
  cj.libelle as "categorieJuridiqueUniteLegale",
  cj1.libelle as "classeCategorieJuridiqueUniteLegale",
  ce.libelle as "categorieEntreprise",
  t."dateDebut" AS "dateClotureEtablissement",
  date_part('year',t."dateDebut") as "anneeClotureEtablissement",
  date_part('month',t."dateDebut") as "moisClotureEtablissement"
FROM etablissement_src e
JOIN tmp_cloture t ON t.siret = e.siret
left join tranche_effectifs te on te.code = e."trancheEffectifsEtablissement" 
left join commune c on c.code = e."codeCommuneEtablissement" 
left join departement d on d.code=c.code_departement
left join region r on r.code=d.code_region
left join activite a on a.code=e."activitePrincipaleEtablissement"
left join activite a1 on a1.code=a.code_parent
left join activite a2 on a2.code=a1.code_parent
left join activite a3 on a3.code=a2.code_parent
left join activite a4 on a4.code=a3.code_parent
left join unite_legale_src ul on ul.siren=e.siren
left join tranche_effectifs teul on teul.code = ul."trancheEffectifsUniteLegale"
left join activite aul on aul.code=ul."activitePrincipaleUniteLegale"
left join activite aul1 on aul1.code=aul.code_parent
left join activite aul2 on aul2.code=aul1.code_parent
left join activite aul3 on aul3.code=aul2.code_parent
left join activite aul4 on aul4.code=aul3.code_parent
left join categorie_juridique cj on cj.code=ul."categorieJuridiqueUniteLegale"
left join categorie_juridique cj1 on cj1.code=cj.code_parent
left join categorie_entreprise ce on ce.code=ul."categorieEntreprise"
left join pays p on p.code=e."codePaysEtrangerEtablissement"
where e."etatAdministratifEtablissement"='F';


CREATE TABLE etablissement_actif AS
SELECT 
  e.siret,
  e."dateCreationEtablissement" as "dateCreationEtablissement",
  date_part('year',e."dateCreationEtablissement")::int as "anneeCreationEtablissement",
  date_part('month',e."dateCreationEtablissement")::int as "moisCreationEtablissement",
  te.libelle as "trancheEffectifsEtablissement",
  teul.libelle as "trancheEffectifsUniteLegale",
  e."etablissementSiege" as "etablissementSiege",
  e."codePostalEtablissement" as "codePostalEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('COM', p.code)
  else c.code
  end as "codeCommuneEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Commune générique pour ', p.nom)
  else c.nom 
  end as "communeEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('DEP', p.code)
  else d.code 
  end as "codeDepartementEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Département générique pour ', p.nom)
  else d.nom 
  end as "departementEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('REG', p.code)
  else r.code
  end as "codeRegionEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Région générique pour ', p.nom)
  else r.nom 
  end as "regionEtablissement",
  case 
  when e."codeCommuneEtablissement" is null then p.nom
  else 'France' 
  end as "paysEtablissement",
  a.libelle as "activitePrincipaleEtablissement",
  a4.libelle as "sectionActivitePrincipaleEtablissement",
  aul.libelle as "activitePrincipaleUniteLegale",
  aul4.libelle as "sectionActivitePrincipaleUniteLegale",
  cj.libelle as "categorieJuridiqueUniteLegale",
  cj1.libelle as "classeCategorieJuridiqueUniteLegale",
  ce.libelle as "categorieEntreprise",
  null::date AS "dateClotureEtablissement",
  null::int as "anneeClotureEtablissement",
  null::int as "moisClotureEtablissement"
FROM etablissement_src e
left join tranche_effectifs te on te.code = e."trancheEffectifsEtablissement" 
left join commune c on c.code = e."codeCommuneEtablissement" 
left join departement d on d.code=c.code_departement
left join region r on r.code=d.code_region
left join activite a on a.code=e."activitePrincipaleEtablissement"
left join activite a1 on a1.code=a.code_parent
left join activite a2 on a2.code=a1.code_parent
left join activite a3 on a3.code=a2.code_parent
left join activite a4 on a4.code=a3.code_parent
left join unite_legale_src ul on ul.siren=e.siren
left join tranche_effectifs teul on teul.code = ul."trancheEffectifsUniteLegale"
left join activite aul on aul.code=ul."activitePrincipaleUniteLegale"
left join activite aul1 on aul1.code=aul.code_parent
left join activite aul2 on aul2.code=aul1.code_parent
left join activite aul3 on aul3.code=aul2.code_parent
left join activite aul4 on aul4.code=aul3.code_parent
left join categorie_juridique cj on cj.code=ul."categorieJuridiqueUniteLegale"
left join categorie_juridique cj1 on cj1.code=cj.code_parent
left join categorie_entreprise ce on ce.code=ul."categorieEntreprise"
left join pays p on p.code = e."codePaysEtrangerEtablissement"
where e."etatAdministratifEtablissement"='A';

create or replace view v_etablissement as 
select 'Actif'::varchar(1) as etat, * from etablissement_actif
union
select 'Fermé'::varchar(1) as etat, * from etablissement_ferme
;





