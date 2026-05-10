\copy
(
SELECT  
libelle as activite,
libelle_niv3 as "classeActivite",
libelle_niv2 as "groupeActivite",
libelle_niv1 as "divisionActivite",
libelle_niv0 as "sectionActivite"
from activite_hierarchie
where niveau=4
union
select 'Non renseigné', 'Non renseigné', 'Non renseigné', 'Non renseigné', 'Non renseigné'
)
to activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv3 as "classeActivite",
libelle_niv2 as "groupeActivite",
libelle_niv1 as "divisionActivite",
libelle_niv0 as "sectionActivite"
from activite_hierarchie
where niveau=3
union
select 'Non renseigné', 'Non renseigné', 'Non renseigné', 'Non renseigné'
)
to classe_activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv2 as "groupeActivite",
libelle_niv1 as "divisionActivite",
libelle_niv0 as "sectionActivite"
from activite_hierarchie
where niveau=2
union
select 'Non renseigné', 'Non renseigné', 'Non renseigné'
)
to groupe_activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv1 as "divisionActivite",
libelle_niv0 as "sectionActivite"
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
libelle_niv0 as "sectionActivite"
from activite_hierarchie
where niveau=0
union
select 'Non renseigné'
)
to section_activite.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle as "categorieJuridique",
libelle_niv1 as "classeCategorieJuridique",
libelle_niv0 as "superClasseCategorieJuridique"
from categorie_juridique_hierarchie
where niveau=2
union
select 'Non renseigné', 'Non renseigné', 'Non renseigné'
)
to categorie_juridique.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle_niv1 as "classeCategorieJuridique",
libelle_niv0 as "superClasseCategorieJuridique"
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
libelle_niv0 as "superClasseCategorieJuridique"
from categorie_juridique_hierarchie
where niveau=0
union
select 'Non renseigné'
)
to super_classe_categorie_juridique.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
libelle as "categorieEntreprise"
from categorie_entreprise
union
select 'Non renseigné'
)
to categorie_entreprise.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
nom as pays
from pays
)
to pays.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
r.nom as region,
p.nom as pays
from region r, pays p
where r.code_pays=p.code
)
to region.csv csv HEADER delimiter ';'
;

\copy
(
SELECT  
d.nom as departement,
r.nom as region,
p.nom as pays
from departement d,region r, pays p
where d.code_region=r.code and r.code_pays=p.code
)
to departement.csv csv HEADER delimiter ';'
;
