\copy
(
SELECT  
libelle as "categorieJuridique",
libelle_niv1 as "classeCategorieJuridique"
from categorie_juridique_hierarchie
where niveau=2
union
select 'Non renseigné', 'Non renseigné'
)
to categorie_juridique.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv1 as classe,
libelle_niv0 as "superClasse"
from categorie_juridique_hierarchie
where niveau=1
union
select 'Non renseigné', 'Non renseigné'
)
to classe_categorie_juridique.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv0 as "superClasse"
from categorie_juridique_hierarchie
where niveau=0
union
select 'Non renseigné'
)
to super_classe_categorie_juridique.csv csv HEADER delimiter ';'
;


