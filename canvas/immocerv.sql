-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 31 juil. 2024 à 11:44
-- Version du serveur : 10.4.22-MariaDB
-- Version de PHP : 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `immocerv`
--

-- --------------------------------------------------------

--
-- Structure de la table `actionnaire`
--

CREATE TABLE `actionnaire` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `prenom` varchar(45) DEFAULT NULL,
  `cin` varchar(45) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `adresse` varchar(255) NOT NULL,
  `descriptif` varchar(255) NOT NULL,
  `Societe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `agence`
--

CREATE TABLE `agence` (
  `id` int(11) NOT NULL,
  `nom` varchar(45) DEFAULT NULL,
  `adresse` varchar(45) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  `code` varchar(255) NOT NULL,
  `Reseau_id` int(11) NOT NULL,
  `ville_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `agence`
--

INSERT INTO `agence` (`id`, `nom`, `adresse`, `tel`, `code`, `Reseau_id`, `ville_id`) VALUES
(2, 'Kenitra Centrale', '1267,haynassim, rabat', 567894067, '', 2, 13),
(3, 'Casa Principale', '124, casa', 598647562, '', 1, 13),
(4, 'Casa Emile Zola.', '908, khrob, casablanca', 678943250, '', 1, 13),
(5, 'Romandie', '6789,casa', 567894532, '', 1, 13),
(6, 'CIH Mohammedia Nord', 'BD tachfine Rue 01', 523443433, '', 4, 13);

-- --------------------------------------------------------

--
-- Structure de la table `commentaireprojet`
--

CREATE TABLE `commentaireprojet` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `commentaire` varchar(45) DEFAULT NULL,
  `Projet_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `composition`
--

CREATE TABLE `composition` (
  `id` int(11) NOT NULL,
  `superficieMoyenne` varchar(45) DEFAULT NULL,
  `prixMoyen` double DEFAULT NULL,
  `nombre` int(11) NOT NULL,
  `Projet_id` int(11) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `typeComposition_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `composition`
--

INSERT INTO `composition` (`id`, `superficieMoyenne`, `prixMoyen`, `nombre`, `Projet_id`, `icon`, `typeComposition_id`) VALUES
(2, '75', 16500, 0, 1, '../img/commerce.png', 4),
(4, '301', 18500, 0, 3, '../img/villa.png', 2),
(5, '120', 23000, 0, 5, '../img/immeuble.png', 1),
(6, '24', 32000, 0, 6, '../img/studio.png', 3),
(7, '300', 15000, 0, 4, '../img/r.png', 8),
(8, '95', 15500, 0, 1, '../img/immeuble.png', 1),
(9, '120', 17000, 0, 7, '../img/r.png', 8),
(10, '500', 19300, 0, 8, '../img/r.png', 11),
(11, '300', 12000, 0, 10, '../img/bureau.png', 5),
(12, '300', 12000, 0, 5, '../img/r.png', 10),
(13, '54', 17000, 0, 6, '../img/r.png', 11),
(14, '300', 9000, 0, 11, '../img/r.png', 11),
(15, '343', 12000, 0, 9, '../img/villa.png', 6),
(16, '343', 12000, 0, 9, '../img/r.png', 8);

-- --------------------------------------------------------

--
-- Structure de la table `deblocage`
--

