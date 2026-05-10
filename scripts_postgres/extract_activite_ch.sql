\copy
(
SELECT  
libelle as activite,
libelle_niv3 as classe
from activite_hierarchie
where niveau=4
union
select 'Non renseigné', 'Non renseigné'
)
to activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv3 as classe,
libelle_niv2 as groupe
from activite_hierarchie
where niveau=3
union
select 'Non renseigné', 'Non renseigné'
)
to classe_activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv2 as groupe,
libelle_niv1 as division
from activite_hierarchie
where niveau=2
union
select 'Non renseigné', 'Non renseigné'
)
to groupe_activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv1 as division,
libelle_niv0 as section
from activite_hierarchie
where niveau=1
union
select 'Non renseigné', 'Non renseigné'
)
to division_activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv0 as section
from activite_hierarchie
where niveau=0
union
select 'Non renseigné'
)
to section_activite.csv csv HEADER delimiter ';'
;
