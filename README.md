# 📌 Présentation du Projet

Ce projet met en pratique des compétences SQL essentielles pour explorer, nettoyer et analyser des données de vente au détail. L'objectif est de construire une base de données, d'appliquer des techniques d'analyse et d'extraire des insights business grâce à des requêtes SQL.

# 🎯 Objectifs

✅ Créer une base de données de ventes au détail : Structurer et alimenter la base avec des données de ventes.

✅ Nettoyage des données : Identifier et supprimer les enregistrements contenant des valeurs nulles ou incohérentes.

✅ Exploration des données : Effectuer une analyse exploratoire (EDA) pour mieux comprendre le dataset.

✅ Analyse commerciale : Répondre à des questions stratégiques sur les ventes, la rentabilité et la fidélité client grâce à SQL.

# 📂 Structure de la Base de Données

```

CREATE TABLE Vente_Boutique (
    ID_commande TEXT, 	
    Date_commande DATE,
    Date_livraison DATE,
    Mode_livraison TEXT,
    ID_client VARCHAR(8),
    Segment VARCHAR(11),
    Ville VARCHAR(17),	
    Pays TEXT,	
    Region TEXT,
    ID_Produit VARCHAR(15),
    Categorie TEXT,	
    Nom_produit TEXT,	
    CA REAL,
    Quantite INT,	
    Remise REAL,	
    Profit REAL
);

```


# 🔍 Exploration des Données

Avant de répondre aux questions business, nous effectuons une analyse préliminaire pour mieux comprendre la base de données :

#### 1. Nombre total d’enregistrements dans la base de données
📌 Objectif : Vérifier le volume de données disponibles pour l’analyse.

```

SELECT COUNT(*) FROM Vente_Boutique

```

#### 2. Nombre de clients uniques
📌 Objectif : Identifier la diversité de la clientèle et analyser la fidélité.

```

SELECT COUNT(DISTINCT ID_client) FROM Vente_Boutique;

```

#### 3. Les différents segments de clients
📌 Objectif : Comprendre les types de clients et adapter l’analyse par segment.

```
SELECT DISTINCT Segment FROM Vente_Boutique;
```


#### 4. Distribution des ventes et des profits
📌 Objectif : Avoir une idée des ventes moyennes et de la rentabilité globale.

```

SELECT AVG(CA) AS CA_moyen, AVG(Profit) AS Profit_moyen FROM Vente_Boutique;

```




# 📈 Analyse Business

#### 1. Quels sont les 10 clients ayant généré le plus de revenus ?
📌 Objectif : Identifier les clients à fort potentiel pour des stratégies de fidélisation.

```
SELECT ID_client, SUM(CA) AS Revenu_total
FROM Vente_Boutique
GROUP BY ID_client
ORDER BY SUM(CA) DESC
LIMIT 10;

```


#### 2. Récupérer toutes les transactions où la catégorie est 'Furniture' et la quantité vendue est supérieure à 4 au cours du mois de décembre 2013.
📌 📌 Objectif : Analyser les performances des produits de la catégorie Furniture et ajuster les stocks.
```

SELECT * 
FROM Vente_Boutique
WHERE Categorie = 'Furniture'
AND Quantite > 4
AND Date_commande BETWEEN '2013/12/01' AND '2013/12/31';

```

#### 3. Calculer le total des ventes pour chaque catégorie

📌 Objectif : Identifier les modes d’expédition à optimiser pour améliorer la satisfaction client.

```

SELECT Categorie, SUM(CA) AS Total_vente
FROM Vente_Boutique
GROUP BY Categorie;

```


#### 4. Quel mode d’expédition entraîne les délais les plus longs ?

📌 Objectif : Adapter les stratégies de vente et marketing aux segments les plus rentables.

```
SELECT Segment, SUM(Quantite) AS Quantite_vendue, SUM(Profit) AS Profit_total
FROM Vente_Boutique
GROUP BY Segment
ORDER BY Profit_total DESC;

```


#### 5. Quel segment de clients génère le plus de profit et de volume de ventes ?
📌 Objectif : Identifier les segments clients les plus rentables et optimiser la stratégie commerciale.

```

SELECT Segment, SUM(Quantite) AS Quantite_vendu, SUM(Profit) AS Profit_effectué
FROM Vente_Boutique
GROUP BY Segment
ORDER BY Profit_effectué DESC
LIMIT 1;

```


#### 6 . Nombre total de commandes par segment et région 

📌 Objectif : Repérer les régions et segments de marché les plus dynamiques.

```

SELECT Segment, Region, COUNT(*) AS Total_commandes
FROM Vente_Boutique
GROUP BY Segment, Region
ORDER BY 3 DESC;


```



#### 7 . Quelles sont les régions ayant un profit total supérieur à la moyenne, triées par profit décroissant ?

📌 Objectif : Repérer les régions et segments de marché les plus dynamiques.

```

SELECT Region, SUM(Profit) AS Profit_total
FROM Vente_Boutique
GROUP BY Region
HAVING SUM(Profit) > (SELECT AVG(Profit_total) FROM (
    SELECT SUM(Profit) AS Profit_total FROM Vente_Boutique GROUP BY Region
) AS Subquery)
ORDER BY Profit_total DESC;

```
