drop view v_etablissement ;
drop table tmp_cloture ;
drop table etablissement_ferme;
drop table etablissement_actif;


CREATE TABLE tmp_cloture AS
SELECT
  siret,
  "dateDebut"
FROM etablissement_historique
WHERE "changementEtatAdministratifEtablissement" IS TRUE
  AND "etatAdministratifEtablissement" = 'F'
  AND "dateFin" IS null
  and "dateDebut" >= to_date('20210101','yyyymmdd');

CREATE unique INDEX idx_tmp_cloture ON tmp_cloture(siret);

CREATE TABLE etablissement_ferme AS
SELECT 
  e.siret,
  e."dateCreationEtablissement" as "dateCreation",
  date_part('year',e."dateCreationEtablissement")::int as "anneeCreation",
  date_part('month',e."dateCreationEtablissement")::int as "moisCreation",
  te.libelle as "trancheEffectif",
  e."etablissementSiege" as "etablissementSiege",
  e."codePostalEtablissement" as "codePostal",
  case 
  when e."codeCommuneEtablissement" is null then concat('COM', p.code)
  else c.code
  end as "codeCommune",
  case 
  when e."codeCommuneEtablissement" is null then concat('Commune générique pour ', p.nom)
  else c.nom 
  end as commune,
  case 
  when e."codeCommuneEtablissement" is null then concat('DEP', p.code)
  else d.code 
  end as "codeDepartement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Département générique pour ', p.nom)
  else d.nom 
  end as departement,
  case 
  when e."codeCommuneEtablissement" is null then concat('REG', p.code)
  else r.code
  end as "codeRegion",
  case 
  when e."codeCommuneEtablissement" is null then concat('Région générique pour ', p.nom)
  else r.nom 
  end as region,
  case 
  when e."codeCommuneEtablissement" is null then p.nom
  else 'France' 
  end as pays,
  a.libelle as activite,
  a1.libelle as "classeActivite",
  a2.libelle as "groupeActivite",
  a3.libelle as "divisionActivite",
  a4.libelle as "sectionActivite",
  cj.libelle as "categorieJuridique",
  cj1.libelle as "classeCategorieJuridique",
  cj2.libelle as "superClasseCategorieJuridique",
  ce.libelle as "categorieEntreprise",
  t."dateDebut" AS "dateCloture",
  date_part('year',t."dateDebut") as "anneeCloture",
  date_part('month',t."dateDebut") as "moisCloture"
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
left join categorie_juridique cj on cj.code=ul."categorieJuridiqueUniteLegale"
left join categorie_juridique cj1 on cj1.code=cj.code_parent
left join categorie_juridique cj2 on cj2.code=cj1.code_parent
left join categorie_entreprise ce on ce.code=ul."categorieEntreprise"
left join pays p on p.code=e."codePaysEtrangerEtablissement"
where e."etatAdministratifEtablissement"='F';


CREATE TABLE etablissement_actif AS
SELECT 
  e.siret,
  e."dateCreationEtablissement" as "dateCreation",
  date_part('year',e."dateCreationEtablissement")::int as "anneeCreation",
  date_part('month',e."dateCreationEtablissement")::int as "moisCreation",
  te.libelle as "trancheEffectif",
  e."etablissementSiege" as "etablissementSiege",
  e."codePostalEtablissement" as "codePostal",
  case 
  when e."codeCommuneEtablissement" is null then concat('COM', p.code)
  else c.code
  end as "codeCommune",
  case 
  when e."codeCommuneEtablissement" is null then concat('Commune générique pour ', p.nom)
  else c.nom 
  end as commune,
  case 
  when e."codeCommuneEtablissement" is null then concat('DEP', p.code)
  else d.code 
  end as "codeDepartement",
  case 
  when e."codeCommuneEtablissement" is null then concat('Département générique pour ', p.nom)
  else d.nom 
  end as departement,
  case 
  when e."codeCommuneEtablissement" is null then concat('REG', p.code)
  else r.code
  end as "codeRegion",
  case 
  when e."codeCommuneEtablissement" is null then concat('Région générique pour ', p.nom)
  else r.nom 
  end as region,
  case 
  when e."codeCommuneEtablissement" is null then p.nom
  else 'France' 
  end as pays,
  a.libelle as activite,
  a1.libelle as "classeActivite",
  a2.libelle as "groupeActivite",
  a3.libelle as "divisionActivite",
  a4.libelle as "sectionActivite",
  cj.libelle as "categorieJuridique",
  cj1.libelle as "classeCategorieJuridique",
  cj2.libelle as "superClasseCategorieJuridique",
  ce.libelle as "categorieEntreprise",
  null::date AS "dateCloture",
  null::int as "anneeCloture",
  null::int as "moisCloture"
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
left join categorie_juridique cj on cj.code=ul."categorieJuridiqueUniteLegale"
left join categorie_juridique cj1 on cj1.code=cj.code_parent
left join categorie_juridique cj2 on cj2.code=cj1.code_parent
left join categorie_entreprise ce on ce.code=ul."categorieEntreprise"
left join pays p on p.code = e."codePaysEtrangerEtablissement"
where e."etatAdministratifEtablissement"='A';

create or replace view v_etablissement as 
select 'Actif'::varchar(1) as etat, * from etablissement_actif
union
select 'Fermé'::varchar(1) as etat, * from etablissement_ferme
;






