use companyClient;

CREATE TABLE Client (
    client_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(255) UNIQUE,
    mot_de_passe VARCHAR(255),
    adresse VARCHAR(255),
    code_postal VARCHAR(20),
    ville VARCHAR(100),
    pays VARCHAR(100)
);

CREATE TABLE Commande (
    commande_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    date_commande TIMESTAMP,
    total DECIMAL(10, 2),
    statut ENUM('En cours', 'Expédiée', 'Annulée'),
    FOREIGN KEY (client_id) REFERENCES Client(client_id)
);

CREATE TABLE Produit (
    produit_id INT PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100),
    description TEXT,
    prix DECIMAL(10, 2),
    stock INT
);

CREATE TABLE Detail_Commande (
    detail_commande_id INT PRIMARY KEY AUTO_INCREMENT,
    commande_id INT,
    produit_id INT,
    quantite INT,
    prix_unitaire DECIMAL(10, 2),
    total DECIMAL(10, 2),
    FOREIGN KEY (commande_id) REFERENCES Commande(commande_id),
    FOREIGN KEY (produit_id) REFERENCES Produit(produit_id)
);


# insertion de données dans la base de données

-- Insertion des clients
INSERT INTO Client (nom, prenom, email, mot_de_passe, adresse, code_postal, ville, pays) VALUES
('Dupont', 'Jean', 'jean.dupont@example.com', 'mdp123', '123 rue de la Liberté', '75001', 'Paris', 'France'),
('Martin', 'Marie', 'marie.martin@example.com', 'motdepasse', '456 avenue des Champs', '69002', 'Lyon', 'France'),
('Doe', 'John', 'john.doe@example.com', 'secret123', '789 boulevard Voltaire', '13001', 'Marseille', 'France');

-- Insertion des produits
INSERT INTO Produit (nom, description, prix, stock) VALUES
('Ordinateur portable', 'Ordinateur portable avec écran 15 pouces', 899.99, 50),
('Smartphone', 'Smartphone avec écran OLED et caméra haute résolution', 699.99, 100),
('Tablette', 'Tablette tactile avec stylet et clavier détachable', 499.99, 75);

-- Insertion des commandes
INSERT INTO Commande (client_id, date_commande, total, statut) VALUES
(1, '2024-03-01 10:30:00', 899.99, 'Expédiée'),
(2, '2024-03-02 11:45:00', 1399.98, 'En cours'),
(3, '2024-03-03 12:15:00', 1499.97, 'En cours');

-- Insertion des détails de commande
-- Pour chaque commande, insérer des détails de commande liés aux produits
-- Exemple pour la commande 1
INSERT INTO Detail_Commande (commande_id, produit_id, quantite, prix_unitaire, total) VALUES
(1, 1, 1, 899.99, 899.99), -- Ordinateur portable
(1, 2, 2, 699.99, 1399.98); -- Smartphone

-- Exemple pour la commande 2
INSERT INTO Detail_Commande (commande_id, produit_id, quantite, prix_unitaire, total) VALUES
(2, 2, 1, 699.99, 699.99), -- Smartphone
(2, 3, 2, 499.99, 999.98); -- Tablette

-- Exemple pour la commande 3
INSERT INTO Detail_Commande (commande_id, produit_id, quantite, prix_unitaire, total) VALUES
(3, 1, 2, 899.99, 1799.98), -- Ordinateur portable
(3, 3, 1, 499.99, 499.99); -- Tablette

SELECT * FROM Client dc ;

## Selection

SELECT p.nom, dc.quantite, dc.total 
FROM Detail_Commande dc
JOIN Produit p ON dc.produit_id = p.produit_id;


SELECT SUM(stock) AS total_produits_en_stock FROM Produit;
