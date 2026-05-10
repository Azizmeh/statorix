select now() as "Début update etablissement";

update etablissement set "codeCommuneEtablissement"='COM'||"codePaysEtrangerEtablissement"
where "codePaysEtrangerEtablissement" is not null and "codeCommuneEtablissement" is null; 


select now() as "Fin update etablissement";