CREATE TABLE `deblocage` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `montant` double NOT NULL,
  `taux` double NOT NULL,
  `img_url` varchar(255) COLLATE utf8mb4_roman_ci NOT NULL,
  `dossierdecredit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_roman_ci;

--
-- Déchargement des données de la table `deblocage`
--

INSERT INTO `deblocage` (`id`, `date`, `montant`, `taux`, `img_url`, `dossierdecredit_id`) VALUES
(1, '2022-10-19', 300000, 0, '', 1),
(2, '2022-10-18', 100000, 0, '', 1),
(3, '2022-10-18', 354000, 0, '', 3),
(4, '2022-10-10', 532000, 0, '', 3),
(5, '2022-09-06', 454000, 0, '', 3),
(6, '2022-08-09', 554745, 0, '', 3),
(7, '2022-07-04', 78457, 0, '', 3),
(8, '2022-06-28', 754000, 0, '', 3),
(9, '2022-05-16', 54000, 0, '', 3);

-- --------------------------------------------------------

--
-- Structure de la table `directionregionale`
--

CREATE TABLE `directionregionale` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `directionregionale`
--

INSERT INTO `directionregionale` (`id`, `libelle`) VALUES
(1, 'Casa');

-- --------------------------------------------------------

--
-- Structure de la table `documentprojet`
--

CREATE TABLE `documentprojet` (
  `id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `typeDocument` varchar(45) DEFAULT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `Projet_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `dossierdecredit`
--

CREATE TABLE `dossierdecredit` (
  `id` int(11) NOT NULL,
  `dateAutorisation` date DEFAULT NULL,
  `dateEcheance` date DEFAULT NULL,
  `montantCredit` double DEFAULT NULL,
  `statut` varchar(45) DEFAULT NULL,
  `encours` double DEFAULT NULL,
  `objetFinancement` varchar(45) DEFAULT NULL,
  `numDossier` varchar(255) DEFAULT NULL,
  `Utilisateur_id` int(11) NOT NULL,
  `Agence_id` int(11) NOT NULL,
  `Projet_id` int(11) NOT NULL,
  `Statut_id` int(11) NOT NULL,
  `typeCredit_id` int(11) NOT NULL,
  `tauxCredit` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `dossierdecredit`
--

INSERT INTO `dossierdecredit` (`id`, `dateAutorisation`, `dateEcheance`, `montantCredit`, `statut`, `encours`, `objetFinancement`, `numDossier`, `Utilisateur_id`, `Agence_id`, `Projet_id`, `Statut_id`, `typeCredit_id`, `tauxCredit`) VALUES
(1, '2022-08-02', '2024-08-14', 15000000, 'En rembourssement', 1400000, 'Villa', '8', 1, 3, 3, 2, 1, 6),
(3, '2022-08-09', '2022-08-10', 120000000, 'En Déblocage', 345343, 'Commerce', '45', 1, 4, 1, 1, 1, 6),
(6, '2022-09-16', '2025-06-06', 1000000, 'En Deblocage', 789855, 'Immeuble', '780', 1, 3, 5, 1, 1, 6),
(7, '2022-09-08', '2022-10-13', 500000, 'En Deblocage', 459343, 'Lot R+4', '34', 1, 5, 4, 1, 1, 6),
(8, '2022-09-05', '2022-09-15', 14000000, 'En Deblocage', 12000000, 'Lot R+3', '34', 1, 5, 7, 1, 1, 6),
(9, '2022-09-01', '2022-09-23', 7000000, 'Cloture', 6840333, 'Lot Industriel', '34', 1, 4, 8, 3, 1, 6),
(10, '2022-10-02', '2022-10-13', 320000, 'En rembourssement', 345343, 'Studio', '34', 1, 2, 6, 2, 1, 6),
(11, '2022-10-02', '2022-10-03', 34999, 'En rembourssement', 345343, 'Bureau', '34', 1, 2, 10, 2, 1, 6),
(12, '2022-10-09', '2022-10-11', 320000, 'En rembourssement', 345343, 'Lot R+6', '34', 1, 6, 11, 2, 1, 6),
(13, '2022-09-08', '2022-10-11', 320000, 'En rembourssement', 345343, 'Lot R+3', '34', 1, 2, 9, 2, 1, 6);

-- --------------------------------------------------------

--
-- Structure de la table `gerant`
--

CREATE TABLE `gerant` (
  `id` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `Groupe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `groupe`
--

