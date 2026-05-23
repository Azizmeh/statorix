drop table activite_all;

create table activite_all as 
(
	select libelle, 'NAFRev2' as nomenclature from activite_hierarchie where niveau=4
	union
	select libelle, 'NAFRev1' as nomenclature from rev1_hierarchie where niveau=4
	union
	select libelle, 'NAF1993' as nomenclature from rev1993_hierarchie where niveau=4
	union 
	select libelle, 'NAP' as nomenclature from nap_hierarchie where niveau=3
);

drop table activite_all_fusion;

create table activite_all_fusion as
(
SELECT 
    libelle,
    STRING_AGG(nomenclature, ', ' ORDER BY nomenclature) AS nomenclatures
FROM activite_all
GROUP BY libelle
ORDER BY libelle
);