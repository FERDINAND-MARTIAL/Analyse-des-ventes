Create table Vente_Boutique
(
	ID_commande text, 	
	Date_commande Date,
	Date_livraison Date,
	Mode_livraison Text,
	ID_client varchar(8),
	Segment varchar(11),
	Ville varchar(17),	
	Pays Text,	
	Region Text,
	ID_Produit varchar(15),
	Categorie Text,	
	Nom_produit Text,	
	CA real,
	Quantite int,	
	Remise real,	
	Profit real
);

select * from Vente_Boutique

-- Exploration des données

"Combien y a-t-il d’enregistrements dans la base de données ?"
Select count (*) from Vente_Boutique

"Combien y a-t-il de clients uniques dans la base de données ?"
Select distinct(ID_client) from Vente_Boutique

"Quelles sont les différents segments de clients ?"
Select distinct(Segment) from Vente_Boutique

"Quelle est la distribution des ventes et des profits ?"
Select AVG (CA) from Vente_Boutique


-- Questions business 

"Quels sont les 10 clients ayant généré le plus de revenus ? "
Select ID_client, sum(CA) as Revenu_total
From Vente_Boutique
Group by ID_client
order by sum(CA) desc
Limit 10


"Récupérer toutes les transactions où la catégorie est : Furniture
et la quantité vendue est supérieure à 4 au cours du mois de décembre 2013."

Select * 
from Vente_Boutique
where Categorie = 'Furniture'
and Quantite > 4
and Date_commande BETWEEN '2013/12/01' and '2013/12/31'


"calcule le total des ventes pour chaque catégorie"
Select Categorie, sum (CA) as total_vente
from Vente_Boutique
Group by Categorie


"Quel mode d’expédition entraîne les délais les plus longs"

Select Mode_livraison, sum(Date_livraison-Date_commande) as Délai_livraison
from Vente_Boutique
Group by Mode_livraison

"Quel segment de clients (consommateurs, entreprises, PME) génère 
le plus de profit et de volume de ventes ?"

Select segment, sum(quantite) as quantité_vendu, sum(profit) as profit_effectué
from Vente_Boutique
Group by segment
order by profit_effectué desc
limit 1


"Ecrivez une requête SQL pour trouver le nombre total de commandes (ID_commande) 
effectuées par segment client dans chaque region"
Select segment, categorie, count (*) as Total_commandes
from Vente_Boutique
Group by segment, categorie 
Order by 3 desc


"Quelles sont les régions ayant un profit total supérieur à la moyenne, 
triées par profit décroissant ?"
Select region, sum(profit) as Profit_total
from Vente_Boutique
Group by region
Having sum(profit) > (select avg(Profit_total) from (
select sum(profit) as Profit_total from Vente_Boutique Group by Region))
Order by 2 desc