CREATE TABLE `groupe` (
  `id` int(11) NOT NULL,
  `if_groupe` varchar(45) DEFAULT NULL,
  `descriptif` varchar(45) DEFAULT NULL,
  `nomGroupe` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `groupe`
--

INSERT INTO `groupe` (`id`, `if_groupe`, `descriptif`, `nomGroupe`) VALUES
(1, '2', '3', 'Tazi'),
(2, '67F', '90KR', 'Aqua');

-- --------------------------------------------------------

--
-- Structure de la table `imageprojet`
--

CREATE TABLE `imageprojet` (
  `id` int(11) NOT NULL,
  `url` varchar(90) NOT NULL,
  `date` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Projet_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `imageprojet`
--

INSERT INTO `imageprojet` (`id`, `url`, `date`, `Projet_id`) VALUES
(1, '../img/projets/Commerceimg1.jpeg', '2022-10-03 19:16:03', 1),
(2, '../img/projets/r3img1.jpeg', '2022-10-03 19:21:19', 7),
(3, '../img/projets/studioimg1.jpeg', '2022-10-03 19:18:57', 6),
(4, '../img/projets/apparimg1.jpeg', '2022-10-03 19:19:46', 5),
(5, '../img/projets/villaimg1.jpeg', '2022-10-03 19:17:14', 3),
(6, '../img/projets/villaimg2.jpeg', '2022-10-03 19:17:26', 3),
(7, '../img/projets/apparimg2.jpeg', '2022-10-03 19:20:15', 5),
(8, '../img/projets/r3img2.jpeg', '2022-10-03 19:21:38', 7),
(9, '../img/projets/lotIndus1.jpeg', '2022-10-03 19:22:37', 8),
(10, '../img/projets/R+4.jpeg', '2022-10-04 15:32:30', 4);

-- --------------------------------------------------------

--
-- Structure de la table `parts_sociales`
--

CREATE TABLE `parts_sociales` (
  `id` int(11) NOT NULL,
  `societe_id` int(11) NOT NULL,
  `actionnaire_id` int(11) NOT NULL,
  `actionnaire` int(11) NOT NULL,
  `part` double NOT NULL,
  `gerant` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_roman_ci;

-- --------------------------------------------------------

--
-- Structure de la table `projet`
--

CREATE TABLE `projet` (
  `id` int(11) NOT NULL,
  `longitude` double DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `nombre` int(11) DEFAULT NULL,
  `superficieMoyenne` double DEFAULT NULL,
  `prixMoyen` double DEFAULT NULL,
  `Societe_id` int(11) NOT NULL,
  `nomProjet` varchar(50) NOT NULL DEFAULT '0',
  `typeProjet` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `projet`
--

INSERT INTO `projet` (`id`, `longitude`, `latitude`, `nombre`, `superficieMoyenne`, `prixMoyen`, `Societe_id`, `nomProjet`, `typeProjet`) VALUES
(1, -7.651082, 33.506311, 4, 55, 60, 1, 'Louise', 1),
(3, -7.639502, 33.555861, 3, 3, 4, 1, 'Aquarelle', 2),
(4, -7.647408, 33.59942, 45, 567890, 400000, 1, 'AN LUXURY', 4),
(5, -7.684387, 33.585798, 60, 5000000, 450000, 2, 'South Tower', 1),
(6, -6.597635, 34.262639, 50, 1000000, 400000, 2, 'YS Signature', 1),
(7, -7.670663, 33.567081, 1, 493, 20000, 2, 'El Fath', 5),
(8, -7.589838, 33.605166, 3, 324, 3443, 1, 'Kings Peak', 4),
(9, -6.636088, 34.260352, 54, 463, 4500, 2, 'Sun Beach', 3),
(10, -6.554721, 34.255812, 45, 509, 13000, 2, 'Ken House', 4),
(11, -7.381514, 33.690517, 45, 454, 9000, 3, 'Media Tower', 3);

-- --------------------------------------------------------

--
-- Structure de la table `quartier`
--

CREATE TABLE `quartier` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) COLLATE utf8_bin NOT NULL,
  `code_quartier` varchar(255) COLLATE utf8_bin NOT NULL,
  `ville_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `quartier`
--

INSERT INTO `quartier` (`id`, `libelle`, `code_quartier`, `ville_id`) VALUES
(1, 'Ain Diab', '20270', 13),
(2, 'Anfa', '20000', 13),
(3, 'Beauséjour', '20250', 13),
(4, 'Belvédère', '20300', 13),
(5, 'Bourgogne', '20220', 13),
(6, 'Californie', '20200', 13),
(7, 'Centre Ville', '20000', 13),
(8, 'Derb Ghallef', '20240', 13),
(9, 'Derb Sultan', '20230', 13),
(10, 'Gauthier', '20100', 13),
(11, 'Hay Hassani', '20220', 13),
(12, 'Hay Moulay Rachid', '20250', 13),
(13, 'Hay Nahda', '20370', 13),
(14, 'Hivernage', '20000', 13),
(15, 'La Colline', '20100', 13),
(16, 'Les Hôpitaux', '20250', 13),
(17, 'Maârif', '20100', 13),
(18, 'Mers Sultan', '20250', 13),
(19, 'Oasis', '20270', 13),
(20, 'Racine', '20100', 13),
(21, 'Sidi Bernoussi', '20600', 13),
(22, 'Sidi Maarouf', '20270', 13),
(23, 'Sidi Moumen', '20600', 13),
(24, 'Sidi Othmane', '20450', 13),
(25, 'Sidi Yahya', '20460', 13),
(26, 'Agdal', '10080', 41),
(27, 'Hassan', '10000', 41),
(28, 'Hay Riad', '10100', 41),
(29, 'Souissi', '10090', 41),
(30, 'Mabella', '10150', 41),
(31, 'Yacoub El Mansour', '10100', 41),
(32, 'Assafa', '20850', 36),
(33, 'Centre Ville', '20800', 36),
(34, 'Hay El Oulfa', '20852', 36),
(35, 'Hay El Farah', '20800', 36),
(36, 'Hay El Hassania', '20852', 36),
(37, 'Hay El Karia', '20851', 36),
(38, 'Hay El Kods', '20800', 36),
(39, 'Hay El Menzeh', '20850', 36),
(40, 'Hay El Nour', '20850', 36),
(41, 'Hay El Oulfa', '20852', 36),
(42, 'Hay Ismailia', '20800', 36),
(43, 'Hay Rahma', '20800', 36),
(44, 'Hay Sidi Abed', '20800', 36),
(45, 'Lissasfa', '20852', 36),
(46, 'Quartier Industriel', '20800', 36);

-- --------------------------------------------------------

--
-- Structure de la table `region`
--

CREATE TABLE `region` (
  `id` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `region`
--

INSERT INTO `region` (`id`, `libelle`) VALUES
(1, 'Tanger-Tétouan-Al Hoceima'),
(2, 'L\'Oriental'),
(3, 'Fès-Meknès'),
(4, 'Rabat-Salé-Kénitra'),
(5, 'Béni Mellal-Khénifra'),
(6, 'Casablanca-Settat'),
(7, 'Marrakech-Safi'),
(8, 'Drâa-Tafilalet'),
(9, 'Souss-Massa'),
(10, 'Guelmim-Oued Noun'),
(11, 'Laâyoune-Sakia El Hamra'),
(12, 'Dakhla-Oued Ed-Dahab');

-- --------------------------------------------------------

--
-- Structure de la table `rembourssement`
--

CREATE TABLE `rembourssement` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `montant` double NOT NULL,
  `dossierdecredit_id` int(11) NOT NULL,
  `taux` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_roman_ci;

--
-- Déchargement des données de la table `rembourssement`
--

INSERT INTO `rembourssement` (`id`, `date`, `montant`, `dossierdecredit_id`, `taux`) VALUES
(1, '2022-10-18', 100000, 3, 7),
(2, '2022-10-10', 2532000, 3, 4.2),
(3, '2022-09-06', 150000, 3, 20),
(4, '2022-08-09', 258745, 3, 8),
(5, '2022-07-04', 145457, 3, 15),
(6, '2022-06-28', 700000, 3, 25),
(7, '2022-05-16', 120000, 3, 14);

-- --------------------------------------------------------

--
-- Structure de la table `reseau`
--

CREATE TABLE `reseau` (
  `id` int(11) NOT NULL,
  `region` varchar(45) DEFAULT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `direction_regionale_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `reseau`
--

INSERT INTO `reseau` (`id`, `region`, `libelle`, `direction_regionale_id`) VALUES
(1, 'Casablanca Settat', 'CS', 1),
(2, 'Rabat Sale Kenitra', 'RSK', 1),
(3, 'Souss Massa Daraa', 'SOUSS', 1),
(4, 'Mohammedia', 'MEDIA', 1);

-- --------------------------------------------------------

--
-- Structure de la table `societe`
--

CREATE TABLE `societe` (
  `id` int(11) NOT NULL,
  `if_societe` varchar(45) DEFAULT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `rc` varchar(255) NOT NULL,
  `ice` varchar(255) NOT NULL,
  `siegeSociale` varchar(255) NOT NULL,
  `formeJuridique` varchar(255) NOT NULL,
  `ville_id` int(11) NOT NULL,
  `Groupe_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `societe`
--

INSERT INTO `societe` (`id`, `if_societe`, `libelle`, `rc`, `ice`, `siegeSociale`, `formeJuridique`, `ville_id`, `Groupe_id`) VALUES
(1, '66', 'Yamed Immobilier', '', '', '', '', 6, 1),
(2, '56', 'KLK Khayatey Living', '', '', '', '', 6, 2),
(3, '456', 'Bouygues Immobilier', '', '', '', '', 6, 1);

-- --------------------------------------------------------

--
-- Structure de la table `statutprojet`
--

CREATE TABLE `statutprojet` (
  `id` int(11) NOT NULL,
  `libelle` varchar(200) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `statutprojet`
--

INSERT INTO `statutprojet` (`id`, `libelle`) VALUES
(1, 'En Déblocage'),
(2, 'En Remboursement'),
(3, 'Clôturé'),
(4, 'Echus');

-- --------------------------------------------------------

--
-- Structure de la table `syslog`
--

CREATE TABLE `syslog` (
  `id` int(11) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `ipAdress` varchar(45) DEFAULT NULL,
  `log` varchar(45) DEFAULT NULL,
  `idUser` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `syslog`
--

INSERT INTO `syslog` (`id`, `date`, `ipAdress`, `log`, `idUser`) VALUES
(26, '22-10-09 10:22:08', '127.0.0.1', 'Authentication successful', 1),
(27, '22-10-09 10:22:12', '127.0.0.1', 'Log Out Successful', 1),
(28, '09-10-22 09:24:06', '127.0.0.1', 'Authentication successful', 1),
(29, '22-10-09 09:24:26', '127.0.0.1', 'Log Out Successful', 1),
(30, '09-10-22 08:36:00', '127.0.0.1', 'Authentication successful', 1),
(31, '09-10-22 08:36:06', '127.0.0.1', 'Log Out Successful', 1),
(32, '09-10-22 08:37:35', '127.0.0.1', 'Authentication successful', 1),
(33, '09-10-22 08:37:39', '127.0.0.1', 'Log Out Successful', 1),
(34, '09-10-22 09:24:28', '127.0.0.1', 'Authentication successful', 1),
(35, '09-10-22 09:35:42', '127.0.0.1', 'Log Out Successful', 1),
(36, '09-10-22 09:35:55', '127.0.0.1', 'Authentication successful', 1),
(37, '09-10-22 09:43:33', '127.0.0.1', 'Log Out Successful', 1),
(38, '09-10-22 09:44:36', '127.0.0.1', 'Authentication successful', 1),
(39, '09-10-22 09:46:02', '127.0.0.1', 'Log Out Successful', 1),
(40, '09-10-22 09:46:51', '127.0.0.1', 'Authentication successful', 1),
(41, '09-10-22 09:49:55', '127.0.0.1', 'Log Out Successful', 1),
(42, '09-10-22 09:50:30', '127.0.0.1', 'Authentication successful', 1),
(43, '09-10-22 09:50:34', '127.0.0.1', 'Log Out Successful', 1),
(44, '09-10-22 09:51:22', '127.0.0.1', 'Authentication successful', 1),
(45, '09-10-22 09:55:23', '127.0.0.1', 'Log Out Successful', 1),
(46, '09-10-22 09:55:27', '127.0.0.1', 'Authentication successful', 1),
(47, '10-10-22 05:13:35', '127.0.0.1', 'Authentication successful', 1),
(48, '17-10-22 07:21:54', '127.0.0.1', 'Authentication successful', 1),
(49, '17-10-22 07:52:10', '127.0.0.1', 'Authentication successful', 1),
(50, '18-10-22 06:56:05', '192.168.64.1', 'Authentication successful', 1),
(51, '18-10-22 07:00:11', '192.168.64.1', 'Authentication successful', 1),
(52, '24-10-22 10:46:41', '::1', 'Authentication successful', 1),
(53, '27-10-22 12:13:37', '::1', 'Authentication successful', 1),
(54, '28-10-22 02:44:39', '::1', 'Authentication successful', 1),
(55, '29-10-22 08:35:15', '::1', 'Authentication successful', 1),
(56, '31-10-22 09:57:44', '::1', 'Authentication successful', 1),
(57, '03-11-22 08:54:25', '::1', 'Authentication successful', 1),
(58, '03-11-22 02:57:22', '::1', 'Authentication successful', 1),
(59, '06-11-22 07:50:28', '127.0.0.1', 'Authentication successful', 1),
(60, '11-12-22 12:56:53', '127.0.0.1', 'Authentication successful', 1),
(61, '19-01-23 06:33:13', '127.0.0.1', 'Authentication successful', 1),
(62, '19-01-23 08:43:43', '127.0.0.1', 'Authentication successful', 1),
(63, '05-03-23 05:51:41', '127.0.0.1', 'Authentication successful', 1),
(64, '10-06-24 12:58:20', '::1', 'Authentication successful', 1),
(65, '10-06-24 12:58:21', '::1', 'Authentication successful', 1),
(66, '10-06-24 12:58:21', '::1', 'Authentication successful', 1),
(67, '10-06-24 12:58:21', '::1', 'Authentication successful', 1),
(68, '10-06-24 01:04:09', '::1', 'Authentication successful', 1),
(69, '10-06-24 01:04:37', '::1', 'Authentication successful', 1),
(70, '10-06-24 01:04:38', '::1', 'Authentication successful', 1),
(71, '10-06-24 01:04:38', '::1', 'Authentication successful', 1),
(72, '10-06-24 01:04:38', '::1', 'Authentication successful', 1),
(73, '10-06-24 01:04:38', '::1', 'Authentication successful', 1),
(74, '10-06-24 01:04:38', '::1', 'Authentication successful', 1),
(75, '10-06-24 01:04:40', '::1', 'Authentication successful', 1),
(76, '10-06-24 01:05:00', '::1', 'Authentication successful', 1),
(77, '10-06-24 01:05:00', '::1', 'Authentication successful', 1),
(78, '10-06-24 01:05:01', '::1', 'Authentication successful', 1),
(79, '10-06-24 01:05:01', '::1', 'Authentication successful', 1),
(80, '10-06-24 01:05:54', '::1', 'Authentication successful', 1),
(81, '10-06-24 01:05:54', '::1', 'Authentication successful', 1),
(82, '10-06-24 01:05:54', '::1', 'Authentication successful', 1),
(83, '10-06-24 01:06:06', '::1', 'Authentication successful', 1),
(84, '10-06-24 01:06:06', '::1', 'Authentication successful', 1),
(85, '10-06-24 01:06:06', '::1', 'Authentication successful', 1),
(86, '10-06-24 01:06:06', '::1', 'Authentication successful', 1),
(87, '10-06-24 01:06:07', '::1', 'Authentication successful', 1),
(88, '10-06-24 01:06:07', '::1', 'Authentication successful', 1),
(89, '10-06-24 01:06:09', '::1', 'Authentication successful', 1),
(90, '10-06-24 01:06:09', '::1', 'Authentication successful', 1),
(91, '10-06-24 01:06:21', '::1', 'Authentication successful', 1);

-- --------------------------------------------------------

--
-- Structure de la table `typecomposition`
--

CREATE TABLE `typecomposition` (
  `id` int(11) NOT NULL,
  `libelle` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `typecomposition`
--

INSERT INTO `typecomposition` (`id`, `libelle`) VALUES
(1, 'Appart'),
(2, 'Villa'),
(3, 'Studio'),
(4, 'Commerce'),
(5, 'Bureau'),
(6, 'Lot de villa'),
(7, 'Lot Industriel'),
(8, 'Lot R+3'),
(9, 'Lot R+4'),
(10, 'Lot R+5'),
(11, 'Lot R+6');

-- --------------------------------------------------------

--
-- Structure de la table `typecredit`
--

CREATE TABLE `typecredit` (
  `id` int(11) NOT NULL,
  `libelle` varchar(200) COLLATE utf8mb4_roman_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_roman_ci;

--
-- Déchargement des données de la table `typecredit`
--

INSERT INTO `typecredit` (`id`, `libelle`) VALUES
(1, 'Terrain'),
(2, 'VRD'),
(3, 'Construction');

-- --------------------------------------------------------

--
-- Structure de la table `typeprojet`
--

CREATE TABLE `typeprojet` (
  `id` int(11) NOT NULL,
  `libelle` varchar(200) COLLATE utf8_bin NOT NULL,
  `urlPin` varchar(255) COLLATE utf8_bin NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Déchargement des données de la table `typeprojet`
--

INSERT INTO `typeprojet` (`id`, `libelle`, `urlPin`) VALUES
(1, 'Immeuble', ''),
(2, 'Villa', ''),
(3, 'Lotissement Residentiel', ''),
(4, 'Lotissement Industriel', ''),
(5, 'Equipement', '');

-- --------------------------------------------------------

--
-- Structure de la table `u`
--

CREATE TABLE `u` (
  `id` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `u`
--

INSERT INTO `u` (`id`, `libelle`) VALUES
(1, 'agent'),
(2, 'admin'),
(3, 'gestionnaire');

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nomComplet` varchar(50) DEFAULT NULL,
  `tel` int(11) DEFAULT NULL,
  `login` varchar(30) DEFAULT NULL,
  `mdp` varchar(30) DEFAULT NULL,
  `TypeUtilisateur_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `nomComplet`, `tel`, `login`, `mdp`, `TypeUtilisateur_id`) VALUES
(1, 'noura mch', 620453678, 'noura@gmail.com', 'noura', 1);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateur`
--

CREATE TABLE `utilisateur` (
  `id` int(11) NOT NULL,
  `nomComplet` varchar(50) NOT NULL,
  `tel` varchar(14) NOT NULL,
  `login` varchar(50) NOT NULL,
  `mdp` varchar(50) NOT NULL,
  `role` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `utilisateur`
--

INSERT INTO `utilisateur` (`id`, `nomComplet`, `tel`, `login`, `mdp`, `role`) VALUES
(1, 'Anass', '012939848', 'anass@gmail.com', 'Anass@2022', 'gerant'),
(2, 'Youness', '012349483', 'youness@gmail.com', 'Youness@2022', 'admin'),
(3, 'smartuser', '+212661049992', 'smartuser@gmail.com', '$2y$10$T0eq4pu9xNqB7tSp9WxvfuNQ81JBzoe1nmLExXUeF/m', ' gerant');

-- --------------------------------------------------------

--
-- Structure de la table `ville`
--

CREATE TABLE `ville` (
  `id` int(11) NOT NULL,
  `libelle` varchar(45) DEFAULT NULL,
  `region_id` int(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `ville`
--

INSERT INTO `ville` (`id`, `libelle`, `region_id`) VALUES
(1, 'Agadir', 9),
(2, 'Aït Melloul', 9),
(3, 'Al Hoceïma', 1),
(4, 'Aousserd', 10),
(5, 'Assa', 10),
(6, 'Azilal', 5),
(7, 'Béni Mellal', 5),
(8, 'Béni Tadjit', 1),
(9, 'Berkane', 2),
(10, 'Berrechid', 6),
(11, 'Boujdour', 10),
(12, 'Boulemane', 3),
(13, 'Casablanca', 6),
(14, 'Chefchaouen', 1),
(15, 'Dakhla', 11),
(16, 'El Aioun', 1),
(17, 'El Hajeb', 3),
(18, 'El Jadida', 6),
(19, 'Errachidia', 3),
(20, 'Es-Semara', 10),
(21, 'Essaouira', 9),
(22, 'Fès', 3),
(23, 'Figuig', 2),
(24, 'Guelmim', 10),
(25, 'Ifrane', 3),
(26, 'Inezgane', 9),
(27, 'Jerada', 2),
(28, 'Kénitra', 4),
(29, 'Khemisset', 4),
(30, 'Khouribga', 5),
(31, 'Laâyoune', 11),
(32, 'Larache', 4),
(33, 'Marrakech', 7),
(34, 'Meknès', 3),
(35, 'Midelt', 3),
(36, 'Mohammédia', 4),
(37, 'Nador', 2),
(38, 'Ouarzazate', 5),
(39, 'Ouezzane', 1),
(40, 'Oujda', 2),
(41, 'Rabat', 4),
(42, 'Safi', 6),
(43, 'Salé', 4),
(44, 'Sefrou', 3),
(45, 'Settat', 6),
(46, 'Sidi Kacem', 4),
(47, 'Sidi Slimane', 4),
(48, 'Skhirate-Témara', 4),
(49, 'Sidi Yahya El Gharb', 4),
(50, 'Tan-Tan', 10),
(51, 'Tanger', 1),
(52, 'Tata', 5),
(53, 'Taza', 3),
(54, 'Tétouan', 1),
(55, 'Tiznit', 9);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `actionnaire`
--
ALTER TABLE `actionnaire`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_Represantant_Societe1` (`Societe_id`);

--
-- Index pour la table `agence`
--
ALTER TABLE `agence`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Reseau_id` (`Reseau_id`),
  ADD KEY `FK_agenceville` (`ville_id`);

--
-- Index pour la table `commentaireprojet`
--
ALTER TABLE `commentaireprojet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Projet_id` (`Projet_id`);

--
-- Index pour la table `composition`
--
ALTER TABLE `composition`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Projet_id` (`Projet_id`),
  ADD KEY `FK_ActifTypeActif` (`typeComposition_id`);

--
-- Index pour la table `deblocage`
--
ALTER TABLE `deblocage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_dossierdecreditddeblocage` (`dossierdecredit_id`);

--
-- Index pour la table `directionregionale`
--
ALTER TABLE `directionregionale`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `documentprojet`
--
ALTER TABLE `documentprojet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Projet_id` (`Projet_id`);

--
-- Index pour la table `dossierdecredit`
--
ALTER TABLE `dossierdecredit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Utilisateur_id` (`Utilisateur_id`),
  ADD KEY `Agence_id` (`Agence_id`),
  ADD KEY `Projet_id` (`Projet_id`),
  ADD KEY `FK_dcstatut` (`Statut_id`),
  ADD KEY `FK_DCTYPECREDIT` (`typeCredit_id`);

--
-- Index pour la table `gerant`
--
ALTER TABLE `gerant`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Groupe_id` (`Groupe_id`);

--
-- Index pour la table `groupe`
--
ALTER TABLE `groupe`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `imageprojet`
--
ALTER TABLE `imageprojet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Projet_id` (`Projet_id`);

--
-- Index pour la table `parts_sociales`
--
ALTER TABLE `parts_sociales`
  ADD KEY `FK_parts_socialesactionnaire` (`actionnaire_id`),
  ADD KEY `FK_parts_socialessociete` (`societe_id`);

--
-- Index pour la table `projet`
--
ALTER TABLE `projet`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Societe_id` (`Societe_id`),
  ADD KEY `FK_ProjetTypeProjet` (`typeProjet`);

--
-- Index pour la table `quartier`
--
ALTER TABLE `quartier`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_quartierville` (`ville_id`);

--
-- Index pour la table `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rembourssement`
--
ALTER TABLE `rembourssement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Rem_DossierCredit` (`dossierdecredit_id`);

--
-- Index pour la table `reseau`
--
ALTER TABLE `reseau`
  ADD PRIMARY KEY (`id`),
  ADD KEY `direction_regionale_id` (`direction_regionale_id`);

--
-- Index pour la table `societe`
--
ALTER TABLE `societe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Groupe_id` (`Groupe_id`),
  ADD KEY `FK_societeville` (`ville_id`);

--
-- Index pour la table `statutprojet`
--
ALTER TABLE `statutprojet`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `syslog`
--
ALTER TABLE `syslog`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_sysLog` (`idUser`);

--
-- Index pour la table `typecomposition`
--
ALTER TABLE `typecomposition`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `typecredit`
--
ALTER TABLE `typecredit`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `typeprojet`
--
ALTER TABLE `typeprojet`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `u`
--
ALTER TABLE `u`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `TypeUtilisateur_id` (`TypeUtilisateur_id`);

--
-- Index pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `ville`
--
ALTER TABLE `ville`
  ADD PRIMARY KEY (`id`),
  ADD KEY `region_id` (`region_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `actionnaire`
--
ALTER TABLE `actionnaire`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `agence`
--
ALTER TABLE `agence`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `commentaireprojet`
--
ALTER TABLE `commentaireprojet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `composition`
--
ALTER TABLE `composition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT pour la table `deblocage`
--
ALTER TABLE `deblocage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `directionregionale`
--
ALTER TABLE `directionregionale`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `documentprojet`
--
ALTER TABLE `documentprojet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `dossierdecredit`
--
ALTER TABLE `dossierdecredit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pour la table `gerant`
--
ALTER TABLE `gerant`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `groupe`
--
ALTER TABLE `groupe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `imageprojet`
--
ALTER TABLE `imageprojet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT pour la table `projet`
--
ALTER TABLE `projet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `quartier`
--
ALTER TABLE `quartier`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT pour la table `region`
--
ALTER TABLE `region`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT pour la table `rembourssement`
--
ALTER TABLE `rembourssement`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `reseau`
--
ALTER TABLE `reseau`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `societe`
--
ALTER TABLE `societe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `statutprojet`
--
ALTER TABLE `statutprojet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `syslog`
--
ALTER TABLE `syslog`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT pour la table `typecomposition`
--
ALTER TABLE `typecomposition`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `typecredit`
--
ALTER TABLE `typecredit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `typeprojet`
--
ALTER TABLE `typeprojet`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `u`
--
ALTER TABLE `u`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `utilisateur`
--
ALTER TABLE `utilisateur`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `ville`
--
ALTER TABLE `ville`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `actionnaire`
--
ALTER TABLE `actionnaire`
  ADD CONSTRAINT `fk_Represantant_Societe1` FOREIGN KEY (`Societe_id`) REFERENCES `societe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `agence`
--
ALTER TABLE `agence`
  ADD CONSTRAINT `FK_agenceville` FOREIGN KEY (`ville_id`) REFERENCES `ville` (`id`),
  ADD CONSTRAINT `agence_ibfk_1` FOREIGN KEY (`Reseau_id`) REFERENCES `reseau` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `commentaireprojet`
--
ALTER TABLE `commentaireprojet`
  ADD CONSTRAINT `commentaireprojet_ibfk_1` FOREIGN KEY (`Projet_id`) REFERENCES `projet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `composition`
--
ALTER TABLE `composition`
  ADD CONSTRAINT `FK_ActifTypeActif` FOREIGN KEY (`typeComposition_id`) REFERENCES `typecomposition` (`id`),
  ADD CONSTRAINT `composition_ibfk_1` FOREIGN KEY (`Projet_id`) REFERENCES `projet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `deblocage`
--
ALTER TABLE `deblocage`
  ADD CONSTRAINT `FK_dossierdecreditddeblocage` FOREIGN KEY (`dossierdecredit_id`) REFERENCES `dossierdecredit` (`id`),
  ADD CONSTRAINT `FK_dossierdecreditdeblocage` FOREIGN KEY (`dossierdecredit_id`) REFERENCES `dossierdecredit` (`id`);

--
-- Contraintes pour la table `documentprojet`
--
ALTER TABLE `documentprojet`
  ADD CONSTRAINT `documentprojet_ibfk_1` FOREIGN KEY (`Projet_id`) REFERENCES `projet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `dossierdecredit`
--
ALTER TABLE `dossierdecredit`
  ADD CONSTRAINT `FK_DCTYPECREDIT` FOREIGN KEY (`typeCredit_id`) REFERENCES `typecredit` (`id`),
  ADD CONSTRAINT `FK_dcstatut` FOREIGN KEY (`Statut_id`) REFERENCES `statutprojet` (`id`),
  ADD CONSTRAINT `dossierdecredit_ibfk_1` FOREIGN KEY (`Utilisateur_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dossierdecredit_ibfk_2` FOREIGN KEY (`Agence_id`) REFERENCES `agence` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `dossierdecredit_ibfk_3` FOREIGN KEY (`Projet_id`) REFERENCES `projet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `gerant`
--
ALTER TABLE `gerant`
  ADD CONSTRAINT `gerant_ibfk_1` FOREIGN KEY (`Groupe_id`) REFERENCES `groupe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `imageprojet`
--
ALTER TABLE `imageprojet`
  ADD CONSTRAINT `imageprojet_ibfk_1` FOREIGN KEY (`Projet_id`) REFERENCES `projet` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `parts_sociales`
--
ALTER TABLE `parts_sociales`
  ADD CONSTRAINT `FK_parts_socialesactionnaire` FOREIGN KEY (`actionnaire_id`) REFERENCES `actionnaire` (`id`),
  ADD CONSTRAINT `FK_parts_socialessociete` FOREIGN KEY (`societe_id`) REFERENCES `societe` (`id`);

--
-- Contraintes pour la table `projet`
--
ALTER TABLE `projet`
  ADD CONSTRAINT `FK_ProjetTypeProjet` FOREIGN KEY (`typeProjet`) REFERENCES `typeprojet` (`id`),
  ADD CONSTRAINT `projet_ibfk_1` FOREIGN KEY (`Societe_id`) REFERENCES `societe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `quartier`
--
ALTER TABLE `quartier`
  ADD CONSTRAINT `FK_quartierville` FOREIGN KEY (`ville_id`) REFERENCES `ville` (`id`);

--
-- Contraintes pour la table `rembourssement`
--
ALTER TABLE `rembourssement`
  ADD CONSTRAINT `FK_Rem_DossierCredit` FOREIGN KEY (`dossierdecredit_id`) REFERENCES `dossierdecredit` (`id`);

--
-- Contraintes pour la table `reseau`
--
ALTER TABLE `reseau`
  ADD CONSTRAINT `reseau_ibfk_1` FOREIGN KEY (`direction_regionale_id`) REFERENCES `directionregionale` (`id`);

--
-- Contraintes pour la table `societe`
--
ALTER TABLE `societe`
  ADD CONSTRAINT `FK_societeville` FOREIGN KEY (`ville_id`) REFERENCES `ville` (`id`),
  ADD CONSTRAINT `societe_ibfk_1` FOREIGN KEY (`Groupe_id`) REFERENCES `groupe` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `syslog`
--
ALTER TABLE `syslog`
  ADD CONSTRAINT `FK_SYS_USER` FOREIGN KEY (`idUser`) REFERENCES `user` (`id`),
  ADD CONSTRAINT `FK_sysLog` FOREIGN KEY (`idUser`) REFERENCES `utilisateur` (`id`);

--
-- Contraintes pour la table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `user_ibfk_1` FOREIGN KEY (`TypeUtilisateur_id`) REFERENCES `u` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `ville`
--
ALTER TABLE `ville`
  ADD CONSTRAINT `ville_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
