
-- D'affichage des informations du client 'Arad Joe'
SELECT * 
FROM Client
WHERE nom='Joe';

-- Selection du stock  d'olives disponilbles dans l'établissement 'PIZZA07'
SELECT Ingredient.nom AS Ingredient, Stock.quantite AS Stock
FROM Stock
INNER JOIN Etablissement ON Etablissement.id=Stock.etablissement_id
INNER JOIN Ingredient ON Ingredient.id=Stock.ingredient_id
WHERE Etablissement.nom='PIZZA07';


--Selection du poids des ingrédients composant une pizza REINE
SELECT Ingredient.nom as Ingredient, Recette.quantite*Ingredient.poids AS Poids 
FROM Recette
INNER JOIN Pizza ON Pizza.nom=Recette.nom_pizza
INNER JOIN Ingredient ON Ingredient.id=Recette.ingredient_id
WHERE nom_pizza = 'REINE';

-- Selection des informations d'une commande
SELECT date, statut, nom_pizza, CONCAT_WS(' ', Client.nom, Client.prenom) AS client, CONCAT_WS(' ',Preparateur.nom, Preparateur.prenom) AS preparateur, 
		CONCAT_WS(' ', Livreur.nom, Livreur.prenom) AS livreur, CONCAT_WS(' ', Vendeur.nom, Vendeur.prenom)  AS vendeur
FROM Commande
INNER JOIN Employe AS Preparateur ON Preparateur.id=Commande.preparateur_id
INNER JOIN Employe AS Livreur ON Livreur.id=Commande.livreur_id
INNER JOIN Employe AS Vendeur ON Vendeur.id=Commande.vendeur_id
INNER JOIN Client ON Client.id=Commande.client_id
WHERE Client.nom='Ali';

