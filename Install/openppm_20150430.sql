-- phpMyAdmin SQL Dump
-- version 4.2.10.1
-- http://www.phpmyadmin.net
--
-- Client :  localhost
-- Généré le :  Jeu 30 Avril 2015 à 13:10
-- Version du serveur :  5.5.40-MariaDB
-- Version de PHP :  5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `openppm`
--
CREATE DATABASE IF NOT EXISTS `openppm` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `openppm`;

-- --------------------------------------------------------

--
-- Structure de la table `activityseller`
--

DROP TABLE IF EXISTS `activityseller`;
CREATE TABLE IF NOT EXISTS `activityseller` (
`idActivitySeller` int(11) NOT NULL,
  `idActivity` int(11) NOT NULL,
  `idSeller` int(11) NOT NULL,
  `statementOfWork` varchar(200) DEFAULT NULL,
  `procurementDocuments` varchar(100) DEFAULT NULL,
  `baselineStart` date DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `baselineFinish` date DEFAULT NULL,
  `finishDate` date DEFAULT NULL,
  `workScheduleInfo` varchar(200) DEFAULT NULL,
  `sellerPerformanceInfo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `activityseller`
--

INSERT INTO `activityseller` (`idActivitySeller`, `idActivity`, `idSeller`, `statementOfWork`, `procurementDocuments`, `baselineStart`, `startDate`, `baselineFinish`, `finishDate`, `workScheduleInfo`, `sellerPerformanceInfo`) VALUES
(1, 63, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 49, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 62, 1, '', '', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 78, 3, '', '', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 185, 7, '', '', '2015-02-02', NULL, '2015-02-27', NULL, '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `assumptionreassessmentlog`
--

DROP TABLE IF EXISTS `assumptionreassessmentlog`;
CREATE TABLE IF NOT EXISTS `assumptionreassessmentlog` (
`IdLog` int(11) NOT NULL,
  `IdAssumption` int(11) DEFAULT NULL,
  `Assumption_date` date DEFAULT NULL,
  `AssumptionChange` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `assumptionregister`
--

DROP TABLE IF EXISTS `assumptionregister`;
CREATE TABLE IF NOT EXISTS `assumptionregister` (
`IdAssumption` int(11) NOT NULL,
  `IdProject` int(11) DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `AssumptionCode` varchar(5) DEFAULT NULL,
  `AssumptionName` varchar(50) DEFAULT NULL,
  `Originator` varchar(100) DEFAULT NULL,
  `AssumptionDoc` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `bscdimension`
--

DROP TABLE IF EXISTS `bscdimension`;
CREATE TABLE IF NOT EXISTS `bscdimension` (
`idBscDimension` int(10) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `idCompany` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `bscdimension`
--

INSERT INTO `bscdimension` (`idBscDimension`, `name`, `idCompany`) VALUES
(1, 'CdS Toulouse', 1),
(2, 'BSC Dimension 2', 1),
(3, 'BSC Dimension 3', 1);

-- --------------------------------------------------------

--
-- Structure de la table `budgetaccounts`
--

DROP TABLE IF EXISTS `budgetaccounts`;
CREATE TABLE IF NOT EXISTS `budgetaccounts` (
`IdBudgetAccount` int(11) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `typeCost` int(11) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `budgetaccounts`
--

INSERT INTO `budgetaccounts` (`IdBudgetAccount`, `Description`, `typeCost`, `idCompany`) VALUES
(1, 'CdS Toulouse', 2, 1),
(2, 'CdS Toulouse - collecteur des dépenses', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `calendarbase`
--

DROP TABLE IF EXISTS `calendarbase`;
CREATE TABLE IF NOT EXISTS `calendarbase` (
`idCalendarBase` int(11) NOT NULL,
  `weekStart` int(11) DEFAULT NULL,
  `fiscalYearStart` int(11) DEFAULT NULL,
  `startTime1` double DEFAULT NULL,
  `startTime2` double DEFAULT NULL,
  `endTime1` double DEFAULT NULL,
  `endTime2` double DEFAULT NULL,
  `hoursDay` double DEFAULT NULL,
  `hoursWeek` double DEFAULT NULL,
  `daysMonth` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `calendarbase`
--

INSERT INTO `calendarbase` (`idCalendarBase`, `weekStart`, `fiscalYearStart`, `startTime1`, `startTime2`, `endTime1`, `endTime2`, `hoursDay`, `hoursWeek`, `daysMonth`, `name`, `idCompany`) VALUES
(1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18, 'CdS - Heures ouvrées', 1),
(2, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18, 'CdS - Heures ouvrées - sous-traitants français', 1),
(3, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18, 'CdS - Heures ouvrées - 4/5ème mercredi', 1);

-- --------------------------------------------------------

--
-- Structure de la table `calendarbaseexceptions`
--

DROP TABLE IF EXISTS `calendarbaseexceptions`;
CREATE TABLE IF NOT EXISTS `calendarbaseexceptions` (
`IdCalendarBaseException` int(11) NOT NULL,
  `IdCalendarBase` int(11) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `FinishDate` date DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `calendarbaseexceptions`
--

INSERT INTO `calendarbaseexceptions` (`IdCalendarBaseException`, `IdCalendarBase`, `StartDate`, `FinishDate`, `Description`) VALUES
(1, 1, '2014-12-26', '2014-12-26', 'RTT employeur'),
(2, 1, '2015-01-02', '2015-01-02', 'RTT employeur'),
(3, 1, '2015-01-01', '2015-01-01', 'Premier de l''An'),
(4, 1, '2015-04-06', '2015-04-06', 'Lundi de Pâques'),
(5, 1, '2015-05-01', '2015-05-01', 'Fête du Travail'),
(6, 1, '2015-05-08', '2015-05-08', '8 Mai 1945'),
(7, 1, '2015-05-14', '2015-05-14', 'Jeudi de l''Ascension'),
(8, 1, '2015-05-25', '2015-05-25', 'Lundi de Pentecôte'),
(9, 1, '2015-07-14', '2015-07-14', 'Fête Nationale'),
(10, 1, '2015-08-15', '2015-08-15', 'Assomption'),
(11, 1, '2015-11-01', '2015-11-01', 'La Toussaint'),
(12, 1, '2015-11-11', '2015-11-11', 'Armistice'),
(13, 1, '2015-12-25', '2015-12-25', 'Noël'),
(14, 1, '2015-12-24', '2015-12-24', 'RTT employeur'),
(15, 2, '2015-01-01', '2015-01-01', 'Premier de l''An'),
(16, 2, '2015-04-06', '2015-04-06', 'Lundi de Pâques'),
(17, 2, '2015-05-01', '2015-05-01', 'Fête du Travail'),
(18, 2, '2015-05-08', '2015-05-08', '8 Mai 1945'),
(19, 2, '2015-05-14', '2015-05-14', 'Jeudi de l''Ascension'),
(20, 2, '2015-05-25', '2015-05-25', 'Lundi de Pentecôte'),
(21, 2, '2015-07-14', '2015-07-14', 'Fête Nationale'),
(22, 2, '2015-08-15', '2015-08-15', 'Assomption'),
(23, 2, '2015-11-01', '2015-11-01', 'La Toussaint'),
(24, 2, '2015-11-11', '2015-11-11', 'Armistice'),
(25, 2, '2015-12-25', '2015-12-25', 'Noël'),
(26, 1, '2014-12-25', '2014-12-25', 'Noël 2014'),
(27, 3, '2015-11-11', '2015-11-11', 'Armistice'),
(28, 3, '2015-05-25', '2015-05-25', 'Lundi de Pentecôte'),
(29, 3, '2015-11-01', '2015-11-01', 'La Toussaint'),
(30, 3, '2015-05-14', '2015-05-14', 'Jeudi de l''Ascension'),
(31, 3, '2015-05-08', '2015-05-08', '8 Mai 1945'),
(32, 3, '2015-01-01', '2015-01-01', 'Premier de l''An'),
(33, 3, '2015-04-06', '2015-04-06', 'Lundi de Pâques'),
(34, 3, '2015-07-14', '2015-07-14', 'Fête Nationale'),
(35, 3, '2015-12-25', '2015-12-25', 'Noël'),
(36, 3, '2015-08-15', '2015-08-15', 'Assomption'),
(37, 3, '2015-05-01', '2015-05-01', 'Fête du Travail'),
(38, 3, '2014-12-31', '2014-12-31', 'Mercredi S1'),
(39, 3, '2015-01-07', '2015-01-07', 'Mercredi S2'),
(40, 3, '2015-01-14', '2015-01-14', 'Mercredi S3'),
(41, 3, '2015-01-21', '2015-01-21', 'Mercredi S4'),
(42, 3, '2015-01-28', '2015-01-28', 'Mercredi S5'),
(43, 3, '2015-02-04', '2015-02-04', 'Mercredi S6'),
(44, 3, '2015-02-11', '2015-02-11', 'Mercredi S7'),
(45, 3, '2015-02-18', '2015-02-18', 'Mercredi S8'),
(46, 3, '2015-02-25', '2015-02-25', 'Mercredi S9'),
(47, 3, '2015-03-04', '2015-03-04', 'Mercredi S10'),
(48, 3, '2015-03-11', '2015-03-11', 'Mercredi S11'),
(49, 3, '2015-03-18', '2015-03-18', 'Mercredi S12'),
(50, 3, '2015-03-25', '2015-03-25', 'Mercredi S13'),
(51, 3, '2015-04-01', '2015-04-01', 'Mercredi S14'),
(52, 3, '2015-04-08', '2015-04-08', 'Mercredi S15'),
(53, 3, '2015-04-15', '2015-04-15', 'Mercredi S16'),
(54, 3, '2015-04-22', '2015-04-22', 'Mercredi S17'),
(55, 3, '2015-04-29', '2015-04-29', 'Mercredi S18'),
(56, 3, '2015-05-06', '2015-05-06', 'Mercredi S19'),
(57, 3, '2015-05-13', '2015-05-13', 'Mercredi S20'),
(58, 3, '2015-05-20', '2015-05-20', 'Mercredi S21'),
(59, 3, '2015-05-27', '2015-05-27', 'Mercredi S22'),
(60, 3, '2015-06-03', '2015-06-03', 'Mercredi S23'),
(61, 3, '2015-06-10', '2015-06-10', 'Mercredi S24'),
(62, 3, '2015-06-17', '2015-06-17', 'Mercredi S25'),
(63, 3, '2015-06-24', '2015-06-24', 'Mercredi S26'),
(64, 3, '2015-07-01', '2015-07-01', 'Mercredi S27'),
(65, 3, '2015-07-08', '2015-07-08', 'Mercredi S28'),
(66, 3, '2015-07-15', '2015-07-15', 'Mercredi S29'),
(67, 3, '2015-07-22', '2015-07-22', 'Mercredi S30'),
(68, 3, '2015-07-29', '2015-07-29', 'Mercredi S31'),
(69, 3, '2015-08-05', '2015-08-05', 'Mercredi S32'),
(70, 3, '2015-08-12', '2015-08-12', 'Mercredi S33'),
(71, 3, '2015-08-19', '2015-08-19', 'Mercredi S34'),
(72, 3, '2015-08-26', '2015-08-26', 'Mercredi S35'),
(73, 3, '2015-09-02', '2015-09-02', 'Mercredi S36'),
(74, 3, '2015-09-09', '2015-09-09', 'Mercredi S37'),
(75, 3, '2015-09-16', '2015-09-16', 'Mercredi S38'),
(76, 3, '2015-09-23', '2015-09-23', 'Mercredi S39'),
(77, 3, '2015-09-30', '2015-09-30', 'Mercredi S40'),
(78, 3, '2015-10-07', '2015-10-07', 'Mercredi S41'),
(79, 3, '2015-10-14', '2015-10-14', 'Mercredi S42'),
(80, 3, '2015-10-21', '2015-10-21', 'Mercredi S43'),
(81, 3, '2015-10-28', '2015-10-28', 'Mercredi S44'),
(82, 3, '2015-11-04', '2015-11-04', 'Mercredi S45'),
(83, 3, '2015-11-11', '2015-11-11', 'Mercredi S46'),
(84, 3, '2015-11-18', '2015-11-18', 'Mercredi S47'),
(85, 3, '2015-11-25', '2015-11-25', 'Mercredi S48'),
(86, 3, '2015-12-02', '2015-12-02', 'Mercredi S49'),
(87, 3, '2015-12-09', '2015-12-09', 'Mercredi S50'),
(88, 3, '2015-12-16', '2015-12-16', 'Mercredi S51'),
(89, 3, '2015-12-23', '2015-12-23', 'Mercredi S52'),
(90, 3, '2015-12-30', '2015-12-30', 'Mercredi S53');

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
`IdCategory` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `category`
--

INSERT INTO `category` (`IdCategory`, `name`, `description`, `idCompany`) VALUES
(1, 'TMA - Corrective', '', 1),
(2, 'Projets', '', 1),
(4, 'TMA - Évolutive', '', 1),
(5, 'Absences', 'tout type d''absence', 1),
(6, 'Gouvernance', 'Gouverance globale du Centre de Services en dehors de toutes les prestations opérationnelles', 1),
(7, 'Formations', 'Formations externes ou internes', 1),
(8, 'Transition', '', 1),
(9, 'Exploitation', 'Exploitation et administration récurrente d''infrastructure', 1),
(10, 'TMA - Opérationnelle', '', 1);

-- --------------------------------------------------------

--
-- Structure de la table `changecontrol`
--

DROP TABLE IF EXISTS `changecontrol`;
CREATE TABLE IF NOT EXISTS `changecontrol` (
`IdChange` int(11) NOT NULL,
  `IdProject` int(11) DEFAULT NULL,
  `IdChangeType` int(11) DEFAULT NULL,
  `IdWBSNode` int(11) DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Priority` char(1) DEFAULT NULL,
  `ChangeDate` date DEFAULT NULL,
  `Originator` varchar(50) DEFAULT NULL,
  `RecommendedSolution` varchar(500) DEFAULT NULL,
  `ImpactDescription` varchar(500) DEFAULT NULL,
  `EstimatedEffort` int(11) DEFAULT NULL,
  `EstimatedCost` double DEFAULT NULL,
  `Resolution` bit(1) DEFAULT NULL,
  `ResolutionReason` varchar(500) DEFAULT NULL,
  `ResolutionDate` date DEFAULT NULL,
  `ChangeDocLink` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `changetype`
--

DROP TABLE IF EXISTS `changetype`;
CREATE TABLE IF NOT EXISTS `changetype` (
`idChangeType` int(11) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `changetype`
--

INSERT INTO `changetype` (`idChangeType`, `description`, `idCompany`) VALUES
(1, 'Change Type 1', 1),
(2, 'Change Type 2', 1),
(3, 'Change Type 3', 1);

-- --------------------------------------------------------

--
-- Structure de la table `chargescosts`
--

DROP TABLE IF EXISTS `chargescosts`;
CREATE TABLE IF NOT EXISTS `chargescosts` (
`idChargesCosts` int(10) unsigned NOT NULL,
  `name` varchar(75) NOT NULL,
  `cost` double DEFAULT NULL,
  `idChargeType` int(11) NOT NULL,
  `idProject` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `chargescosts`
--

INSERT INTO `chargescosts` (`idChargesCosts`, `name`, `cost`, `idChargeType`, `idProject`) VALUES
(8, 'Serveurs', 15000, 2, 16),
(9, 'Infrastructure logicielle open-source', 0, 3, 16),
(11, 'Serveur', 0, 2, 74);

-- --------------------------------------------------------

--
-- Structure de la table `checklist`
--

DROP TABLE IF EXISTS `checklist`;
CREATE TABLE IF NOT EXISTS `checklist` (
`idChecklist` int(10) unsigned NOT NULL,
  `idWbsnode` int(11) NOT NULL,
  `code` varchar(10) DEFAULT NULL,
  `description` varchar(200) DEFAULT NULL,
  `percentageComplete` int(10) unsigned DEFAULT NULL,
  `actualizationDate` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `checklist`
--

INSERT INTO `checklist` (`idChecklist`, `idWbsnode`, `code`, `description`, `percentageComplete`, `actualizationDate`) VALUES
(4, 46, '', 'SPECIFICATION DOSSIER', NULL, NULL),
(5, 46, '', 'User guide', NULL, NULL),
(6, 40, '', 'Sprint 1: tasks details list', NULL, NULL),
(7, 40, '', 'Sprint 2: Tasks details list', NULL, NULL),
(8, 66, '', 'Devis', NULL, NULL),
(9, 67, '', 'Spécifications', NULL, NULL),
(10, 68, '', 'Evolutions packagées', NULL, NULL),
(12, 69, '', 'Cahier de recette', NULL, NULL),
(13, 70, '', 'Fichier de suivi des évolutions', NULL, NULL),
(14, 68, '', 'Documents de paramétrage', NULL, NULL),
(15, 70, '', 'Bon de livraison', NULL, NULL),
(16, 65, '', 'PV de réception client', NULL, NULL),
(18, 99, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2014-12-23'),
(19, 101, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2014-12-23'),
(20, 100, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2014-12-23'),
(21, 98, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2014-12-23'),
(22, 102, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2014-12-31'),
(23, 105, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2015-01-09'),
(24, 106, 'V0.1', 'Version en PHP limitée aux fonctions essentielles', 100, '2015-01-09'),
(26, 1113, '', 'Fichier consolidé des interviews', NULL, NULL),
(27, 1063, '', 'WBS du projet', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `company`
--

DROP TABLE IF EXISTS `company`;
CREATE TABLE IF NOT EXISTS `company` (
`IdCompany` int(11) NOT NULL,
  `Name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `company`
--

INSERT INTO `company` (`IdCompany`, `Name`) VALUES
(1, 'Devoteam');

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
`IdContact` int(11) NOT NULL,
  `IdCompany` int(11) DEFAULT NULL,
  `FullName` varchar(50) DEFAULT NULL,
  `JobTitle` varchar(50) DEFAULT NULL,
  `FileAs` varchar(60) DEFAULT NULL,
  `BusinessPhone` varchar(12) DEFAULT NULL,
  `MobilePhone` varchar(12) DEFAULT NULL,
  `BusinessAddress` varchar(200) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Notes` varchar(200) DEFAULT NULL,
  `locale` varchar(5) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `contact`
--

INSERT INTO `contact` (`IdContact`, `IdCompany`, `FullName`, `JobTitle`, `FileAs`, `BusinessPhone`, `MobilePhone`, `BusinessAddress`, `Email`, `Notes`, `locale`) VALUES
(10, 1, 'Admin', 'Admin', 'Admin', NULL, NULL, NULL, 'admin@openppm.com', NULL, NULL),
(11, 1, 'Patrice Prouzat', 'Directeur opérationnel', 'Porfolio Manager', '', '', '8 rue Claude-Marie Perroud, 31100 Toulouse', 'patrice.prouzat@devoteam.com', '', NULL),
(12, 1, 'Stéphan Peccini', 'Manager', 'Directeur du Centre de Service de Toulouse', '0667410147', '', '8 rue Claude-Marie Perroud, 31100 Toulouse', 'speccini@localhost.localdomain', '', ''),
(13, 1, 'Guillem Boyer', 'ITSM N2', 'ITSM N2', '', '', '8', 'guillem.boyer@devoteam.com', '', NULL),
(14, 1, 'Philippe Contesse', 'Operational Delivery Manager', 'OdM', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'philippe.contesse@devoteam.com', '', NULL),
(15, 1, 'Éric Llamas', 'Operational Delivery Manager', 'OdM', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'eric.llamas@devoteam.com', '', NULL),
(16, 1, 'Jean-Christophe Bourion', 'Operational Delivery Manager', 'OdM', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'jean-christophe.bourion@devoteam.com', '', ''),
(17, 1, 'Valérie Malaval', 'Directrice de Projets', 'DP', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'valerie.malaval@devoteam.com', '', NULL),
(18, 1, 'Steve Marques', 'Operational Delivery Manager', 'OdM', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'steve.marques@devoteam.com', '', NULL),
(19, 1, 'Amine Saoud', 'NTIC - N3', 'NTIC - N3', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'amine.saoud@devoteam.com', '', NULL),
(20, 1, 'Samir Hadiri', 'ITSM - N3', 'ITSM - N3', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'samir.hadiri@devoteam.com', '', NULL),
(21, 1, 'Trang Vu', 'ITSM - N3', 'ITSM - N3', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'trang.vu@devoteam.com', '', NULL),
(22, 1, 'Maxence Varangot', 'Directeur de Projets', 'Transformation Manager', '', '', '8 rue Claude-Marie Perroud 31100 Toulouse', 'maxence.varangot@devoteam.com', '', NULL),
(23, 1, 'Alexandre Gonzalez', 'Chef De Projet', 'AGO', '', '', '8, rue Claude Marie Perroud, 31140 Montberon', 'alexandre.gonzalez@devoteam.com', '', NULL),
(24, 1, 'Didier Pavy', 'Directeur de projet', 'DPA', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'didier.pavy@devoteam.com', '', NULL),
(25, 1, 'Thomas Torres', 'N3', 'TTO', '0562476393', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'thomas.torres@devoteam.com', '', '\r'),
(26, 1, 'Zazah Laurent', 'N2', 'ZLA', '0562476393', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'zazah.laurent@devoteam.com', '', '\r'),
(27, 1, 'Olivier Sacareau', 'N2', 'OSA', '0562476393', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'olivier.sacareau@devoteam.com', '', '\r'),
(28, 1, 'Junior Kpadjouda', 'N2', 'JKP', '0562476393', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'junior.kpadjouda@devoteam.com', '', '\r'),
(29, 1, 'Chloé Adam', 'transverse', 'CAD', '0562476394', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'chloe.adam@devoteam.com', '', '\r'),
(30, 1, 'Jean-Lilian Zircher', 'N2', 'JLZ', '0562473328', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'jean-lilian.zircher@devoteam.com', '', '\r'),
(31, 1, 'Pierre Bartalan', 'N2', 'PBA', '0562476392', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'pierre.bartalan@devoteam.com', '', '\r'),
(32, 1, 'Sebastien Ricard', 'N3', 'SRI', '0562473328', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'sebastien.ricard@devoteam.com', '', '\r'),
(33, 1, 'Renaud Dellac', 'N2', 'RDE', '0562476392', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'renaud.dellac@devoteam.com', '', '\r'),
(34, 1, 'Frederic Toniolo', 'N2', 'FTO', '0562476392', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'frederic.toniolo@devoteam.com', '', '\r'),
(35, 1, 'Paul Louis-Thérèse', 'N1', 'PLT', '0562476392', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'paul.louis.therese@devoteam.com', '', ''),
(36, 1, 'Xavier De Langautier', 'N2', 'XDL', '', '0699653349', '8, rue Claude Marie Perroud, 31000 Toulouse', 'xavier.de.langautier@devoteam.com', '', '\r'),
(37, 1, 'Romain Blanjean', 'Transverse', 'RBL', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'romain.blanjean@devoteam.com', '', '\r'),
(38, 1, 'Vincent Burkic', 'N3', 'VBU', '0562476395', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'vincent.burkic@devoteam.com', '', '\r'),
(39, 1, 'Philippe Andrieux', 'N2', 'PAD', '0562476391', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'philippe.andrieux@devoteam.com', '', '\r'),
(40, 1, 'Louis Watrin', 'N3', 'LWA', '0562476395', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'louis.watrin@devoteam.com', '', '\r'),
(41, 1, 'Benjamin Falala', 'N2', 'BFA', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'benjamin.falala@devoteam.com', '', '\r'),
(42, 1, 'Frederic Prat', 'N2', 'FPR', '0562476391', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'frederic.prat@devoteam.com', '', '\r'),
(43, 1, 'Guilhem Valentin', 'N2', 'GVA', '0562476391', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'guilhem.valentin@devoteam.com', '', '\r'),
(44, 1, 'Hugo Barberet', 'N2', 'HBA', '0562476391', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'hugo.barberet.ext@devoteam.com', 'Sous-traitant Koncept', '\r'),
(45, 1, 'Mehdi Dbouki', 'N2', 'MDB', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'mehdi.dbouki.ext@devoteam.com', 'Sous-traitant Innovans', '\r'),
(46, 1, 'Manel Jelliti', 'N3', 'MJE', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'manel.jelliti@devoteam.com', '', '\r'),
(47, 1, 'Vincent Sautier', 'N3', 'VSA', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'vincent.sautier@devoteam.com', '', '\r'),
(48, 1, 'Arnaud Dangas', 'N1', 'ADA', '', '', '8, rue Claude Marie Perroud, 31000 Toulouse', 'arnaud.dangas@devoteam.com', '', '\r'),
(49, 1, 'Nathalie Morin', 'Directrice des opérations', 'NMO', '', '0608044853', '73, rue Anatole France, 92300 Levallois-Perret,  France', 'nathalie.morin@devoteam.com', '', NULL),
(50, 1, 'FPT1', 'Développeur', 'FPT1', '', '', 'Hanoi, Vietnam', 'fpt1@localhost.localdomain', '', NULL),
(51, 1, 'FPT2', 'Développeur', 'FPT2', '', '', 'Hanoi, Veitnam', 'fpt2@localhost.localdomain', '', NULL),
(52, 1, 'Bertrand Greff', 'Expert', 'BGR', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'bertrand.greff@devoteam.com', '', NULL),
(53, 1, 'José Costa', 'Responsable opérationnel CdS France', 'José Costa', '', '06 65 52 64', '73 rue Anatole France, 92300 Levallois-Perret', 'josealexandre.costa@devoteam.com', '', NULL),
(54, 1, 'Baptiste Dupuy', 'Consultant ITSM', 'BDU', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'baptiste.dupuy@deoteam.com', '', NULL),
(55, 1, 'Christophe Sancéau', 'Expert', 'CSA', '', '', 'Nantes', 'christophe.sanceau@devoteam.com', '', NULL),
(56, 1, 'Pierre Kowalczyk', 'Responsable Transformation CdS', 'PKO', '', '', 'Levallois', 'pierre.kowalczyk@devoteam.com', '', NULL),
(57, 1, 'Karine Lang', 'DRH Régions', 'KLA', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'karine.lang@devoteam.com', '', NULL),
(58, 1, 'Emmanuel Diaz', 'Expert NTIC', 'EDI', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'emmanuel.diaz@devoteam.com', '', NULL),
(59, 1, 'Jean-Philippe Romé', 'Expert', 'JPR', '', '', 'Massy', 'jean-philippe.rome@devoteam.com', '', NULL),
(60, 1, 'Jérôme Louzoun', 'Expert NTIC', 'JLO', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'jerome.louzoun@devoteam.com', '', NULL),
(61, 1, 'Jean-Christophe Pichant', 'Expert N3, CdP ITSM Remedy', 'JCP', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'jean-christophe.pichant@devoteam.com', '', NULL),
(62, 1, 'Corinne Farenc', 'Experte BO', 'CFA', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'corinne.farenc@devoteam.com', '', NULL),
(63, 1, 'Gilles Lecomte-Flament', 'Responsable commercial', 'GLF', '', '', 'Levallois', 'gilles.lecomte-flament@devoteam.com', '', NULL),
(64, 1, 'Mohammed Zaït', 'Expert BI + Finances', 'MZA', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'mohammed.zait@devoteam.com', '', NULL),
(65, 1, 'Cédric Ndanga', 'Stagiaire', 'CND', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'cedric.ndanga@devoteam.com', '', NULL),
(67, 1, 'Samuel Maussion', 'Expert NTIC', 'SMA', '', '', 'Koncept, Toulouse, France', 'samuel.maussion.ext@devoteam.com', '', NULL),
(68, 1, 'Jérémy Pineau', 'Expert NTIC', 'JPI', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'jeremy.pineau.ext@devoteam.com', '', NULL),
(69, 1, 'Stéphane Wezel', 'Consultant ITSM', 'SWE', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'stephane.wezel@devoteam.com', '', NULL),
(70, 1, 'Ismael Rodriguez Aragon', 'Expert ITSM', 'IRA', '', '', 'Madrid, Spain*', 'ismael.rodriguez.aragon@devoteam.com', '', NULL),
(71, 1, 'Pascal Soulé', 'Chef de Projets', 'PSO', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'pascal.soule@devoteam.com', '', ''),
(72, 1, 'Marine Trentin', 'Experte NTIC', 'MTR', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'marine.trentin@devoteam.com', '', NULL),
(73, 1, 'Jesus Jimenez Patiño', 'Expert ITSM', 'JJP', '', '', 'Madrid, Spain', 'jesus.jimenez.patino@devoteam.com', '', NULL),
(74, 1, 'Manuel Barrajón Casado', 'Expert ITSM', 'MBC', '', '', 'Madrid, Spain', 'manuel.barrajon.casado@devoteam.com', '', NULL),
(75, 1, 'Marie Casimir', 'Experte N2 ITSM', 'MCA', '', '', '8, rue Claude-Marie Perroud, 31100 Toulouse', 'marie.casimir@devoteam.com', '', '');

-- --------------------------------------------------------

--
-- Structure de la table `contentfile`
--

DROP TABLE IF EXISTS `contentfile`;
CREATE TABLE IF NOT EXISTS `contentfile` (
`idContentFile` int(10) unsigned NOT NULL,
  `content` mediumblob,
  `extension` varchar(10) DEFAULT NULL,
  `mime` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `contracttype`
--

DROP TABLE IF EXISTS `contracttype`;
CREATE TABLE IF NOT EXISTS `contracttype` (
`IdContractType` int(11) NOT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `contracttype`
--

INSERT INTO `contracttype` (`IdContractType`, `Description`, `idCompany`) VALUES
(1, 'Récurrent', 1),
(2, 'Unités d''oeuvre', 1),
(3, 'Devis', 1);

-- --------------------------------------------------------

--
-- Structure de la table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
`IdCustomer` int(11) NOT NULL,
  `IdCompany` int(11) DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `idCustomerType` int(10) unsigned DEFAULT NULL,
  `description` varchar(500) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `customer`
--

INSERT INTO `customer` (`IdCustomer`, `IdCompany`, `name`, `idCustomerType`, `description`) VALUES
(7, 1, 'Airbus', 4, 'Airbus is a leading aircraft manufacturer, with the most modern and comprehensive aircraft family.'),
(8, 1, 'La Banque Postale', 5, 'La Banque postale est une banque publique française héritière des services financiers de La Poste.'),
(9, 1, 'CEA - DAM', 5, 'Le CEA, branche militaire, est un organisme de recherche sur les énergies ...'),
(10, 1, 'Airbus Helicopters', 4, 'Airbus Helicopters est le premier fabricant d''hélicoptères civils ...'),
(11, 1, 'Interne', 5, ''),
(12, 1, 'Total', 4, NULL),
(13, 1, 'SANOFI', 4, 'Notre métier est de soigner et d’aider ceux qui soignent, de prévenir les maladies'),
(14, 1, 'CEGID', 5, 'Éditeur de solutions de gestion'),
(15, 1, 'EDF', 1, 'EDF pour les clients particuliers, professionnels et collectivités locales.');

-- --------------------------------------------------------

--
-- Structure de la table `customertype`
--

DROP TABLE IF EXISTS `customertype`;
CREATE TABLE IF NOT EXISTS `customertype` (
`idCustomerType` int(10) unsigned NOT NULL,
  `idCompany` int(11) NOT NULL,
  `name` varchar(75) NOT NULL,
  `description` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `customertype`
--

INSERT INTO `customertype` (`idCustomerType`, `idCompany`, `name`, `description`) VALUES
(1, 1, 'Secteur primaire', 'Le secteur primaire comprend l''agriculture, la pêche, l''exploitation forestière et l''exploitation minière.'),
(4, 1, 'Secteur secondaire', 'On désigne parfois les trois dernières industries par « autres industries primaires ». Les industries\nprimaires sont liées à l''extraction des ressources de la terre et à l''agriculture.'),
(5, 1, 'Secteur tertiaire', 'On désigne parfois les trois dernières industries par « autres industries primaires ». Les industries\nprimaires sont liées à l''extraction des ressources de la terre et à l''agriculture.');

-- --------------------------------------------------------

--
-- Structure de la table `directcosts`
--

DROP TABLE IF EXISTS `directcosts`;
CREATE TABLE IF NOT EXISTS `directcosts` (
`IdDirectCosts` int(11) NOT NULL,
  `IdBudgetAccount` int(11) DEFAULT NULL,
  `IdProjectCosts` int(11) DEFAULT NULL,
  `Planned` double DEFAULT NULL,
  `Actual` double DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `directcosts`
--

INSERT INTO `directcosts` (`IdDirectCosts`, `IdBudgetAccount`, `IdProjectCosts`, `Planned`, `Actual`, `Description`) VALUES
(1, 1, 18, 10000, 4000, '30 jours'),
(2, 1, 16, 3000, NULL, '10 jours d''opérations'),
(3, 1, 32, 39000, 10500, 'Patrice Prouzat à 80%'),
(4, 1, 32, 85000, 23300, 'Stéphan Peccini à 80%'),
(5, 1, 70, 45144, NULL, '');

-- --------------------------------------------------------

--
-- Structure de la table `documentation`
--

DROP TABLE IF EXISTS `documentation`;
CREATE TABLE IF NOT EXISTS `documentation` (
`idDocumentation` int(10) unsigned NOT NULL,
  `nameFile` varchar(150) DEFAULT NULL,
  `namePopup` varchar(250) NOT NULL,
  `idCompany` int(11) NOT NULL,
  `idContentFile` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `documentproject`
--

DROP TABLE IF EXISTS `documentproject`;
CREATE TABLE IF NOT EXISTS `documentproject` (
`idDocumentProject` int(10) unsigned NOT NULL,
  `idProject` int(11) NOT NULL,
  `link` varchar(200) DEFAULT NULL,
  `type` varchar(25) NOT NULL,
  `mime` varchar(100) DEFAULT NULL,
  `extension` varchar(10) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL,
  `contentComment` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `employee`
--

DROP TABLE IF EXISTS `employee`;
CREATE TABLE IF NOT EXISTS `employee` (
`idEmployee` int(11) NOT NULL,
  `costRate` double DEFAULT NULL,
  `idContact` int(11) DEFAULT NULL,
  `idPerfOrg` int(11) DEFAULT NULL,
  `idProfile` int(11) DEFAULT NULL,
  `profileDate` date DEFAULT NULL,
  `idResourceManager` int(11) DEFAULT NULL,
  `token` varchar(30) DEFAULT NULL,
  `idCalendarBase` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `employee`
--

INSERT INTO `employee` (`idEmployee`, `costRate`, `idContact`, `idPerfOrg`, `idProfile`, `profileDate`, `idResourceManager`, `token`, `idCalendarBase`) VALUES
(10, NULL, 10, NULL, 10, '2012-07-31', NULL, NULL, NULL),
(13, 0, 11, 1, 7, '2014-11-19', NULL, NULL, NULL),
(17, 264, 13, 1, 1, '2014-11-24', 28, NULL, 1),
(18, 0, 12, 1, 4, '2014-11-19', NULL, NULL, NULL),
(23, 0, 11, NULL, 9, '2014-11-19', NULL, NULL, NULL),
(24, 493, 12, 1, 1, '2014-12-04', 29, NULL, 1),
(25, 0, 11, 1, 4, '2014-11-20', NULL, NULL, NULL),
(26, 0, 12, 1, 7, '2014-11-20', NULL, NULL, NULL),
(27, 0, 12, 1, 3, '2014-11-20', NULL, NULL, NULL),
(28, 0, 11, 1, 6, '2014-11-20', NULL, NULL, NULL),
(29, 0, 12, 1, 6, '2014-11-20', NULL, NULL, NULL),
(30, 0, 14, 1, 5, '2014-11-20', NULL, NULL, NULL),
(31, 0, 16, 1, 5, '2014-11-20', NULL, NULL, NULL),
(32, 0, 15, 1, 5, '2014-11-20', NULL, NULL, NULL),
(33, 0, 18, 1, 5, '2014-11-20', NULL, NULL, NULL),
(34, 0, 19, 1, 2, '2014-11-20', NULL, NULL, NULL),
(35, 284, 19, 1, 1, '2014-12-04', 28, NULL, 1),
(36, 0, 11, 1, 5, '2014-11-20', NULL, NULL, NULL),
(37, 304, 20, 1, 1, '2014-12-22', 28, NULL, 1),
(38, 0, 21, 1, 2, '2014-11-20', NULL, NULL, NULL),
(39, 264, 21, 1, 1, '2015-02-12', 28, NULL, 1),
(40, 0, 18, 1, 2, '2014-11-20', NULL, NULL, NULL),
(41, 0, 11, 1, 3, '2014-11-20', NULL, NULL, NULL),
(42, 0, 12, 1, 8, '2014-11-20', NULL, NULL, NULL),
(43, 0, 16, 1, 2, '2014-11-20', NULL, NULL, NULL),
(44, 0, 12, 1, 5, '2014-11-21', NULL, NULL, NULL),
(45, 0, 12, 1, 2, '2014-11-21', NULL, NULL, NULL),
(46, 443, 11, 1, 1, '2014-11-21', 29, NULL, 1),
(47, 0, 11, 1, 2, '2014-11-21', NULL, NULL, NULL),
(48, 479, 22, 6, 1, '2014-11-21', 29, NULL, 1),
(49, 0, 22, 6, 2, '2014-11-21', NULL, NULL, NULL),
(50, 0, 22, 6, 5, '2014-11-21', NULL, NULL, NULL),
(51, 0, 22, 6, 3, '2014-11-21', NULL, NULL, NULL),
(53, 386, 16, 1, 1, '2014-11-21', 28, NULL, 1),
(54, 0, 22, 6, 7, '2014-11-21', NULL, NULL, NULL),
(55, 375, 23, 6, 1, '2015-03-16', 28, NULL, 1),
(56, 0, 23, 6, 2, '2014-11-21', NULL, NULL, NULL),
(57, 0, 23, 6, 5, '2014-11-21', NULL, NULL, NULL),
(58, 479, 24, 6, 1, '2014-11-21', 29, NULL, 1),
(59, 0, 24, 6, 2, '2014-11-21', NULL, NULL, NULL),
(60, 0, 24, 6, 3, '2014-11-21', NULL, NULL, NULL),
(61, 0, 24, 6, 5, '2014-11-21', NULL, NULL, NULL),
(62, 0, 24, 6, 7, '2014-11-21', NULL, NULL, NULL),
(63, 358, 25, 1, 1, '2015-03-06', 28, NULL, 1),
(64, 264, 26, 1, 1, '2014-11-24', 28, NULL, 1),
(65, 334, 27, 1, 1, '2015-01-29', 28, NULL, 3),
(66, 334, 28, 1, 1, '2014-11-24', 28, NULL, 1),
(67, 284, 29, 1, 1, '2014-11-24', 28, NULL, 1),
(68, 304, 30, 1, 1, '2014-12-04', 28, NULL, 1),
(69, 264, 31, 1, 1, '2014-11-24', 28, NULL, 1),
(70, 304, 32, 1, 1, '2014-11-24', 28, NULL, 1),
(71, 304, 33, 1, 1, '2014-12-16', 28, NULL, 1),
(72, 304, 34, 1, 1, '2014-12-19', 28, NULL, 1),
(73, 186, 35, 1, 1, '2014-11-24', 28, NULL, 1),
(74, 386, 36, 1, 1, '2015-01-23', 28, NULL, 1),
(75, 305, 37, 1, 1, '2014-11-24', 28, NULL, 1),
(76, 264, 38, 1, 1, '2014-11-24', 28, NULL, 1),
(77, 304, 39, 1, 1, '2014-11-24', 28, NULL, 1),
(78, 304, 40, 1, 1, '2014-11-24', 28, NULL, 1),
(79, 264, 41, 1, 1, '2014-11-24', 28, NULL, 1),
(80, 304, 42, 1, 1, '2014-11-24', 28, NULL, 1),
(81, 264, 43, 1, 1, '2014-11-24', 28, NULL, 1),
(82, 280, 44, 1, 1, '2014-12-19', 28, NULL, 2),
(83, 300, 45, 1, 1, '2014-12-18', 28, NULL, 2),
(84, 264, 46, 1, 1, '2014-11-24', 28, NULL, 1),
(85, 418, 47, 1, 1, '2014-11-24', 28, NULL, 1),
(86, 186, 48, 1, 1, '2014-11-24', 28, NULL, 1),
(94, 0, 49, NULL, 9, '2014-11-26', NULL, NULL, NULL),
(95, 0, 15, 1, 2, '2014-12-03', NULL, NULL, NULL),
(96, 110, 50, 7, 1, '2014-12-03', 28, NULL, 1),
(97, 110, 51, 7, 1, '2014-12-03', 28, NULL, 1),
(98, 0, 14, 1, 2, '2014-12-04', NULL, NULL, NULL),
(99, 0, 17, 1, 4, '2014-12-04', NULL, NULL, NULL),
(100, 0, 17, 1, 2, '2014-12-04', NULL, NULL, NULL),
(101, 413, 14, 1, 1, '2015-01-29', 28, NULL, 1),
(102, 386, 15, 1, 1, '2015-01-14', 28, NULL, 1),
(103, 413, 52, 1, 1, '2014-12-18', 28, NULL, 1),
(104, 0, 52, 1, 2, '2014-12-18', NULL, NULL, NULL),
(105, 0, 53, NULL, 9, '2014-12-23', NULL, NULL, NULL),
(106, 348, 54, 6, 1, '2014-12-29', 28, NULL, 1),
(107, NULL, 12, 6, 7, '2014-12-29', NULL, NULL, NULL),
(108, NULL, 12, 7, 7, '2014-12-29', NULL, NULL, NULL),
(109, 334, 18, 1, 1, '2014-12-31', 28, NULL, 1),
(111, NULL, 12, 9, 7, '2015-01-09', NULL, NULL, NULL),
(112, 295, 55, 9, 1, '2015-01-09', 29, NULL, 1),
(113, 0, 56, NULL, 9, '2015-01-13', NULL, NULL, NULL),
(114, 0, 12, NULL, 9, '2015-01-15', NULL, NULL, NULL),
(115, 0, 57, 1, 4, '2015-01-16', NULL, NULL, NULL),
(116, 0, 36, 1, 7, '2015-01-29', NULL, NULL, NULL),
(117, 381, 58, 1, 1, '2015-02-04', 28, NULL, 1),
(118, 0, 27, 1, 7, '2015-02-05', NULL, NULL, NULL),
(119, 0, 32, 1, 2, '2015-02-05', NULL, NULL, NULL),
(120, 0, 38, 1, 2, '2015-02-05', NULL, NULL, NULL),
(121, 0, 46, 1, 2, '2015-02-05', NULL, NULL, NULL),
(122, NULL, 12, 10, 7, '2015-02-13', NULL, NULL, NULL),
(123, 385, 59, 10, 1, '2015-02-13', 29, NULL, 1),
(124, 386, 60, 1, 1, '2015-02-16', 28, NULL, 1),
(125, 0, 60, 1, 2, '2015-02-16', NULL, NULL, NULL),
(126, 0, 30, 1, 2, '2015-02-19', NULL, NULL, NULL),
(127, 386, 61, 1, 1, '2015-03-02', 28, NULL, 1),
(128, 0, 61, 1, 2, '2015-02-23', NULL, NULL, NULL),
(129, 324, 62, 6, 1, '2015-03-11', 29, NULL, 1),
(130, 0, 25, 1, 2, '2015-03-05', NULL, NULL, NULL),
(131, 324, 64, 1, 1, '2015-03-06', 28, NULL, 1),
(132, 0, 65, 1, 1, '2015-03-06', 28, NULL, 1),
(134, 0, 58, 1, 2, '2015-03-11', NULL, NULL, NULL),
(135, NULL, 12, 11, 7, '2015-03-13', NULL, NULL, NULL),
(136, NULL, 12, 12, 7, '2015-03-13', NULL, NULL, NULL),
(137, 280, 67, 1, 1, '2015-03-13', 29, NULL, 1),
(138, 280, 68, 1, 1, '2015-03-16', 29, NULL, 1),
(139, 264, 69, 1, 1, '2015-03-16', 28, NULL, 1),
(140, 234, 70, 11, 1, '2015-03-16', 29, NULL, 1),
(141, 0, 16, 1, 4, '2015-03-18', NULL, NULL, NULL),
(142, 430, 71, 1, 1, '2015-03-20', 28, NULL, 1),
(143, 0, 71, 1, 7, '2015-03-27', NULL, NULL, NULL),
(144, 0, 27, 1, 2, '2015-03-27', NULL, NULL, NULL),
(145, 0, 71, 1, 2, '2015-03-27', NULL, NULL, NULL),
(146, 304, 72, 1, 1, '2015-03-30', 28, NULL, 1),
(147, 0, 72, 1, 2, '2015-03-30', NULL, NULL, NULL),
(148, 0, 23, 1, 7, '2015-03-31', NULL, NULL, NULL),
(149, 190, 73, 11, 1, '2015-04-08', 29, NULL, 1),
(150, 190, 74, 1, 1, '2015-04-22', 29, NULL, 1),
(151, 264, 75, 1, 1, '2015-04-27', 28, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `expenseaccounts`
--

DROP TABLE IF EXISTS `expenseaccounts`;
CREATE TABLE IF NOT EXISTS `expenseaccounts` (
`IdExpenseAccount` int(11) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `expenseaccounts`
--

INSERT INTO `expenseaccounts` (`IdExpenseAccount`, `Description`, `idCompany`) VALUES
(1, 'Expense account 1', 1),
(2, 'Expense account 2', 1),
(3, 'Expense account 3', 1);

-- --------------------------------------------------------

--
-- Structure de la table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
CREATE TABLE IF NOT EXISTS `expenses` (
`IdExpense` int(11) NOT NULL,
  `IdBudgetAccount` int(11) DEFAULT NULL,
  `IdProjectCosts` int(11) DEFAULT NULL,
  `Planned` double DEFAULT NULL,
  `Actual` double DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `expenses`
--

INSERT INTO `expenses` (`IdExpense`, `IdBudgetAccount`, `IdProjectCosts`, `Planned`, `Actual`, `Description`) VALUES
(1, 2, 23, 4500, NULL, 'Frais pour déplacement des comités'),
(2, 2, 16, 15000, NULL, 'Serveurs et moyens associés');

-- --------------------------------------------------------

--
-- Structure de la table `expensesheet`
--

DROP TABLE IF EXISTS `expensesheet`;
CREATE TABLE IF NOT EXISTS `expensesheet` (
`idExpenseSheet` int(10) unsigned NOT NULL,
  `idProject` int(11) DEFAULT NULL,
  `idOperation` int(11) DEFAULT NULL,
  `idExpenseAccount` int(11) DEFAULT NULL,
  `idEmployee` int(11) NOT NULL,
  `cost` double DEFAULT NULL,
  `reimbursable` bit(1) DEFAULT NULL,
  `paidEmployee` bit(1) DEFAULT NULL,
  `expenseDate` date DEFAULT NULL,
  `autorizationNumber` int(11) DEFAULT NULL,
  `description` varchar(150) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `idExpense` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `expensesheetcomment`
--

DROP TABLE IF EXISTS `expensesheetcomment`;
CREATE TABLE IF NOT EXISTS `expensesheetcomment` (
`idExpenseSheetComment` int(10) unsigned NOT NULL,
  `idExpenseSheet` int(10) unsigned NOT NULL,
  `previousStatus` varchar(10) NOT NULL,
  `actualStatus` varchar(10) NOT NULL,
  `commentDate` datetime NOT NULL,
  `contentComment` varchar(1000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `fundingsource`
--

DROP TABLE IF EXISTS `fundingsource`;
CREATE TABLE IF NOT EXISTS `fundingsource` (
`idFundingSource` int(10) unsigned NOT NULL,
  `name` varchar(80) NOT NULL,
  `idCompany` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `fundingsource`
--

INSERT INTO `fundingsource` (`idFundingSource`, `name`, `idCompany`) VALUES
(1, 'Budget Management CdS 2014', 1),
(2, 'Budget Formation 2015', 1),
(3, 'Budget Absences 2014', 1),
(4, 'Budget investissement 2014', 1),
(5, 'Budget investissement 2015', 1),
(6, 'Budget Airbus Helicopters - TMA S400', 1),
(7, 'Budget CEA - DAM 2015', 1),
(8, 'Budget Absences 2015', 1),
(9, 'Budget OPUS 2015', 1),
(10, 'Avant-Vente 2015', 1),
(11, 'Budget Management CdS 2015', 1);

-- --------------------------------------------------------

--
-- Structure de la table `geography`
--

DROP TABLE IF EXISTS `geography`;
CREATE TABLE IF NOT EXISTS `geography` (
`idGeography` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `geography`
--

INSERT INTO `geography` (`idGeography`, `name`, `description`, `idCompany`) VALUES
(9, 'Toulouse', '', 1);

-- --------------------------------------------------------

--
-- Structure de la table `incomes`
--

DROP TABLE IF EXISTS `incomes`;
CREATE TABLE IF NOT EXISTS `incomes` (
`idIncome` int(11) NOT NULL,
  `idProject` int(11) NOT NULL,
  `plannedBillDate` date DEFAULT NULL,
  `plannedBillAmmount` double DEFAULT NULL,
  `actualBillDate` date DEFAULT NULL,
  `actualBillAmmount` double DEFAULT NULL,
  `plannedDescription` varchar(200) DEFAULT NULL,
  `actualDescription` varchar(200) DEFAULT NULL,
  `actualPaymentDate` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `incomes`
--

INSERT INTO `incomes` (`idIncome`, `idProject`, `plannedBillDate`, `plannedBillAmmount`, `actualBillDate`, `actualBillAmmount`, `plannedDescription`, `actualDescription`, `actualPaymentDate`) VALUES
(1, 21, '2014-12-05', 3333, NULL, NULL, 'Prorata sur 1 mois de la commande du WP3', NULL, NULL),
(2, 18, '2015-02-28', 1500, NULL, NULL, 'Stagiaire sur 3 mois', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `issuelog`
--

DROP TABLE IF EXISTS `issuelog`;
CREATE TABLE IF NOT EXISTS `issuelog` (
`IdIssue` int(11) NOT NULL,
  `IdProject` int(11) DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Priority` char(1) DEFAULT NULL,
  `DateLogged` date DEFAULT NULL,
  `Originator` varchar(100) DEFAULT NULL,
  `AssignedTo` varchar(100) DEFAULT NULL,
  `TargetDate` date DEFAULT NULL,
  `Resolution` varchar(300) DEFAULT NULL,
  `DateClosed` date DEFAULT NULL,
  `IssueDoc` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `iwo`
--

DROP TABLE IF EXISTS `iwo`;
CREATE TABLE IF NOT EXISTS `iwo` (
`IdIWO` int(11) NOT NULL,
  `IdProjectCosts` int(11) DEFAULT NULL,
  `Planned` double DEFAULT NULL,
  `Actual` double DEFAULT NULL,
  `Description` varchar(50) DEFAULT NULL,
  `IWODoc` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `logprojectstatus`
--

DROP TABLE IF EXISTS `logprojectstatus`;
CREATE TABLE IF NOT EXISTS `logprojectstatus` (
`idLogProjectStatus` int(10) unsigned NOT NULL,
  `idProject` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `projectStatus` char(1) NOT NULL,
  `investmentStatus` char(1) NOT NULL,
  `logDate` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `logprojectstatus`
--

INSERT INTO `logprojectstatus` (`idLogProjectStatus`, `idProject`, `idEmployee`, `projectStatus`, `investmentStatus`, `logDate`) VALUES
(13, 7, 26, 'I', 'P', '2014-11-21 08:07:33'),
(14, 7, 27, 'P', 'A', '2014-11-21 08:11:46'),
(15, 7, 45, 'C', 'A', '2014-11-21 08:25:07'),
(16, 8, 26, 'I', 'P', '2014-11-21 08:29:29'),
(17, 8, 26, 'P', 'A', '2014-11-21 10:46:02'),
(18, 8, 26, 'C', 'A', '2014-11-21 10:46:30'),
(19, 9, 26, 'I', 'P', '2014-11-21 10:53:42'),
(20, 9, 26, 'P', 'A', '2014-11-21 11:00:00'),
(21, 9, 26, 'C', 'A', '2014-11-21 11:03:24'),
(22, 10, 26, 'I', 'P', '2014-11-21 11:05:22'),
(23, 10, 26, 'P', 'A', '2014-11-21 11:29:05'),
(24, 10, 26, 'C', 'A', '2014-11-21 11:29:18'),
(29, 13, 26, 'I', 'P', '2014-11-21 13:47:09'),
(30, 14, 26, 'I', 'P', '2014-11-26 17:59:09'),
(32, 16, 26, 'I', 'P', '2014-11-27 08:41:50'),
(34, 18, 27, 'I', 'P', '2014-11-27 12:10:57'),
(35, 19, 26, 'I', 'P', '2014-12-03 16:12:51'),
(36, 19, 27, 'P', 'A', '2014-12-03 17:49:55'),
(37, 19, 95, 'C', 'A', '2014-12-03 17:50:46'),
(38, 20, 26, 'I', 'P', '2014-12-04 07:59:29'),
(39, 21, 26, 'I', 'P', '2014-12-04 08:07:18'),
(40, 22, 26, 'I', 'P', '2014-12-04 08:27:30'),
(41, 23, 26, 'I', 'P', '2014-12-04 12:45:31'),
(42, 24, 26, 'I', 'P', '2014-12-04 13:01:20'),
(43, 25, 26, 'I', 'P', '2014-12-04 15:36:29'),
(44, 25, 26, 'P', 'A', '2014-12-04 16:29:56'),
(45, 25, 100, 'C', 'A', '2014-12-04 16:30:25'),
(46, 26, 26, 'I', 'P', '2014-12-04 17:42:05'),
(47, 27, 26, 'I', 'P', '2014-12-16 15:25:20'),
(48, 27, 27, 'P', 'A', '2014-12-16 15:30:16'),
(49, 27, 26, 'C', 'A', '2014-12-16 15:31:37'),
(50, 28, 26, 'I', 'P', '2014-12-16 16:20:57'),
(51, 29, 26, 'I', 'P', '2014-12-16 16:34:07'),
(52, 30, 26, 'I', 'P', '2014-12-16 16:42:17'),
(53, 31, 26, 'I', 'P', '2014-12-16 16:46:22'),
(54, 14, 27, 'P', 'A', '2014-12-16 18:29:02'),
(55, 14, 26, 'C', 'A', '2014-12-16 18:30:31'),
(56, 14, 26, 'X', 'C', '2014-12-16 18:32:39'),
(57, 32, 26, 'I', 'P', '2014-12-16 18:36:31'),
(58, 32, 27, 'P', 'A', '2014-12-16 18:52:21'),
(59, 32, 26, 'C', 'A', '2014-12-16 18:53:11'),
(62, 33, 26, 'I', 'P', '2014-12-19 07:13:26'),
(63, 33, 27, 'P', 'A', '2014-12-19 07:14:44'),
(64, 33, 26, 'C', 'A', '2014-12-19 07:15:23'),
(65, 34, 26, 'I', 'P', '2014-12-22 15:46:56'),
(66, 34, 26, 'P', 'A', '2014-12-22 16:17:54'),
(67, 34, 26, 'C', 'A', '2014-12-22 16:18:14'),
(68, 18, 26, 'P', 'A', '2014-12-23 14:06:47'),
(69, 18, 26, 'C', 'A', '2014-12-23 15:55:13'),
(70, 22, 26, 'P', 'A', '2014-12-29 14:50:26'),
(71, 22, 26, 'C', 'A', '2014-12-29 14:51:02'),
(72, 20, 26, 'P', 'A', '2014-12-29 14:51:18'),
(73, 20, 26, 'C', 'A', '2014-12-29 14:51:35'),
(74, 23, 26, 'P', 'A', '2014-12-29 15:32:13'),
(75, 23, 26, 'C', 'A', '2014-12-29 15:32:39'),
(76, 24, 26, 'P', 'A', '2014-12-29 15:37:41'),
(77, 21, 26, 'P', 'A', '2014-12-29 15:37:46'),
(78, 24, 26, 'C', 'A', '2014-12-30 16:12:35'),
(79, 21, 26, 'C', 'A', '2014-12-30 16:13:41'),
(80, 30, 26, 'P', 'A', '2015-01-09 15:33:59'),
(81, 30, 40, 'C', 'A', '2015-01-09 15:34:58'),
(82, 29, 26, 'P', 'A', '2015-01-09 16:06:10'),
(83, 28, 26, 'P', 'A', '2015-01-09 16:07:18'),
(84, 7, 45, 'X', 'C', '2015-01-14 15:36:41'),
(85, 35, 27, 'I', 'P', '2015-01-15 08:50:26'),
(86, 35, 27, 'P', 'A', '2015-01-15 08:55:47'),
(87, 35, 45, 'C', 'A', '2015-01-20 11:41:20'),
(88, 28, 40, 'C', 'A', '2015-01-29 23:04:40'),
(89, 29, 26, 'C', 'A', '2015-01-30 12:39:01'),
(90, 36, 26, 'I', 'P', '2015-02-05 11:20:44'),
(91, 36, 26, 'P', 'A', '2015-02-05 11:21:31'),
(92, 37, 26, 'I', 'P', '2015-02-05 11:48:07'),
(93, 37, 26, 'P', 'A', '2015-02-05 13:20:48'),
(94, 38, 118, 'I', 'P', '2015-02-05 17:39:44'),
(95, 38, 118, 'P', 'A', '2015-02-05 17:40:56'),
(96, 39, 26, 'I', 'P', '2015-02-06 07:29:12'),
(97, 39, 26, 'P', 'A', '2015-02-06 07:40:09'),
(98, 40, 26, 'I', 'P', '2015-02-06 07:41:03'),
(99, 40, 26, 'P', 'A', '2015-02-06 07:41:29'),
(100, 41, 26, 'I', 'P', '2015-02-06 07:42:35'),
(101, 41, 26, 'P', 'A', '2015-02-06 07:42:58'),
(104, 38, 118, 'C', 'A', '2015-02-10 14:15:03'),
(105, 39, 120, 'C', 'A', '2015-02-10 14:30:58'),
(106, 43, 26, 'I', 'P', '2015-02-11 14:46:59'),
(107, 43, 26, 'P', 'A', '2015-02-11 14:49:46'),
(108, 37, 119, 'C', 'A', '2015-02-12 10:55:35'),
(109, 44, 26, 'I', 'P', '2015-02-13 06:53:52'),
(110, 44, 26, 'P', 'A', '2015-02-13 07:05:42'),
(111, 45, 26, 'I', 'P', '2015-02-13 07:09:25'),
(112, 45, 26, 'P', 'A', '2015-02-13 07:11:27'),
(113, 46, 26, 'I', 'P', '2015-02-13 07:14:00'),
(114, 46, 26, 'P', 'A', '2015-02-13 07:26:08'),
(115, 47, 26, 'I', 'P', '2015-02-13 07:36:22'),
(116, 47, 26, 'P', 'A', '2015-02-13 07:40:10'),
(117, 48, 26, 'I', 'P', '2015-02-13 07:43:23'),
(118, 48, 26, 'P', 'A', '2015-02-13 07:46:50'),
(119, 49, 26, 'I', 'P', '2015-02-13 07:49:09'),
(120, 49, 26, 'P', 'A', '2015-02-13 07:51:18'),
(121, 50, 26, 'I', 'P', '2015-02-16 07:38:00'),
(122, 51, 26, 'I', 'P', '2015-02-16 07:42:30'),
(123, 52, 26, 'I', 'P', '2015-02-16 07:44:50'),
(124, 53, 26, 'I', 'P', '2015-02-16 07:49:14'),
(125, 54, 26, 'I', 'P', '2015-02-16 07:51:56'),
(126, 55, 26, 'I', 'P', '2015-02-16 07:53:07'),
(127, 55, 26, 'P', 'A', '2015-02-16 07:55:12'),
(128, 53, 26, 'P', 'A', '2015-02-16 07:55:16'),
(129, 54, 26, 'P', 'A', '2015-02-16 07:55:20'),
(130, 52, 26, 'P', 'A', '2015-02-16 07:55:30'),
(131, 50, 26, 'P', 'A', '2015-02-16 07:55:36'),
(132, 51, 26, 'P', 'A', '2015-02-16 07:55:42'),
(133, 31, 26, 'P', 'A', '2015-02-16 07:55:54'),
(134, 16, 26, 'P', 'A', '2015-02-16 07:56:45'),
(135, 56, 26, 'I', 'P', '2015-02-16 11:00:59'),
(136, 56, 26, 'P', 'A', '2015-02-16 11:26:07'),
(137, 57, 41, 'I', 'P', '2015-02-17 15:17:46'),
(138, 58, 26, 'I', 'P', '2015-02-19 15:31:57'),
(139, 59, 26, 'I', 'P', '2015-02-19 15:37:09'),
(140, 58, 26, 'P', 'A', '2015-02-19 15:38:24'),
(141, 59, 26, 'P', 'A', '2015-02-19 15:38:29'),
(142, 60, 26, 'I', 'P', '2015-02-19 15:39:59'),
(143, 60, 26, 'P', 'A', '2015-02-19 15:41:23'),
(144, 61, 26, 'I', 'P', '2015-02-19 15:48:17'),
(145, 61, 26, 'P', 'A', '2015-02-19 15:57:12'),
(146, 44, 40, 'C', 'A', '2015-02-23 00:03:53'),
(147, 46, 40, 'C', 'A', '2015-02-23 00:34:45'),
(148, 45, 40, 'C', 'A', '2015-02-23 22:10:52'),
(149, 48, 40, 'C', 'A', '2015-02-24 17:35:59'),
(150, 57, 26, 'P', 'A', '2015-02-25 08:10:25'),
(151, 56, 121, 'C', 'A', '2015-02-25 14:43:24'),
(152, 49, 40, 'C', 'A', '2015-02-25 23:52:47'),
(153, 35, 45, 'X', 'C', '2015-03-02 06:59:30'),
(154, 47, 40, 'C', 'A', '2015-03-04 00:20:16'),
(155, 26, 26, 'P', 'A', '2015-03-04 18:45:22'),
(156, 13, 26, 'X', 'I', '2015-03-04 18:46:13'),
(157, 26, 43, 'C', 'A', '2015-03-05 11:57:50'),
(158, 36, 43, 'C', 'A', '2015-03-05 14:49:31'),
(159, 51, 43, 'C', 'A', '2015-03-09 15:11:16'),
(160, 54, 43, 'C', 'A', '2015-03-09 15:18:38'),
(161, 40, 120, 'C', 'A', '2015-03-10 14:25:26'),
(162, 62, 26, 'I', 'P', '2015-03-11 06:59:39'),
(163, 63, 26, 'I', 'P', '2015-03-11 07:18:50'),
(164, 64, 26, 'I', 'P', '2015-03-11 07:24:22'),
(165, 65, 26, 'I', 'P', '2015-03-11 07:26:17'),
(166, 66, 26, 'I', 'P', '2015-03-11 07:28:21'),
(167, 13, 26, 'I', 'P', '2015-03-11 07:30:37'),
(168, 13, 26, 'X', 'R', '2015-03-11 07:30:50'),
(169, 64, 26, 'P', 'A', '2015-03-11 07:32:28'),
(170, 62, 26, 'P', 'A', '2015-03-11 07:32:32'),
(171, 63, 26, 'P', 'A', '2015-03-11 07:32:36'),
(172, 65, 26, 'P', 'A', '2015-03-11 07:32:41'),
(173, 66, 26, 'P', 'A', '2015-03-11 07:32:45'),
(174, 62, 125, 'C', 'A', '2015-03-11 09:13:52'),
(175, 57, 118, 'C', 'A', '2015-03-12 10:43:28'),
(176, 31, 121, 'C', 'A', '2015-03-12 11:39:13'),
(177, 65, 118, 'C', 'A', '2015-03-12 14:51:24'),
(178, 64, 118, 'C', 'A', '2015-03-12 14:52:17'),
(179, 66, 134, 'C', 'A', '2015-03-12 15:19:23'),
(180, 67, 26, 'I', 'P', '2015-03-12 16:06:22'),
(181, 68, 26, 'I', 'P', '2015-03-12 16:08:47'),
(182, 68, 26, 'P', 'A', '2015-03-12 16:09:28'),
(183, 67, 26, 'P', 'A', '2015-03-12 16:09:31'),
(184, 68, 134, 'C', 'A', '2015-03-12 16:20:38'),
(185, 67, 34, 'C', 'A', '2015-03-13 16:38:34'),
(186, 69, 26, 'I', 'P', '2015-03-16 10:27:54'),
(187, 50, 98, 'C', 'A', '2015-03-17 13:40:16'),
(188, 53, 98, 'C', 'A', '2015-03-17 13:40:29'),
(189, 58, 38, 'C', 'A', '2015-03-17 13:45:02'),
(190, 60, 38, 'C', 'A', '2015-03-17 13:45:24'),
(191, 70, 26, 'I', 'P', '2015-03-18 12:30:16'),
(192, 71, 26, 'I', 'P', '2015-03-18 12:52:46'),
(193, 71, 26, 'P', 'A', '2015-03-18 12:53:11'),
(194, 70, 26, 'P', 'A', '2015-03-18 12:53:15'),
(195, 55, 95, 'C', 'A', '2015-03-19 16:07:07'),
(196, 52, 95, 'C', 'A', '2015-03-19 17:03:53'),
(197, 8, 26, 'X', 'C', '2015-03-20 07:19:21'),
(198, 72, 26, 'I', 'P', '2015-03-20 08:30:33'),
(199, 73, 26, 'I', 'P', '2015-03-20 08:32:06'),
(200, 69, 26, 'P', 'A', '2015-03-20 08:33:03'),
(201, 73, 26, 'P', 'A', '2015-03-20 08:33:08'),
(202, 72, 26, 'P', 'A', '2015-03-20 08:33:12'),
(203, 72, 134, 'C', 'A', '2015-03-20 14:22:34'),
(204, 73, 95, 'C', 'A', '2015-03-20 15:25:23'),
(205, 70, 56, 'C', 'A', '2015-03-23 07:55:24'),
(206, 74, 26, 'I', 'P', '2015-03-25 12:53:36'),
(207, 75, 26, 'I', 'P', '2015-03-25 13:00:40'),
(208, 76, 26, 'I', 'P', '2015-03-25 13:13:18'),
(209, 77, 26, 'I', 'P', '2015-03-25 13:21:02'),
(210, 77, 26, 'P', 'A', '2015-03-31 15:18:12'),
(211, 76, 26, 'P', 'A', '2015-03-31 15:18:18'),
(212, 75, 26, 'P', 'A', '2015-03-31 15:18:22'),
(213, 74, 26, 'P', 'A', '2015-03-31 15:18:27'),
(214, 78, 26, 'I', 'P', '2015-04-01 16:56:55'),
(215, 78, 26, 'P', 'A', '2015-04-01 16:59:17'),
(216, 79, 26, 'I', 'P', '2015-04-01 17:06:30'),
(217, 79, 26, 'P', 'A', '2015-04-01 17:08:28'),
(218, 28, 121, 'X', 'C', '2015-04-02 14:46:32'),
(219, 25, 40, 'X', 'C', '2015-04-03 16:20:35'),
(220, 78, 121, 'C', 'A', '2015-04-07 10:05:37'),
(221, 80, 26, 'I', 'P', '2015-04-08 12:29:43'),
(222, 81, 26, 'I', 'P', '2015-04-08 12:32:46'),
(223, 82, 26, 'I', 'P', '2015-04-08 12:34:48'),
(224, 81, 26, 'P', 'A', '2015-04-08 12:50:40'),
(225, 82, 26, 'P', 'A', '2015-04-08 12:50:45'),
(226, 80, 26, 'P', 'A', '2015-04-08 12:50:50'),
(227, 83, 26, 'I', 'P', '2015-04-08 13:56:19'),
(228, 83, 26, 'P', 'A', '2015-04-08 13:56:43'),
(229, 84, 26, 'I', 'P', '2015-04-09 09:21:55'),
(230, 84, 26, 'P', 'A', '2015-04-09 09:22:33'),
(231, 83, 121, 'C', 'A', '2015-04-09 11:27:57'),
(232, 63, 148, 'C', 'A', '2015-04-10 10:21:01'),
(233, 81, 148, 'C', 'A', '2015-04-13 11:06:14'),
(234, 81, 148, 'C', 'A', '2015-04-13 11:29:13'),
(235, 85, 26, 'I', 'P', '2015-04-13 15:41:31'),
(236, 85, 26, 'P', 'A', '2015-04-13 15:42:55'),
(237, 86, 26, 'I', 'P', '2015-04-13 15:51:49'),
(238, 86, 26, 'P', 'A', '2015-04-13 15:52:49'),
(239, 86, 148, 'C', 'A', '2015-04-13 17:12:58'),
(240, 85, 148, 'C', 'A', '2015-04-14 11:28:07'),
(241, 87, 26, 'I', 'P', '2015-04-15 17:22:16'),
(242, 87, 26, 'P', 'A', '2015-04-15 17:22:58'),
(243, 88, 26, 'I', 'P', '2015-04-16 10:55:33'),
(244, 88, 26, 'P', 'A', '2015-04-16 10:57:48'),
(245, 89, 26, 'I', 'P', '2015-04-17 10:36:22'),
(246, 89, 26, 'P', 'A', '2015-04-17 10:36:56'),
(247, 88, 147, 'C', 'A', '2015-04-20 16:29:30'),
(248, 89, 121, 'C', 'A', '2015-04-21 11:22:57'),
(249, 90, 26, 'I', 'P', '2015-04-21 13:41:24'),
(250, 90, 26, 'P', 'A', '2015-04-21 13:42:32'),
(251, 87, 34, 'C', 'A', '2015-04-23 09:15:29'),
(252, 91, 26, 'I', 'P', '2015-04-23 09:23:58'),
(253, 92, 26, 'I', 'P', '2015-04-23 09:26:00'),
(254, 92, 26, 'P', 'A', '2015-04-23 09:26:41'),
(255, 91, 26, 'P', 'A', '2015-04-23 09:26:45'),
(256, 91, 34, 'C', 'A', '2015-04-23 11:41:57'),
(257, 92, 34, 'C', 'A', '2015-04-23 11:42:11'),
(258, 74, 13, 'C', 'A', '2015-04-23 11:54:11'),
(259, 90, 147, 'C', 'A', '2015-04-24 14:39:26'),
(260, 59, 118, 'C', 'A', '2015-04-27 11:45:53'),
(261, 61, 118, 'C', 'A', '2015-04-27 11:46:11'),
(262, 93, 26, 'I', 'P', '2015-04-27 15:30:05'),
(263, 93, 26, 'P', 'A', '2015-04-27 15:40:33'),
(264, 93, 26, 'C', 'A', '2015-04-27 15:40:56'),
(265, 94, 26, 'I', 'P', '2015-04-27 15:49:00'),
(266, 94, 26, 'P', 'A', '2015-04-27 15:51:30'),
(267, 94, 26, 'C', 'A', '2015-04-27 15:51:53'),
(268, 84, 45, 'C', 'A', '2015-04-29 06:59:38');

-- --------------------------------------------------------

--
-- Structure de la table `metrickpi`
--

DROP TABLE IF EXISTS `metrickpi`;
CREATE TABLE IF NOT EXISTS `metrickpi` (
`idMetricKpi` int(10) unsigned NOT NULL,
  `idBscDimension` int(10) unsigned DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `definition` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `metrickpi`
--

INSERT INTO `metrickpi` (`idMetricKpi`, `idBscDimension`, `name`, `definition`, `idCompany`) VALUES
(1, 1, 'Respect des délais', 'D = contrat, C = constat. KPI = %age de C<D ; 100% < target (=cible DVT) < threshold (=engagement)', 1),
(2, 1, 'Marge du projet', '', 1),
(3, 2, 'Metric KPI 3', NULL, 1),
(4, 2, 'Metric KPI 4', NULL, 1),
(5, 3, 'Metric KPI 5', NULL, 1),
(6, 3, 'Metric KPI 6', NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `milestones`
--

DROP TABLE IF EXISTS `milestones`;
CREATE TABLE IF NOT EXISTS `milestones` (
`IdMilestone` int(11) NOT NULL,
  `IdActivity` int(11) DEFAULT NULL,
  `Description` varchar(200) DEFAULT NULL,
  `Label` varchar(30) DEFAULT NULL,
  `ReportType` char(1) DEFAULT NULL,
  `Planned` date DEFAULT NULL,
  `Achieved` date DEFAULT NULL,
  `IdProject` int(11) NOT NULL,
  `achievedComments` varchar(200) DEFAULT NULL,
  `notify` bit(1) DEFAULT NULL,
  `notifyDays` int(10) unsigned DEFAULT NULL,
  `notificationText` varchar(200) DEFAULT NULL,
  `notifyDate` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `milestones`
--

INSERT INTO `milestones` (`IdMilestone`, `IdActivity`, `Description`, `Label`, `ReportType`, `Planned`, `Achieved`, `IdProject`, `achievedComments`, `notify`, `notifyDays`, `notificationText`, `notifyDate`) VALUES
(3, 11, 'Fin Novembre 2014', '', 'Y', '2014-11-28', '2014-11-28', 7, '', b'0', 0, '', NULL),
(4, 11, 'Fin Décembre 2014', '', 'Y', '2014-12-31', NULL, 7, NULL, b'0', 0, '', NULL),
(7, 88, '', '', 'Y', '2015-01-05', NULL, 34, NULL, b'1', 1, 'BOR2 à 16h30', '2015-01-04'),
(8, 36, 'Lancement du produit', '', 'Y', '2015-01-08', NULL, 18, NULL, b'1', 1, 'Lancement du produit', '2015-01-07'),
(9, 567, '', '', 'Y', '2015-03-27', NULL, 70, NULL, b'0', 0, '', NULL),
(10, 577, '', '', 'N', '2015-04-03', NULL, 70, NULL, b'0', 0, '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `operation`
--

DROP TABLE IF EXISTS `operation`;
CREATE TABLE IF NOT EXISTS `operation` (
`IdOperation` int(11) NOT NULL,
  `OperationName` char(18) DEFAULT NULL,
  `OperationCode` char(18) DEFAULT NULL,
  `IdOpAccount` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `operation`
--

INSERT INTO `operation` (`IdOperation`, `OperationName`, `OperationCode`, `IdOpAccount`) VALUES
(4, 'Attente imputation', 'ATT', 1);

-- --------------------------------------------------------

--
-- Structure de la table `operationaccount`
--

DROP TABLE IF EXISTS `operationaccount`;
CREATE TABLE IF NOT EXISTS `operationaccount` (
`IdOpAccount` int(11) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `operationaccount`
--

INSERT INTO `operationaccount` (`IdOpAccount`, `Description`, `idCompany`) VALUES
(1, 'Collecteur Centre de Services', 1);

-- --------------------------------------------------------

--
-- Structure de la table `performingorg`
--

DROP TABLE IF EXISTS `performingorg`;
CREATE TABLE IF NOT EXISTS `performingorg` (
`IdPerfOrg` int(11) NOT NULL,
  `Manager` int(11) DEFAULT NULL,
  `IdCompany` int(11) DEFAULT NULL,
  `OnSaaS` bit(1) DEFAULT NULL,
  `name` varchar(45) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `performingorg`
--

INSERT INTO `performingorg` (`IdPerfOrg`, `Manager`, `IdCompany`, `OnSaaS`, `name`) VALUES
(1, 18, 1, b'0', 'Centre de Services Toulouse'),
(6, 18, 1, b'0', 'Agence de Toulouse'),
(7, 18, 1, b'0', 'FPT Software'),
(9, 18, 1, b'0', 'Agence de Nantes'),
(10, 18, 1, b'0', 'Massy'),
(11, 18, 1, b'0', 'Centre de Services Madrid'),
(12, 18, 1, b'0', 'Agence de Lyon');

-- --------------------------------------------------------

--
-- Structure de la table `plugin`
--

DROP TABLE IF EXISTS `plugin`;
CREATE TABLE IF NOT EXISTS `plugin` (
`idPlugin` int(10) unsigned NOT NULL,
  `idCompany` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `enabled` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `procurementpayments`
--

DROP TABLE IF EXISTS `procurementpayments`;
CREATE TABLE IF NOT EXISTS `procurementpayments` (
`idProcurementPayment` int(11) NOT NULL,
  `idSeller` int(11) NOT NULL,
  `idProject` int(11) NOT NULL,
  `purchaseOrder` varchar(50) DEFAULT NULL,
  `plannedDate` date DEFAULT NULL,
  `actualDate` date DEFAULT NULL,
  `plannedPayment` double DEFAULT NULL,
  `actualPayment` double DEFAULT NULL,
  `paymentScheduleInfo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `procurementpayments`
--

INSERT INTO `procurementpayments` (`idProcurementPayment`, `idSeller`, `idProject`, `purchaseOrder`, `plannedDate`, `actualDate`, `plannedPayment`, `actualPayment`, `paymentScheduleInfo`) VALUES
(1, 1, 23, 'Intention de commande du Responsable Achats', '2014-12-31', NULL, 2777.05, 0, 'Attente du Purchase Order ; essai de facturation sur l''intention de commande ; facturation au kick-off de 8228 euros au prorata de la part gouvernance dans le fixed price'),
(2, 1, 20, 'Intention de commande du Responsable Achats', '2014-12-31', NULL, 2725, 0, 'Attente du Purchase Order ; essai de facturation sur l''intention de commande ; facturation au kick-off de 8228 euros au prorata de la part WP1 dans le fixed price'),
(3, 1, 22, 'Intention de commande du Responsable Achats', '2014-12-31', NULL, 14692, 0, 'Attente du Purchase Order ; essai de facturation sur l''intention de commande ; 100% au kick-off'),
(4, 1, 23, 'Intention de commande du Responsable Achats', '2014-12-31', NULL, 4165.5, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata de la gouvernance'),
(5, 1, 23, 'Intention de commande du Responsable Achats', '2015-03-31', NULL, 4165.5, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata de la gouvernance'),
(6, 1, 23, 'Intention de commande du Responsable Achats', '2015-06-30', NULL, 4165.5, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata de la gouvernance'),
(7, 1, 23, 'Intention de commande du Responsable Achats', '2015-09-30', NULL, 4165.5, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata de la gouvernance'),
(8, 1, 20, 'Intention de commande du Responsable Achats', '2014-12-31', NULL, 8176.25, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata du WP1'),
(9, 1, 20, 'Intention de commande du Responsable Achats', '2015-03-31', NULL, 8176.25, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata du WP1'),
(10, 1, 20, 'Intention de commande du Responsable Achats', '2015-06-30', NULL, 8176.25, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata du WP1'),
(11, 1, 20, 'Intention de commande du Responsable Achats', '2015-09-30', NULL, 8176.25, 0, 'paiement trimestriel terme a echoir ; 12341,75 euros au prorata du WP1'),
(12, 3, 30, '', '2015-01-01', NULL, 33463, 0, ''),
(13, 7, 44, 'Ã  trouver', '2015-02-27', NULL, 30921, 0, '');

-- --------------------------------------------------------

--
-- Structure de la table `program`
--

DROP TABLE IF EXISTS `program`;
CREATE TABLE IF NOT EXISTS `program` (
`IdProgram` int(11) NOT NULL,
  `ProgramManager` int(11) DEFAULT NULL,
  `ProgramCode` varchar(20) NOT NULL,
  `ProgramName` varchar(50) NOT NULL,
  `ProgramTitle` varchar(50) NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `ProgramDoc` varchar(200) DEFAULT NULL,
  `budget` double DEFAULT NULL,
  `BudgetYear` varchar(4) DEFAULT NULL,
  `idPerfOrg` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `program`
--

INSERT INTO `program` (`IdProgram`, `ProgramManager`, `ProgramCode`, `ProgramName`, `ProgramTitle`, `description`, `ProgramDoc`, `budget`, `BudgetYear`, `idPerfOrg`) VALUES
(3, 30, 'Bundle Tools - ITSM', 'Bundle Tools - ITSM', 'Bundle Tools - ITSM', '', '', 0, '2015', 1),
(5, 32, 'Bundle Tools - NTIC', 'Bundle Tools - NTIC', 'Bundle Tools - NTIC', '', '', 0, '2015', 1),
(6, 31, 'Bundle Tools - BI', 'Bundle Tools - BI', 'Bundle Tools - BI', '', '', 0, '2015', 1),
(7, 33, 'CEA - TMA Nautiles', 'CEA - TMA Nautiles', 'CEA - TMA Nautiles', '', '', 0, '2015', 1),
(8, 33, 'OPUS', 'OPUS', 'OPUS', '', '', 0, '2015', 1),
(9, 33, 'TMA ITSM Total', 'TMA ITSM Total', 'TMA ITSM Total', '', '', 0, '2015', 1),
(10, 30, 'TMA S400 AH', 'TMA S400 AH', 'TMA S400 AH', 'Prise en charge de la TMA S400 dans le cadre d''un contrat basé sur celui de Bundle Tools avec du récurrent, des TOP et de l''évolutive.', '', 22920, '2015', 1),
(11, 36, 'Absences 2014', 'Absences 2014', 'Absences 2014', 'Collecteur de toutes les absences du centre de services', '', 0, '2014', 1),
(12, 44, 'Gouvernance 2014', 'Gouvernance 2014', 'Gouvernance 2014', '', '', 0, '2014', 1),
(13, 44, 'Formations 2015', 'Formations 2015', 'Formations 2015', '', '', 12000, '2015', 1),
(16, 44, 'Gouvernance 2015', 'Gouvernance 2015', 'Gouvernance 2015', '', '', 0, '2015', 1),
(17, 36, 'Absences 2015', 'Absences 2015', 'Absences 2015', 'Collecteur de toutes les absences du centre de services', '', 0, '2015', 1),
(18, 30, 'SANOFI - DéplPromise', 'SANOFI - Déploiement Promise', 'SANOFI - Déploiement Promise', 'Back-office de l''activité RUN du déploiement de Promise sur 120 sites.', '', 0, '2015', 1),
(19, 31, 'Industrialisation', 'Industrialisation', 'Industrialisation', 'Ensemble des activités d''industrialisation autour des outils, processus, organisation, ...', '', 70000, '2015', 1),
(20, 30, 'CEGID - TMA ITSM', 'CEGID - TMA ITSM', 'CEGID - TMA ITSM', 'TMA corrective, évolutive et préventive de la solution ITSM, support de leur relation avec leur clients', 'https://drive.google.com/open?id=0B5Gw8IjwsdhgQzg1eFhTWGFUcFE&authuser=0', 44611, '2015', 1),
(21, 36, 'Airbus Autres', 'Airbus, autres contrats', 'Airbus, autres contrats', 'Collecteur de tous les projets Airbus ne rentrant pas dans un programme', '', 280000, '2015', 1),
(22, 44, 'EDF', 'EDF', 'EDF, collecteur des contrats EDF', 'Tous les contrats EDF dont la direction de projet est sur Paris.', '', 0, '2015', 1);

-- --------------------------------------------------------

--
-- Structure de la table `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE IF NOT EXISTS `project` (
`idProject` int(11) NOT NULL,
  `projectName` varchar(80) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `risk` char(1) DEFAULT NULL,
  `priority` int(10) unsigned DEFAULT NULL,
  `idPerfOrg` int(11) DEFAULT NULL,
  `idCustomer` int(11) DEFAULT NULL,
  `idProgram` int(11) DEFAULT NULL,
  `projectManager` int(11) DEFAULT NULL,
  `functionalManager` int(11) DEFAULT NULL,
  `sponsor` int(11) DEFAULT NULL,
  `idProjectCalendar` int(11) DEFAULT NULL,
  `bac` double DEFAULT NULL,
  `netIncome` double DEFAULT NULL,
  `tcv` double DEFAULT NULL,
  `initDate` date DEFAULT NULL,
  `endDate` date DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `effort` int(11) DEFAULT NULL,
  `IdContractType` int(11) DEFAULT NULL,
  `plannedFinishDate` date DEFAULT NULL,
  `planDate` date DEFAULT NULL,
  `execDate` date DEFAULT NULL,
  `plannedInitDate` date DEFAULT NULL,
  `closeComments` varchar(200) DEFAULT NULL,
  `closeStakeholderComments` varchar(200) DEFAULT NULL,
  `closeUrlLessons` varchar(50) DEFAULT NULL,
  `closeLessons` varchar(200) DEFAULT NULL,
  `internalProject` bit(1) DEFAULT NULL,
  `projectDoc` varchar(20) DEFAULT NULL,
  `budgetYear` int(4) unsigned DEFAULT NULL,
  `chartLabel` varchar(15) DEFAULT NULL,
  `investmentManager` int(11) DEFAULT NULL,
  `probability` int(10) unsigned DEFAULT NULL,
  `isGeoSelling` bit(1) DEFAULT NULL,
  `idCategory` int(11) DEFAULT NULL,
  `idGeography` int(11) DEFAULT NULL,
  `investmentStatus` char(1) DEFAULT NULL,
  `sended` bit(1) DEFAULT NULL,
  `numCompetitors` int(10) unsigned DEFAULT NULL,
  `finalPosition` int(10) unsigned DEFAULT NULL,
  `clientComments` varchar(1000) DEFAULT NULL,
  `canceledComments` varchar(200) DEFAULT NULL,
  `comments` varchar(200) DEFAULT NULL,
  `linkDoc` varchar(200) DEFAULT NULL,
  `accountingCode` varchar(20) DEFAULT NULL,
  `statusDate` date DEFAULT NULL,
  `lowerThreshold` int(11) DEFAULT NULL,
  `upperThreshold` int(11) DEFAULT NULL,
  `idFundingSource` int(10) unsigned DEFAULT NULL,
  `linkComment` varchar(250) DEFAULT NULL,
  `scopeStatement` varchar(1500) DEFAULT NULL,
  `hdDescription` varchar(500) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `project`
--

INSERT INTO `project` (`idProject`, `projectName`, `status`, `risk`, `priority`, `idPerfOrg`, `idCustomer`, `idProgram`, `projectManager`, `functionalManager`, `sponsor`, `idProjectCalendar`, `bac`, `netIncome`, `tcv`, `initDate`, `endDate`, `duration`, `effort`, `IdContractType`, `plannedFinishDate`, `planDate`, `execDate`, `plannedInitDate`, `closeComments`, `closeStakeholderComments`, `closeUrlLessons`, `closeLessons`, `internalProject`, `projectDoc`, `budgetYear`, `chartLabel`, `investmentManager`, `probability`, `isGeoSelling`, `idCategory`, `idGeography`, `investmentStatus`, `sended`, `numCompetitors`, `finalPosition`, `clientComments`, `canceledComments`, `comments`, `linkDoc`, `accountingCode`, `statusDate`, `lowerThreshold`, `upperThreshold`, `idFundingSource`, `linkComment`, `scopeStatement`, `hdDescription`) VALUES
(0, 'Projet nul pour la creation de WBSNode sur CN sans projet associé', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'Management du Centre de Services', 'X', NULL, 99, 1, 11, 12, 45, 18, NULL, 4, NULL, NULL, 0, '2014-11-21', '2015-01-14', NULL, NULL, 3, '2014-12-31', '2014-11-21', '2014-11-21', '2014-11-21', 'RAS, fin d''année', '', NULL, NULL, b'0', NULL, 2014, 'Mgt CdS', 27, 100, b'0', 6, 9, 'C', NULL, 0, 1, '', NULL, NULL, '', 'MgtCdS', NULL, NULL, NULL, 1, NULL, '', ''),
(8, 'Congés 2014', 'X', NULL, 99, 1, 11, 11, 47, 18, NULL, 5, NULL, NULL, 0, '2014-11-21', '2015-03-20', NULL, NULL, 3, '2014-12-31', '2014-11-21', '2014-11-21', '2014-11-21', 'fin d''année 2014', '', NULL, NULL, b'0', NULL, 2014, 'Congés 2014', 27, 100, b'0', 5, 9, 'C', NULL, 0, 1, '', NULL, NULL, '', 'C2014', NULL, NULL, NULL, 3, NULL, 'Les RTT employeurs sont déjà intégrés dans le calendrier CdS - HO', ''),
(9, 'Formations Externes 2015', 'C', NULL, 99, 1, 11, 13, 45, 115, NULL, 6, 12000, NULL, 0, '2015-01-01', '2015-12-31', NULL, NULL, 3, '2015-12-31', '2015-01-01', '2014-11-21', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Form. Externes', 27, 100, b'0', 7, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, 2, NULL, '', ''),
(10, 'Formations Internes 2015', 'C', NULL, 99, 1, 11, 13, 45, 115, NULL, 7, NULL, NULL, 0, '2015-01-01', '2015-12-31', NULL, NULL, 3, '2015-12-31', '2015-01-01', '2014-11-21', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Form. Internes', 27, 100, b'0', 7, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, 2, NULL, '', ''),
(13, 'Interface entre OpenPPM et SmartPlan', 'X', NULL, 75, 1, 11, 16, 43, NULL, NULL, 19, NULL, NULL, 0, '2014-11-21', NULL, NULL, NULL, 3, '2015-02-27', NULL, NULL, '2015-01-05', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'OPPM SP', 27, 50, b'0', 2, 9, 'R', NULL, 0, 1, '', NULL, NULL, '', '', NULL, NULL, NULL, 4, NULL, '', ''),
(14, 'Formulaire de saisie de congés', 'X', NULL, 50, 1, 11, 12, 45, NULL, NULL, 21, 0, 0, 0, '2014-11-26', '2014-12-16', NULL, NULL, 3, '2014-12-12', '2014-12-16', '2014-12-16', '2014-12-01', 'À intégrer dans le futur dans openppm et maintenance à prévoir', '', NULL, NULL, b'0', NULL, 2014, 'Form Congés', 27, 100, b'0', 2, 9, 'C', NULL, 0, 1, '', NULL, NULL, 'https://drive.google.com/open?id=1M7pfEf2u6sGidHxDfGf924uJk_JmIK_S3VVAVNNUzzw&authuser=0', '', NULL, NULL, NULL, 4, NULL, '', NULL),
(16, 'Infrastructure du centre de services', 'P', NULL, 50, 1, 11, 16, 40, 18, NULL, 41, 0, 0, 0, '2014-11-27', NULL, NULL, NULL, 3, '2015-03-31', '2015-02-16', NULL, '2015-01-05', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Infra CdS', 27, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, 5, NULL, NULL, NULL),
(18, 'Évolutions d''OpenPPM', 'C', NULL, 25, 1, 11, 16, 43, 18, NULL, 25, 0, 0, 0, '2014-11-27', NULL, NULL, NULL, 3, '2015-12-31', '2014-12-23', '2014-12-23', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Evol OPPM', 27, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, 5, NULL, '', ''),
(19, 'E-Sign EIS evolutions', 'C', NULL, 99, 1, 7, 5, 95, 25, NULL, 11, NULL, NULL, 17820, '2014-12-03', NULL, NULL, NULL, NULL, '2015-01-30', '2014-12-03', '2014-12-03', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2014, 'cnXXXX - E-Sign', 27, 100, b'0', 2, NULL, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(20, 'Airbus Helicopters - TMA S400 - WP1 - recurring activities', 'C', NULL, 99, 1, 10, 10, 98, 25, NULL, 16, NULL, NULL, 35430, '2014-12-04', NULL, NULL, NULL, 1, '2015-12-31', '2014-12-29', '2014-12-29', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AHTMAS400WP1', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0114-FNLNOZ', NULL, NULL, NULL, 6, NULL, '', ''),
(21, 'Airbus Helicopters - TMA S400 - WP3 - Requests Management', 'C', NULL, 99, 1, 10, 10, 38, 25, NULL, 12, NULL, NULL, 46667, '2014-12-04', NULL, NULL, NULL, 2, '2015-12-31', '2014-12-29', '2014-12-30', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AHTMAS400WP3', 41, 100, b'0', 10, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0114-FNLNOZ', '2015-02-27', NULL, NULL, 6, NULL, '', ''),
(22, 'Airbus Helicopters - TMA S400 - Initialisation', 'C', NULL, 99, 1, 10, 10, 38, 25, NULL, 26, NULL, NULL, 14692, '2014-12-04', NULL, NULL, NULL, 3, '2015-02-27', '2014-12-29', '2014-12-29', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AHTMAS400INIT', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0114-FNLNOZ', NULL, NULL, NULL, 6, NULL, '', NULL),
(23, 'Airbus Helicopters - TMA S400 - Gouvernance', 'C', NULL, 99, 1, 10, 10, 98, 25, NULL, 27, NULL, NULL, 18051, '2014-12-04', NULL, NULL, NULL, 1, '2015-12-31', '2014-12-29', '2014-12-29', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AHTMAS400GVC', 41, 100, b'0', 6, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0114-FNLNOZ', '2015-02-27', NULL, NULL, 6, NULL, '', ''),
(24, 'Airbus Helicopters - TMA S400 - On demand projects', 'C', NULL, 99, 1, 10, 10, 38, 25, NULL, 17, NULL, NULL, 76382, '2014-12-04', NULL, NULL, NULL, 3, '2015-12-31', '2014-12-29', '2014-12-30', '2014-12-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AHTMAS400WP2', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0114-FNLNOZ', NULL, NULL, NULL, 6, NULL, '', NULL),
(25, 'CEA - DAM - Train de maintenance évolutive n° 01', 'X', NULL, 75, 1, 9, 7, 40, 99, NULL, 13, NULL, NULL, 16800, '2014-12-04', '2015-04-03', NULL, NULL, 3, '2015-01-30', '2014-12-04', '2014-12-04', '2014-12-08', '', '', NULL, NULL, b'0', NULL, 2015, 'CEADAMTME01', 41, 100, b'0', 4, 9, 'C', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-8EY6RU', NULL, 0, 0, 7, NULL, '', ''),
(26, 'Reporting dashboard migration', 'C', NULL, 99, 1, 7, 6, 43, 25, NULL, 14, NULL, 10, 21314, '2014-12-04', NULL, NULL, NULL, 3, '2015-01-30', '2015-03-04', '2015-03-05', '2014-12-08', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CN-01070', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(27, 'Congés 2015', 'C', NULL, 99, 1, 11, 17, 47, 18, NULL, 15, 0, 0, 0, '2014-12-16', NULL, NULL, NULL, 3, '2015-12-31', '2014-12-16', '2014-12-16', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Congés 2015', 27, 100, b'0', 5, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ABRSO4P', NULL, NULL, NULL, 8, NULL, '', ''),
(28, 'CEA - DAM - Formations session S1 2015', 'X', NULL, 99, 1, 9, 7, 121, 99, NULL, 30, NULL, NULL, 28821, '2014-12-16', '2015-04-02', NULL, NULL, 3, '2015-03-31', '2015-01-09', '2015-01-29', '2015-01-05', '', '', NULL, NULL, b'0', NULL, 2015, 'CEADAMFORM01', 27, 100, b'0', 7, 9, 'C', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-8EY6RU', NULL, NULL, NULL, 7, NULL, '', ''),
(29, 'LBP - OPUS - Train de maintenance évolutive n° 15', 'C', NULL, 99, 1, 8, 8, 121, 99, NULL, 18, NULL, NULL, 13080, '2014-12-16', NULL, NULL, NULL, 3, '2015-04-10', '2015-01-09', '2015-01-30', '2015-01-05', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'LPBOPUSTME15', 27, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR01010433161', NULL, NULL, NULL, 9, NULL, '', NULL),
(30, 'LBP - OPUS - TMA Corrective - Q1 2015', 'C', NULL, 99, 1, 8, 8, 121, 99, NULL, 28, NULL, NULL, 33463, '2014-12-16', NULL, NULL, NULL, 1, '2015-03-31', '2015-01-09', '2015-01-09', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'LPBOPUSCORQ1', 27, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR01010433161', NULL, NULL, NULL, 9, NULL, '', NULL),
(31, 'CEA - DAM - TMA - Corrective Q1 2015', 'C', NULL, 99, 1, 9, 7, 121, 99, NULL, NULL, NULL, NULL, 0, '2014-12-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-12', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEADAMCORQ1', 27, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-8EY6RU', NULL, NULL, NULL, 7, NULL, '', ''),
(32, 'Management du Centre de Services 2015', 'C', NULL, 99, 1, 11, 16, 45, 18, NULL, 22, 0, 1, 0, '2014-12-16', NULL, NULL, NULL, 1, '2015-12-31', '2014-12-16', '2014-12-16', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Mgt CdS 2015', 27, 100, b'0', 6, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, NULL, NULL, '', NULL),
(33, 'Jours de maladie - 2015', 'C', NULL, 99, 1, 11, 17, 47, 18, NULL, 23, NULL, NULL, 0, '2014-12-19', NULL, NULL, NULL, 3, '2015-12-31', '2014-12-19', '2014-12-19', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Maladies 2015', 27, 100, b'0', 5, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ABRSO4P', NULL, NULL, NULL, 8, NULL, '', NULL),
(34, 'Avant-vente 2015', 'C', NULL, 99, 1, 11, 16, 45, 18, NULL, 24, NULL, NULL, 0, '2014-12-22', NULL, NULL, NULL, 3, '2015-12-31', '2014-12-22', '2014-12-22', '2014-12-22', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AVV15', 27, 100, b'0', 6, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, 11, NULL, 'Airbus D&S Bundle IT Transformation : https://weez.devoteam.com/community/sales-portal/manufacturing-and-natural-resources/airbus_dav_presales_activity/projects/airbus-defence-and-space-it-bundle-transformation-ahka-igxll8', ''),
(35, 'Fin du rôle Direction Technique 2014', 'X', NULL, 99, 1, 11, 16, 45, 18, NULL, 29, NULL, NULL, 0, '2015-01-15', '2015-03-02', NULL, NULL, NULL, '2015-02-28', '2015-01-15', '2015-01-20', '2015-01-01', '', '', NULL, NULL, b'0', NULL, 2015, 'FINDT2014', 27, 100, b'0', 6, NULL, 'C', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, 11, NULL, '', ''),
(36, 'Tous les projets BI de moins de 25 jours', 'C', NULL, 99, 1, 7, 6, 43, 25, NULL, NULL, NULL, NULL, 0, '2015-02-05', NULL, NULL, NULL, 3, '2015-12-31', '2015-02-05', '2015-03-05', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'BI Projects', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(37, 'MAGIC - Activités autour de l''outil', 'C', NULL, 99, 1, 7, 3, 119, 25, NULL, 32, NULL, NULL, 0, '2015-02-05', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-05', '2015-02-12', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'RUN Magic', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(38, 'Tout le run BI de moins de 25 jours', 'C', NULL, 99, 1, NULL, 6, 43, 25, NULL, NULL, NULL, NULL, 0, '2015-02-05', NULL, NULL, NULL, NULL, '2015-12-31', '2015-02-05', '2015-02-10', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'BI Run', 41, 100, b'0', 4, NULL, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(39, 'AAL V8.6.0', 'C', NULL, 99, 1, 7, 5, 120, 25, NULL, 31, NULL, NULL, 0, '2015-02-06', NULL, NULL, NULL, 3, '2015-04-30', '2015-02-06', '2015-02-10', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AAL V8.6.0', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(40, 'ATREF V1.4.20', 'C', NULL, 99, 1, 7, 5, 120, 25, NULL, NULL, NULL, NULL, 0, '2015-02-06', NULL, NULL, NULL, 3, '2015-04-30', '2015-02-06', '2015-03-10', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ATREF V1.4.20', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(41, 'ICT', 'P', NULL, 99, 1, 7, 5, 120, 25, NULL, NULL, NULL, NULL, 0, '2015-02-06', NULL, NULL, NULL, 3, '2015-04-30', '2015-02-06', NULL, '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ICT', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'Airbus Helicopters - Projet S400 - déploiement SSO', 'P', NULL, 99, 1, 10, 10, 98, 25, NULL, NULL, NULL, NULL, 0, '2015-02-11', NULL, NULL, NULL, 3, '2015-04-30', '2015-02-11', NULL, '2015-02-11', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AHPRJS400SSO', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-BMSIFC', NULL, NULL, NULL, 6, NULL, NULL, NULL),
(44, 'Total - TMA ITSM - Support ITSM', 'C', NULL, 99, 1, 12, 9, 40, 25, NULL, 35, NULL, NULL, 340135, '2015-02-13', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-13', '2015-02-23', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Support ITSM', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HY4FTZ', NULL, NULL, NULL, NULL, NULL, '', ''),
(45, 'Total - TMA ITSM - Support BO', 'C', NULL, 99, 1, 12, 9, 40, 25, NULL, 36, NULL, NULL, 18792, '2015-02-13', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-13', '2015-02-23', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Support BO', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HY4FTZ', NULL, NULL, NULL, NULL, NULL, '', NULL),
(46, 'Total - TMA ITSM - Gestion des problèmes', 'C', NULL, 99, 1, 12, 9, 40, 25, NULL, 40, NULL, NULL, 23997, '2015-02-13', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-13', '2015-02-23', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Gestion des Pb', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HY4FTZ', NULL, NULL, NULL, NULL, NULL, '', NULL),
(47, 'Total - TMA ITSM - Chef de Projet technique', 'C', NULL, 99, 1, 12, 9, 40, 25, NULL, 37, NULL, NULL, 28512, '2015-02-13', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-13', '2015-03-04', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CdP Technique', 41, 100, b'0', 6, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HY4FTZ', NULL, NULL, NULL, NULL, NULL, '', NULL),
(48, 'Total - TMA ITSM - Transfert', 'C', NULL, 99, 1, 12, 9, 40, 25, NULL, 39, NULL, NULL, 0, '2015-02-13', NULL, NULL, NULL, 3, '2015-03-31', '2015-02-13', '2015-02-24', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Transfert', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HY4FTZ', NULL, NULL, NULL, NULL, NULL, '', ''),
(49, 'Total - TMA ITSM - Gouvernance', 'C', NULL, 99, 1, 12, 9, 40, 25, NULL, 38, NULL, NULL, 0, '2015-02-13', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-13', '2015-02-25', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Gouvernance', 41, 100, b'0', 6, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HY4FTZ', NULL, NULL, NULL, NULL, NULL, '', ''),
(50, 'Bundle Tools - ITSM - WP1', 'C', NULL, 99, 1, 7, 3, 98, 25, NULL, NULL, NULL, NULL, 0, '2015-02-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-17', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'BT-ITSM-WP1', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(51, 'Incidents - Bundle Tools - BI', 'C', NULL, 99, 1, 7, 6, 43, 25, NULL, NULL, NULL, NULL, 0, '2015-02-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-09', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'INC-BT-BI', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(52, 'Incidents - Bundle Tools - NTIC', 'C', NULL, 99, 1, 7, 5, 95, 25, NULL, NULL, NULL, NULL, 0, '2015-02-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-19', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'INC-BT-NTIC', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(53, 'Bundle Tools - ITSM - WP3', 'C', NULL, 99, 1, 7, 3, 98, 25, NULL, NULL, NULL, NULL, 0, '2015-02-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-17', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'BT-ITSM-WP3', 41, 100, b'0', 10, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(54, 'TOP - Bundle Tools - BI', 'C', NULL, 99, 1, 7, 6, 43, 25, NULL, 42, NULL, NULL, 0, '2015-02-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-09', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'TOP-BT-BI', 41, 100, b'0', 10, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(55, 'TOP - Bundle Tools - NTIC', 'C', NULL, 99, 1, 7, 5, 95, 25, NULL, NULL, NULL, NULL, 0, '2015-02-16', NULL, NULL, NULL, 1, '2015-12-31', '2015-02-16', '2015-03-19', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'TOP-BT-NTIC', 41, 100, b'0', 10, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(56, 'CEA - DAM - Train de maintenance évolutive n° 02', 'C', NULL, 99, 1, 9, 7, 121, 99, NULL, 33, NULL, NULL, 5354.34, '2015-02-16', NULL, NULL, NULL, 3, '2015-03-27', '2015-02-16', '2015-02-25', '2015-02-16', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEADAMTME02', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-8EY6RU', NULL, NULL, NULL, NULL, NULL, '', ''),
(57, 'AIRBUS - ITSM - ARTS V2', 'C', NULL, 95, 1, 7, 21, 98, 99, NULL, 34, NULL, NULL, 280000, '2015-02-17', NULL, NULL, NULL, 3, '2015-11-30', '2015-02-25', '2015-03-12', '2015-02-23', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'PO-ARTS-V2', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-ISOEYV', NULL, NULL, NULL, NULL, NULL, 'Provide a global functional coverage of the request fulfillment process\n\nLeverage S400 to \n - implement 99% OOTB Requests \n - Provide User Experience improvement capitalizing on Remedy ITSM 8.1 \n\nSimplify Request Catalogue and get more agility in the evolution and maintenance of this catalogue\n\nEnhance integrations with BuySide, SAP OM, SAP HR\n\nDeliver one integrated tool for all front office processes\n\nCope with Magic Service Desk obsolescence', ''),
(58, 'Semaphore RUN', 'C', NULL, 99, 1, 7, 3, 38, 25, NULL, NULL, NULL, NULL, 0, '2015-02-19', NULL, NULL, NULL, 3, '2015-12-31', '2015-02-19', '2015-03-17', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Semaphore RUN', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(59, 'ITSM TOOL RUN', 'C', NULL, 99, 1, 7, 3, 126, 25, NULL, NULL, NULL, NULL, 0, '2015-02-19', NULL, NULL, NULL, 3, '2015-12-31', '2015-02-19', '2015-04-27', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ITSM-TOOL RUN', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(60, 'Semaphore Projets', 'C', NULL, 99, 1, 7, 3, 38, 25, NULL, NULL, NULL, NULL, 0, '2015-02-19', NULL, NULL, NULL, 3, '2015-12-31', '2015-02-19', '2015-03-17', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Semaphore PRJ', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(61, 'ITSM TOOL Projets', 'C', NULL, 99, 1, 7, 3, 126, 25, NULL, NULL, NULL, NULL, 0, '2015-02-19', NULL, NULL, NULL, 3, '2015-12-31', '2015-02-19', '2015-04-27', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ITSM-TOOL Prj', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(62, 'ASPIRE V1.14', 'C', NULL, 99, 1, 7, 5, 125, 25, NULL, NULL, NULL, NULL, 0, '2015-03-11', NULL, NULL, NULL, 3, '2015-04-30', '2015-03-11', '2015-03-11', '2015-02-16', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ASPIRE V1.14', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(63, 'ASPIRE V1.15', 'C', NULL, 99, 1, 7, 5, 125, 25, NULL, NULL, NULL, NULL, 0, '2015-03-11', NULL, NULL, NULL, 3, '2015-07-15', '2015-03-11', '2015-04-10', '2015-03-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ASPIRE V1.15', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(64, 'AML V2.4.9', 'C', NULL, 99, 1, 7, 5, 34, 25, NULL, NULL, NULL, NULL, 0, '2015-03-11', NULL, NULL, NULL, 3, '2015-05-31', '2015-03-11', '2015-03-12', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AML V2.4.9', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(65, 'I4U V1.2', 'C', NULL, 99, 1, 7, 5, 34, 25, NULL, NULL, NULL, NULL, 0, '2015-03-11', NULL, NULL, NULL, 3, '2015-05-31', '2015-03-11', '2015-03-12', '2015-02-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'I4U V1.2', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(66, 'MASTER PLAN 2.1', 'C', NULL, 99, 1, 7, 5, 134, 25, NULL, NULL, NULL, NULL, 0, '2015-03-11', NULL, NULL, NULL, 3, '2015-05-22', '2015-03-11', '2015-03-12', '2015-03-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'MASTER PLAN 2.1', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', ''),
(67, 'ETICKET V3.0', 'C', NULL, 99, 1, 7, 5, 34, 25, NULL, NULL, NULL, NULL, 0, '2015-03-12', NULL, NULL, NULL, 3, '2015-05-29', '2015-03-12', '2015-03-13', '2015-03-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ETICKET V3.0', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(68, 'MASTER PLAN 2.0', 'C', NULL, 99, 1, 7, 5, 134, 25, NULL, NULL, NULL, NULL, 0, '2015-03-12', NULL, NULL, NULL, 3, '2015-04-13', '2015-03-12', '2015-03-12', '2015-02-02', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'MASTER PLAN 2.0', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(69, 'SANOFI - Déploiement Promise - RUN', 'P', NULL, 99, 1, 13, 18, 98, 99, NULL, 43, 542098, NULL, 542098, '2015-03-16', NULL, NULL, NULL, 1, '2018-04-30', '2015-03-20', NULL, '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Dépl. Promise', 41, 100, b'0', 10, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-HPVDIU', NULL, NULL, NULL, NULL, NULL, '', ''),
(70, 'Gestion des activités - V1', 'C', NULL, 99, 1, 11, 19, 56, 141, NULL, 46, NULL, 49000, 49000, '2015-03-18', NULL, NULL, NULL, 3, '2015-06-30', '2015-03-18', '2015-03-23', '2015-03-18', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'GestActivitésV1', 27, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-DAVOUT', '2015-03-23', NULL, NULL, NULL, NULL, 'Projet de mis en place d''un outil de gestion des activités en version 1. La gestion des activités va concerner l''intégralité du Delivery Devoteam : centres de Services, infogérance, DRI.\nLe produit choisit est OpenPPM.', ''),
(71, 'Gestion des demandes', 'P', NULL, 99, 1, 11, 19, 56, 141, NULL, NULL, NULL, NULL, 0, '2015-03-18', NULL, NULL, NULL, 3, '2015-06-30', '2015-03-18', NULL, '2015-03-18', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'GestDemandes', 27, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-DAVOUT', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 'MASTER PLAN 2.2', 'C', NULL, 99, 1, 7, 5, 134, 25, NULL, NULL, NULL, NULL, 0, '2015-03-20', NULL, NULL, NULL, 3, '2015-07-01', '2015-03-20', '2015-03-20', '2015-03-09', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'MASTER PLAN 2.2', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(73, 'PWINIT v3.6', 'C', NULL, 99, 1, 7, 5, 147, 25, NULL, NULL, NULL, NULL, 0, '2015-03-20', NULL, NULL, NULL, 3, '2015-04-15', '2015-03-20', '2015-03-20', '2015-03-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'PWINIT v3.6', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(74, 'CEGID TMA Phase de transition', 'C', NULL, 99, 1, 14, 20, 98, 18, NULL, 48, NULL, NULL, 13000, '2015-03-25', NULL, NULL, NULL, 3, '2015-04-30', '2015-03-31', '2015-04-23', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEGID Transit', 41, 100, b'0', 8, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-ILXSN6', NULL, NULL, NULL, NULL, NULL, '', ''),
(75, 'CEGID TMA Corrective', 'P', NULL, 99, 1, 14, 20, 98, 18, NULL, NULL, NULL, NULL, 9966, '2015-03-25', NULL, NULL, NULL, 1, '2016-04-30', '2015-03-31', NULL, '2015-05-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEGID Correct', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-ILXSN6', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(76, 'CEGID TMA Evolutive', 'P', NULL, 99, 1, 14, 20, 98, 18, NULL, NULL, NULL, NULL, 13014, '2015-03-25', NULL, NULL, NULL, 3, '2016-04-30', '2015-03-31', NULL, '2015-05-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEGID Evolutive', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-ILXSN6', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(77, 'CEGID TMA Préventive', 'P', NULL, 99, 1, 14, 20, 98, 18, NULL, NULL, NULL, NULL, 0, '2015-03-25', NULL, NULL, NULL, 3, '2016-04-30', '2015-03-31', NULL, '2015-05-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEGI Préventive', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-ILXSN6', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(78, 'CEA - DAM - Train de maintenance évolutive n° 03', 'C', NULL, 99, 1, 9, 7, 121, 99, NULL, 44, NULL, 6859.47, 6859.47, '2015-04-01', NULL, NULL, NULL, 3, '2015-05-15', '2015-04-01', '2015-04-07', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'CEADAMTME03', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-8EY6RU', NULL, NULL, NULL, NULL, NULL, '', NULL),
(79, 'Reporting Bundle Tools Activity', 'P', NULL, 99, 1, 7, 6, 43, 25, NULL, NULL, NULL, NULL, 0, '2015-04-01', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-01', NULL, '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Reporting BT', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 'AAL V8.7.0', 'P', NULL, 99, 1, 7, 5, 120, 25, NULL, NULL, NULL, NULL, 0, '2015-04-08', NULL, NULL, NULL, 3, '2015-06-05', '2015-04-08', NULL, '2015-03-30', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AAL V8.7.0', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(81, 'ATREF V2.1', 'C', NULL, 99, 1, 7, 5, 120, 25, NULL, NULL, NULL, NULL, 0, '2015-04-08', NULL, NULL, NULL, 3, '2015-06-05', '2015-04-08', '2015-04-13', '2015-03-30', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ATREF V2.1', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(82, 'AIFU', 'P', NULL, 99, 1, 7, 5, 95, 25, NULL, NULL, NULL, NULL, 0, '2015-04-08', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-08', NULL, '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AIFU', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 'LBP - OPUS - TMA Corrective - 2015', 'C', NULL, 99, 1, 8, 8, 121, 99, NULL, 45, NULL, NULL, 0, '2015-04-08', NULL, NULL, NULL, 1, '2015-12-31', '2015-04-08', '2015-04-09', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'LPBOPUSCOR', 41, 100, b'0', 1, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR01010433161', NULL, NULL, NULL, NULL, NULL, '', ''),
(84, 'Activités externes au CdS', 'C', NULL, 99, 1, 11, 16, 45, 18, NULL, 51, NULL, NULL, 0, '2015-04-09', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-09', '2015-04-29', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Act.Ext.', 27, 100, b'0', 6, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'Générique', NULL, NULL, NULL, NULL, NULL, '', NULL),
(85, 'ICT Catalogue', 'C', NULL, 99, 1, 7, 5, 120, 25, NULL, NULL, NULL, NULL, 0, '2015-04-13', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-13', '2015-04-14', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'ICT Catalogue', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(86, 'Reste à produire 2015', 'C', NULL, 99, 1, 7, 5, 95, 25, NULL, NULL, NULL, NULL, 0, '2015-04-13', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-13', '2015-04-13', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'RàP2015', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(87, 'I4U 1.3', 'C', NULL, 99, 1, 7, 5, 34, 25, NULL, NULL, NULL, NULL, 0, '2015-04-15', NULL, NULL, NULL, 3, '2015-07-31', '2015-04-15', '2015-04-23', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'I4U 1.3', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(88, 'PWINIT Out of Release', 'C', NULL, 99, 1, 7, 5, 147, 25, NULL, NULL, NULL, NULL, 0, '2015-04-16', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-16', '2015-04-20', '2015-01-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'PWINIT OOR', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(89, 'CEA - DAM - Reprise de Données Centre Gramat', 'C', NULL, 99, 1, 9, 7, 121, 99, NULL, 47, NULL, NULL, 0, '2015-04-17', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-17', '2015-04-21', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'GRAMATRécupData', 41, 100, b'0', 2, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0113-8EY6RU', NULL, NULL, NULL, NULL, NULL, '', ''),
(90, 'PWINIT 3.7', 'C', NULL, 99, 1, 7, 5, 147, 25, NULL, NULL, NULL, NULL, 0, '2015-04-21', NULL, NULL, NULL, 3, '2015-12-31', '2015-04-21', '2015-04-24', '2015-04-13', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'PWINIT 3.7', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(91, 'AML V2.4.9.1', 'C', NULL, 99, 1, 7, 5, 34, 25, NULL, NULL, NULL, NULL, 0, '2015-04-23', NULL, NULL, NULL, 3, '2015-06-30', '2015-04-23', '2015-04-23', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'AML V2.4.9.1', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(92, 'Eticket V3.1', 'C', NULL, 99, 1, 7, 5, 34, 25, NULL, NULL, NULL, NULL, 0, '2015-04-23', NULL, NULL, NULL, 3, '2015-07-31', '2015-04-23', '2015-04-23', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, 2015, 'Eticket V3.1', 41, 100, b'0', 4, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IRMDX4', NULL, NULL, NULL, NULL, NULL, '', NULL),
(93, 'Intermission', 'C', NULL, 99, 1, 11, 16, 45, 18, NULL, 49, NULL, NULL, 0, '2015-04-27', NULL, NULL, NULL, NULL, '2015-12-31', '2015-04-27', '2015-04-27', '2015-04-01', NULL, NULL, NULL, NULL, b'0', NULL, NULL, 'IM', 27, 100, b'0', NULL, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0100ADRSO4P', NULL, NULL, NULL, NULL, NULL, '', NULL),
(94, 'EDF TMO²', 'C', NULL, 99, 1, 15, 22, 45, 18, NULL, 50, NULL, NULL, 0, '2015-04-27', NULL, NULL, NULL, 1, '2015-12-31', '2015-04-27', '2015-04-27', '2015-04-28', NULL, NULL, NULL, NULL, b'0', NULL, NULL, 'TMO²', 27, 100, b'1', 10, 9, 'A', NULL, 0, 1, '', NULL, NULL, '', 'FR0115-IWMZLT', NULL, NULL, NULL, NULL, NULL, '', '');

-- --------------------------------------------------------

--
-- Structure de la table `projectactivity`
--

DROP TABLE IF EXISTS `projectactivity`;
CREATE TABLE IF NOT EXISTS `projectactivity` (
`IdActivity` int(11) NOT NULL,
  `idProject` int(11) NOT NULL,
  `ActivityName` varchar(150) DEFAULT NULL COMMENT 'de 100 à 150',
  `WBSDictionary` varchar(300) DEFAULT NULL,
  `WorkPackage` int(11) NOT NULL,
  `PlanInitDate` date DEFAULT NULL,
  `ActualInitDate` date DEFAULT NULL,
  `PlanEndDate` date DEFAULT NULL,
  `ActualEndDate` date DEFAULT NULL,
  `EV` double DEFAULT NULL,
  `PV` double DEFAULT NULL,
  `AC` double DEFAULT NULL,
  `poc` double DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=967 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectactivity`
--

INSERT INTO `projectactivity` (`IdActivity`, `idProject`, `ActivityName`, `WBSDictionary`, `WorkPackage`, `PlanInitDate`, `ActualInitDate`, `PlanEndDate`, `ActualEndDate`, `EV`, `PV`, `AC`, `poc`) VALUES
(11, 7, 'Management du Centre de Services', NULL, 13, '2014-11-21', '2014-11-21', '2014-12-23', '2014-12-23', NULL, NULL, NULL, NULL),
(12, 7, 'PPR. Patrice Prouzat', '', 14, '2014-11-21', '2014-11-21', '2014-12-23', '2014-12-23', 0, 0, NULL, 100),
(13, 7, 'SPE. Stéphan Peccini', '', 15, '2014-11-21', '2014-11-21', '2014-12-31', NULL, 0, 0, NULL, 100),
(15, 8, 'Congés 2014', NULL, 16, '2014-11-21', '2014-11-21', '2014-12-31', '2014-12-31', NULL, NULL, NULL, NULL),
(16, 8, 'CP14. Congés Payés 2014', '', 17, '2014-11-21', NULL, '2014-12-31', NULL, NULL, 0, NULL, NULL),
(17, 8, 'RE14. RTT employé 2014', '', 18, '2014-11-21', NULL, '2014-12-31', NULL, NULL, 0, NULL, NULL),
(18, 8, 'AE14. Absences exceptionnelles 2014', '', 19, '2014-11-21', NULL, '2014-12-31', NULL, NULL, 0, NULL, NULL),
(19, 9, 'Formations Externes 2015', NULL, 20, '2015-01-20', '2015-01-01', '2015-04-28', NULL, NULL, NULL, NULL, NULL),
(21, 10, 'Formations Internes 2015', NULL, 22, '2014-12-01', '2015-01-01', '2015-04-30', NULL, NULL, NULL, NULL, NULL),
(22, 10, 'OpenPPM', '', 23, '2014-12-01', NULL, '2014-12-31', NULL, NULL, 0, NULL, NULL),
(26, 13, 'Interface entre OpenPPM et SmartPlan', '', 27, '2015-01-05', NULL, '2015-02-27', NULL, NULL, 0, NULL, NULL),
(32, 14, 'Formulaire de saisie de congés', NULL, 33, '2014-12-01', '2014-12-01', '2014-12-12', '2014-12-12', 0, NULL, NULL, 100),
(34, 16, 'BU. Infrastructure du centre de services', NULL, 35, '2015-01-05', NULL, '2015-03-31', NULL, NULL, NULL, NULL, NULL),
(36, 18, 'Évolutions d''OpenPPM', NULL, 37, '2014-12-01', '2014-12-08', '2015-12-31', NULL, NULL, NULL, NULL, NULL),
(37, 19, 'E-Sign EIS evolutions', NULL, 38, '2014-12-01', '2014-12-01', '2015-01-30', '2014-12-02', NULL, NULL, NULL, NULL),
(38, 19, 'Kick-off (4j)', '', 39, '2014-12-01', '2014-12-01', '2014-12-02', '2014-12-02', 0, 0, NULL, 0),
(40, 19, 'Suivi (4j)', '', 41, '2014-12-08', NULL, '2014-12-23', NULL, NULL, 0, NULL, NULL),
(42, 19, 'Sprint 1 (7,5j)', '', 42, '2014-12-08', NULL, '2014-12-17', NULL, NULL, 0, NULL, NULL),
(43, 19, 'Sprint 2 (7,5j)', '', 43, '2014-12-18', NULL, '2014-12-26', NULL, NULL, 0, NULL, NULL),
(45, 19, 'MII - Unit test (3j)', '', 45, '2014-12-29', NULL, '2014-12-31', NULL, NULL, 0, NULL, NULL),
(46, 19, 'Documentation Update (2j)', '', 46, '2015-01-05', NULL, '2015-01-06', NULL, NULL, 0, NULL, NULL),
(47, 19, 'MIV - Support BAT', '', 47, '2015-01-08', NULL, '2015-01-23', NULL, NULL, 0, NULL, NULL),
(48, 19, 'MIP', '', 48, '2015-01-30', NULL, '2015-01-30', NULL, NULL, 0, NULL, NULL),
(49, 20, 'Airbus Helicopters - TMA S400 - WP1 - recurring activities', '', 49, '2014-12-01', '2014-12-01', '2015-12-31', '2015-12-31', 10983.3, 0, NULL, 31),
(50, 21, 'Airbus Helicopters - TMA S400 - WP3 - Requests Management', NULL, 50, '2014-12-01', '2014-12-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(51, 21, 'Unit Data Administration - Modification of an attribute of an information', '', 51, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(53, 21, 'Mass Data Administration', '', 53, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(55, 21, 'Data export/import from template', '', 55, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(56, 21, 'Database restore/refresh, not under INB responsibility', '', 56, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(57, 21, 'Database restore/refresh, under INB responsibility', '', 57, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(58, 21, 'Report Schedule Creation', '', 58, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(59, 21, 'Report Update Schedule', '', 59, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(60, 21, 'Report Schedule Suppress', '', 60, '2014-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(62, 22, 'Airbus Helicopters - TMA S400 - Initialisation', '', 62, '2014-12-01', '2014-12-01', '2015-04-30', '2015-02-27', 12488, 0, NULL, 85),
(63, 23, 'Airbus Helicopters - TMA S400 - Gouvernance', '', 63, '2014-12-01', '2014-12-01', '2015-12-31', '2015-12-31', 5596, 0, NULL, 31),
(64, 24, 'Airbus Helicopters - TMA S400 - On demand projects', '', 64, '2015-04-22', '2014-12-01', '2015-06-30', '2015-12-31', 0, 0, NULL, 0),
(65, 25, 'CEA - DAM - Train de maintenance évolutive n° 01', NULL, 65, '2014-12-09', '2014-12-09', '2015-01-30', '2015-01-30', NULL, NULL, NULL, NULL),
(66, 25, 'Devis', '', 66, '2014-12-09', NULL, '2014-12-12', NULL, NULL, 0, NULL, NULL),
(67, 25, 'Specs Update', '', 67, '2014-12-22', NULL, '2014-12-24', NULL, NULL, 0, NULL, NULL),
(68, 25, 'Développement (20j)', '', 68, '2015-01-05', NULL, '2015-01-16', NULL, NULL, 0, NULL, NULL),
(69, 25, 'Recette croisée (3j)', '', 69, '2015-01-19', NULL, '2015-01-23', NULL, NULL, 0, NULL, NULL),
(70, 25, 'Livraison (1j)', '', 70, '2015-01-29', NULL, '2015-01-30', NULL, NULL, 0, NULL, NULL),
(71, 26, 'Reporting dashboard migration', NULL, 71, '2014-12-08', '2014-12-08', '2015-04-30', '2015-04-30', NULL, NULL, NULL, NULL),
(72, 27, 'Congés 2015', NULL, 72, '2015-01-01', '2015-01-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(73, 27, 'CP15. Congés Payés 2015', '', 73, '2015-01-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(74, 27, 'RE15. RTT employé 2015', '', 74, '2015-01-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(75, 27, 'AE14. Absences exceptionnelles 2015', '', 75, '2015-01-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(76, 28, 'CEA - DAM - Formations session S1 2015', NULL, 76, '2015-01-07', '2015-01-07', '2015-01-08', '2015-01-08', NULL, NULL, NULL, NULL),
(77, 29, 'LBP - OPUS - Train de maintenance évolutive n° 15', NULL, 77, '2015-01-05', '2015-01-05', '2015-04-03', '2015-04-03', NULL, NULL, NULL, NULL),
(78, 30, 'LBP - OPUS - TMA Corrective - Q1 2015', NULL, 78, '2015-01-01', '2015-01-01', '2015-03-31', '2015-03-31', NULL, NULL, NULL, NULL),
(79, 31, 'CEA - DAM - TMA - Corrective Q1 2015', NULL, 79, '2015-01-01', '2015-01-01', '2015-05-31', '2015-03-31', NULL, NULL, NULL, NULL),
(80, 32, 'Management du Centre de Services 2015', NULL, 80, '2015-01-01', '2015-01-01', '2015-12-31', '2015-12-31', 0, NULL, NULL, 25),
(81, 33, 'Jours de maladie - 2015', NULL, 81, '2015-01-01', '2015-01-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(82, 34, 'Avant-vente 2015', NULL, 82, '2014-12-22', '2014-12-22', '2015-06-12', '2015-03-23', NULL, NULL, NULL, NULL),
(84, 34, 'AVV. SANOFI DAI : Déploiement PROMISE - Proposition V2', 'Mettre à jour la proposition pour répondre aux demandes lors de la soutenance', 84, '2014-12-22', '2014-12-22', '2014-12-31', '2014-12-31', 0, 0, NULL, 100),
(85, 34, 'AVV. Total CDS Middle office - V1 - Rédaction des UO et chiffrage - partie 1', '', 86, '2014-12-22', '2014-12-22', '2014-12-31', '2014-12-31', 0, 0, NULL, 100),
(86, 34, 'AVV. Airbus D&S - IT Bundle RFP - V1 - Contribution à la proposition', '', 88, '2014-12-22', NULL, '2015-01-23', NULL, 0, 0, NULL, 100),
(87, 34, 'AVV. LBP - OPUS V2 - V1 - Contribution à la proposition', '', 90, '2014-12-22', NULL, '2015-02-04', NULL, 0, 0, NULL, 100),
(88, 34, 'AVV. Celine - Bundle Patch Management - V1 - contribution à la proposition', '', 93, '2015-01-05', '2015-01-05', '2015-02-04', '2015-02-04', 0, 0, NULL, 100),
(89, 34, 'AVV. DSI Courrier La poste MEP de CdS - V1 - contribution à la proposition', '', 94, '2014-12-22', '2014-12-22', '2015-01-29', '2015-01-30', 0, 0, NULL, 100),
(91, 34, 'AVV. Akérys - TMA - proposition', '', 97, '2015-01-12', NULL, '2015-06-12', NULL, NULL, 0, NULL, NULL),
(92, 18, 'BU. Gestion des Skills', '', 98, '2014-12-01', '2014-12-22', '2015-06-30', NULL, 0, 0, NULL, 30),
(93, 18, 'BU. Capacity Planning', 'Mise en place du capacity planning détaillé des ressources et global pour les ressources et les skills', 99, '2014-12-01', '2014-12-08', '2015-06-30', NULL, 0, 0, NULL, 30),
(94, 18, 'BU. Gestion des Congés', 'Permettre l''autodéclaration des congés dans OpenPPM', 100, '2014-12-01', '2014-12-08', '2015-06-30', NULL, 0, 0, NULL, 50),
(95, 18, 'BU. Déclaration des UO', '', 101, '2014-12-01', '2014-12-08', '2015-06-30', NULL, 0, 0, NULL, 50),
(96, 18, 'BU. Du CRA vers Aramis', 'Permettre de récupérer les informations validées du CRA pour en sortir une synthèse pour injecter dans Aramis', 102, '2014-12-29', NULL, '2015-01-16', NULL, 0, 0, NULL, 50),
(97, 18, 'BU. Génération du SFP', '', 105, '2014-12-31', NULL, '2015-01-16', NULL, 0, 0, NULL, 50),
(98, 18, 'BU. Gestion des coûts standards', '', 106, '2014-12-30', NULL, '2015-01-09', NULL, 0, 0, NULL, 50),
(99, 28, 'Session DIF / SISR', '', 107, '2015-01-07', NULL, '2015-01-08', NULL, NULL, 0, NULL, NULL),
(101, 34, 'AVV. MSC Assurances - Prism Particuliers - Qualification', 'Qualification du besoin en vue de définir le CCTP light', 109, '2015-01-14', '2015-01-14', '2015-01-15', '2015-01-15', 0, 0, NULL, 100),
(102, 35, 'Fin du rôle Direction Technique 2014', NULL, 110, '2015-01-01', '2015-01-01', '2015-02-27', '2015-02-27', NULL, NULL, NULL, NULL),
(103, 35, 'MGT. Bilan financier et MDB', '', 111, '2015-01-01', NULL, '2015-01-31', NULL, 0, 0, NULL, 100),
(104, 35, 'MGT. Transfert de connaissances', '', 112, '2015-02-02', NULL, '2015-02-27', NULL, 0, 0, NULL, 100),
(105, 34, 'AVV. CEGID TMA ITSM - Contribution à la proposition V1', '', 114, '2015-01-15', '2015-01-15', '2015-02-13', '2015-02-13', 0, 0, NULL, 100),
(106, 9, 'FR15. Sauveteur Secouriste du Travail', '', 115, '2015-01-20', NULL, '2015-01-21', NULL, NULL, 0, NULL, NULL),
(107, 29, 'TM15 - Spécifications (2,4j)', '', 116, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(108, 29, 'TM15 - Réalisation / Documentation (13,2j)', '', 117, '2015-01-27', NULL, '2015-02-27', NULL, NULL, 0, NULL, NULL),
(109, 29, 'TM15 - Intégration / Recette croisée (3,6j)', '', 118, '2015-03-02', NULL, '2015-03-06', NULL, NULL, 0, NULL, NULL),
(110, 29, 'TM15 - VABF', '', 120, '2015-03-11', NULL, '2015-04-03', NULL, NULL, 0, NULL, NULL),
(111, 29, 'TM15 - Gestion de projet', '', 121, '2015-01-05', NULL, '2015-04-03', NULL, NULL, 0, NULL, NULL),
(112, 34, 'AVV. MSC Assurances - Prism Particuliers - contribution à la réponse', '', 122, '2015-01-19', '2015-01-19', '2015-01-23', '2015-01-23', 0, 0, NULL, 100),
(113, 34, 'AVV. Airbus - ARTS v2 - round 1', '', 124, '2015-01-19', '2015-01-19', '2015-02-06', '2015-02-06', 0, 0, NULL, 100),
(114, 28, 'Session S6 - Valduc - MJE', '', 125, '2015-02-02', NULL, '2015-02-03', NULL, NULL, 0, NULL, NULL),
(115, 28, 'Session S6 - DIF - CSA', '', 126, '2015-02-05', NULL, '2015-02-06', NULL, NULL, 0, NULL, NULL),
(116, 28, 'Session S7 - DIF - CSA', '', 127, '2015-02-11', NULL, '2015-02-12', NULL, NULL, 0, NULL, NULL),
(117, 28, 'Session S8 - DIF - VSA', '', 128, '2015-02-16', NULL, '2015-02-17', NULL, NULL, 0, NULL, NULL),
(118, 28, 'Session S8 - Valduc - MJE', '', 129, '2015-02-17', NULL, '2015-02-18', NULL, NULL, 0, NULL, NULL),
(119, 28, 'Session S8 - Ripault - CSA', '', 130, '2015-02-19', NULL, '2015-02-20', NULL, NULL, 0, NULL, NULL),
(120, 28, 'Session S9 - DIF - CSA', '', 131, '2015-02-23', NULL, '2015-02-24', NULL, NULL, 0, NULL, NULL),
(121, 28, 'Session S9 - DIF - VSA', '', 133, '2015-02-25', NULL, '2015-02-26', NULL, NULL, 0, NULL, NULL),
(122, 28, 'Session S10 - Ripault - MJE', '', 134, '2015-03-02', NULL, '2015-03-03', NULL, NULL, 0, NULL, NULL),
(123, 28, 'Session S10 - DIF - CSA', '', 135, '2015-03-04', NULL, '2015-03-05', NULL, NULL, 0, NULL, NULL),
(124, 28, 'Session S11 - Ripault - MJE', '', 136, '2015-03-09', NULL, '2015-03-10', NULL, NULL, 0, NULL, NULL),
(125, 28, 'Session S12 - DIF - CSA', '', 138, '2015-03-17', NULL, '2015-03-18', NULL, NULL, 0, NULL, NULL),
(126, 28, 'Session S13 - DIF - VSA', '', 139, '2015-03-24', NULL, '2015-03-25', NULL, NULL, 0, NULL, NULL),
(127, 28, 'Session S9 - Valduc - MJE', '', 132, '2015-02-23', NULL, '2015-02-24', NULL, NULL, 0, NULL, NULL),
(128, 28, 'Session S11 - DIF - VSA', '', 137, '2015-03-11', NULL, '2015-03-13', NULL, NULL, 0, NULL, NULL),
(129, 34, 'AVV. Total CDS Middle Office - Soutenance et BAFO', '', 140, '2015-02-02', '2015-02-02', '2015-02-06', '2015-02-06', 0, 0, NULL, 100),
(130, 36, 'Tous les projets BI de moins de 25 jours', NULL, 141, '2015-02-02', '2015-02-02', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(131, 37, 'MAGIC - Activités autour de l''outil', NULL, 142, '2015-01-01', '2015-02-06', '2015-12-31', '2015-02-20', NULL, NULL, NULL, NULL),
(132, 38, 'Tout le run BI de moins de 25 jours', NULL, 143, '2015-02-02', '2015-01-01', '2015-12-31', '2015-03-31', NULL, NULL, NULL, NULL),
(134, 39, 'AAL V8.6.0', NULL, 145, '2015-02-02', '2015-02-02', '2015-04-30', NULL, NULL, NULL, NULL, NULL),
(135, 40, 'ATREF V1.4.20', NULL, 146, '2015-02-02', '2015-02-02', '2015-04-30', '2015-04-30', NULL, NULL, NULL, NULL),
(136, 41, 'ICT', NULL, 147, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, NULL),
(138, 34, 'AVV. ARTS v2 - préparation soutenance', '', 150, '2015-02-09', '2015-02-09', '2015-02-13', '2015-02-20', 0, 0, NULL, 100),
(142, 21, 'Mass User Administration - 2015-02-10T10:30:01+00:00', NULL, 155, '2015-02-06', '2015-02-06', '2015-02-06', '2015-02-10', 225, NULL, NULL, 100),
(143, 21, 'Unit Data Administration - Modification of an attribute of an end-user - 2015-02-10T10:31:23+00:00', NULL, 156, '2015-02-03', '2015-02-03', '2015-02-03', '2015-02-10', 36, NULL, NULL, 100),
(147, 41, '01889. CN-01889 - Suivi ICT Février 2015', '', 160, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(154, 34, 'AVV. Airbus - Bundle Tools - pré BOR2', '', 168, '2015-02-11', '2015-02-11', '2015-03-31', NULL, 0, 0, NULL, 100),
(155, 43, 'Airbus Helicopters - Projet S400 - déploiement SSO', NULL, 169, '2015-02-11', NULL, '2015-04-30', NULL, NULL, NULL, NULL, NULL),
(160, 34, 'AVV. SANOFI DAI : Déploiement PROMISE - Proposition V3', '', 175, '2015-02-12', '2015-02-12', '2015-02-13', '2015-02-13', 0, 0, NULL, 100),
(161, 18, 'BU. Support Fonctionnel', '', 176, '2015-02-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(162, 44, 'Total - TMA ITSM - Support ITSM', NULL, 177, '2015-02-02', '2015-02-02', '2015-12-31', '2015-04-30', NULL, NULL, NULL, NULL),
(163, 45, 'Total - TMA ITSM - Support BO', NULL, 178, '2015-02-02', '2015-02-02', '2015-06-30', '2015-04-30', NULL, NULL, NULL, NULL),
(164, 46, 'Total - TMA ITSM - Gestion des problèmes', NULL, 179, '2015-02-02', '2015-02-02', '2015-06-30', '2015-04-30', NULL, NULL, NULL, NULL),
(165, 47, 'Total - TMA ITSM - Chef de Projet technique', NULL, 180, '2015-02-02', '2015-02-02', '2015-12-31', '2015-04-30', NULL, NULL, NULL, NULL),
(166, 48, 'Total - TMA ITSM - Transfert', NULL, 181, '2015-02-02', '2015-02-02', '2015-04-30', '2015-03-31', NULL, NULL, NULL, NULL),
(167, 49, 'Total - TMA ITSM - Gouvernance', NULL, 182, '2015-02-02', '2015-02-02', '2015-06-30', '2015-04-30', NULL, NULL, NULL, NULL),
(168, 50, 'Bundle Tools - ITSM - WP1', NULL, 183, '2015-02-01', '2015-02-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(169, 51, 'Incidents - Bundle Tools - BI', NULL, 184, '2015-02-01', '2015-02-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(170, 52, 'Incidents - Bundle Tools - NTIC', NULL, 185, '2015-02-01', '2015-02-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(171, 53, 'Bundle Tools - ITSM - WP3', NULL, 186, '2015-02-01', '2015-02-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(172, 54, 'TOP - Bundle Tools - BI', NULL, 187, '2015-02-01', '2015-02-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(173, 55, 'TOP - Bundle Tools - NTIC', NULL, 188, '2015-02-01', '2015-02-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(174, 56, 'CEA - DAM - Train de maintenance évolutive n° 02', NULL, 189, '2015-02-16', '2015-02-16', '2015-03-27', '2015-03-27', 5354.34, NULL, NULL, 100),
(179, 34, 'AVV. LVMH - Les Échos - Patch Management - Contribution V1', '', 196, '2015-02-16', '2015-02-16', '2015-02-24', NULL, 0, 0, NULL, 100),
(180, 57, 'AIRBUS - ITSM - ARTS V2', NULL, 197, '2015-02-23', '2015-02-23', '2015-11-30', '2015-11-30', NULL, NULL, NULL, NULL),
(181, 58, 'Semaphore RUN', NULL, 198, '2015-02-02', '2015-02-02', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(182, 59, 'ITSM TOOL RUN', NULL, 199, '2015-02-02', '2015-02-02', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(183, 60, 'Semaphore Projets', NULL, 200, '2015-02-02', '2015-02-02', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(184, 61, 'ITSM TOOL Projets', NULL, 201, '2015-02-02', '2015-02-02', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(185, 44, 'Total - TMA ITSM - Support ITSM - 02/2015', '20 jours ouvrés', 202, '2015-02-02', '2015-02-02', '2015-02-27', '2015-02-27', 30921, 0, NULL, 100),
(186, 44, 'Total - TMA ITSM - Support ITSM - 03/2015', '22 jours ouvrés', 203, '2015-03-02', '2015-03-02', '2015-03-31', '2015-03-31', 30921, 0, NULL, 100),
(187, 46, 'Total - TMA ITSM - Gestion des problèmes - 02/2015', '', 204, '2015-02-02', '2015-02-02', '2015-02-27', '2015-02-27', 4800, 0, NULL, 100),
(188, 46, 'Total - TMA ITSM - Gestion des problèmes - 03/2015', '', 205, '2015-03-02', '2015-03-02', '2015-03-31', '2015-03-31', 4800, 0, NULL, 100),
(189, 45, 'Total - TMA ITSM - Support BO - 02/2015', '', 206, '2015-02-02', '2015-02-02', '2015-02-27', '2015-02-27', 3758, 0, NULL, 100),
(190, 45, 'Total - TMA ITSM - Support BO - 03/2015', '', 207, '2015-03-02', '2015-03-02', '2015-03-31', '2015-03-31', 3758, 0, NULL, 100),
(191, 48, 'Total - TMA ITSM - Transfert - Pilotage', '', 208, '2015-02-02', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(192, 48, 'Total - TMA ITSM - Transfert - RO', '', 209, '2015-02-02', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(193, 48, 'Total - TMA ITSM - Transfert - MCO', '', 210, '2015-02-02', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(194, 34, 'AVV. Orange - PEO - accompagnement amont', '', 212, '2015-02-23', '2015-02-23', '2015-03-27', NULL, 0, 0, NULL, 50),
(195, 31, 'CEA - DAM - VSR SM9 Q1 2015', '', 213, '2015-01-01', NULL, '2015-03-31', NULL, NULL, 0, NULL, NULL),
(196, 31, 'CEA - DAM - CESTA - TMA - Corrective -SM7 Q1 2015', '', 214, '2015-01-01', NULL, '2015-03-31', NULL, NULL, 0, NULL, NULL),
(197, 49, 'Total - TMA ITSM - Gouvernance - 02/2015', '', 215, '2015-02-02', '2015-02-02', '2015-02-27', '2015-02-27', 0, 0, NULL, 100),
(198, 49, 'Total - TMA ITSM - Gouvernance - 03/2015', '', 216, '2015-03-02', '2015-03-02', '2015-03-31', '2015-03-31', 0, 0, NULL, 100),
(199, 34, 'AVV. GDF SUEZ - .Net Centre - Faisabilité', '', 218, '2015-02-23', '2015-02-23', '2015-03-06', NULL, NULL, 0, NULL, NULL),
(200, 34, 'AVV. SANOFI DAI : Déploiement PROMISE - visite client', '', 219, '2015-03-02', '2015-03-02', '2015-03-06', '2015-03-06', 0, 0, NULL, 100),
(203, 21, 'Mass Data Administration - 2015-03-03T18:20:39+00:00', NULL, 220, '2015-03-03', '2015-03-03', '2015-03-06', '2015-03-03', 337.5, NULL, NULL, 100),
(204, 44, 'Total - TMA ITSM - Support ITSM - 04/2015', '', 221, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', 30921, 0, NULL, 100),
(205, 44, 'Total - TMA ITSM - Support ITSM - 05/2015', '', 222, '2015-05-01', NULL, '2015-05-29', NULL, NULL, 0, NULL, NULL),
(206, 44, 'Total - TMA ITSM - Support ITSM - 06/2015', '', 223, '2015-06-01', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(207, 44, 'Total - TMA ITSM - Support ITSM - 07/2015', '', 224, '2015-07-01', NULL, '2015-07-31', NULL, NULL, 0, NULL, NULL),
(208, 44, 'Total - TMA ITSM - Support ITSM - 08/2015', '', 225, '2015-08-03', NULL, '2015-08-31', NULL, NULL, 0, NULL, NULL),
(209, 44, 'Total - TMA ITSM - Support ITSM - 09/2015', '', 226, '2015-09-01', NULL, '2015-09-30', NULL, NULL, 0, NULL, NULL),
(210, 44, 'Total - TMA ITSM - Support ITSM - 10/2015', '', 227, '2015-10-01', NULL, '2015-10-30', NULL, NULL, 0, NULL, NULL),
(211, 44, 'Total - TMA ITSM - Support ITSM - 11/2015', '', 228, '2015-11-02', NULL, '2015-11-30', NULL, NULL, 0, NULL, NULL),
(212, 44, 'Total - TMA ITSM - Support ITSM - 12/2015', '', 229, '2015-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(213, 45, 'Total - TMA ITSM - Support BO - 04/2015', '', 230, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', 3758, 0, NULL, 100),
(214, 45, 'Total - TMA ITSM - Support BO - 05/2015', '', 231, '2015-05-01', NULL, '2015-05-29', NULL, NULL, 0, NULL, NULL),
(215, 45, 'Total - TMA ITSM - Support BO - 06/2015', '', 232, '2015-06-01', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(216, 47, 'Total - TMA ITSM - CdP Technique - 02/2015', '', 233, '2015-02-02', '2015-02-02', '2015-02-27', '2015-02-27', 2592, 0, NULL, 100),
(217, 47, 'Total - TMA ITSM - CdP Technique - 03/2015', '', 234, '2015-03-02', '2015-03-02', '2015-03-31', '2015-03-31', 2592, 0, NULL, 100),
(218, 47, 'Total - TMA ITSM - CdP Technique - 04/2015', '', 235, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', 2592, 0, NULL, 100),
(219, 47, 'Total - TMA ITSM - CdP Technique - 05/2015', '', 236, '2015-05-01', NULL, '2015-05-29', NULL, NULL, 0, NULL, NULL),
(220, 47, 'Total - TMA ITSM - CdP Technique - 06/2015', '', 237, '2015-06-01', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(221, 47, 'Total - TMA ITSM - CdP Technique - 07/2015', '', 238, '2015-07-01', NULL, '2015-07-31', NULL, NULL, 0, NULL, NULL),
(222, 47, 'Total - TMA ITSM - CdP Technique - 08/2015', '', 239, '2015-08-03', NULL, '2015-08-31', NULL, NULL, 0, NULL, NULL),
(223, 47, 'Total - TMA ITSM - CdP Technique - 09/2015', '', 240, '2015-09-01', NULL, '2015-09-30', NULL, NULL, 0, NULL, NULL),
(224, 47, 'Total - TMA ITSM - CdP Technique - 10/2015', '', 241, '2015-10-01', NULL, '2015-10-30', NULL, NULL, 0, NULL, NULL),
(225, 47, 'Total - TMA ITSM - CdP Technique - 11/2015', '', 242, '2015-11-02', NULL, '2015-11-30', NULL, NULL, 0, NULL, NULL),
(226, 47, 'Total - TMA ITSM - CdP Technique - 12/2015', '', 243, '2015-12-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(227, 26, 'CN-01070 (40j)', NULL, 507, '2014-12-08', NULL, '2015-01-30', NULL, NULL, NULL, NULL, 0),
(228, 26, '_CN-01070 - Analyse (16j)', '', 508, '2014-12-08', NULL, '2015-04-30', NULL, NULL, 0, NULL, 0),
(229, 26, '_CN-01070 - Dev (16j)', '', 509, '2014-12-08', NULL, '2015-04-30', NULL, NULL, 0, NULL, 0),
(230, 26, '_CN-01070 - Test (8j)', '', 510, '2014-12-08', NULL, '2015-04-30', NULL, NULL, 0, NULL, 0),
(251, 38, 'CN-01086 (67.2j)', NULL, 796, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(252, 38, '_CN-01086 - Analyse (26.88j)', NULL, 797, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(253, 38, '_CN-01086 - Dev (26.88j)', NULL, 798, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(254, 38, '_CN-01086 - Test (13.44j)', NULL, 799, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(255, 38, 'CN-01080 (19.2j)', NULL, 805, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(256, 38, '_CN-01080 - Analyse (7.68j)', NULL, 806, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(257, 38, '_CN-01080 - Dev (7.68j)', NULL, 807, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(258, 38, '_CN-01080 - Test (3.84j)', NULL, 808, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(259, 38, 'CN-01078 (4.8j)', NULL, 809, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(260, 38, '_CN-01078 - Analyse (1.92j)', NULL, 810, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(261, 38, '_CN-01078 - Dev (1.92j)', NULL, 811, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(262, 38, '_CN-01078 - Test (0.96j)', NULL, 812, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(263, 38, 'CN-01072 (29.625j)', NULL, 817, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(264, 38, '_CN-01072 - Analyse (11.85j)', NULL, 818, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(265, 38, '_CN-01072 - Dev (11.85j)', NULL, 819, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(266, 38, '_CN-01072 - Test (5.93j)', NULL, 820, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(267, 38, 'CN-01062 (16j)', NULL, 832, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(268, 38, '_CN-01062 - Analyse (6.4j)', NULL, 833, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(269, 38, '_CN-01062 - Dev (6.4j)', NULL, 834, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(270, 38, '_CN-01062 - Test (3.2j)', NULL, 835, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(271, 38, 'CN-01058 (24j)', NULL, 841, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(272, 38, '_CN-01058 - Analyse (9.6j)', NULL, 842, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(273, 38, '_CN-01058 - Dev (9.6j)', NULL, 843, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(274, 38, '_CN-01058 - Test (4.8j)', NULL, 844, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(275, 36, 'CN-01082 (11.25j)', NULL, 800, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(276, 36, '_CN-01082 - Analyse (4.5j)', NULL, 801, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(277, 36, '_CN-01082 - Dev (4.5j)', NULL, 802, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(278, 36, '_CN-01082 - Test (2.25j)', NULL, 803, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(279, 36, 'CN-01088 (2.5j)', NULL, 795, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(290, 38, 'CN-01703 (6.4j)', NULL, 745, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(291, 38, '_CN-01703 - Analyse (2.56j)', NULL, 746, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(292, 38, '_CN-01703 - Dev (2.56j)', NULL, 747, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(293, 38, '_CN-01703 - Test (1.28j)', NULL, 748, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(294, 38, 'CN-01856 (8j)', NULL, 653, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(295, 38, 'CN-01856 (8j)', NULL, 653, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(296, 18, 'BU. Management', '', 872, '2015-03-02', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(297, 40, 'CN-01891 (0j)', NULL, 594, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(298, 40, '_CN-01891 - Analyse (0j)', NULL, 595, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(299, 40, '_CN-01891 - Dev (0j)', NULL, 596, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(300, 40, '_CN-01891 - Test (0j)', NULL, 597, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(301, 40, 'CN-01880 (1.6j)', NULL, 619, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(302, 40, '_CN-01880 - Analyse (0.64j)', NULL, 620, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(303, 40, '_CN-01880 - Dev (0.64j)', NULL, 621, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(304, 40, '_CN-01880 - Test (0.32j)', NULL, 622, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(305, 40, 'CN-01879 (5.6j)', NULL, 623, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(306, 40, '_CN-01879 - Analyse (2.24j)', NULL, 624, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(307, 40, '_CN-01879 - Dev (2.24j)', NULL, 625, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(308, 40, '_CN-01879 - Test (1.12j)', NULL, 626, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(309, 40, 'CN-01869 (8.8j)', NULL, 631, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(310, 40, '_CN-01869 - Analyse (3.52j)', NULL, 632, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(311, 40, '_CN-01869 - Dev (3.52j)', NULL, 633, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(312, 40, '_CN-01869 - Test (1.76j)', NULL, 634, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(313, 40, 'CN-01868 (5.6j)', NULL, 635, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(314, 40, '_CN-01868 - Analyse (2.24j)', NULL, 636, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(315, 40, '_CN-01868 - Dev (2.24j)', NULL, 637, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(316, 40, '_CN-01868 - Test (1.12j)', NULL, 638, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(317, 40, 'CN-01848 (5.6j)', NULL, 673, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(318, 40, '_CN-01848 - Analyse (2.24j)', NULL, 674, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(319, 40, '_CN-01848 - Dev (2.24j)', NULL, 675, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(320, 40, '_CN-01848 - Test (1.12j)', NULL, 676, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(329, 62, 'ASPIRE V1.14', NULL, 897, '2015-02-16', '2015-02-16', '2015-04-30', '2015-04-30', NULL, NULL, NULL, NULL),
(330, 63, 'ASPIRE V1.15', NULL, 898, '2015-03-02', '2015-03-02', '2015-07-15', '2015-07-15', NULL, NULL, NULL, NULL),
(331, 64, 'AML V2.4.9', NULL, 899, '2015-02-01', '2015-02-01', '2015-05-31', '2015-05-31', NULL, NULL, NULL, NULL),
(332, 65, 'I4U V1.2', NULL, 900, '2015-02-01', '2015-02-01', '2015-05-31', '2015-05-31', NULL, NULL, NULL, NULL),
(333, 66, 'MASTER PLAN 2.1', NULL, 901, '2015-03-02', '2015-03-02', '2015-05-22', '2015-05-22', NULL, NULL, NULL, NULL),
(334, 62, 'CN-01930 (1.6j)', NULL, 563, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(335, 62, '_CN-01930 - Analyse (0.64j)', NULL, 564, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(336, 62, '_CN-01930 - Dev (0.64j)', NULL, 565, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(337, 62, '_CN-01930 - Test (0.32j)', NULL, 566, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(338, 62, '_CN-01930 - ARA (0.3j)', NULL, 567, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(339, 62, 'CN-01899 (0.8j)', NULL, 580, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(340, 62, '_CN-01899 - Analyse (0.32j)', NULL, 581, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(341, 62, '_CN-01899 - Dev (0.32j)', NULL, 582, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(342, 62, '_CN-01899 - Test (0.16j)', NULL, 583, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(343, 62, '_CN-01899 - ARA (0.15j)', NULL, 584, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(344, 62, 'CN-01897 (28j)', NULL, 585, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(345, 62, '_CN-01897 - Analyse (11.2j)', NULL, 586, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(346, 62, '_CN-01897 - Dev (11.2j)', NULL, 587, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(347, 62, '_CN-01897 - Test (5.6j)', NULL, 588, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(348, 62, '_CN-01897 - ARA (5.25j)', NULL, 589, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(349, 62, 'CN-01888 (0.8j)', NULL, 598, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(350, 62, '_CN-01888 - Analyse (0.32j)', NULL, 599, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(351, 62, '_CN-01888 - Dev (0.32j)', NULL, 600, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(352, 62, '_CN-01888 - Test (0.16j)', NULL, 601, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(353, 62, '_CN-01888 - ARA (0.15j)', NULL, 602, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(354, 62, 'CN-01887 (2.4j)', NULL, 603, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(355, 62, '_CN-01887 - Analyse (0.96j)', NULL, 604, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(356, 62, '_CN-01887 - Dev (0.96j)', NULL, 605, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(357, 62, '_CN-01887 - Test (0.48j)', NULL, 606, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(358, 62, '_CN-01887 - ARA (0.45j)', NULL, 607, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(359, 62, 'CN-01886 (1.6j)', NULL, 608, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(360, 62, '_CN-01886 - Analyse (0.64j)', NULL, 609, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(361, 62, '_CN-01886 - Dev (0.64j)', NULL, 610, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(362, 62, '_CN-01886 - Test (0.32j)', NULL, 611, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(363, 62, '_CN-01886 - ARA (0.3j)', NULL, 612, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(364, 62, 'CN-01885 (2j)', NULL, 613, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(365, 62, '_CN-01885 - Analyse (0.8j)', NULL, 614, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(366, 62, '_CN-01885 - Dev (0.8j)', NULL, 615, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(367, 62, '_CN-01885 - Test (0.4j)', NULL, 616, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(368, 62, '_CN-01885 - ARA (0.375j)', NULL, 617, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(369, 34, 'AVV. Airbus - Bundle Tools - INUY - Frame', '', 903, '2015-03-09', '2015-03-09', '2015-03-27', NULL, NULL, 0, NULL, NULL),
(370, 34, 'AVV. Airbus - Bundle Tools - INUY - CMS V3', '', 904, '2015-03-09', '2015-03-09', '2015-03-27', NULL, NULL, 0, NULL, NULL),
(371, 34, 'AVV. Airbus - Bundle Tools - INUY - Lean Ticketing', '', 905, '2015-03-09', '2015-03-09', '2015-03-27', NULL, NULL, 0, NULL, NULL),
(372, 57, 'KickOff Meeting', '', 907, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(373, 34, 'AVV. MINEFI - TMA OGPS - Volet 3', '', 921, '2015-03-12', '2015-03-16', '2015-03-25', NULL, 0, 0, NULL, 100),
(374, 65, 'CN-01917 (5.6j)', NULL, 572, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(375, 65, '_CN-01917 - Analyse (2.24j)', NULL, 573, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(376, 65, '_CN-01917 - Dev (2.24j)', NULL, 574, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(377, 65, '_CN-01917 - Test (1.12j)', NULL, 575, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(378, 65, 'CN-01916 (2.8j)', NULL, 576, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(379, 65, '_CN-01916 - Analyse (1.12j)', NULL, 577, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(380, 65, '_CN-01916 - Dev (1.12j)', NULL, 578, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(381, 65, '_CN-01916 - Test (0.56j)', NULL, 579, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(382, 67, 'ETICKET V3.0', NULL, 945, '2015-03-02', '2015-03-02', '2015-05-29', '2015-05-29', NULL, NULL, NULL, NULL),
(383, 68, 'MASTER PLAN 2.0', NULL, 946, '2015-02-02', '2015-02-02', '2015-04-13', '2015-04-13', NULL, NULL, NULL, NULL),
(384, 68, 'CN-01866 (14.4j)', NULL, 639, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(385, 68, '_CN-01866 - Analyse (5.76j)', NULL, 640, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(386, 68, '_CN-01866 - Dev (5.76j)', NULL, 641, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(387, 68, '_CN-01866 - Test (2.88j)', NULL, 642, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(388, 68, 'CN-01764 (32j)', NULL, 731, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(389, 68, '_CN-01764 - Analyse (12.8j)', NULL, 732, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(390, 68, '_CN-01764 - Dev (12.8j)', NULL, 733, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(391, 68, '_CN-01764 - Test (6.4j)', NULL, 734, '2015-02-02', NULL, '2015-04-13', NULL, NULL, NULL, NULL, 0),
(392, 37, 'CN-01953 (3.84j)', NULL, 932, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(393, 37, '_CN-01953 - Analyse (1.54j)', '', 933, '2015-01-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, 0),
(394, 37, '_CN-01953 - Dev (1.54j)', NULL, 934, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(395, 37, '_CN-01953 - Test (0.77j)', NULL, 935, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(396, 37, '_CN-01953 - ARA (0.72j)', NULL, 936, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(402, 37, 'CN-01955 (3.84j)', NULL, 922, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(403, 37, '_CN-01955 - Analyse (1.54j)', '', 923, '2015-03-16', NULL, '2015-03-17', NULL, NULL, 0, NULL, 0),
(404, 37, '_CN-01955 - Dev (1.54j)', NULL, 924, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(405, 37, '_CN-01955 - Test (0.77j)', NULL, 925, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(406, 37, '_CN-01955 - ARA (0.72j)', NULL, 926, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(412, 37, 'CN-01954 (3.84j)', NULL, 927, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(413, 37, '_CN-01954 - Analyse (1.54j)', NULL, 928, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(414, 37, '_CN-01954 - Dev (1.54j)', NULL, 929, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(415, 37, '_CN-01954 - Test (0.77j)', NULL, 930, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(416, 37, '_CN-01954 - ARA (0.72j)', NULL, 931, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(417, 34, 'AVV. Celine - Bundle Patch Management - V2 - contribution à la proposition', '', 988, '2015-03-13', '2015-03-16', '2015-03-20', '2015-03-23', 0, 0, NULL, 100),
(418, 66, 'CN-01921 (19.2j)', NULL, 978, '2015-03-02', NULL, '2015-05-22', NULL, NULL, NULL, NULL, 0),
(419, 66, '_CN-01921 - Analyse (7.68j)', NULL, 979, '2015-03-02', NULL, '2015-05-22', NULL, NULL, NULL, NULL, 0),
(420, 66, '_CN-01921 - Dev (7.68j)', NULL, 980, '2015-03-02', NULL, '2015-05-22', NULL, NULL, NULL, NULL, 0),
(421, 66, '_CN-01921 - Test (3.84j)', NULL, 981, '2015-03-02', NULL, '2015-05-22', NULL, NULL, NULL, NULL, 0),
(427, 64, 'CN-01918 (12.75j)', NULL, 873, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(428, 64, '_CN-01918 - Analyse (5.1j)', NULL, 874, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(429, 64, '_CN-01918 - Dev (5.1j)', NULL, 875, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(430, 64, '_CN-01918 - Test (2.55j)', NULL, 876, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(435, 64, 'CN-01847 (11.125j)', NULL, 998, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(436, 64, '_CN-01847 - Analyse (4.45j)', NULL, 999, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(437, 64, '_CN-01847 - Dev (4.45j)', NULL, 1000, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(438, 64, '_CN-01847 - Test (2.23j)', NULL, 1001, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(439, 67, 'CN-01937 (2.8j)', NULL, 937, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(440, 67, '_CN-01937 - Analyse (1.12j)', NULL, 938, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(441, 67, '_CN-01937 - Dev (1.12j)', NULL, 939, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(442, 67, '_CN-01937 - Test (0.56j)', NULL, 940, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(443, 67, 'CN-01936 (15.6j)', NULL, 908, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(444, 67, '_CN-01936 - Analyse (6.24j)', NULL, 909, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(445, 67, '_CN-01936 - Dev (6.24j)', NULL, 910, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(446, 67, '_CN-01936 - Test (3.12j)', NULL, 911, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(447, 69, 'SANOFI - Déploiement Promise - RUN', NULL, 1007, '2015-04-01', NULL, '2018-04-30', NULL, NULL, NULL, NULL, NULL),
(492, 70, 'Gestion des activités - V1', NULL, 1063, '2015-02-18', '2015-03-18', '2015-06-30', '2015-06-30', NULL, NULL, NULL, NULL),
(493, 71, 'Gestion des demandes', NULL, 1064, '2015-03-18', NULL, '2015-06-30', NULL, NULL, NULL, NULL, NULL),
(494, 37, 'CN-01966 (1.6j)', NULL, 1042, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(495, 37, '_CN-01966 - Analyse (0.64j)', NULL, 1043, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(496, 37, '_CN-01966 - Dev (0.64j)', '', 1044, '2015-03-17', NULL, '2015-03-17', NULL, NULL, 0, NULL, 0),
(497, 37, '_CN-01966 - Test (0.32j)', '', 1045, '2015-03-17', NULL, '2015-03-17', NULL, NULL, 0, NULL, 0),
(498, 37, '_CN-01966 - ARA (0.3j)', '', 1046, '2015-03-20', NULL, '2015-03-20', NULL, NULL, 0, NULL, 0),
(499, 34, 'AVV. Orange - PEO - réponse V1', '', 1065, '2015-03-23', '2015-03-23', '2015-04-10', NULL, NULL, 0, NULL, NULL),
(500, 40, 'CN-01870 (7.2j)', NULL, 941, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(501, 40, '_CN-01870 - Analyse (2.88j)', NULL, 942, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(502, 40, '_CN-01870 - Dev (2.88j)', NULL, 943, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(503, 40, '_CN-01870 - Test (1.44j)', NULL, 944, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(508, 39, 'CN-01892 (0.8j)', NULL, 590, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(509, 39, '_CN-01892 - Analyse (0.32j)', NULL, 591, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(510, 39, '_CN-01892 - Dev (0.32j)', NULL, 592, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(511, 39, '_CN-01892 - Test (0.16j)', NULL, 593, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(512, 39, 'CN-01858 (4j)', NULL, 881, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(513, 39, '_CN-01858 - Analyse (1.6j)', NULL, 882, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(514, 39, '_CN-01858 - Dev (1.6j)', NULL, 883, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(515, 39, '_CN-01858 - Test (0.8j)', NULL, 884, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(516, 39, 'CN-01852 (1.6j)', NULL, 664, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(517, 39, '_CN-01852 - Analyse (0.64j)', NULL, 665, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(518, 39, '_CN-01852 - Dev (0.64j)', NULL, 666, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(519, 39, '_CN-01852 - Test (0.32j)', NULL, 667, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(520, 39, 'CN-01845 (1.2j)', NULL, 677, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(521, 39, '_CN-01845 - Analyse (0.48j)', NULL, 678, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(522, 39, '_CN-01845 - Dev (0.48j)', NULL, 679, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(523, 39, '_CN-01845 - Test (0.24j)', NULL, 680, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(524, 39, 'CN-01828 (1.6j)', NULL, 682, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(525, 39, '_CN-01828 - Analyse (0.64j)', NULL, 683, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(526, 39, '_CN-01828 - Dev (0.64j)', NULL, 684, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(527, 39, '_CN-01828 - Test (0.32j)', NULL, 685, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(528, 39, 'CN-01807 (11.2j)', NULL, 893, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(529, 39, '_CN-01807 - Analyse (4.48j)', NULL, 894, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(530, 39, '_CN-01807 - Dev (4.48j)', NULL, 895, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(531, 39, '_CN-01807 - Test (2.24j)', NULL, 896, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(532, 39, 'CN-01801 (8.4j)', NULL, 705, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(533, 39, '_CN-01801 - Analyse (3.36j)', NULL, 706, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(534, 39, '_CN-01801 - Dev (3.36j)', NULL, 707, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(535, 39, '_CN-01801 - Test (1.68j)', NULL, 708, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(536, 72, 'MASTER PLAN 2.2', NULL, 1066, '2015-03-09', '2015-03-09', '2015-07-01', '2015-07-01', NULL, NULL, NULL, NULL),
(537, 73, 'PWINIT v3.6', NULL, 1067, '2015-03-01', '2015-03-01', '2015-04-15', '2015-04-15', NULL, NULL, NULL, NULL),
(538, 37, 'CN-01919 (1.6j)', NULL, 952, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(539, 37, '_CN-01919 - Analyse (0.64j)', NULL, 953, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(540, 37, '_CN-01919 - Dev (0.64j)', NULL, 954, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(541, 37, '_CN-01919 - Test (0.32j)', NULL, 955, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(542, 37, '_CN-01919 - ARA (0.3j)', NULL, 956, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(543, 37, 'CN-01920 (3.84j)', NULL, 947, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(544, 37, '_CN-01920 - Analyse (1.54j)', NULL, 948, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(545, 37, '_CN-01920 - Dev (1.54j)', NULL, 949, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(546, 37, '_CN-01920 - Test (0.77j)', NULL, 950, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(547, 37, '_CN-01920 - ARA (0.72j)', NULL, 951, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(548, 72, 'CN-01963 (24.8j)', NULL, 1069, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(549, 72, '_CN-01963 - Analyse (9.92j)', NULL, 1070, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(550, 72, '_CN-01963 - Dev (9.92j)', NULL, 1071, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(551, 72, '_CN-01963 - Test (4.96j)', NULL, 1072, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(552, 73, 'CN-01719 (8j)', NULL, 987, '2015-03-01', NULL, '2015-04-15', NULL, NULL, NULL, NULL, 0),
(558, 34, 'BU. Transverse - Catalogue de Services', '', 1101, '2015-03-23', '2015-03-23', '2015-05-29', NULL, NULL, 0, NULL, NULL),
(559, 74, 'CEGID TMA Phase de transition', NULL, 1108, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', NULL, NULL, NULL, NULL),
(560, 75, 'CEGID TMA Corrective', NULL, 1109, '2015-05-01', NULL, '2016-04-30', NULL, NULL, NULL, NULL, NULL),
(561, 76, 'CEGID TMA Evolutive', NULL, 1110, '2015-05-01', NULL, '2016-04-30', NULL, NULL, NULL, NULL, NULL),
(562, 77, 'CEGID TMA Préventive', NULL, 1111, '2015-05-01', NULL, '2016-04-30', NULL, NULL, NULL, NULL, NULL),
(567, 70, 'Realisation des interviews', '', 1113, '2015-03-16', NULL, '2015-03-27', NULL, NULL, 0, NULL, NULL),
(568, 37, 'CN-01991 (1.6j)', NULL, 1093, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(569, 37, '_CN-01991 - Analyse (0.64j)', NULL, 1094, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(570, 37, '_CN-01991 - Dev (0.64j)', NULL, 1095, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(571, 37, '_CN-01991 - Test (0.32j)', NULL, 1096, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(572, 37, '_CN-01991 - ARA (0.3j)', NULL, 1097, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(575, 21, 'Mass Data Administration - 2015-03-23T17:15:22+00:00', NULL, 1123, '2015-03-23', '2015-04-03', '2015-04-03', '2015-04-15', 337.5, NULL, NULL, 100),
(576, 21, 'Mass Data Administration - 2015-03-23T17:16:54+00:00', NULL, 1124, '2015-03-23', '2015-04-03', '2015-04-03', '2015-04-15', 337.5, NULL, NULL, 100),
(577, 70, 'Quotation des users stories et implémentation dans icescrum', '', 1205, '2015-03-30', NULL, '2015-04-03', NULL, NULL, 0, NULL, NULL),
(578, 65, 'CN-01861 (0j)', NULL, 1033, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(579, 65, '_CN-01861 - Analyse (0j)', NULL, 1034, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(580, 65, '_CN-01861 - Dev (0j)', NULL, 1035, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(581, 65, '_CN-01861 - Test (0j)', NULL, 1036, '2015-02-01', NULL, '2015-05-31', NULL, NULL, NULL, NULL, 0),
(583, 78, 'CEA - DAM - Train de maintenance évolutive n° 03', NULL, 1221, '2015-04-01', '2015-04-01', '2015-05-15', '2015-05-15', NULL, NULL, NULL, NULL),
(584, 79, 'Reporting Bundle Tools Activity (19j)', NULL, 1222, '2015-04-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, NULL),
(585, 49, 'Total - TMA ITSM - Gouvernance - 04/2015', '', 1223, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', 0, 0, NULL, 100),
(586, 46, 'Total - TMA ITSM - Gestion des problèmes - 04/2015', '', 1224, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', 4800, 0, NULL, 100),
(587, 46, 'Total - TMA ITSM - Gestion des problèmes - 05/2015', '', 1225, '2015-05-01', NULL, '2015-05-29', NULL, NULL, 0, NULL, NULL),
(588, 46, 'Total - TMA ITSM - Gestion des problèmes - 06/2015', '', 1226, '2015-06-01', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(589, 37, 'CN-02006 (3.84j)', NULL, 1206, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(590, 37, '_CN-02006 - Analyse (1.54j)', NULL, 1207, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(591, 37, '_CN-02006 - Dev (1.54j)', NULL, 1208, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(592, 37, '_CN-02006 - Test (0.77j)', NULL, 1209, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(593, 37, '_CN-02006 - ARA (0.72j)', NULL, 1210, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(594, 37, 'CN-01996 (3.84j)', NULL, 1125, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(595, 37, '_CN-01996 - Analyse (1.54j)', NULL, 1126, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(596, 37, '_CN-01996 - Dev (1.54j)', NULL, 1127, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(597, 37, '_CN-01996 - Test (0.77j)', NULL, 1128, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(598, 37, '_CN-01996 - ARA (0.72j)', NULL, 1129, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(599, 37, 'CN-01958 (6.4j)', NULL, 1168, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(600, 37, '_CN-01958 - Analyse (2.56j)', NULL, 1169, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0);
INSERT INTO `projectactivity` (`IdActivity`, `idProject`, `ActivityName`, `WBSDictionary`, `WorkPackage`, `PlanInitDate`, `ActualInitDate`, `PlanEndDate`, `ActualEndDate`, `EV`, `PV`, `AC`, `poc`) VALUES
(601, 37, '_CN-01958 - Dev (2.56j)', NULL, 1170, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(602, 37, '_CN-01958 - Test (1.28j)', NULL, 1171, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(603, 37, '_CN-01958 - ARA (1.2j)', NULL, 1172, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(604, 37, 'CN-01985 (6j)', NULL, 1102, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(605, 31, 'CEA - DAM -VSR SM9', '', 1227, '2015-04-01', NULL, '2015-05-31', NULL, NULL, 0, NULL, NULL),
(606, 34, 'AVV. CEA Civil - participation', '', 1229, '2015-04-01', NULL, '2015-04-03', NULL, NULL, 0, NULL, NULL),
(607, 38, 'CN-01091 (23.625j)', NULL, 1265, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(608, 38, '_CN-01091 - Analyse (9.45j)', NULL, 1266, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(609, 38, '_CN-01091 - Dev (9.45j)', NULL, 1267, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(610, 38, '_CN-01091 - Test (4.73j)', NULL, 1268, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(611, 38, 'CN-01932 (16.75j)', NULL, 1253, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(612, 38, '_CN-01932 - Analyse (6.7j)', '', 1254, '2015-02-02', NULL, '2015-09-30', NULL, NULL, 0, NULL, 0),
(613, 38, '_CN-01932 - Dev (6.7j)', NULL, 1255, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(614, 38, '_CN-01932 - Test (3.35j)', NULL, 1256, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(620, 70, 'Gestion des activites', '', 1271, '2015-02-18', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(621, 70, 'Sprint 1', '', 1272, '2015-04-07', NULL, '2015-04-20', NULL, NULL, 0, NULL, NULL),
(622, 80, 'AAL V8.7.0', NULL, 1319, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, NULL),
(623, 81, 'ATREF V2.1', NULL, 1320, '2015-03-30', '2015-03-30', '2015-06-05', '2015-06-05', NULL, NULL, NULL, NULL),
(624, 82, 'AIFU', NULL, 1321, '2015-01-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, NULL),
(625, 83, 'LBP - OPUS - TMA Corrective - 2015', NULL, 1322, '2015-04-01', '2015-04-01', '2015-04-30', '2015-04-30', NULL, NULL, NULL, NULL),
(626, 84, 'Activités externes au CdS', NULL, 1323, '2015-01-01', '2015-01-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(627, 72, 'CN-01980 (38.4j)', NULL, 1277, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(628, 72, '_CN-01980 - Analyse (15.36j)', NULL, 1278, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(629, 72, '_CN-01980 - Dev (15.36j)', NULL, 1279, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(630, 72, '_CN-01980 - Test (7.68j)', NULL, 1280, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(631, 72, 'CN-01933 (0j)', NULL, 1194, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(632, 72, '_CN-01933 - Analyse (0j)', NULL, 1195, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(633, 72, '_CN-01933 - Dev (0j)', NULL, 1196, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(634, 72, '_CN-01933 - Test (0j)', NULL, 1197, '2015-03-09', NULL, '2015-07-01', NULL, NULL, NULL, NULL, 0),
(635, 83, 'LBP - OPUS TMA Corrective - Avril  2015', '', 1324, '2015-04-01', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(636, 62, 'CN-01987 (0j)', NULL, 1130, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(637, 62, '_CN-01987 - Analyse (0j)', NULL, 1131, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(638, 62, '_CN-01987 - Dev (0j)', NULL, 1132, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(639, 62, '_CN-01987 - Test (0j)', NULL, 1133, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(640, 62, '_CN-01987 - ARA (0j)', NULL, 1134, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(641, 63, 'CN-01913 (5.6j)', NULL, 993, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(642, 63, '_CN-01913 - Analyse (2.24j)', NULL, 994, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(643, 63, '_CN-01913 - Dev (2.24j)', NULL, 995, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(644, 63, '_CN-01913 - Test (1.12j)', NULL, 996, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(645, 63, '_CN-01913 - ARA (1.05j)', NULL, 997, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(646, 63, 'CN-01780 (22.8j)', NULL, 715, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(647, 63, '_CN-01780 - Analyse (9.12j)', NULL, 716, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(648, 63, '_CN-01780 - Dev (9.12j)', NULL, 717, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(649, 63, '_CN-01780 - Test (4.56j)', NULL, 718, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(650, 63, '_CN-01780 - ARA (4.275j)', NULL, 719, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(651, 63, 'CN-01819 (20j)', NULL, 1002, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(652, 63, '_CN-01819 - Analyse (8j)', NULL, 1003, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(653, 63, '_CN-01819 - Dev (8j)', NULL, 1004, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(654, 63, '_CN-01819 - Test (4j)', NULL, 1005, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(655, 63, '_CN-01819 - ARA (3.75j)', NULL, 1006, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(656, 81, 'CN-01875 (13.6j)', NULL, 1346, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(657, 81, '_CN-01875 - Analyse (5.44j)', NULL, 1347, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(658, 81, '_CN-01875 - Dev (5.44j)', NULL, 1348, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(659, 81, '_CN-01875 - Test (2.72j)', NULL, 1349, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(660, 81, 'CN-01827 (36.4j)', NULL, 885, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(661, 81, '_CN-01827 - Analyse (14.56j)', NULL, 886, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(662, 81, '_CN-01827 - Dev (14.56j)', NULL, 887, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(663, 81, '_CN-01827 - Test (7.28j)', NULL, 888, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(664, 81, 'CN-01877 (2.8j)', NULL, 1302, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(665, 81, '_CN-01877 - Analyse (1.12j)', NULL, 1303, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(666, 81, '_CN-01877 - Dev (1.12j)', NULL, 1304, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(667, 81, '_CN-01877 - Test (0.56j)', NULL, 1305, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(668, 39, 'CN-01995 (0j)', NULL, 1273, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(669, 39, '_CN-01995 - Analyse (0j)', NULL, 1274, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(670, 39, '_CN-01995 - Dev (0j)', NULL, 1275, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(671, 39, '_CN-01995 - Test (0j)', NULL, 1276, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(676, 85, 'ICT Catalogue', NULL, 1368, '2015-04-01', '2015-04-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(677, 86, 'Reste à produire 2015', NULL, 1369, '2015-04-01', '2015-04-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(678, 39, 'CN-01927 (1.6j)', NULL, 1081, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(679, 39, '_CN-01927 - Analyse (0.64j)', NULL, 1082, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(680, 39, '_CN-01927 - Dev (0.64j)', NULL, 1083, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(681, 39, '_CN-01927 - Test (0.32j)', NULL, 1084, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(682, 85, 'CN-01831 (2.8j)', NULL, 1037, '2015-04-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(683, 85, '_CN-01831 - Analyse (1.12j)', NULL, 1038, '2015-04-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(684, 85, '_CN-01831 - Dev (1.12j)', NULL, 1039, '2015-04-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(685, 85, '_CN-01831 - Test (0.56j)', NULL, 1040, '2015-04-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(686, 85, 'CN-01832 (2.4j)', NULL, 1310, '2015-04-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(687, 21, 'Mass Data Administration - 2015-04-15T09:56:43+00:00', NULL, 1384, '2015-04-15', '2015-04-15', '2015-04-20', NULL, NULL, NULL, NULL, NULL),
(688, 39, 'CN-01938 (2j)', NULL, 1364, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(689, 39, '_CN-01938 - Analyse (0.8j)', NULL, 1365, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(690, 39, '_CN-01938 - Dev (0.8j)', NULL, 1366, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(691, 39, '_CN-01938 - Test (0.4j)', NULL, 1367, '2015-02-02', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(696, 87, 'I4U 1.3', NULL, 1385, '2015-04-01', '2015-04-01', '2015-07-31', '2015-07-31', NULL, NULL, NULL, NULL),
(697, 63, 'CN-01981 (0j)', NULL, 1151, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(698, 63, '_CN-01981 - Analyse (0j)', NULL, 1152, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(699, 63, '_CN-01981 - Dev (0j)', NULL, 1153, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(700, 63, '_CN-01981 - Test (0j)', NULL, 1154, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(701, 63, '_CN-01981 - ARA (0j)', NULL, 1155, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(702, 63, 'CN-01979 (1.5j)', NULL, 1281, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(703, 63, '_CN-01979 - Analyse (0.6j)', NULL, 1282, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(704, 63, '_CN-01979 - Dev (0.6j)', NULL, 1283, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(705, 63, '_CN-01979 - Test (0.3j)', NULL, 1284, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(706, 63, '_CN-01979 - ARA (0.28125j)', NULL, 1285, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(707, 63, 'CN-01978 (1.5j)', NULL, 1286, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(708, 63, '_CN-01978 - Analyse (0.6j)', NULL, 1287, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(709, 63, '_CN-01978 - Dev (0.6j)', NULL, 1288, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(710, 63, '_CN-01978 - Test (0.3j)', NULL, 1289, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(711, 63, '_CN-01978 - ARA (0.28125j)', NULL, 1290, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(712, 63, 'CN-01977 (5.6j)', NULL, 1291, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(713, 63, '_CN-01977 - Analyse (2.24j)', NULL, 1292, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(714, 63, '_CN-01977 - Dev (2.24j)', NULL, 1293, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(715, 63, '_CN-01977 - Test (1.12j)', NULL, 1294, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(716, 63, '_CN-01977 - ARA (1.05j)', NULL, 1295, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(717, 63, 'CN-01975 (2.3j)', NULL, 1354, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(718, 63, '_CN-01975 - Analyse (0.92j)', NULL, 1355, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(719, 63, '_CN-01975 - Dev (0.92j)', NULL, 1356, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(720, 63, '_CN-01975 - Test (0.46j)', NULL, 1357, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(721, 63, '_CN-01975 - ARA (0.43125j)', NULL, 1358, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(722, 63, 'CN-01974 (1.5j)', NULL, 1359, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(723, 63, '_CN-01974 - Analyse (0.6j)', NULL, 1360, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(724, 63, '_CN-01974 - Dev (0.6j)', NULL, 1361, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(725, 63, '_CN-01974 - Test (0.3j)', NULL, 1362, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(726, 63, '_CN-01974 - ARA (0.28125j)', NULL, 1363, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(727, 63, 'CN-01973 (4.1j)', NULL, 1296, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(728, 63, '_CN-01973 - Analyse (1.64j)', NULL, 1297, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(729, 63, '_CN-01973 - Dev (1.64j)', NULL, 1298, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(730, 63, '_CN-01973 - Test (0.82j)', NULL, 1299, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(731, 63, '_CN-01973 - ARA (0.76875j)', NULL, 1300, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(732, 63, 'CN-01929 (0j)', NULL, 1341, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(733, 63, '_CN-01929 - Analyse (0j)', NULL, 1342, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(734, 63, '_CN-01929 - Dev (0j)', NULL, 1343, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(735, 63, '_CN-01929 - Test (0j)', NULL, 1344, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(736, 63, '_CN-01929 - ARA (0j)', NULL, 1345, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(737, 63, 'CN-01049 (11.2j)', NULL, 1379, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(738, 63, '_CN-01049 - Analyse (4.48j)', NULL, 1380, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(739, 63, '_CN-01049 - Dev (4.48j)', NULL, 1381, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(740, 63, '_CN-01049 - Test (2.24j)', NULL, 1382, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(741, 63, '_CN-01049 - ARA (2.1j)', NULL, 1383, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(742, 88, 'PWINIT Out of Release', NULL, 1386, '2015-01-01', '2015-01-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(743, 70, 'Sprint 2', '', 1387, '2015-04-20', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(744, 89, 'CEA - DAM - Reprise de Données Centre Gramat', NULL, 1388, '2015-04-20', '2015-04-20', '2015-07-31', '2015-07-31', NULL, NULL, NULL, NULL),
(745, 60, 'CN-01089 (11j)', NULL, 1041, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(746, 60, 'CN-01092 (21.6j)', NULL, 1311, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(747, 60, '_CN-01092 - Analyse (8.64j)', NULL, 1312, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(748, 60, '_CN-01092 - Dev (8.64j)', NULL, 1313, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(749, 60, '_CN-01092 - Test (4.32j)', NULL, 1314, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(750, 60, 'CN-01087 (2.5j)', NULL, 1012, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(751, 60, 'CN-01085 (2j)', NULL, 1013, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(752, 60, 'CN-01084 (2j)', NULL, 1014, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(753, 60, 'CN-01083 (35.2j)', NULL, 1315, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(754, 60, '_CN-01083 - Analyse (14.08j)', NULL, 1316, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(755, 60, '_CN-01083 - Dev (14.08j)', NULL, 1317, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(756, 60, '_CN-01083 - Test (7.04j)', NULL, 1318, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(757, 58, 'CN-01067 (12.8j)', NULL, 823, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(758, 58, '_CN-01067 - Analyse (5.12j)', NULL, 824, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(759, 58, '_CN-01067 - Dev (5.12j)', NULL, 825, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(760, 58, '_CN-01067 - Test (2.56j)', NULL, 826, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(761, 60, 'CN-01051 (11.2j)', NULL, 849, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(762, 60, '_CN-01051 - Analyse (4.48j)', NULL, 850, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(763, 60, '_CN-01051 - Dev (4.48j)', NULL, 851, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(764, 60, '_CN-01051 - Test (2.24j)', NULL, 852, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(765, 60, 'CN-01054 (3.2j)', NULL, 845, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(766, 60, '_CN-01054 - Analyse (1.28j)', NULL, 846, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(767, 60, '_CN-01054 - Dev (1.28j)', NULL, 847, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(768, 60, '_CN-01054 - Test (0.64j)', NULL, 848, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(769, 60, 'CN-01061 (24j)', NULL, 836, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(770, 58, 'CN-01063 (35j)', NULL, 831, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(771, 60, 'CN-01081 (29j)', NULL, 804, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(772, 60, 'CN-01068 (25j)', NULL, 822, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(773, 60, 'CN-01069 (30j)', NULL, 821, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(774, 37, 'CN-02011 (3.84j)', NULL, 1235, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(775, 37, '_CN-02011 - Analyse (1.54j)', NULL, 1236, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(776, 37, '_CN-02011 - Dev (1.92j)', NULL, 1237, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(777, 37, '_CN-02011 - Test (0.38j)', NULL, 1238, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(778, 37, '_CN-02011 - ARA (0.72j)', NULL, 1239, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(779, 37, 'CN-02010 (3.84j)', NULL, 1240, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(780, 37, '_CN-02010 - Analyse (1.54j)', NULL, 1241, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(781, 37, '_CN-02010 - Dev (1.92j)', NULL, 1242, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(782, 37, '_CN-02010 - Test (0.38j)', NULL, 1243, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(783, 37, '_CN-02010 - ARA (0.72j)', NULL, 1244, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(784, 37, 'CN-01849 (3.84j)', NULL, 668, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(785, 37, '_CN-01849 - Analyse (1.54j)', NULL, 669, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(786, 37, '_CN-01849 - Dev (1.54j)', NULL, 670, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(787, 37, '_CN-01849 - Test (0.77j)', NULL, 671, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(788, 37, '_CN-01849 - ARA (0.72j)', NULL, 672, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(789, 67, 'CN-02002 (8.4j)', NULL, 1329, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(790, 67, '_CN-02002 - Analyse (3.36j)', NULL, 1330, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(791, 67, '_CN-02002 - Dev (3.36j)', NULL, 1331, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(792, 67, '_CN-02002 - Test (1.68j)', NULL, 1332, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(793, 67, 'CN-01998 (4.8j)', NULL, 1374, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(794, 67, '_CN-01998 - Analyse (1.92j)', NULL, 1375, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(795, 67, '_CN-01998 - Dev (1.92j)', NULL, 1376, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(796, 67, '_CN-01998 - Test (0.96j)', NULL, 1377, '2015-03-02', NULL, '2015-05-29', NULL, NULL, NULL, NULL, 0),
(797, 62, 'CN-01986 (0j)', NULL, 1135, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(798, 62, '_CN-01986 - Analyse (0j)', NULL, 1136, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(799, 62, '_CN-01986 - Dev (0j)', NULL, 1137, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(800, 62, '_CN-01986 - Test (0j)', NULL, 1138, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(801, 62, '_CN-01986 - ARA (0j)', NULL, 1139, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(802, 62, 'CN-01984 (0j)', NULL, 1141, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(803, 62, '_CN-01984 - Analyse (0j)', NULL, 1142, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(804, 62, '_CN-01984 - Dev (0j)', NULL, 1143, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(805, 62, '_CN-01984 - Test (0j)', NULL, 1144, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(806, 62, '_CN-01984 - ARA (0j)', NULL, 1145, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(807, 62, 'CN-01983 (0j)', NULL, 1211, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(808, 62, '_CN-01983 - Analyse (0j)', NULL, 1212, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(809, 62, '_CN-01983 - Dev (0j)', NULL, 1213, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(810, 62, '_CN-01983 - Test (0j)', NULL, 1214, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(811, 62, '_CN-01983 - ARA (0j)', NULL, 1215, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(812, 62, 'CN-01982 (0j)', NULL, 1146, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(813, 62, '_CN-01982 - Analyse (0j)', NULL, 1147, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(814, 62, '_CN-01982 - Dev (0j)', NULL, 1148, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(815, 62, '_CN-01982 - Test (0j)', NULL, 1149, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(816, 62, '_CN-01982 - ARA (0j)', NULL, 1150, '2015-02-16', NULL, '2015-04-30', NULL, NULL, NULL, NULL, 0),
(817, 63, 'CN-01993 (1.5j)', NULL, 1394, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(818, 63, '_CN-01993 - Analyse (0.6j)', NULL, 1395, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(819, 63, '_CN-01993 - Dev (0.6j)', NULL, 1396, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(820, 63, '_CN-01993 - Test (0.3j)', NULL, 1397, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(821, 63, '_CN-01993 - ARA (0.28125j)', NULL, 1398, '2015-03-02', NULL, '2015-07-15', NULL, NULL, NULL, NULL, 0),
(822, 89, 'Spécification(s)-Atelier(s)', '', 1452, '2015-04-20', NULL, '2015-07-31', NULL, NULL, 0, NULL, NULL),
(823, 90, 'PWINIT 3.7', NULL, 1502, '2015-04-13', '2015-04-13', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(824, 81, 'CN-01825 (14j)', NULL, 889, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(825, 81, '_CN-01825 - Analyse (5.6j)', NULL, 890, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(826, 81, '_CN-01825 - Dev (5.6j)', NULL, 891, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(827, 81, '_CN-01825 - Test (2.8j)', NULL, 892, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(828, 81, 'CN-01825 (13.6j)', NULL, 916, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(829, 81, '_CN-01825 - Analyse (5.44j)', NULL, 917, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(830, 81, '_CN-01825 - Dev (5.44j)', NULL, 918, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(831, 81, '_CN-01825 - Test (2.72j)', NULL, 919, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(832, 37, 'CN-02014 (1.6j)', NULL, 1230, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(833, 37, '_CN-02014 - Analyse (0.64j)', NULL, 1231, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(834, 37, '_CN-02014 - Dev (0.8j)', NULL, 1232, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(835, 37, '_CN-02014 - Test (0.16j)', NULL, 1233, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(836, 37, '_CN-02014 - ARA (0.3j)', NULL, 1234, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(837, 37, 'CN-01809 (21j)', NULL, 700, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(838, 37, '_CN-01809 - Analyse (8.4j)', NULL, 701, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(839, 37, '_CN-01809 - Dev (8.4j)', NULL, 702, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(840, 37, '_CN-01809 - Test (4.2j)', NULL, 703, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(841, 37, '_CN-01809 - ARA (3.9375j)', NULL, 704, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(842, 37, 'CN-01618 (87j)', NULL, 762, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(843, 37, '_CN-01618 - Analyse (34.8j)', NULL, 763, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(844, 37, '_CN-01618 - Dev (34.8j)', NULL, 764, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(845, 37, '_CN-01618 - Test (17.4j)', NULL, 765, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(846, 37, '_CN-01618 - ARA (16.3125j)', NULL, 766, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(847, 37, 'CN-02038 (5j)', NULL, 1503, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(848, 37, 'CN-01985 (6j)', NULL, 1140, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(849, 91, 'AML V2.4.9.1', NULL, 1504, '2015-04-01', '2015-04-01', '2015-06-30', '2015-06-30', NULL, NULL, NULL, NULL),
(850, 92, 'Eticket V3.1', NULL, 1505, '2015-04-01', '2015-04-01', '2015-07-31', '2015-07-31', NULL, NULL, NULL, NULL),
(851, 87, 'CN-01965 (29.6j)', NULL, 1164, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(852, 87, '_CN-01965 - Analyse (11.84j)', NULL, 1165, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(853, 87, '_CN-01965 - Dev (11.84j)', NULL, 1166, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(854, 87, '_CN-01965 - Test (5.92j)', NULL, 1167, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(855, 91, 'CN-02007 (11.2j)', NULL, 1370, '2015-04-01', NULL, '2015-06-30', NULL, NULL, NULL, NULL, 0),
(856, 91, '_CN-02007 - Analyse (4.48j)', NULL, 1371, '2015-04-01', NULL, '2015-06-30', NULL, NULL, NULL, NULL, 0),
(857, 91, '_CN-02007 - Dev (4.48j)', NULL, 1372, '2015-04-01', NULL, '2015-06-30', NULL, NULL, NULL, NULL, 0),
(858, 91, '_CN-02007 - Test (2.24j)', NULL, 1373, '2015-04-01', NULL, '2015-06-30', NULL, NULL, NULL, NULL, 0),
(859, 34, 'AVV. Airbus - Bundle Tools - STADS - round 1', '', 1524, '2015-04-23', NULL, '2015-05-27', NULL, NULL, 0, NULL, NULL),
(860, 24, 'CN-005_Enable Audit Asset_EMA(1.2j)', 'Analyse + Other EMA', 1525, '2015-04-24', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(861, 37, 'CN-02040 (1.6j)', NULL, 1538, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(862, 37, '_CN-02040 - Analyse (0.64j)', NULL, 1539, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(863, 37, '_CN-02040 - Dev (0.8j)', NULL, 1540, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(864, 37, '_CN-02040 - Test (0.16j)', NULL, 1541, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(865, 37, '_CN-02040 - ARA (0.3j)', NULL, 1542, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(866, 88, 'CN-01568 (5j)', NULL, 1088, '2015-01-01', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(867, 73, 'CN-01943 (2j)', NULL, 989, '2015-03-01', NULL, '2015-04-15', NULL, NULL, NULL, NULL, 0),
(868, 73, '_CN-01943 - Analyse (0.8j)', NULL, 990, '2015-03-01', NULL, '2015-04-15', NULL, NULL, NULL, NULL, 0),
(869, 73, '_CN-01943 - Dev (0.8j)', NULL, 991, '2015-03-01', NULL, '2015-04-15', NULL, NULL, NULL, NULL, 0),
(870, 73, '_CN-01943 - Test (0.4j)', NULL, 992, '2015-03-01', NULL, '2015-04-15', NULL, NULL, NULL, NULL, 0),
(871, 92, 'CN-01997 (4.8j)', NULL, 1433, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(872, 92, '_CN-01997 - Analyse (1.92j)', NULL, 1434, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(873, 92, '_CN-01997 - Dev (1.92j)', NULL, 1435, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(874, 92, '_CN-01997 - Test (0.96j)', NULL, 1436, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(875, 92, 'CN-02025 (5.6j)', NULL, 1518, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(876, 92, '_CN-02025 - Analyse (2.24j)', NULL, 1519, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(877, 92, '_CN-02025 - Dev (2.24j)', NULL, 1520, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(878, 92, '_CN-02025 - Test (1.12j)', NULL, 1521, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(879, 92, 'CN-02000 (4.8j)', NULL, 1390, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(880, 92, '_CN-02000 - Analyse (1.92j)', NULL, 1391, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(881, 92, '_CN-02000 - Dev (1.92j)', NULL, 1392, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(882, 92, '_CN-02000 - Test (0.96j)', NULL, 1393, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(883, 92, 'CN-01999 (1.41j)', NULL, 1457, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(884, 92, '_CN-01999 - Analyse (0.56j)', NULL, 1458, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(885, 92, '_CN-01999 - Dev (0.56j)', NULL, 1459, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(886, 92, '_CN-01999 - Test (0.28j)', NULL, 1460, '2015-04-01', NULL, '2015-07-31', NULL, NULL, NULL, NULL, 0),
(887, 61, 'CN-01802 (35j)', NULL, 1099, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(888, 61, 'CN-01881 (11j)', NULL, 618, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(889, 61, 'CN-01659 (50.9j)', NULL, 756, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(890, 61, '_CN-01659 - Analyse (20.36j)', NULL, 757, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(891, 61, '_CN-01659 - Dev (20.36j)', NULL, 758, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(892, 61, '_CN-01659 - Test (10.18j)', NULL, 759, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(893, 61, 'CN-01812 (22.4j)', NULL, 695, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(894, 61, '_CN-01812 - Analyse (8.96j)', NULL, 696, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(895, 61, '_CN-01812 - Dev (8.96j)', NULL, 697, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(896, 61, '_CN-01812 - Test (4.48j)', NULL, 698, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(897, 61, 'CN-01813 (2j)', NULL, 1103, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(898, 61, '_CN-01813 - Analyse (0.8j)', NULL, 1104, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(899, 61, '_CN-01813 - Dev (0.8j)', NULL, 1105, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(900, 61, '_CN-01813 - Test (0.4j)', NULL, 1106, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(901, 61, 'CN-01893 (3j)', NULL, 1543, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(902, 61, '_CN-01893 - Analyse (1.2j)', NULL, 1544, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(903, 61, '_CN-01893 - Dev (1.2j)', NULL, 1545, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(904, 61, '_CN-01893 - Test (0.6j)', NULL, 1546, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(905, 61, 'CN-01972 (1.2j)', NULL, 1245, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(906, 61, '_CN-01972 - Analyse (0.48j)', NULL, 1246, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(907, 61, '_CN-01972 - Dev (0.48j)', NULL, 1247, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(908, 61, '_CN-01972 - Test (0.24j)', NULL, 1248, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(909, 93, 'Intermission', NULL, 1547, '2015-04-01', '2015-04-01', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(910, 93, 'BU. Intégration', '', 1548, '2015-04-01', NULL, '2015-12-31', NULL, NULL, 0, NULL, NULL),
(911, 10, 'FR15. Formation reçue - HP SM9 pour EDF TMO²', '', 1549, '2015-04-28', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(912, 10, 'FD15. Formation donnée - HP SM9 pour EDF TMO²', '', 1550, '2015-04-28', NULL, '2015-04-30', NULL, NULL, 0, NULL, NULL),
(913, 94, 'EDF TMO²', NULL, 1551, '2015-04-28', '2015-04-28', '2015-12-31', '2015-12-31', NULL, NULL, NULL, NULL),
(914, 49, 'Total - TMA ITSM - Gouvernance - 05/2015', '', 1552, '2015-05-04', NULL, '2015-05-29', NULL, NULL, 0, NULL, NULL),
(915, 49, 'Total - TMA ITSM - Gouvernance - 06/2015', '', 1553, '2015-06-01', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(916, 24, 'CN-002_EvolutionInterfaceAssetPC_EMA_(9j)', 'Analyse + other EMA', 1559, '2015-04-22', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(917, 9, 'FR15. Risques Psycho Sociaux', '', 1560, '2015-04-28', NULL, '2015-04-28', NULL, NULL, 0, NULL, NULL),
(922, 24, 'CN-002_EvolutionInterfaceAssetPC_EvoImple', '', 1578, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(923, 24, 'CN-005_Enable Audit Asset_EvolImple(2j)', '', 1579, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(924, 81, 'CN-01876 (4.4j)', NULL, 1029, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(925, 81, '_CN-01876 - Analyse (1.76j)', NULL, 1030, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(926, 81, '_CN-01876 - Dev (1.76j)', NULL, 1031, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(927, 81, '_CN-01876 - Test (0.88j)', NULL, 1032, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(928, 81, 'CN-01992 (0j)', NULL, 1399, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(929, 81, '_CN-01992 - Analyse (0j)', NULL, 1400, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(930, 81, '_CN-01992 - Dev (0j)', NULL, 1401, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(931, 81, '_CN-01992 - Test (0j)', NULL, 1402, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(932, 81, 'CN-01903 (0j)', NULL, 1534, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(933, 81, '_CN-01903 - Analyse (0j)', NULL, 1535, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(934, 81, '_CN-01903 - Dev (0j)', NULL, 1536, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(935, 81, '_CN-01903 - Test (0j)', NULL, 1537, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(936, 81, 'CN-01878 (7.2j)', NULL, 1257, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(937, 81, '_CN-01878 - Analyse (2.88j)', NULL, 1258, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(938, 81, '_CN-01878 - Dev (2.88j)', NULL, 1259, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(939, 81, '_CN-01878 - Test (1.44j)', NULL, 1260, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(940, 81, 'CN-01876 (5.2j)', NULL, 1412, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(941, 81, '_CN-01876 - Analyse (2.08j)', NULL, 1413, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(942, 81, '_CN-01876 - Dev (2.08j)', NULL, 1414, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(943, 81, '_CN-01876 - Test (1.04j)', NULL, 1415, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(944, 81, 'CN-01992 (0j)', NULL, 1399, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(945, 81, '_CN-01992 - Analyse (0j)', NULL, 1400, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(946, 81, '_CN-01992 - Dev (0j)', NULL, 1401, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(947, 81, '_CN-01992 - Test (0j)', NULL, 1402, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(948, 81, 'CN-01903 (0j)', NULL, 1534, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(949, 81, '_CN-01903 - Analyse (0j)', NULL, 1535, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(950, 81, '_CN-01903 - Dev (0j)', NULL, 1536, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(951, 81, '_CN-01903 - Test (0j)', NULL, 1537, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(952, 81, 'CN-01878 (7.2j)', NULL, 1257, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(953, 81, '_CN-01878 - Analyse (2.88j)', NULL, 1258, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(954, 81, '_CN-01878 - Dev (2.88j)', NULL, 1259, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(955, 81, '_CN-01878 - Test (1.44j)', NULL, 1260, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(956, 81, 'CN-01876 (5.2j)', NULL, 1412, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(957, 81, '_CN-01876 - Analyse (2.08j)', NULL, 1413, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(958, 81, '_CN-01876 - Dev (2.08j)', NULL, 1414, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(959, 81, '_CN-01876 - Test (1.04j)', NULL, 1415, '2015-03-30', NULL, '2015-06-05', NULL, NULL, NULL, NULL, 0),
(960, 36, 'CN-01094 (0.8j)', NULL, 1580, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(961, 36, '_CN-01094 - Analyse (0.32j)', NULL, 1581, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(962, 36, '_CN-01094 - Dev (0.32j)', NULL, 1582, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(963, 36, '_CN-01094 - Test (0.16j)', NULL, 1583, '2015-02-02', NULL, '2015-12-31', NULL, NULL, NULL, NULL, 0),
(964, 24, 'CN-003_AutomaticClosurePendingGroups_EMA', '', 1584, '2015-04-28', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL),
(965, 24, 'CN-003_AutomaticClosurePendingGroups_EvoImple', '', 1585, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(966, 24, 'CN-004_ProtectionDuplicatePCname_EMA', '', 1586, '2015-04-29', NULL, '2015-06-30', NULL, NULL, 0, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `projectassociation`
--

DROP TABLE IF EXISTS `projectassociation`;
CREATE TABLE IF NOT EXISTS `projectassociation` (
`idProjectAssociation` int(10) unsigned NOT NULL,
  `lead` int(11) NOT NULL,
  `dependent` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `projectcalendar`
--

DROP TABLE IF EXISTS `projectcalendar`;
CREATE TABLE IF NOT EXISTS `projectcalendar` (
`IdProjectCalendar` int(11) NOT NULL,
  `idCalendarBase` int(11) DEFAULT NULL,
  `weekStart` int(11) DEFAULT NULL,
  `fiscalYearStart` int(11) DEFAULT NULL,
  `startTime1` double DEFAULT NULL,
  `startTime2` double DEFAULT NULL,
  `endTime1` double DEFAULT NULL,
  `endTime2` double DEFAULT NULL,
  `hoursDay` double DEFAULT NULL,
  `hoursWeek` double DEFAULT NULL,
  `daysMonth` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectcalendar`
--

INSERT INTO `projectcalendar` (`IdProjectCalendar`, `idCalendarBase`, `weekStart`, `fiscalYearStart`, `startTime1`, `startTime2`, `endTime1`, `endTime2`, `hoursDay`, `hoursWeek`, `daysMonth`) VALUES
(1, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(2, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(3, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(4, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(5, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(6, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(7, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(8, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(9, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(10, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(11, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(12, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(13, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(14, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(15, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(16, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(17, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(18, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(19, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(20, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(21, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(22, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(23, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(24, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(25, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(26, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(27, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(28, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(29, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(30, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(31, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(32, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(33, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(34, NULL, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(35, 1, 1, 1, 9, NULL, 18, NULL, 8, 36.5, 18),
(36, 1, 1, 1, 9, NULL, 18, NULL, 8, 36.5, 18),
(37, 1, 1, 1, 9, NULL, 18, NULL, 8, 36.5, 18),
(38, 1, 1, 1, 9, NULL, 18, NULL, 8, 36.5, 18),
(39, 1, 1, 1, 9, NULL, 18, NULL, 8, 36.5, 18),
(40, 1, 1, 1, 9, NULL, 18, NULL, 8, 36.5, 18),
(41, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(42, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(43, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(44, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(45, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(46, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(47, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(48, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(50, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18),
(51, 1, 1, 1, 9.5, NULL, 18, NULL, 8, 36.5, 18);

-- --------------------------------------------------------

--
-- Structure de la table `projectcalendarexceptions`
--

DROP TABLE IF EXISTS `projectcalendarexceptions`;
CREATE TABLE IF NOT EXISTS `projectcalendarexceptions` (
`IdProjectCalendarException` int(11) NOT NULL,
  `IdProjectCalendar` int(11) DEFAULT NULL,
  `StartDate` date DEFAULT NULL,
  `FinishDate` date DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `projectcharter`
--

DROP TABLE IF EXISTS `projectcharter`;
CREATE TABLE IF NOT EXISTS `projectcharter` (
`IdProjectCharter` int(11) NOT NULL,
  `IdProject` int(11) NOT NULL,
  `BusinessNeed` varchar(1500) DEFAULT NULL,
  `ProjectObjectives` varchar(1500) DEFAULT NULL,
  `SucessCriteria` varchar(1500) DEFAULT NULL,
  `MainConstraints` varchar(1500) DEFAULT NULL,
  `Milestones` varchar(200) DEFAULT NULL,
  `MainAssumptions` varchar(1500) DEFAULT NULL,
  `MainRisks` varchar(1500) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectcharter`
--

INSERT INTO `projectcharter` (`IdProjectCharter`, `IdProject`, `BusinessNeed`, `ProjectObjectives`, `SucessCriteria`, `MainConstraints`, `Milestones`, `MainAssumptions`, `MainRisks`) VALUES
(7, 7, '', '', '', '', NULL, '', ''),
(8, 8, '', '', '', '', NULL, '', ''),
(9, 9, '', '', '', '', NULL, '', ''),
(10, 10, '', '', '', '', NULL, '', ''),
(13, 13, '', 'Diminuer les actes administratifs associés à la génération des activités d''un projet', 'Interfacer SmatPlan et OpenPPM pour créer à partir du workflow associé à chaque demande du catalogue de service de SmatPlan l''ensemble des activités d''un projet dans OpenPPM', '', NULL, '', ''),
(14, 14, '', 'Automatiser l''intégration d''une demande de congés par un Team Member directement dans l''activité concernée en preassigned sans avoir à le faire faire par le project manager du projet des absences 2014\n\nFaire un premier pilote montrant la facilité d''étendre OpenPPM', 'Création d''un formulaire de demande de congés pour s''intégrer avec OpenPPM', 'Faire au plus simple avec processus papier à côté si cela complexifie trop le travail', NULL, '', 'Aucun'),
(16, 16, '', 'Supporter les produits internes utilisés sur le centre de service : gestion documentaire, iTop (?), OpenPPM (?)', 'Achat et installation de deux serveurs avec sauvegardes et secours courant', 'Conformité à la stratégie du groupe', NULL, '', ''),
(18, 18, '', '', 'Faire évoluer OpenPPM pour qu''il s''intègre au mieux dans nos outils (type export de données pour remplir le CRA dans Aramis, voire lien direct avec Aramis), pour corriger certains écarts existants ou ajouter des fonctionnalités non couvertes comme du reporting avec de la BI.', '', NULL, '', ''),
(19, 19, '', '', '', '', NULL, '', ''),
(20, 20, '', '', 'WP1 – Incidents & Problems management\nFrom L1.5 to L3/L4\nOLA on responsiveness, solving efficiency and reopening rate', '', NULL, '', ''),
(21, 21, '', '', 'WP3 – Requests management\nOne shot processed operations\nNo contractual OLA (delivery date based on common agreement)\nStrong commitment in delivery schedule respect and automation task', '', NULL, '', ''),
(22, 22, '', '', '', '', NULL, '', ''),
(23, 23, '', '', '', '', NULL, '', ''),
(24, 24, '', '', 'Budget de 100 jours optionnels', '', NULL, '4114 € à reporter depuis la partie récurrente passée de 14 à 13 mois', ''),
(25, 25, '', '', '', '', NULL, '', ''),
(26, 26, '', '', '', '', NULL, '', ''),
(27, 27, '', '', '', '', NULL, '', ''),
(28, 28, '', '', '', '', NULL, '', ''),
(29, 29, '', '', '', '', NULL, '', ''),
(30, 30, '', '', '', '', NULL, '', ''),
(31, 31, '', '', '', '', NULL, '', ''),
(32, 32, '', '', '', '', NULL, '', ''),
(33, 33, '', '', '', '', NULL, '', ''),
(34, 34, '', '', '', '', NULL, '', ''),
(35, 35, '', '', '', '', NULL, '', ''),
(36, 36, '', '', '', '', NULL, '', ''),
(37, 37, '', '', '', '', NULL, '', ''),
(38, 38, '', '', '', '', NULL, '', ''),
(39, 39, '', '', '', '', NULL, '', ''),
(40, 40, '', '', '', '', NULL, '', ''),
(41, 41, '', '', '', '', NULL, '', ''),
(43, 43, '', '', '', '', NULL, '', ''),
(44, 44, '', '', '11 mois de MCO N1/N2/N3 sur ITSM avec 504 jours sur une année pleine soit 462 jours pour 11 mois avec budget mensuel de 30921 €', '', NULL, '', ''),
(45, 45, '', '', '5 mois de MCO BO avec 87 jours année pleine soit 36 jours sur 5 mois pour un budget mensuel de 3758 €', '', NULL, '', ''),
(46, 46, '', '', '5 mois de gestion des problèmes avec 87 jours année pleine soit 36 jours sur 5 mois pour un budget mensuel de 4800 €', '', NULL, '', ''),
(47, 47, '', '', '20% de 218 jours année pleine soit 40 jours sur 11 mois pour un budget mensuel de 2592 €', '', NULL, '', ''),
(48, 48, '', '', '', '', NULL, '', ''),
(49, 49, '', '', '11 mois avec Cédric Charpier (8j), Patrice Prouzat (11j), Steve Marques (119j)', '', NULL, '', ''),
(50, 50, '', '', '', '', NULL, '', ''),
(51, 51, '', '', '', '', NULL, '', ''),
(52, 52, '', '', '', '', NULL, '', ''),
(53, 53, '', '', '', '', NULL, '', ''),
(54, 54, '', '', '', '', NULL, '', ''),
(55, 55, '', '', '', '', NULL, '', ''),
(56, 56, '', '', '', '', NULL, '', ''),
(57, 57, '', '', '', '', NULL, '', 'en attente de la confirmation des achats, prévue vers le 23 février'),
(58, 58, '', '', '', '', NULL, '', ''),
(59, 59, '', '', '', '', NULL, '', ''),
(60, 60, '', '', '', '', NULL, '', ''),
(61, 61, '', '', '', '', NULL, '', ''),
(62, 62, '', '', '', '', NULL, '', ''),
(63, 63, '', '', '', '', NULL, '', ''),
(64, 64, '', '', '', '', NULL, '', ''),
(65, 65, '', '', '', '', NULL, '', ''),
(66, 66, '', '', '', '', NULL, '', ''),
(67, 67, '', '', '', '', NULL, '', ''),
(68, 68, '', '', '', '', NULL, '', ''),
(69, 69, '', '', '', '', NULL, 'Les frais ne font pas partie des coûts associés\nLe pricing tool a été fait sans les 3% du CdS Toulouse.', '5% provisionnés sur la phase d''Init RUN\n10% sur le RUN pour les 3 années'),
(70, 70, 'En cours de définition au travers des interviews', 'Definir des users stories par ordre de priorité afin de les implémenter dans la version V1.0 d''OpenPPM\nPrioriser les users stories pour la version 1.0 en tenant aussi compte de la complexité de développement\nDévelopper les users stories en methodologie agile (sprint de 15 jours)', 'Definir et implementer un outil de gestion des activites commun à toutes les entites du delivery Devoteam: centres de services, Infogérance, DRI, projets', 'Ne pas impacter la structure de données dans l''outil OpenPPM', NULL, 'Product Owner doit consacré 25% de son activité sur le projet', 'Les personnes interviewés n''ont pas de besoin simples et clairs sur le futur outil de gestion des activités'),
(71, 71, '', '', '', '', NULL, '', ''),
(72, 72, '', '', '', '', NULL, '', ''),
(73, 73, '', '', '', '', NULL, '', ''),
(74, 74, '', '', 'Il faut considérer 11 000 € pour la transition en elle-même et 2 000 € pour la plate-forme. En deux éléments de facturation.', '', NULL, '', ''),
(75, 75, '', '', '', '', NULL, '', ''),
(76, 76, '', '', 'Base 20 jours de prestation', '', NULL, '', ''),
(77, 77, '', '', 'Intervention sur site de Benoit Ischia de Lyon', '', NULL, '', ''),
(78, 78, '', '', '', '', NULL, '', ''),
(79, 79, '', '', '', '', NULL, '', ''),
(80, 80, '', '', '', '', NULL, '', ''),
(81, 81, '', '', '', '', NULL, '', ''),
(82, 82, '', '', '', '', NULL, '', ''),
(83, 83, '', '', '', '', NULL, '', ''),
(84, 84, '', '', '', '', NULL, '', ''),
(85, 85, '', '', '', '', NULL, '', ''),
(86, 86, '', '', '', '', NULL, '', ''),
(87, 87, '', '', '', '', NULL, '', ''),
(88, 88, '', '', '', '', NULL, '', ''),
(89, 89, '', '', '', '', NULL, '', ''),
(90, 90, '', '', '', '', NULL, '', ''),
(91, 91, '', '', '', '', NULL, '', ''),
(92, 92, '', '', '', '', NULL, '', ''),
(93, 93, '', '', '', '', NULL, '', ''),
(94, 94, '', '', '', '', NULL, '', '');

-- --------------------------------------------------------

--
-- Structure de la table `projectclosure`
--

DROP TABLE IF EXISTS `projectclosure`;
CREATE TABLE IF NOT EXISTS `projectclosure` (
`idProjectClouse` int(10) unsigned NOT NULL,
  `idProject` int(11) NOT NULL,
  `projectResults` varchar(500) DEFAULT NULL,
  `goalAchievement` varchar(500) DEFAULT NULL,
  `lessonsLearned` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectclosure`
--

INSERT INTO `projectclosure` (`idProjectClouse`, `idProject`, `projectResults`, `goalAchievement`, `lessonsLearned`) VALUES
(1, 28, 'L''ensemble des formations a été réalisé.\nLe suivi a été fait hors openppm.', 'OK', ''),
(2, 25, 'TM terminé et suivi hors OpenPPM.', '', '');

-- --------------------------------------------------------

--
-- Structure de la table `projectcosts`
--

DROP TABLE IF EXISTS `projectcosts`;
CREATE TABLE IF NOT EXISTS `projectcosts` (
`IdProjectCosts` int(11) NOT NULL,
  `IdProject` int(11) DEFAULT NULL,
  `CostDate` date DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectcosts`
--

INSERT INTO `projectcosts` (`IdProjectCosts`, `IdProject`, `CostDate`) VALUES
(7, 7, '2014-11-21'),
(8, 8, '2014-11-21'),
(9, 9, '2014-11-21'),
(10, 10, '2014-11-21'),
(13, 13, '2014-12-01'),
(14, 14, '2014-12-01'),
(16, 16, '2015-01-05'),
(18, 18, '2014-12-23'),
(19, 19, '2014-12-01'),
(20, 20, '2014-11-03'),
(21, 21, '2014-12-01'),
(22, 22, '2014-12-01'),
(23, 23, '2014-12-01'),
(24, 24, '2014-12-01'),
(25, 25, '2014-12-08'),
(26, 26, '2014-12-08'),
(27, 27, '2015-01-01'),
(28, 28, '2015-01-05'),
(29, 29, '2015-01-05'),
(30, 30, '2015-01-01'),
(31, 31, '2015-01-01'),
(32, 32, '2015-01-01'),
(33, 33, '2015-01-01'),
(34, 34, '2014-12-22'),
(35, 35, '2015-01-01'),
(36, 36, '2015-02-02'),
(37, 37, '2015-02-02'),
(38, 38, '2015-02-02'),
(39, 39, '2015-02-02'),
(40, 40, '2015-02-02'),
(41, 41, '2015-02-02'),
(43, 43, '2015-02-11'),
(44, 44, '2015-02-01'),
(45, 45, '2015-02-01'),
(46, 46, '2015-02-01'),
(47, 47, '2015-02-01'),
(48, 48, '2015-01-01'),
(49, 49, '2015-02-01'),
(50, 50, '2015-02-01'),
(51, 51, '2015-02-01'),
(52, 52, '2015-02-01'),
(53, 53, '2015-02-01'),
(54, 54, '2015-02-01'),
(55, 55, '2015-02-01'),
(56, 56, '2015-02-16'),
(57, 57, '2015-02-23'),
(58, 58, '2015-02-02'),
(59, 59, '2015-02-02'),
(60, 60, '2015-02-02'),
(61, 61, '2015-02-02'),
(62, 62, '2015-02-16'),
(63, 63, '2015-03-02'),
(64, 64, '2015-02-01'),
(65, 65, '2015-02-01'),
(66, 66, '2015-03-02'),
(67, 67, '2015-03-02'),
(68, 68, '2015-02-02'),
(69, 69, '2015-04-01'),
(70, 70, '2015-03-18'),
(71, 71, '2015-03-18'),
(72, 72, '2015-03-09'),
(73, 73, '2015-03-01'),
(74, 74, '2015-04-01'),
(75, 75, '2015-04-01'),
(76, 76, '2015-05-01'),
(77, 77, '2015-05-01'),
(78, 78, '2015-04-01'),
(79, 79, '2015-04-01'),
(80, 80, '2015-03-30'),
(81, 81, '2015-03-30'),
(82, 82, '2015-01-01'),
(83, 83, '2015-04-01'),
(84, 84, '2015-01-01'),
(85, 85, '2015-04-01'),
(86, 86, '2015-04-01'),
(87, 87, '2015-04-01'),
(88, 88, '2015-01-01'),
(89, 89, '2015-04-01'),
(90, 90, '2015-04-13'),
(91, 91, '2015-04-01'),
(92, 92, '2015-04-01'),
(93, 93, '2015-04-01'),
(94, 94, '2015-04-28');

-- --------------------------------------------------------

--
-- Structure de la table `projectfollowup`
--

DROP TABLE IF EXISTS `projectfollowup`;
CREATE TABLE IF NOT EXISTS `projectfollowup` (
`IdProjectFollowup` int(11) NOT NULL,
  `IdProject` int(11) DEFAULT NULL,
  `FollowupDate` date DEFAULT NULL,
  `EV` double DEFAULT NULL,
  `PV` double DEFAULT NULL,
  `AC` double DEFAULT NULL,
  `GeneralComments` varchar(300) DEFAULT NULL,
  `RisksComments` varchar(300) DEFAULT NULL,
  `CostComments` varchar(300) DEFAULT NULL,
  `ScheduleComments` varchar(300) DEFAULT NULL,
  `GeneralFlag` char(1) DEFAULT NULL,
  `RiskFlag` char(1) DEFAULT NULL,
  `CostFlag` char(1) DEFAULT NULL,
  `ScheduleFlag` char(1) DEFAULT NULL,
  `PerformanceDoc` varchar(50) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=234 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectfollowup`
--

INSERT INTO `projectfollowup` (`IdProjectFollowup`, `IdProject`, `FollowupDate`, `EV`, `PV`, `AC`, `GeneralComments`, `RisksComments`, `CostComments`, `ScheduleComments`, `GeneralFlag`, `RiskFlag`, `CostFlag`, `ScheduleFlag`, `PerformanceDoc`) VALUES
(13, 7, '2014-11-21', 0, 0, 0, 'RAS', 'Avant-vente à maîtriser', 'Sous contrôle', 'RAS', 'N', 'M', 'N', 'N', NULL),
(14, 7, '2014-12-31', NULL, NULL, NULL, 'RAS', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(15, 8, '2014-11-21', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(16, 8, '2014-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(17, 9, '2014-11-21', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(18, 9, '2014-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(19, 10, '2014-11-21', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(20, 10, '2014-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(25, 13, '2015-01-05', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(26, 13, '2015-02-04', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(32, 14, '2014-12-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(33, 14, '2014-12-12', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(36, 16, '2015-01-05', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(37, 16, '2015-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(40, 18, '2014-12-01', NULL, 0, NULL, 'RAS', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(41, 18, '2015-06-30', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(42, 19, '2014-12-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(43, 19, '2014-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(44, 20, '2014-12-01', NULL, 0, NULL, 'Tout est sous contrôle', 'RAS', 'RAS', 'RAS car récurent', 'N', 'N', 'N', 'L', NULL),
(45, 20, '2015-01-28', NULL, NULL, NULL, 'Tout est sous contrôle', 'RAS', 'Plus de jours que prévus', 'RAS car récurrent', 'N', 'N', 'M', 'L', NULL),
(46, 21, '2014-12-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(47, 21, '2014-12-31', NULL, NULL, NULL, 'Pas d''activité', '', '', '', 'L', NULL, NULL, NULL, NULL),
(48, 22, '2014-12-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(49, 22, '2015-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(50, 23, '2014-12-01', NULL, 0, NULL, 'Tout est sous contrôle', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(51, 23, '2014-12-31', NULL, NULL, NULL, 'Tout est sous contrôle', 'Aucun risque identifié', 'Nominal', 'Nominal', 'N', 'N', 'N', 'N', NULL),
(52, 24, '2014-12-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(53, 24, '2014-12-31', NULL, NULL, NULL, 'Pas d''activité', '', '', '', 'L', NULL, NULL, NULL, NULL),
(54, 25, '2014-12-08', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(55, 25, '2015-01-16', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(56, 26, '2014-12-08', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(57, 26, '2015-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(58, 27, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(59, 27, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(60, 28, '2015-01-05', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(61, 28, '2015-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(62, 29, '2015-01-05', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(63, 29, '2015-04-10', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(64, 30, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(65, 30, '2015-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(66, 31, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(67, 31, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(68, 32, '2015-01-01', NULL, 0, NULL, 'RAS', 'Attention au niveau d''avant-vente attendue au niveau du CdS', 'Constant', 'Tout est sous contrôle', 'N', 'M', 'N', 'N', NULL),
(69, 32, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(70, 33, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(71, 33, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(72, 34, '2014-12-22', NULL, 0, NULL, 'Beaucoup d''avant-ventes en cours permettant d''envisager de la croissance', 'Attention au niveau d''avant-vente attendue au niveau du CdS', 'Idem', 'Voir statut du risque', 'N', 'M', 'M', 'M', NULL),
(73, 34, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(74, 18, '2014-12-23', 0, 0, 4000, 'Le pilote n''a pas encore réellement démarré', 'Difficulté à lancer au retour des congés', 'Nuit et week-end permet de baisser les coûts réels et l''impact', 'Avancement au delà de ce que l''on pouvait attendre', 'M', 'M', 'N', 'N', NULL),
(75, 18, '2015-01-09', NULL, 0, NULL, 'Objectif au 1er février OK', 'Acceptation et changement', 'RAS', 'RAS', 'N', 'M', 'N', 'N', NULL),
(76, 22, '2014-12-31', NULL, NULL, NULL, 'Tout est sous contrôle', 'Aucun risque identifié', 'Nominal', 'Nominal', 'N', 'N', 'N', 'N', NULL),
(77, 20, '2014-12-31', NULL, NULL, NULL, 'Tout est sous contrôle', 'Aucun risque identifié', 'Moins de jours que prévus', 'RAS car récurrent', 'N', 'N', 'N', 'L', NULL),
(78, 30, '2015-01-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(79, 35, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(80, 35, '2015-02-28', NULL, NULL, NULL, 'RAS, tout est sous contrôle pour la suite', 'RAS', 'Conforme aux attentes', 'Dans les temps', 'N', 'N', 'N', 'N', NULL),
(81, 35, '2015-01-19', NULL, NULL, NULL, 'Tout est sous contrôle, reste le dernier MDB', 'Aucun sur bilan financier, élevé sur transfert', 'RAS', 'Voir Risk', 'N', 'M', 'N', 'M', NULL),
(82, 36, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(83, 36, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(84, 37, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(85, 37, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(86, 38, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(87, 38, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(88, 39, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(89, 39, '2015-03-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(90, 40, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(91, 40, '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(92, 41, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(93, 41, '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(96, 32, '2015-01-30', NULL, NULL, NULL, 'Globalement sous contrôle mais combinaison AVV, démarrage CdS + activité normale difficile', 'Charge importante', 'Conforme aux attentes voire un peu en dessous', 'RAS', 'M', 'M', 'N', 'N', NULL),
(97, 35, '2015-01-30', NULL, NULL, NULL, 'La situation n''est pas encore totalement clarifiée', 'Personne ne contrôle réellement les engagements côté agence', 'Conforme aux attentes', 'Tout n''est pas encore défini comme le stockage des SFP', 'M', 'M', 'N', 'M', NULL),
(98, 34, '2015-01-30', NULL, NULL, NULL, 'Après un début un peu difficile pour se caler tous sur le bon niveau d''implication, tout est sous contrôle', 'La charge reste malgré tout importante due au fait qu''il y a eu beaucoup d''avant-ventes en //', 'Conforme aux attentes', 'RAS', 'N', 'M', 'N', 'N', NULL),
(99, 43, '2015-02-11', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(100, 43, '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 44, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(102, 44, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(103, 45, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(104, 45, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(105, 46, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(106, 46, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(107, 47, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(108, 47, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(109, 48, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(110, 48, '2015-03-31', NULL, NULL, NULL, 'Les transferts ont été réalisés. Il reste quelques éléments (<1j.)', '', '', '', 'N', 'N', 'N', 'N', NULL),
(111, 49, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(112, 49, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(113, 34, '2015-02-27', NULL, NULL, NULL, 'RAS', 'Le risque n''est pas dans l''avant-vente, mais dans le delivery qui s''en suivra', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(114, 50, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(115, 50, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(116, 51, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(117, 51, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(118, 52, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(119, 52, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(120, 53, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(121, 53, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(122, 54, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(123, 54, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(124, 55, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(125, 55, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(126, 56, '2015-02-16', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(127, 56, '2015-03-27', NULL, NULL, NULL, '', '', '', '', 'N', 'N', 'N', 'N', NULL),
(128, 57, '2015-02-23', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(129, 57, '2015-11-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(130, 58, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(131, 58, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(132, 59, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(133, 59, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(134, 60, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(135, 60, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(136, 61, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(137, 61, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(138, 32, '2015-02-27', NULL, NULL, NULL, 'RAS, pas de difficultés globalement', 'L''avant-vente est maîtrisée en termes de charges, mais la charge globale reste élevée', 'RAS', 'RAS', 'N', 'M', 'N', 'N', NULL),
(139, 22, '2015-02-27', NULL, NULL, NULL, 'Pas pouvoir finir le projet à temps ==> AH n''a pas les infrastructures didiés pour les reporting & les monitorings mise en place par nous (Pas d''environment Reporting; pas de serveur didié pour stoker les monitorings)', 'Les actions côtés Claude avancent très doucement (Espace de partage entre DVT & AH n''est pas encore en place; Relancer plusieurs fois sur des actions liés à la partie Initialisation) De notre côté, la priorités est la partie Run par rapport à la partie Initialisation (On a un seul poste de travail)', '', '', 'M', 'M', 'N', 'M', NULL),
(140, 20, '2015-02-27', NULL, NULL, NULL, 'Sous contrôle', 'RAS', 'Revenu à la normale, même moins de jours que prévus.', 'RAS car récurrent', 'N', 'N', 'N', 'L', NULL),
(141, 44, '2015-02-27', NULL, NULL, NULL, 'RAS', 'Risque sur les ressources (arrêt ADA)', 'RAS', 'Revue pour optimisation du N1 - Mutualisation avec Bundle', 'N', 'M', 'N', 'N', NULL),
(142, 23, '2015-03-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(143, 23, '2015-02-27', NULL, NULL, NULL, 'Sous contrôle mais attention au changement de contacts AH en mars pour la TMA', 'Changement de contacts AH en mars pour la TMA', 'RAS', 'RAS', 'M', 'M', 'N', 'N', NULL),
(144, 45, '2015-02-27', NULL, NULL, NULL, 'RAS', 'Pas de risque identifié', 'RAS', 'Planification en cours d''optimisation', 'N', 'N', 'N', 'N', NULL),
(145, 45, '2015-03-31', NULL, NULL, NULL, 'RAS', 'Le contrat demande des compétences d''Admin BO que l''on ne couvre pas.', 'RAS', 'Suivi du plan de charge pour respecter les charges vendues', 'N', 'M', 'N', 'N', NULL),
(146, 46, '2015-02-27', NULL, NULL, NULL, 'Difficulté à maitriser le périmètre. Travail en cours ...', 'Gestion de l''absence de JPR sur la déclaration et analyse des problèmes', 'Maîtriser les dépassements de charges suite à des erreurs de planification (sur-staffing)', 'Revue de la planification de JPR qui est en surconsommation du Janvier / Février', 'M', 'M', 'M', 'M', NULL),
(147, 47, '2015-02-27', NULL, NULL, NULL, 'RAS - Pas de consommation en Février', 'RAS', 'RAS - Pas de consommation en Février', 'RAS', 'N', 'N', 'N', 'N', NULL),
(148, 62, '2015-02-16', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(149, 62, '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(150, 63, '2015-03-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(151, 63, '2015-07-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(152, 64, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(153, 64, '2015-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(154, 65, '2015-02-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(155, 65, '2015-05-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(156, 66, '2015-03-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(157, 66, '2015-05-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(158, 67, '2015-03-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(159, 67, '2015-05-29', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(160, 68, '2015-02-02', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(161, 68, '2015-04-13', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(162, 69, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(163, 69, '2018-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(164, 70, '2015-03-18', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(165, 70, '2015-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(166, 71, '2015-03-18', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(167, 71, '2015-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(168, 72, '2015-03-09', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(169, 72, '2015-07-01', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(170, 73, '2015-03-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(171, 73, '2015-04-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(172, 70, '2015-03-24', NULL, NULL, NULL, 'Realisation de l''interview de CDS Toulouse 1ère partie. Realisation de l’interview de Nicolas Breart, Olivier Lefauconnier', 'Pas de disponibilité de Sebastien Boessembacher pour interview cette semaine. Olivier L. et Nicolas B. ne connaissent pas la finalité du projet. Langue au niveau de la documentation de l’outil à faire en anglais (besoin Olivier L. et Nicolas B.)', 'NA', 'Interviews Cyril Veillon, Vincent Filloux, Cédric Charpier, Xavier Lagrange, Emmanuel Gerber semaine 13. Deux sessions Interview supplémentaires sont planifiées semaine 13.', 'N', 'N', 'N', 'M', NULL),
(173, 70, '2015-03-24', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(174, 74, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(175, 74, '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(176, 75, '2015-05-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(177, 75, '2016-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(178, 76, '2015-05-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(179, 76, '2016-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(180, 77, '2015-05-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(181, 77, '2016-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(182, 32, '2015-03-31', NULL, NULL, NULL, 'Difficulté à faire redescendre la pression', 'Difficulté à gérer le problème de ressource NTIC et Remdy et faire remonter les prestations', 'RAS', 'RAS', 'M', 'M', 'N', 'N', NULL),
(183, 44, '2015-03-31', NULL, NULL, NULL, 'Cf RISK.', 'Après le départ de JC Pichant risque sur le suivi N2/N3 de la TMA avec des ressources mutualisées.', 'RAS - Réduction des coûts sur le profil N1 - Mutualisation avec autres contrats.', 'RAS - Attention au risques cependant', 'M', 'H', 'N', 'N', NULL),
(184, 70, '2015-04-01', NULL, NULL, NULL, 'Réalisation de toutes les interviews excepté Sebastien et Wilfried non disponible. Consolidation des users stories après brainstorming interne', 'Pas de risque identifié', 'N/A', 'Comité de priorisation prévu le 02 avril: Cedric Charpier, Vincent Filloux, Stephan Peccini, JC Bourion', 'N', 'N', NULL, 'N', NULL),
(185, 78, '2015-04-01', NULL, 0, NULL, '', 'Peu d''UO SM9 commandée => risque de dépassement des charge sur SM9', '', '', 'N', 'M', 'N', 'N', NULL),
(186, 78, '2015-05-15', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(187, 79, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(188, 79, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(189, 49, '2015-03-31', NULL, NULL, NULL, 'RAS', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(190, 46, '2015-03-31', NULL, NULL, NULL, 'Meilleur maitrise du périmètre. Reste quelques points à voir ...', 'Maîtrise des risques grâce au dialogue avec le client.', 'Maitrîse des coûts sur Q1 et Q2. Pas de gain en cible.', 'Reprise en main de la planification sur Q1. Planning Q2 OK !', 'N', 'N', 'N', 'N', NULL),
(191, 47, '2015-03-31', NULL, NULL, NULL, 'RAS', 'RAS', 'RAS - Consommation à 50%', 'RAS', 'N', 'N', 'N', 'N', NULL),
(192, 78, '2015-04-15', NULL, NULL, NULL, 'Partie 1 TME3 livrée', '', '', '', 'N', 'N', 'N', 'N', NULL),
(193, 78, '2015-04-22', NULL, NULL, NULL, 'Partie 2 TME3 livrée', 'Risque retour VABF (Manque de maîtrise sur la recette fonctionnelle)', '', '', 'N', 'M', 'N', 'N', NULL),
(194, 70, '2015-04-07', NULL, NULL, NULL, 'Comité de priorisation 1ère partie réalisée. Affectation des poids aux users stories pour la version 1. Intégration dans l''outil icescrum de tous les éléments du projet. Lancement du sprint 1', 'Pas de risque identifié.', 'N/A', 'Comité de priorisation 2ème partie planifié le 08/04. Réunion quotidienne avec l''équipe de développement dans le cadre du sprint 1.', 'N', 'N', NULL, 'N', NULL),
(195, 80, '2015-03-30', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(196, 80, '2015-06-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(197, 81, '2015-03-30', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(198, 81, '2015-06-05', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(199, 82, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(200, 82, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(201, 83, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(202, 83, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(203, 84, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(204, 84, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(205, 83, '2015-04-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(206, 85, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(207, 85, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(208, 86, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(209, 86, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(210, 87, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(211, 87, '2015-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(212, 70, '2015-04-16', NULL, NULL, NULL, 'Sprint 1 en cours (date de fin: 17/04)', 'Nous devons obtenir une architecture de production pour une MIP planifiée le 04 mai. Une deuxième ressource doit rejoindre le projet pour absorber toute la charge des users stories idenifiées dans la V1', 'Le cout de la nouvelle architecture de production ne doit pas être imputée au budget existant si nous voulons intégrer un nouveau développeur à l''équipe', 'Meeting de validation des priorités programmés le 17/04. Meeting de revue de sprint ainsi que la retrospective du sprint prévue le 07/04', 'N', 'M', 'N', 'N', NULL),
(213, 88, '2015-01-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(214, 88, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(215, 89, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(216, 89, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(217, 89, '2015-04-27', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(218, 90, '2015-04-13', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(219, 90, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(220, 91, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(221, 91, '2015-06-30', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(222, 92, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(223, 92, '2015-07-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(224, 93, '2015-04-01', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(225, 93, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(226, 94, '2015-04-28', NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(227, 94, '2015-12-31', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(228, 44, '2015-04-30', NULL, NULL, NULL, 'Idem mois précédent', 'Idem mois précédent', 'RAS - Maintien de la réduction des coûts sur le N1', 'RAS', 'M', 'H', 'N', 'N', NULL),
(229, 45, '2015-04-30', NULL, NULL, NULL, 'RAS - Départ de CFA remplacée par MZA sur Mai', 'Idem mois précédent', 'RAS', 'RAS', 'N', 'M', 'N', 'N', NULL),
(230, 49, '2015-04-30', NULL, NULL, NULL, 'RAS', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(231, 46, '2015-04-30', NULL, NULL, NULL, 'RAS', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(232, 47, '2015-04-30', NULL, NULL, NULL, 'RAS - Traitement ce mois du PMP Light', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL),
(233, 48, '2015-04-30', NULL, NULL, NULL, 'Pas de charges consommées en Avril', 'RAS', 'RAS', 'RAS', 'N', 'N', 'N', 'N', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `projectkpi`
--

DROP TABLE IF EXISTS `projectkpi`;
CREATE TABLE IF NOT EXISTS `projectkpi` (
`IdProjectKPI` int(11) NOT NULL,
  `IdProject` int(11) NOT NULL,
  `idMetricKpi` int(10) unsigned NOT NULL,
  `UpperThreshold` int(11) DEFAULT NULL,
  `LowerThreshold` int(11) DEFAULT NULL,
  `Weight` int(11) DEFAULT NULL,
  `Value` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `projectkpi`
--

INSERT INTO `projectkpi` (`IdProjectKPI`, `IdProject`, `idMetricKpi`, `UpperThreshold`, `LowerThreshold`, `Weight`, `Value`) VALUES
(3, 25, 1, -2, 1, 50, -2),
(5, 25, 2, 40, 38, 50, 39),
(6, 18, 1, 97, 95, 100, 98);

-- --------------------------------------------------------

--
-- Structure de la table `resourceprofiles`
--

DROP TABLE IF EXISTS `resourceprofiles`;
CREATE TABLE IF NOT EXISTS `resourceprofiles` (
  `IdProfile` int(11) NOT NULL,
  `ProfileName` varchar(50) DEFAULT NULL,
  `Description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `resourceprofiles`
--

INSERT INTO `resourceprofiles` (`IdProfile`, `ProfileName`, `Description`) VALUES
(1, 'Team Member', NULL),
(2, 'Project Manager', NULL),
(3, 'Investment Manager', NULL),
(4, 'Functional Manager', NULL),
(5, 'Program Manager', NULL),
(6, 'Resource Manager', NULL),
(7, 'PMO', NULL),
(8, 'Sponsor', NULL),
(9, 'Porfolio Manager', NULL),
(10, 'Admin', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `riskcategories`
--

DROP TABLE IF EXISTS `riskcategories`;
CREATE TABLE IF NOT EXISTS `riskcategories` (
  `IdRiskCategory` int(11) NOT NULL,
  `Description` varchar(100) DEFAULT NULL,
  `riskType` int(11) NOT NULL,
  `mitigate` bit(1) NOT NULL,
  `accept` bit(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Contenu de la table `riskcategories`
--

INSERT INTO `riskcategories` (`IdRiskCategory`, `Description`, `riskType`, `mitigate`, `accept`) VALUES
(1, 'Accept (contain)', 1, b'0', b'1'),
(2, 'Avoid', 1, b'0', b'0'),
(3, 'Mitigate', 1, b'1', b'1'),
(4, 'Transfer', 1, b'0', b'0'),
(5, 'Accept', 0, b'0', b'0'),
(6, 'Exploit', 0, b'0', b'0'),
(7, 'Enhance', 0, b'0', b'0'),
(8, 'Share', 0, b'0', b'0'),
(9, 'Accept (passive)', 1, b'0', b'1');

-- --------------------------------------------------------

--
-- Structure de la table `riskreassessmentlog`
--

DROP TABLE IF EXISTS `riskreassessmentlog`;
CREATE TABLE IF NOT EXISTS `riskreassessmentlog` (
`IdLog` int(11) NOT NULL,
  `IdRisk` int(11) DEFAULT NULL,
  `RiskDate` date DEFAULT NULL,
  `RiskChange` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `riskregister`
--

DROP TABLE IF EXISTS `riskregister`;
CREATE TABLE IF NOT EXISTS `riskregister` (
`IdRisk` int(11) NOT NULL,
  `IdProject` int(11) DEFAULT NULL,
  `IdRiskCategory` int(11) DEFAULT NULL,
  `RiskCode` varchar(5) DEFAULT NULL,
  `RiskName` varchar(50) DEFAULT NULL,
  `Owner` varchar(100) DEFAULT NULL,
  `DateRaised` date DEFAULT NULL,
  `PotentialCost` double DEFAULT NULL,
  `PotentialDelay` int(11) DEFAULT NULL,
  `Risk_Trigger` varchar(500) DEFAULT NULL,
  `Description` varchar(500) DEFAULT NULL,
  `Probability` int(11) DEFAULT NULL,
  `Impact` int(11) DEFAULT NULL,
  `Materialized` bit(1) DEFAULT NULL,
  `MitigationActionsRequired` varchar(500) DEFAULT NULL,
  `ContingencyActionsRequired` varchar(500) DEFAULT NULL,
  `ActualMaterializationCost` double DEFAULT NULL,
  `ActualMaterializationDelay` int(11) DEFAULT NULL,
  `finalComments` varchar(500) DEFAULT NULL,
  `RiskDoc` varchar(100) DEFAULT NULL,
  `riskType` int(11) DEFAULT NULL,
  `PlannedMitigationCost` double DEFAULT NULL,
  `PlannedContingencyCost` double DEFAULT NULL,
  `Closed` bit(1) DEFAULT NULL,
  `dateMaterialization` date DEFAULT NULL,
  `dueDate` date DEFAULT NULL,
  `status` varchar(1) DEFAULT NULL,
  `responseDescription` varchar(500) DEFAULT NULL,
  `residualRisk` varchar(500) DEFAULT NULL,
  `residualCost` double DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `riskregister`
--

INSERT INTO `riskregister` (`IdRisk`, `IdProject`, `IdRiskCategory`, `RiskCode`, `RiskName`, `Owner`, `DateRaised`, `PotentialCost`, `PotentialDelay`, `Risk_Trigger`, `Description`, `Probability`, `Impact`, `Materialized`, `MitigationActionsRequired`, `ContingencyActionsRequired`, `ActualMaterializationCost`, `ActualMaterializationDelay`, `finalComments`, `RiskDoc`, `riskType`, `PlannedMitigationCost`, `PlannedContingencyCost`, `Closed`, `dateMaterialization`, `dueDate`, `status`, `responseDescription`, `residualRisk`, `residualCost`) VALUES
(1, 34, 2, '1', 'Niveau d''avant-vente', 'Stéphan Peccini', '2014-12-22', 0, 0, 'Incapacité à concilier le management ou la production à réaliser avec un niveau d''avant-vente trop élevé', 'Définir et maîtriser le niveau d''avant-vente dans le Centre de Services de Toulouse ; répartition à trouver entre', 70, 40, b'0', 'Travailler avec José Costa et Nathalie Morin sur le sujet', 'Faire du design to cost et impliquer plus fortement les entités', NULL, NULL, '', NULL, 1, NULL, NULL, NULL, NULL, '2015-01-30', 'O', 'Définir le bon niveau d''avant-vente à prendre en compte tant en description qu''en pourcentage prévisionnel et informer les entités clientes du Centre de Services', '', NULL),
(2, 35, 1, '001', 'Identification du futur DT', 'Stéphan Peccini', '2015-01-12', 0, 0, 'Initialisation des SFP, planification des comités internes, externes, MDB, ...', 'L''identification n''est pas encore validée ==> DPA et DPA a très peu de temps libre', 70, 40, b'0', 'Le nommer et lui donner les objectifs', 'Aucune', NULL, NULL, '', NULL, 1, 0, 0, NULL, NULL, '2015-01-30', 'O', 'Activer le remplaçant', '', NULL),
(3, 57, NULL, 'PC001', 'ITSM Ressources Availability', 'Philippe Contesse', '2015-02-27', NULL, NULL, '', 'ITSM Ressources Availability if insufficiant N1 Ressources and if we cannot work with N2 Ressources from Spain for BT RUN activities', 30, 40, b'0', '', '', NULL, NULL, '', NULL, NULL, NULL, NULL, NULL, NULL, '2015-03-20', 'O', '', '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `security`
--

DROP TABLE IF EXISTS `security`;
CREATE TABLE IF NOT EXISTS `security` (
`IdSec` int(11) NOT NULL,
  `Login` varchar(20) DEFAULT NULL,
  `Password` varchar(35) DEFAULT NULL,
  `AutorizationLevel` char(1) DEFAULT NULL,
  `dateCreation` date NOT NULL,
  `dateLapsed` datetime DEFAULT NULL,
  `attempts` int(10) unsigned DEFAULT '0',
  `idContact` int(11) NOT NULL,
  `dateLastAttempt` datetime DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `security`
--

INSERT INTO `security` (`IdSec`, `Login`, `Password`, `AutorizationLevel`, `dateCreation`, `dateLapsed`, `attempts`, `idContact`, `dateLastAttempt`) VALUES
(10, 'admin', 'ddca2b95754e9da163e731ba0d5e4b77', NULL, '2012-07-31', '2015-03-12 10:14:18', 3, 10, '2015-03-12 10:11:18'),
(11, 'pprouzat', 'e32e3f1aca5ebf6024ccf9ec540fa552', NULL, '2014-11-19', NULL, 0, 11, NULL),
(12, 'speccini', '75c6e4b9f66a26029eb5ac450d61367e', NULL, '2014-11-19', NULL, 0, 12, NULL),
(13, 'gboyer', 'eef3fd277054a975fd170c8023d332ed', NULL, '2014-11-19', NULL, 0, 13, NULL),
(14, 'pcontesse', 'be617d21610c92924becedba0c94c192', NULL, '2014-11-20', NULL, 0, 14, NULL),
(15, 'ellamas', '32629184ce06b6f4d918626c024d98c8', NULL, '2014-11-20', NULL, 0, 15, NULL),
(16, 'jcbourion', 'cd6a63dfa2f73f5b7a677c308abf888c', NULL, '2014-11-20', NULL, 0, 16, NULL),
(17, 'vmalaval', '0776cd716a56bf3d07ae4e0c6cc55b67', NULL, '2014-11-20', NULL, 0, 17, NULL),
(18, 'smarques', '1f2fa73c779eefa9001278898f964ecc', NULL, '2014-11-20', NULL, 0, 18, NULL),
(19, 'asaoud', 'f02ef08885864a2c130c4e1d9087b65f', NULL, '2014-11-20', NULL, 0, 19, NULL),
(20, 'shadiri', '29735165b77942fd04f69f5e867c1a19', NULL, '2014-11-20', NULL, 0, 20, NULL),
(21, 'tvu', '2a80f3e2c44a617e971be2ab45b82192', NULL, '2014-11-20', NULL, 0, 21, NULL),
(22, 'mvarangot', 'bdcd51bda592633c639dd3614655b7de', NULL, '2014-11-21', NULL, 0, 22, NULL),
(23, 'agonzalez', '1bb99ff2ded3153589c8c37786716f71', NULL, '2014-11-21', NULL, 0, 23, NULL),
(24, 'dpavy', 'ff6ead9d6411f6fbb41be6b44295d0a0', NULL, '2014-11-21', NULL, 0, 24, NULL),
(25, 'ttorres', '6e4d305b7313180eaa2669b7b287f624', NULL, '2014-11-24', NULL, 0, 25, NULL),
(26, 'zlaurent', '9cd4867b17a42a9b95650a5c16d1ae9b', NULL, '2014-11-24', NULL, 0, 26, NULL),
(27, 'osacareau', 'bc67dd596ed40758c8bf66e6b810019d', NULL, '2014-11-24', NULL, 0, 27, NULL),
(28, 'jkpadjouda', '4d89f45ceb49d4cd85ea84b3e234a60a', NULL, '2014-11-24', NULL, 0, 28, NULL),
(29, 'cadam', '8bc0398ce29c6660a4c13b2360bdb2aa', NULL, '2014-11-24', NULL, 0, 29, NULL),
(30, 'jzircher', '4444c3cddb54f15dc266946b67f26ad8', NULL, '2014-11-24', NULL, 0, 30, NULL),
(31, 'pbartalan', '7fd095e0bf2bb9d4662659b4c19c1a58', NULL, '2014-11-24', NULL, 0, 31, NULL),
(32, 'sricard', 'adbfaa76119a8db22db8bcc92c814653', NULL, '2014-11-24', NULL, 0, 32, NULL),
(33, 'rdellac', '1f219cb92634eb8ba2f5c9141a834c47', NULL, '2014-11-24', NULL, 0, 33, NULL),
(34, 'ftoniolo', '7499bb8fefb683c44e733493b969d141', NULL, '2014-11-24', NULL, 0, 34, NULL),
(35, 'plouistherese', 'abae3d7138cb9e72df9ad15d81351400', NULL, '2014-11-24', NULL, 0, 35, NULL),
(36, 'xlangautier', 'aa7117296d9e63f246363bed2744fa62', NULL, '2014-11-24', NULL, 0, 36, NULL),
(37, 'rblanjean', 'f847ca0676c4c70a0ceb67f2e667ee30', NULL, '2014-11-24', NULL, 0, 37, NULL),
(38, 'vburkic', '9e4b55af41164823c1a305a308c2768a', NULL, '2014-11-24', NULL, 0, 38, NULL),
(39, 'pandrieux', 'd8ee21bc4ed521acfa63ba259a4c479f', NULL, '2014-11-24', NULL, 0, 39, NULL),
(40, 'lwatrin', 'c86d8c3f53dd383ce6144aac0a9fdabe', NULL, '2014-11-24', NULL, 0, 40, NULL),
(41, 'bfalala', '0ec612bf59468ccc790f3002d21525bc', NULL, '2014-11-24', NULL, 0, 41, NULL),
(42, 'fprat', 'ccc327e24d75e12832135ef50e5a9bdf', NULL, '2014-11-24', NULL, 0, 42, NULL),
(43, 'gvalentin', '0905ca964aa9056a37890b664e511951', NULL, '2014-11-24', NULL, 0, 43, NULL),
(44, 'hbarberet', 'b671de18aa7291a5aece39a7e87159f9', NULL, '2014-11-24', NULL, 0, 44, NULL),
(45, 'mdbouki', 'b149e436a9b808f24c1f9a09ccfecf9e', NULL, '2014-11-24', NULL, 0, 45, NULL),
(46, 'mjelliti', 'b95f03c42803ed846eef012a7a4d8bb8', NULL, '2014-11-24', NULL, 0, 46, NULL),
(47, 'vsautier', '857d31389b9f72fa5929ad7de7fff9f7', NULL, '2014-11-24', NULL, 0, 47, NULL),
(48, 'adangas', '45821c344dd89d04eb6da60f0b9061c5', NULL, '2014-11-24', NULL, 0, 48, NULL),
(49, 'nmorin', '91b902f54f47444a59b5c9942251093d', NULL, '2014-11-26', NULL, 0, 49, NULL),
(50, 'fpt1', '73420dfdb141c4d2fd64533e0f67aaed', NULL, '2014-12-03', NULL, 0, 50, NULL),
(51, 'fpt2', '9ca5617b98be8e91f2a02d6cbb4f7692', NULL, '2014-12-03', NULL, 0, 51, NULL),
(52, 'bgreff', '3cd718141cc3927bc6e0a942542e5b07', NULL, '2014-12-18', NULL, 0, 52, NULL),
(53, 'jcosta', '03617f076881816d50452f14bc510785', NULL, '2014-12-23', NULL, 0, 53, NULL),
(54, 'bdupuy', '9ddf6aeddb960a5ea70344a586dbc54f', NULL, '2014-12-29', '2015-03-02 08:18:18', 3, 54, '2015-03-02 12:10:50'),
(55, 'csanceau', '72e44dd2bb605cdd271de4673d885d94', NULL, '2015-01-09', NULL, 0, 55, NULL),
(56, 'pkowalczyk', '19a29e841bd7a992c51bd58f6c77b399', NULL, '2015-01-13', NULL, 0, 56, NULL),
(57, 'klang', '4f9110d8dec439035d845639d354f19a', NULL, '2015-01-16', NULL, 0, 57, NULL),
(58, 'ediaz', 'cb64f7622fdc328179d69648a7ec5ff7', NULL, '2015-02-04', NULL, 0, 58, NULL),
(59, 'jprome', '3997b5d6178e75b49c3ba057af670e21', NULL, '2015-02-13', NULL, 0, 59, NULL),
(60, 'jlouzoun', '8950564cfbd96236459c3a802c289dda', NULL, '2015-02-16', NULL, 0, 60, NULL),
(61, 'jcpichant', 'fb16e65c0bbb16451f31868bb8af98f4', NULL, '2015-02-23', NULL, 0, 61, NULL),
(62, 'cfarenc', 'a2f2717471a4489ba2b1dd7c0ba3a279', NULL, '2015-02-23', NULL, 0, 62, NULL),
(63, 'glecomteflament', NULL, NULL, '2015-03-02', NULL, 0, 63, NULL),
(64, 'mzait', '95a18313531f69a2e1cbda6237be6e4b', NULL, '2015-03-06', NULL, 0, 64, NULL),
(65, 'cndanga', '13a0250d508b24ffa0ffe02362d4ed19', NULL, '2015-03-06', NULL, 0, 65, NULL),
(67, 'smaussion', 'a03cdb99bfcfd9a490c9171b853eb174', NULL, '2015-03-13', NULL, 0, 67, NULL),
(68, 'jpineau', 'c02c1fa1f695756b2036d0f05991000c', NULL, '2015-03-16', NULL, 0, 68, NULL),
(69, 'swezel', 'aad0bcae2c1eb37b30ff717027f7754a', NULL, '2015-03-16', NULL, 0, 69, NULL),
(70, 'irodriguez', '6fdf126df660a343473491299cb16d62', NULL, '2015-03-16', NULL, 0, 70, NULL),
(71, 'psoule', '48f5ab5b0a7da3e07640e520eebdba57', NULL, '2015-03-20', NULL, 0, 71, NULL),
(72, 'mtrentin', '8c361e8ebaaf80b26452fd5978070101', NULL, '2015-03-30', NULL, 0, 72, NULL),
(73, 'jjimenez', '62654955b6e11bc5b84ba546681162c3', NULL, '2015-04-08', NULL, 0, 73, NULL),
(74, 'mbarrajon', '1df7a52a7ab91f473f2d72c0da830108', NULL, '2015-04-22', NULL, 0, 74, NULL),
(75, 'mcasimir', '9af50a3afc9df444dc2a1f7bd425df83', NULL, '2015-04-27', NULL, 0, 75, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `seller`
--

DROP TABLE IF EXISTS `seller`;
CREATE TABLE IF NOT EXISTS `seller` (
`idSeller` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `selected` bit(1) DEFAULT NULL,
  `qualified` bit(1) DEFAULT NULL,
  `qualificationDate` date DEFAULT NULL,
  `soleSource` bit(1) DEFAULT NULL,
  `singleSource` bit(1) DEFAULT NULL,
  `information` varchar(100) DEFAULT NULL,
  `idCompany` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `seller`
--

INSERT INTO `seller` (`idSeller`, `name`, `selected`, `qualified`, `qualificationDate`, `soleSource`, `singleSource`, `information`, `idCompany`) VALUES
(1, 'Jean-Jacques Coste', b'1', b'0', NULL, b'0', b'0', '', 1),
(2, 'Julien Goergen', b'1', b'0', NULL, b'0', b'0', '', 1),
(3, 'Céline Daulion', b'1', b'0', NULL, b'0', b'0', '', 1),
(4, 'Walid Chelbab', b'1', b'0', NULL, b'0', b'0', '', 1),
(5, 'Marc Mandin', b'1', b'0', NULL, b'0', b'0', '', 1),
(6, 'Marie Jolly', b'1', b'0', NULL, b'0', b'0', '', 1),
(7, 'Gilles Lecomte-Flament', b'1', b'0', NULL, b'0', b'0', '', 1);

-- --------------------------------------------------------

--
-- Structure de la table `setting`
--

DROP TABLE IF EXISTS `setting`;
CREATE TABLE IF NOT EXISTS `setting` (
`idSetting` int(10) unsigned NOT NULL,
  `idCompany` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` varchar(100) NOT NULL,
  `status` varchar(50) NOT NULL,
  `information` varchar(200) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `setting`
--

INSERT INTO `setting` (`idSetting`, `idCompany`, `name`, `value`, `status`, `information`) VALUES
(1, 1, 'setting.last_level_for_approve_sheet', '0', 'visible', '0 = Project Manager, 4 = Functional Manager, 7 = PMO'),
(2, 1, 'setting.followup_information_csv', 'true', 'no_visible', 'true = Enable, false = Disable'),
(3, 1, 'setting.status_report_order', 'asc', 'visible', 'asc = Ascendant, desc = Descendant');

-- --------------------------------------------------------

--
-- Structure de la table `skill`
--

DROP TABLE IF EXISTS `skill`;
CREATE TABLE IF NOT EXISTS `skill` (
`idSkill` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  `idCompany` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=328 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `skill`
--

INSERT INTO `skill` (`idSkill`, `name`, `description`, `idCompany`) VALUES
(1, 'Personne physique', NULL, 1),
(5, 'Management - OdM', NULL, 1),
(6, 'Management - SDCM', NULL, 1),
(7, 'Management - Director', NULL, 1),
(8, 'Management - Operational Director', NULL, 1),
(9, 'APPLI - AAL - développement', NULL, 1),
(10, 'APPLI - AAL - fonctionnel', NULL, 1),
(11, 'APPLI - AAL - technique', NULL, 1),
(12, 'APPLI - AFROM - développement', NULL, 1),
(13, 'APPLI - AFROM - fonctionnel', NULL, 1),
(14, 'APPLI - AFROM - technique', NULL, 1),
(15, 'APPLI - AIFU - développement', NULL, 1),
(16, 'APPLI - AIFU - fonctionnel', NULL, 1),
(17, 'APPLI - AIFU - technique', NULL, 1),
(18, 'APPLI - AirFisc/Prisca - développement', NULL, 1),
(19, 'APPLI - AirFisc/Prisca - fonctionnel', NULL, 1),
(20, 'APPLI - AirFisc/Prisca - technique', NULL, 1),
(21, 'APPLI - AML - développement', NULL, 1),
(22, 'APPLI - AML - fonctionnel', NULL, 1),
(23, 'APPLI - AML - technique', NULL, 1),
(24, 'APPLI - AOP/Masterplan - développement', NULL, 1),
(25, 'APPLI - AOP/Masterplan - fonctionnel', NULL, 1),
(26, 'APPLI - AOP/Masterplan - technique', NULL, 1),
(27, 'APPLI - Aspire - développement', NULL, 1),
(28, 'APPLI - Aspire - fonctionnel', NULL, 1),
(29, 'APPLI - Aspire - technique', NULL, 1),
(30, 'APPLI - ATN - développement', NULL, 1),
(31, 'APPLI - ATN - fonctionnel', NULL, 1),
(32, 'APPLI - ATN - technique', NULL, 1),
(33, 'APPLI - Atref - développement', NULL, 1),
(34, 'APPLI - Atref - fonctionnel', NULL, 1),
(35, 'APPLI - Atref - technique', NULL, 1),
(36, 'APPLI - Drop - développement', NULL, 1),
(37, 'APPLI - Drop - fonctionnel', NULL, 1),
(38, 'APPLI - Drop - technique', NULL, 1),
(39, 'APPLI - Eticket - développement', NULL, 1),
(40, 'APPLI - Eticket - fonctionnel', NULL, 1),
(41, 'APPLI - Eticket - technique', NULL, 1),
(42, 'APPLI - GDX - développement', NULL, 1),
(43, 'APPLI - GDX - fonctionnel', NULL, 1),
(44, 'APPLI - GDX - technique', NULL, 1),
(45, 'APPLI - ICT Catalogues - développement', NULL, 1),
(46, 'APPLI - ICT Catalogues - fonctionnel', NULL, 1),
(47, 'APPLI - ICT Catalogues - technique', NULL, 1),
(48, 'APPLI - ITSM projects - fonctionnel', NULL, 1),
(49, 'APPLI - MAGIC - développement', NULL, 1),
(50, 'APPLI - MAGIC - fonctionnel', NULL, 1),
(51, 'APPLI - MAGIC - technique', NULL, 1),
(52, 'APPLI - PC Backup - développement', NULL, 1),
(53, 'APPLI - PC Backup - fonctionnel', NULL, 1),
(54, 'APPLI - PC Backup - technique', NULL, 1),
(55, 'APPLI - PWINIT - développement', NULL, 1),
(56, 'APPLI - PWINIT - fonctionnel', NULL, 1),
(57, 'APPLI - PWINIT - technique', NULL, 1),
(58, 'APPLI - Remedy SAD - développement', NULL, 1),
(59, 'APPLI - Remedy SAD - fonctionnel', NULL, 1),
(60, 'APPLI - Remedy SAD - technique', NULL, 1),
(61, 'APPLI - Semaphore - développement', NULL, 1),
(62, 'APPLI - Semaphore - fonctionnel', NULL, 1),
(63, 'APPLI - Semaphore - technique', NULL, 1),
(64, 'BI - Semaphore Dashboard - N2', NULL, 1),
(65, 'BI - Semaphore Dashboard - N3', NULL, 1),
(67, 'BO - Analytics - N2', NULL, 1),
(68, 'BO - Analytics - N3', NULL, 1),
(69, 'BO - Smarter - N2', NULL, 1),
(70, 'BO - Smarter - N3', NULL, 1),
(71, 'ITSE - Remedy V7.X - ARS administration - N2', NULL, 1),
(72, 'ITSE - Remedy V7.X - ARS administration - N3', NULL, 1),
(73, 'ITSE - Remedy V7.X - Asset management - N2', NULL, 1),
(74, 'ITSE - Remedy V7.X - Asset management - N3', NULL, 1),
(75, 'ITSE - Remedy V7 - Atrium integration eng. AI - N2', NULL, 1),
(76, 'ITSE - Remedy V7 - Atrium integration eng. AI - N3', NULL, 1),
(77, 'ITSE - Remedy V7.X - Change management - N2', NULL, 1),
(78, 'ITSE - Remedy V7.X - Change management - N3', NULL, 1),
(79, 'ITSE - Remedy V7.X - Email Engine - N2', NULL, 1),
(80, 'ITSE - Remedy V7.X - Email Engine - N3', NULL, 1),
(81, 'ITSE - Remedy V7.X - Fondation data - N2', NULL, 1),
(82, 'ITSE - Remedy V7.X - Fondation data - N3', NULL, 1),
(83, 'ITSE - Remedy V7.X - Incident management - N2', NULL, 1),
(84, 'ITSE - Remedy V7.X - Incident management - N3', NULL, 1),
(85, 'ITSE - Remedy V7.X - Mid-tier configuration - N2', NULL, 1),
(86, 'ITSE - Remedy V7.X - Mid-tier configuration - N3', NULL, 1),
(87, 'ITSE - Remedy V7.X - Problem management - N2', NULL, 1),
(88, 'ITSE - Remedy V7.X - Problem management - N3', NULL, 1),
(89, 'ITSE - Remedy V7.X - Release management - N2', NULL, 1),
(90, 'ITSE - Remedy V7.X - Release management - N3', NULL, 1),
(91, 'ITSE - Remedy V7.X - Service level management - N2', NULL, 1),
(92, 'ITSE - Remedy V7.X - Service level management - N3', NULL, 1),
(93, 'ITSE - Remedy V7.X - Swce request management - N2', NULL, 1),
(94, 'ITSE - Remedy V7.X - Swce request management - N3', NULL, 1),
(95, 'ITSE - Remedy V8.X - ARS administration - N2', NULL, 1),
(96, 'ITSE - Remedy V8.X - ARS administration - N3', NULL, 1),
(97, 'ITSE - Remedy V8.X - Asset management - N2', NULL, 1),
(98, 'ITSE - Remedy V8.X - Asset management - N3', NULL, 1),
(99, 'ITSE - Remedy V8 - Atrium integration eng. AI - N2', NULL, 1),
(100, 'ITSE - Remedy V8 - Atrium integration eng. AI - N3', NULL, 1),
(101, 'ITSE - Remedy V8.X - Change management - N2', NULL, 1),
(102, 'ITSE - Remedy V8.X - Change management - N3', NULL, 1),
(103, 'ITSE - Remedy V8.X - Email Engine - N2', NULL, 1),
(104, 'ITSE - Remedy V8.X - Email Engine - N3', NULL, 1),
(105, 'ITSE - Remedy V8.X - Fondation data - N2', NULL, 1),
(106, 'ITSE - Remedy V8.X - Fondation data - N3', NULL, 1),
(107, 'ITSE - Remedy V8.X - Incident management - N2', NULL, 1),
(108, 'ITSE - Remedy V8.X - Incident management - N3', NULL, 1),
(109, 'ITSE - Remedy V8.X - Mid-tier configuration - N2', NULL, 1),
(110, 'ITSE - Remedy V8.X - Mid-tier configuration - N3', NULL, 1),
(111, 'ITSE - Remedy V8.X - Problem management - N2', NULL, 1),
(112, 'ITSE - Remedy V8.X - Problem management - N3', NULL, 1),
(113, 'ITSE - Remedy V8.X - Release management - N2', NULL, 1),
(114, 'ITSE - Remedy V8.X - Release management - N3', NULL, 1),
(115, 'ITSE - Remedy V8.X - Service level management - N2', NULL, 1),
(116, 'ITSE - Remedy V8.X - Service level management - N3', NULL, 1),
(117, 'ITSE - Remedy V8.X - Swce request management - N2', NULL, 1),
(118, 'ITSE - Remedy V8.X - Swce request management - N3', NULL, 1),
(119, 'ITSE - Service Manager V7.x - SM - N2', NULL, 1),
(120, 'ITSE - Service Manager V7.x - SM - N3', NULL, 1),
(121, 'ITSE - Service Manager V7.x - uCMDB - N2', NULL, 1),
(122, 'ITSE - Service Manager V7.x - uCMDB - N3', NULL, 1),
(123, 'ITSE - Service Manager V9.x - SM - N2', NULL, 1),
(124, 'ITSE - Service Manager V9.x - SM - N3', NULL, 1),
(125, 'ITSE - Service Manager V9.x - uCMDB - N2', NULL, 1),
(126, 'ITSE - Service Manager V9.x - uCMDB - N3', NULL, 1),
(127, 'NTIC - .Net - N2', NULL, 1),
(128, 'NTIC - .Net - N3', NULL, 1),
(129, 'NTIC - Ajax - N2', NULL, 1),
(130, 'NTIC - Ajax - N3', NULL, 1),
(131, 'NTIC - ASPX - N2', NULL, 1),
(132, 'NTIC - ASPX - N3', NULL, 1),
(133, 'NTIC - C# - N2', NULL, 1),
(134, 'NTIC - C# - N3', NULL, 1),
(135, 'NTIC - Cobol - N2', NULL, 1),
(136, 'NTIC - Cobol - N3', NULL, 1),
(137, 'NTIC - HTML - N2', NULL, 1),
(138, 'NTIC - HTML - N3', NULL, 1),
(139, 'NTIC - J2EE - N2', NULL, 1),
(140, 'NTIC - J2EE - N3', NULL, 1),
(141, 'NTIC - Java - N2', NULL, 1),
(142, 'NTIC - Java - N3', NULL, 1),
(143, 'NTIC - jQuery - N2', NULL, 1),
(144, 'NTIC - jQuery - N3', NULL, 1),
(145, 'NTIC - MVC.Net - N2', NULL, 1),
(146, 'NTIC - MVC.Net - N3', NULL, 1),
(147, 'NTIC - PHP - N2', NULL, 1),
(148, 'NTIC - PHP - N3', NULL, 1),
(149, 'NTIC - SQL - N2', NULL, 1),
(150, 'NTIC - SQL - N3', NULL, 1),
(151, 'NTIC - VB - N2', NULL, 1),
(152, 'NTIC - VB - N3', NULL, 1),
(153, 'NTIC - WebServices - N2', NULL, 1),
(154, 'NTIC - WebServices - N3', NULL, 1),
(155, 'RÔLE - AR - N2', NULL, 1),
(156, 'RÔLE - AR - N3', NULL, 1),
(157, 'RÔLE - ARA - N2', NULL, 1),
(158, 'RÔLE - ARA - N3', NULL, 1),
(159, 'RÔLE - BPL - N2', NULL, 1),
(160, 'RÔLE - BPL - N3', NULL, 1),
(161, 'RÔLE - Expert - N2', NULL, 1),
(162, 'RÔLE - Expert - N3', NULL, 1),
(163, 'RÔLE - IL - N2', NULL, 1),
(164, 'RÔLE - IL - N3', NULL, 1),
(165, 'RÔLE - ISPL - N2', NULL, 1),
(166, 'RÔLE - ISPL - N3', NULL, 1),
(167, 'TRANSVERSE - ACDS/Ecodir', NULL, 1),
(168, 'TRANSVERSE - Admin - N2', NULL, 1),
(169, 'TRANSVERSE - Admin - N3', NULL, 1),
(170, 'TRANSVERSE - Aphache Tomcat - N2', NULL, 1),
(171, 'TRANSVERSE - Aphache Tomcat - N3', NULL, 1),
(172, 'TRANSVERSE - CRM', NULL, 1),
(173, 'TRANSVERSE - Designer - N2', NULL, 1),
(174, 'TRANSVERSE - Designer - N3', NULL, 1),
(175, 'TRANSVERSE - eTicket', NULL, 1),
(176, 'TRANSVERSE - Talend - N2', NULL, 1),
(177, 'TRANSVERSE - Talend - N3', NULL, 1),
(178, 'TRANSVERSE - External Acess', NULL, 1),
(179, 'TRANSVERSE - IIS - N2', NULL, 1),
(180, 'TRANSVERSE - IIS - N3', NULL, 1),
(181, 'TRANSVERSE - Magic CI', NULL, 1),
(182, 'TRANSVERSE - Oracle - N2', NULL, 1),
(183, 'TRANSVERSE - Oracle - N3', NULL, 1),
(184, 'TRANSVERSE - Quality Center - N2', NULL, 1),
(185, 'TRANSVERSE - Quality Center - N3', NULL, 1),
(186, 'TRANSVERSE - SQL Server - N2', NULL, 1),
(187, 'TRANSVERSE - SQL Server - N3', NULL, 1),
(188, 'TRANSVERSE - SSO', NULL, 1),
(189, 'TRANSVERSE - Tivoli', NULL, 1),
(190, 'TRANSVERSE - Webi - N2', NULL, 1),
(191, 'TRANSVERSE - Webi - N3', NULL, 1),
(192, 'TRANSVERSE - WebSphere - N2', NULL, 1),
(193, 'TRANSVERSE - WebSphere - N3', NULL, 1),
(194, 'CLIENT - Airbus Helicopters - TMA S400', NULL, 1),
(317, 'BO - BI 4 - N2', NULL, 1),
(318, 'BO - BI 4 - N3', NULL, 1),
(319, 'BO - BI 4 - Administration user', NULL, 1),
(320, 'BO - BI 4 - Administration server', NULL, 1),
(321, 'ITSE - HP SM9 - Incident management - N2', NULL, 1),
(322, 'TSE - HP SM9 - Incident management - N3', NULL, 1),
(323, 'ITSE - HP SM9 - Request management - N2', NULL, 1),
(324, 'ITSE - HP SM9 - Request management - N3', NULL, 1),
(325, 'ITSE - HP SM9 - Change management - N2', NULL, 1),
(326, 'ITSE - HP SM9 - Change management - N3', NULL, 1),
(327, 'ITSE - HP SM9 - Configuration management - N2', NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `skillsemployee`
--

DROP TABLE IF EXISTS `skillsemployee`;
CREATE TABLE IF NOT EXISTS `skillsemployee` (
`idSkillsEmployee` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idSkill` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=843 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `skillsemployee`
--

INSERT INTO `skillsemployee` (`idSkillsEmployee`, `idEmployee`, `idSkill`) VALUES
(1, 17, 1),
(2, 17, 59),
(3, 17, 60),
(4, 17, 62),
(5, 17, 63),
(6, 17, 72),
(7, 17, 73),
(8, 17, 77),
(9, 17, 79),
(10, 17, 81),
(11, 17, 83),
(12, 17, 85),
(13, 17, 87),
(14, 17, 89),
(15, 17, 91),
(16, 17, 94),
(17, 17, 99),
(18, 17, 103),
(19, 17, 167),
(20, 17, 172),
(21, 17, 173),
(22, 17, 175),
(23, 17, 176),
(24, 17, 178),
(25, 17, 181),
(26, 17, 184),
(27, 17, 188),
(28, 17, 189),
(29, 17, 190),
(30, 17, 319),
(31, 24, 1),
(32, 24, 7),
(33, 35, 1),
(34, 35, 14),
(35, 35, 20),
(36, 35, 21),
(37, 35, 22),
(38, 35, 23),
(39, 35, 26),
(40, 35, 32),
(41, 35, 41),
(42, 35, 53),
(43, 35, 57),
(44, 35, 59),
(45, 35, 60),
(46, 35, 62),
(47, 35, 63),
(48, 35, 71),
(49, 35, 75),
(50, 35, 77),
(51, 35, 79),
(52, 35, 81),
(53, 35, 83),
(54, 35, 85),
(55, 35, 87),
(56, 35, 89),
(57, 35, 91),
(58, 35, 93),
(59, 35, 97),
(60, 35, 120),
(61, 35, 121),
(62, 35, 167),
(63, 35, 173),
(64, 35, 190),
(65, 37, 1),
(66, 37, 58),
(67, 37, 59),
(68, 37, 60),
(69, 37, 61),
(70, 37, 62),
(71, 37, 63),
(72, 37, 72),
(73, 37, 74),
(74, 37, 76),
(75, 37, 78),
(76, 37, 80),
(77, 37, 82),
(78, 37, 84),
(79, 37, 86),
(80, 37, 88),
(81, 37, 90),
(82, 37, 92),
(83, 37, 94),
(84, 37, 167),
(85, 37, 172),
(86, 37, 175),
(87, 37, 178),
(88, 37, 181),
(89, 37, 188),
(90, 37, 189),
(91, 39, 1),
(92, 39, 13),
(93, 39, 58),
(94, 39, 59),
(95, 39, 60),
(96, 39, 61),
(97, 39, 62),
(98, 39, 63),
(99, 39, 72),
(100, 39, 73),
(101, 39, 76),
(102, 39, 77),
(103, 39, 80),
(104, 39, 82),
(105, 39, 84),
(106, 39, 86),
(107, 39, 88),
(108, 39, 89),
(109, 39, 92),
(110, 39, 167),
(111, 39, 172),
(112, 39, 178),
(113, 39, 184),
(114, 39, 188),
(115, 39, 189),
(116, 46, 1),
(117, 46, 6),
(118, 46, 8),
(119, 48, 1),
(120, 53, 1),
(121, 53, 5),
(122, 53, 49),
(123, 53, 50),
(124, 53, 51),
(125, 53, 58),
(126, 53, 59),
(127, 53, 60),
(128, 53, 61),
(129, 53, 62),
(130, 53, 63),
(131, 53, 174),
(132, 53, 184),
(133, 53, 190),
(134, 53, 319),
(135, 53, 320),
(137, 58, 1),
(174, 64, 1),
(175, 64, 58),
(176, 64, 59),
(177, 64, 60),
(178, 64, 61),
(179, 64, 62),
(180, 64, 63),
(181, 64, 71),
(182, 64, 73),
(183, 64, 75),
(184, 64, 79),
(185, 64, 81),
(186, 64, 83),
(187, 64, 87),
(188, 64, 89),
(189, 64, 91),
(190, 64, 95),
(191, 64, 97),
(192, 64, 99),
(193, 64, 103),
(194, 64, 105),
(195, 64, 107),
(196, 64, 111),
(197, 64, 113),
(198, 64, 115),
(199, 64, 167),
(200, 64, 172),
(201, 64, 175),
(202, 64, 178),
(203, 64, 181),
(204, 64, 185),
(205, 64, 188),
(206, 64, 189),
(207, 65, 1),
(208, 65, 185),
(209, 66, 1),
(210, 66, 16),
(211, 66, 17),
(212, 66, 28),
(213, 66, 29),
(214, 66, 34),
(215, 66, 35),
(216, 66, 40),
(217, 66, 48),
(218, 66, 50),
(219, 66, 51),
(220, 66, 53),
(221, 66, 56),
(222, 66, 59),
(223, 66, 60),
(224, 66, 62),
(225, 66, 63),
(226, 66, 69),
(227, 66, 83),
(228, 66, 91),
(229, 66, 107),
(230, 66, 115),
(231, 66, 161),
(232, 66, 163),
(233, 66, 165),
(234, 66, 168),
(235, 66, 173),
(236, 66, 175),
(237, 66, 178),
(238, 66, 190),
(239, 66, 317),
(240, 66, 319),
(241, 67, 1),
(242, 67, 77),
(243, 67, 78),
(244, 67, 101),
(245, 67, 102),
(246, 67, 162),
(247, 67, 163),
(248, 68, 1),
(249, 68, 58),
(250, 68, 59),
(251, 68, 60),
(252, 68, 61),
(253, 68, 62),
(254, 68, 63),
(255, 68, 72),
(256, 68, 74),
(257, 68, 76),
(258, 68, 78),
(259, 68, 80),
(260, 68, 82),
(261, 68, 84),
(262, 68, 86),
(263, 68, 88),
(264, 68, 90),
(265, 68, 92),
(266, 68, 94),
(267, 68, 188),
(268, 68, 189),
(269, 69, 1),
(270, 69, 49),
(271, 69, 50),
(272, 69, 51),
(273, 69, 58),
(274, 69, 59),
(275, 69, 60),
(276, 69, 61),
(277, 69, 62),
(278, 69, 63),
(279, 69, 73),
(280, 69, 75),
(281, 69, 77),
(282, 69, 79),
(283, 69, 81),
(284, 69, 83),
(285, 69, 85),
(286, 69, 87),
(287, 69, 89),
(288, 69, 91),
(289, 69, 93),
(290, 69, 184),
(291, 70, 1),
(292, 70, 49),
(293, 70, 50),
(294, 70, 51),
(295, 70, 58),
(296, 70, 59),
(297, 70, 60),
(298, 70, 61),
(299, 70, 62),
(300, 70, 63),
(301, 70, 72),
(302, 70, 74),
(303, 70, 76),
(304, 70, 80),
(305, 70, 82),
(306, 70, 84),
(307, 70, 86),
(308, 70, 88),
(309, 70, 90),
(310, 70, 92),
(311, 70, 94),
(312, 70, 167),
(313, 70, 172),
(314, 70, 175),
(315, 70, 178),
(316, 70, 181),
(317, 70, 184),
(318, 70, 188),
(319, 70, 189),
(320, 71, 1),
(321, 71, 12),
(322, 71, 14),
(323, 71, 50),
(324, 71, 51),
(325, 71, 58),
(326, 71, 59),
(327, 71, 60),
(328, 71, 61),
(329, 71, 62),
(330, 71, 63),
(331, 71, 71),
(332, 71, 73),
(333, 71, 75),
(334, 71, 77),
(335, 71, 79),
(336, 71, 81),
(337, 71, 83),
(338, 71, 85),
(339, 71, 87),
(340, 71, 89),
(341, 71, 91),
(342, 71, 93),
(343, 71, 119),
(344, 71, 121),
(345, 71, 184),
(346, 72, 1),
(347, 72, 30),
(348, 72, 31),
(349, 72, 32),
(350, 72, 49),
(351, 72, 50),
(352, 72, 51),
(353, 72, 52),
(354, 72, 53),
(355, 72, 54),
(356, 72, 58),
(357, 72, 59),
(358, 72, 60),
(359, 72, 61),
(360, 72, 63),
(361, 72, 71),
(362, 72, 73),
(363, 72, 75),
(364, 72, 79),
(365, 72, 81),
(366, 72, 83),
(367, 72, 85),
(368, 72, 87),
(369, 72, 93),
(370, 72, 125),
(371, 72, 137),
(372, 72, 149),
(373, 72, 151),
(374, 72, 167),
(375, 72, 170),
(376, 72, 172),
(377, 72, 178),
(378, 72, 181),
(379, 72, 182),
(380, 72, 184),
(381, 72, 186),
(382, 73, 1),
(383, 73, 59),
(384, 73, 62),
(385, 73, 81),
(386, 73, 83),
(387, 74, 1),
(388, 74, 9),
(389, 74, 11),
(390, 74, 12),
(391, 74, 14),
(392, 74, 15),
(393, 74, 17),
(394, 74, 18),
(395, 74, 20),
(396, 74, 21),
(397, 74, 23),
(398, 74, 24),
(399, 74, 26),
(400, 74, 27),
(401, 74, 29),
(402, 74, 30),
(403, 74, 32),
(404, 74, 33),
(405, 74, 35),
(406, 74, 36),
(407, 74, 38),
(408, 74, 39),
(409, 74, 41),
(410, 74, 42),
(411, 74, 43),
(412, 74, 44),
(413, 74, 52),
(414, 74, 54),
(415, 74, 55),
(416, 74, 57),
(417, 74, 128),
(418, 74, 130),
(419, 74, 132),
(420, 74, 134),
(421, 74, 136),
(422, 74, 138),
(423, 74, 140),
(424, 74, 142),
(425, 74, 144),
(426, 74, 148),
(427, 74, 150),
(428, 74, 152),
(429, 74, 171),
(430, 74, 177),
(431, 74, 180),
(432, 74, 183),
(433, 74, 187),
(434, 74, 193),
(435, 75, 1),
(436, 75, 180),
(437, 75, 184),
(438, 76, 1),
(439, 76, 9),
(440, 76, 10),
(441, 76, 11),
(442, 76, 12),
(443, 76, 14),
(444, 76, 15),
(445, 76, 16),
(446, 76, 17),
(447, 76, 18),
(448, 76, 26),
(449, 76, 27),
(450, 76, 29),
(451, 76, 30),
(452, 76, 32),
(453, 76, 33),
(454, 76, 35),
(455, 76, 36),
(456, 76, 38),
(457, 76, 39),
(458, 76, 41),
(459, 76, 128),
(460, 76, 130),
(461, 76, 132),
(462, 76, 134),
(463, 76, 136),
(464, 76, 138),
(465, 76, 140),
(466, 76, 142),
(467, 76, 144),
(468, 76, 148),
(469, 76, 152),
(470, 76, 171),
(471, 76, 180),
(472, 76, 184),
(473, 76, 187),
(474, 77, 1),
(475, 77, 9),
(476, 77, 10),
(477, 77, 11),
(478, 77, 12),
(479, 77, 14),
(480, 77, 15),
(481, 77, 16),
(482, 77, 17),
(483, 77, 18),
(484, 77, 27),
(485, 77, 28),
(486, 77, 29),
(487, 77, 30),
(488, 77, 32),
(489, 77, 33),
(490, 77, 34),
(491, 77, 35),
(492, 77, 36),
(493, 77, 37),
(494, 77, 38),
(495, 77, 39),
(496, 77, 41),
(497, 77, 52),
(498, 77, 54),
(499, 77, 55),
(500, 77, 57),
(501, 77, 127),
(502, 77, 129),
(503, 77, 131),
(504, 77, 133),
(505, 77, 137),
(506, 77, 139),
(507, 77, 141),
(508, 77, 143),
(509, 77, 148),
(510, 77, 151),
(511, 77, 170),
(512, 77, 186),
(513, 78, 1),
(514, 78, 9),
(515, 78, 10),
(516, 78, 11),
(517, 78, 12),
(518, 78, 13),
(519, 78, 14),
(520, 78, 15),
(521, 78, 16),
(522, 78, 17),
(523, 78, 18),
(524, 78, 20),
(525, 78, 21),
(526, 78, 22),
(527, 78, 23),
(528, 78, 24),
(529, 78, 25),
(530, 78, 26),
(531, 78, 27),
(532, 78, 28),
(533, 78, 30),
(534, 78, 32),
(535, 78, 33),
(536, 78, 34),
(537, 78, 35),
(538, 78, 36),
(539, 78, 37),
(540, 78, 38),
(541, 78, 39),
(542, 78, 40),
(543, 78, 41),
(544, 78, 52),
(545, 78, 53),
(546, 78, 54),
(547, 78, 55),
(548, 78, 56),
(549, 78, 57),
(550, 78, 127),
(551, 78, 128),
(552, 78, 129),
(553, 78, 130),
(554, 78, 131),
(555, 78, 132),
(556, 78, 134),
(557, 78, 138),
(558, 78, 139),
(559, 78, 141),
(560, 78, 143),
(561, 78, 148),
(562, 78, 170),
(563, 78, 179),
(564, 78, 184),
(565, 78, 186),
(566, 79, 1),
(567, 79, 14),
(568, 79, 20),
(569, 79, 23),
(570, 79, 26),
(571, 79, 29),
(572, 79, 32),
(573, 79, 35),
(574, 79, 38),
(575, 79, 41),
(576, 79, 54),
(577, 79, 57),
(578, 79, 127),
(579, 79, 131),
(580, 79, 133),
(581, 79, 137),
(582, 79, 141),
(583, 79, 147),
(584, 79, 151),
(585, 80, 1),
(586, 80, 11),
(587, 80, 13),
(588, 80, 14),
(589, 80, 17),
(590, 80, 20),
(591, 80, 21),
(592, 80, 22),
(593, 80, 23),
(594, 80, 26),
(595, 80, 29),
(596, 80, 32),
(597, 80, 33),
(598, 80, 35),
(599, 80, 36),
(600, 80, 38),
(601, 80, 39),
(602, 80, 41),
(603, 80, 52),
(604, 80, 54),
(605, 80, 55),
(606, 80, 57),
(607, 80, 60),
(608, 80, 61),
(609, 80, 127),
(610, 80, 129),
(611, 80, 131),
(612, 80, 133),
(613, 80, 137),
(614, 80, 139),
(615, 80, 141),
(616, 80, 143),
(617, 80, 147),
(618, 80, 149),
(619, 80, 151),
(620, 81, 1),
(621, 81, 9),
(622, 81, 11),
(623, 81, 12),
(624, 81, 13),
(625, 81, 14),
(626, 81, 15),
(627, 81, 17),
(628, 81, 18),
(629, 81, 20),
(630, 81, 21),
(631, 81, 23),
(632, 81, 25),
(633, 81, 28),
(634, 81, 31),
(635, 81, 34),
(636, 81, 37),
(637, 81, 39),
(638, 81, 40),
(639, 81, 41),
(640, 81, 53),
(641, 81, 55),
(642, 81, 56),
(643, 81, 57),
(644, 81, 127),
(645, 81, 129),
(646, 81, 131),
(647, 81, 133),
(648, 81, 137),
(649, 81, 139),
(650, 81, 141),
(651, 81, 143),
(652, 81, 147),
(653, 81, 149),
(654, 81, 151),
(655, 81, 170),
(656, 81, 179),
(657, 81, 184),
(658, 81, 186),
(659, 82, 1),
(660, 83, 1),
(661, 84, 1),
(662, 84, 58),
(663, 84, 59),
(664, 84, 60),
(665, 84, 61),
(666, 84, 62),
(667, 84, 63),
(668, 84, 71),
(669, 84, 76),
(670, 84, 77),
(671, 84, 79),
(672, 84, 81),
(673, 84, 83),
(674, 84, 85),
(675, 84, 87),
(676, 84, 89),
(677, 84, 91),
(678, 84, 93),
(679, 84, 97),
(680, 84, 120),
(681, 84, 121),
(682, 84, 124),
(683, 84, 125),
(684, 85, 1),
(685, 85, 58),
(686, 85, 59),
(687, 85, 60),
(688, 85, 61),
(689, 85, 62),
(690, 86, 1),
(691, 86, 71),
(692, 86, 73),
(693, 86, 75),
(694, 86, 77),
(695, 86, 79),
(696, 86, 81),
(697, 86, 83),
(698, 86, 85),
(699, 86, 87),
(700, 86, 89),
(701, 86, 91),
(702, 86, 93),
(703, 86, 319),
(704, 86, 320),
(705, 96, 1),
(706, 97, 1),
(707, 101, 1),
(708, 101, 5),
(709, 102, 1),
(710, 102, 5),
(711, 103, 1),
(712, 103, 40),
(713, 103, 41),
(714, 103, 56),
(715, 103, 57),
(716, 103, 127),
(717, 103, 138),
(718, 103, 139),
(719, 103, 141),
(720, 103, 150),
(721, 103, 151),
(722, 103, 162),
(723, 103, 166),
(724, 103, 169),
(725, 103, 171),
(726, 103, 172),
(727, 103, 175),
(728, 103, 183),
(729, 103, 186),
(730, 103, 193),
(731, 106, 1),
(732, 109, 1),
(733, 109, 5),
(734, 112, 1),
(735, 117, 1),
(736, 117, 25),
(737, 117, 26),
(738, 117, 131),
(739, 117, 137),
(740, 117, 149),
(741, 117, 151),
(742, 123, 1),
(743, 124, 1),
(744, 124, 28),
(745, 124, 29),
(746, 124, 128),
(747, 124, 132),
(748, 124, 134),
(749, 124, 138),
(750, 124, 150),
(751, 124, 154),
(752, 124, 180),
(753, 124, 183),
(754, 124, 187),
(755, 127, 1),
(756, 131, 1),
(757, 132, 1),
(758, 132, 142),
(795, 63, 1),
(796, 63, 39),
(797, 63, 40),
(798, 63, 41),
(799, 63, 58),
(800, 63, 59),
(801, 63, 60),
(802, 63, 61),
(803, 63, 62),
(804, 63, 63),
(805, 63, 68),
(806, 63, 70),
(807, 63, 72),
(808, 63, 74),
(809, 63, 76),
(810, 63, 78),
(811, 63, 80),
(812, 63, 82),
(813, 63, 84),
(814, 63, 86),
(815, 63, 88),
(816, 63, 90),
(817, 63, 92),
(818, 63, 94),
(819, 63, 167),
(820, 63, 172),
(821, 63, 174),
(822, 63, 176),
(823, 63, 178),
(824, 63, 181),
(825, 63, 184),
(826, 63, 188),
(827, 63, 189),
(828, 63, 191),
(829, 63, 319),
(830, 63, 320),
(831, 129, 1),
(833, 137, 1),
(834, 138, 1),
(835, 55, 1),
(836, 139, 1),
(837, 140, 1),
(838, 142, 1),
(839, 146, 1),
(840, 149, 1),
(841, 150, 1),
(842, 151, 1);

-- --------------------------------------------------------

--
-- Structure de la table `stakeholder`
--

DROP TABLE IF EXISTS `stakeholder`;
CREATE TABLE IF NOT EXISTS `stakeholder` (
`IdStakeholder` int(11) NOT NULL,
  `IdProject` int(11) NOT NULL,
  `ProjectRole` varchar(50) DEFAULT NULL,
  `Requirements` varchar(200) DEFAULT NULL,
  `Expectations` varchar(200) DEFAULT NULL,
  `Influence` varchar(50) DEFAULT NULL,
  `MgtStrategy` varchar(50) DEFAULT NULL,
  `Classification` char(1) DEFAULT NULL,
  `Type` char(1) DEFAULT NULL,
  `contactName` varchar(50) DEFAULT NULL,
  `department` varchar(150) DEFAULT NULL,
  `orderToShow` int(11) DEFAULT '100'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `teammember`
--

DROP TABLE IF EXISTS `teammember`;
CREATE TABLE IF NOT EXISTS `teammember` (
`idTeamMember` int(10) unsigned NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `dateApproved` date DEFAULT NULL,
  `sellRate` double DEFAULT NULL,
  `fte` int(11) DEFAULT NULL,
  `dateIn` date DEFAULT NULL,
  `dateOut` date DEFAULT NULL,
  `hours` int(10) unsigned DEFAULT NULL,
  `expenses` int(11) DEFAULT NULL,
  `idActivity` int(11) DEFAULT NULL,
  `idSkill` int(11) DEFAULT NULL,
  `status` varchar(11) DEFAULT NULL,
  `commentsPM` varchar(2000) DEFAULT NULL,
  `commentsRM` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=936 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `teammember`
--

INSERT INTO `teammember` (`idTeamMember`, `idEmployee`, `dateApproved`, `sellRate`, `fte`, `dateIn`, `dateOut`, `hours`, `expenses`, `idActivity`, `idSkill`, `status`, `commentsPM`, `commentsRM`) VALUES
(9, 46, '2014-11-21', 0, 50, '2014-11-21', '2014-12-31', NULL, NULL, 12, NULL, 'assigned', '', ''),
(10, 24, '2014-11-21', 0, 100, '2014-11-21', '2014-12-31', NULL, NULL, 13, NULL, 'assigned', '', ''),
(16, 96, '2014-12-03', 0, 100, '2014-12-08', '2014-12-17', NULL, NULL, 42, NULL, 'assigned', '', ''),
(17, 96, '2014-12-03', 0, 100, '2014-12-18', '2014-12-26', NULL, NULL, 43, NULL, 'assigned', '', ''),
(18, 35, '2014-12-03', 0, 100, '2014-12-01', '2014-12-23', NULL, NULL, 40, NULL, 'released', '', ''),
(19, 35, '2014-12-03', 0, 100, '2014-12-01', '2014-12-02', NULL, NULL, 38, NULL, 'assigned', '', ''),
(20, 96, '2014-12-03', 0, 100, '2014-12-01', '2014-12-02', NULL, NULL, 38, NULL, 'assigned', '', ''),
(21, 35, '2014-12-03', 0, 10, '2015-01-05', '2015-01-13', NULL, NULL, 46, NULL, 'assigned', '', ''),
(22, 35, '2014-12-03', 0, 10, '2015-01-08', '2015-01-23', NULL, NULL, 47, NULL, 'assigned', '', ''),
(23, 35, '2014-12-03', 0, 100, '2015-01-30', '2015-01-30', NULL, NULL, 48, NULL, 'assigned', '', ''),
(24, 35, '2014-12-03', 0, 10, '2014-12-08', '2014-12-23', NULL, NULL, 40, NULL, 'assigned', '', ''),
(25, 24, '2014-12-16', 0, 20, '2014-12-01', '2014-12-12', NULL, NULL, 32, NULL, 'assigned', '', ''),
(26, 46, '2014-12-16', 0, 50, '2015-01-01', '2015-12-31', NULL, NULL, 80, NULL, 'assigned', '', ''),
(27, 24, '2014-12-16', 0, 100, '2015-01-01', '2015-12-31', NULL, NULL, 80, NULL, 'assigned', '', ''),
(29, 79, '2014-12-19', 0, 100, '2015-01-05', '2015-01-05', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(30, 79, '2014-12-19', 0, 100, '2014-12-22', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(31, 79, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(32, 72, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'released', ' - journée(s) complète(s)', ''),
(33, 69, '2014-12-19', 0, 100, '2015-01-05', '2015-01-05', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(34, 69, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(35, 17, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(36, 39, '2014-12-19', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'released', ' - journée(s) complète(s)', ''),
(37, 39, '2014-12-19', 0, 100, '2014-12-31', '2014-12-31', NULL, NULL, 16, NULL, 'released', ' - journée(s) complète(s)', ''),
(38, 68, '2014-12-19', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(39, 68, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(40, 73, '2014-12-19', 0, 100, '2014-12-18', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(41, 74, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(42, 75, '2014-12-19', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(43, 53, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(44, 63, '2014-12-19', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(45, 63, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(46, 66, '2014-12-19', 0, 100, '2014-12-22', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(47, 66, '2014-12-19', 0, 100, '2014-12-31', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(48, 64, '2014-12-19', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(49, 64, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(50, 65, '2014-12-19', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(51, 65, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(52, 76, '2014-12-19', 0, 100, '2014-12-22', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(53, 76, '2014-12-19', 0, 100, '2014-12-31', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(54, 77, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(55, 81, '2014-12-19', 0, 100, '2014-12-22', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(56, 81, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(57, 80, '2014-12-19', 0, 100, '2014-12-31', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(58, 35, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(61, 46, '2014-12-22', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(62, 86, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(63, 55, NULL, 0, 100, '2014-12-22', '2014-12-24', NULL, NULL, 16, NULL, 'released', '- journée(s) complète(s)', NULL),
(64, 71, '2014-12-19', 0, 100, '2014-12-31', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(65, 70, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(66, 75, '2014-12-19', 0, 50, '2014-12-22', '2014-12-22', NULL, NULL, 17, NULL, 'assigned', ' - après-midi', ''),
(67, 37, '2014-12-19', 0, 100, '2015-01-07', '2015-01-07', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(68, 37, '2014-12-19', 0, 100, '2015-01-21', '2015-01-21', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(69, 37, '2014-12-19', 0, 100, '2015-02-04', '2015-02-04', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(70, 37, '2014-12-19', 0, 100, '2015-02-25', '2015-02-25', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(71, 37, '2014-12-19', 0, 100, '2015-03-18', '2015-03-18', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(72, 37, '2014-12-19', 0, 100, '2015-04-08', '2015-04-08', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(73, 37, '2014-12-19', 0, 100, '2015-04-29', '2015-04-29', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(74, 37, '2014-12-19', 0, 100, '2015-05-13', '2015-05-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(75, 37, '2014-12-19', 0, 100, '2015-05-20', '2015-05-20', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(77, 103, '2014-12-19', 0, 100, '2014-12-22', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(78, 103, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(80, 82, '2014-12-19', 0, 100, '2014-12-26', '2014-12-26', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(81, 102, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 17, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(82, 101, '2014-12-19', 0, 100, '2015-01-05', '2015-01-06', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(83, 46, '2014-12-22', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 16, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(84, 82, '2014-12-29', 0, 100, '2015-01-02', '2015-01-02', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(85, 39, '2014-12-29', 0, 100, '2014-12-24', '2014-12-24', NULL, NULL, 17, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(86, 39, '2014-12-29', 0, 100, '2014-12-31', '2014-12-31', NULL, NULL, 17, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(88, 72, '2014-12-19', 0, 100, '2014-12-29', '2014-12-31', NULL, NULL, 17, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(89, 24, '2014-12-22', 0, 20, '2014-12-22', '2014-12-31', NULL, NULL, 84, NULL, 'assigned', '', ''),
(90, 24, '2014-12-22', 0, 33, '2014-12-22', '2014-12-31', NULL, NULL, 85, NULL, 'assigned', '', ''),
(91, 24, '2014-12-22', 0, 15, '2015-01-05', '2015-01-23', NULL, NULL, 86, NULL, 'assigned', '', ''),
(92, 24, '2014-12-23', 350, 20, '2014-12-22', '2014-12-26', NULL, NULL, 92, NULL, 'assigned', '', ''),
(93, 24, '2014-12-23', 0, 20, '2014-12-08', '2014-12-26', NULL, NULL, 93, NULL, 'assigned', '', ''),
(94, 24, '2014-12-23', 0, 20, '2014-12-08', '2014-12-12', NULL, NULL, 94, NULL, 'assigned', '', ''),
(95, 24, '2014-12-23', 0, 30, '2014-12-08', '2014-12-19', NULL, NULL, 95, NULL, 'assigned', '', ''),
(96, 24, '2014-12-24', 0, 15, '2014-12-29', '2015-01-16', NULL, NULL, 96, NULL, 'assigned', '', ''),
(97, 106, '2014-12-29', 300, 5, '2014-12-10', '2015-02-27', NULL, NULL, 62, NULL, 'assigned', '', ''),
(98, 39, '2014-12-29', 300, 40, '2014-12-10', '2015-02-27', NULL, NULL, 62, NULL, 'assigned', '', ''),
(99, 101, '2014-12-29', 300, 5, '2014-12-01', '2015-12-31', NULL, NULL, 63, NULL, 'assigned', '', ''),
(100, 39, '2014-12-29', 300, 5, '2014-12-01', '2015-12-31', NULL, NULL, 63, NULL, 'assigned', '', ''),
(101, 46, '2014-12-31', 0, 1, '2014-12-01', '2015-12-31', NULL, NULL, 63, NULL, 'assigned', '', ''),
(102, 39, '2014-12-29', 300, 10, '2014-12-10', '2015-12-31', NULL, NULL, 49, NULL, 'assigned', '', ''),
(103, 71, '2014-12-29', 300, 10, '2014-12-10', '2015-12-31', NULL, NULL, 49, NULL, 'assigned', '', ''),
(104, 68, '2014-12-29', 300, 10, '2014-12-10', '2015-12-31', NULL, NULL, 49, NULL, 'assigned', '', ''),
(105, 24, '2014-12-31', 0, 10, '2014-12-30', '2015-01-09', NULL, NULL, 98, NULL, 'assigned', '', ''),
(106, 24, '2014-12-31', 0, 10, '2014-12-31', '2015-01-09', NULL, NULL, 97, NULL, 'assigned', '', ''),
(107, 24, '2014-12-31', 0, 15, '2015-01-05', '2015-01-30', NULL, NULL, 85, NULL, 'assigned', '', ''),
(108, 72, '2015-01-20', 0, 15, '2015-01-06', '2015-01-23', NULL, NULL, 88, NULL, 'assigned', 'Travail sur questions pour préparer le workshop avec le client + workshop', ''),
(109, 24, '2015-01-20', 0, 10, '2015-01-05', '2015-01-23', NULL, NULL, 88, NULL, 'assigned', '', ''),
(110, 46, '2015-01-09', 0, 20, '2015-01-12', '2015-01-23', NULL, NULL, 91, NULL, 'released', '', ''),
(111, 72, NULL, 0, 50, '2015-01-09', '2015-01-09', NULL, NULL, 73, NULL, 'released', '- après-midi', NULL),
(112, 72, NULL, 0, 50, '2015-01-09', '2015-01-09', NULL, NULL, 73, NULL, 'released', '- après-midi', NULL),
(113, 72, '2015-01-12', 0, 50, '2015-01-09', '2015-01-09', NULL, NULL, 73, NULL, 'assigned', ' - après-midi', ''),
(114, 84, '2015-01-12', 0, 5, '2015-01-01', '2015-03-31', NULL, NULL, 78, NULL, 'assigned', '', ''),
(115, 85, '2015-01-12', 0, 2, '2015-01-01', '2015-03-31', NULL, NULL, 78, NULL, 'assigned', '', ''),
(116, 112, '2015-01-09', 0, 100, '2015-01-07', '2015-01-08', NULL, NULL, 99, NULL, 'released', '', ''),
(117, 24, '2015-01-14', 0, 10, '2015-01-12', '2015-01-30', NULL, NULL, 89, NULL, 'assigned', '', ''),
(118, 24, '2015-01-19', 0, 15, '2015-01-14', '2015-01-19', NULL, NULL, 101, NULL, 'assigned', '', ''),
(119, 102, '2015-01-19', 0, 20, '2015-01-14', '2015-01-19', NULL, NULL, 101, NULL, 'assigned', '', ''),
(120, 24, '2015-01-15', 0, 20, '2015-01-05', '2015-01-30', NULL, NULL, 103, NULL, 'assigned', '', ''),
(121, 24, '2015-01-15', 0, 10, '2015-02-02', '2015-02-13', NULL, NULL, 104, NULL, 'assigned', '', ''),
(122, 70, '2015-01-19', 0, 100, '2015-01-29', '2015-01-30', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(123, 76, '2015-01-19', 0, 100, '2015-01-20', '2015-01-21', NULL, NULL, 106, NULL, 'assigned', '', ''),
(124, 71, '2015-01-19', 0, 100, '2015-01-20', '2015-01-21', NULL, NULL, 106, NULL, 'assigned', '', ''),
(125, 46, '2015-01-19', 0, 10, '2015-01-15', '2015-01-21', NULL, NULL, 101, NULL, 'assigned', '', ''),
(126, 24, '2015-01-19', 0, 100, '2015-05-11', '2015-05-15', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(127, 109, '2015-01-23', 0, 100, '2015-02-09', '2015-02-09', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(128, 109, '2015-01-23', 0, 100, '2015-02-10', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(129, 46, '2015-01-20', 0, 10, '2015-01-15', '2015-01-23', NULL, NULL, 105, NULL, 'assigned', '', ''),
(130, 24, '2015-01-20', 0, 10, '2015-01-15', '2015-01-23', NULL, NULL, 105, NULL, 'assigned', '', ''),
(131, 46, '2015-01-20', 0, 10, '2015-01-15', '2015-01-30', NULL, NULL, 88, NULL, 'assigned', '', ''),
(132, 102, '2015-01-23', 0, 10, '2015-01-19', '2015-01-23', NULL, NULL, 112, NULL, 'assigned', '', ''),
(133, 24, '2015-01-20', 0, 10, '2015-01-19', '2015-01-23', NULL, NULL, 112, NULL, 'assigned', '', ''),
(134, 24, '2015-01-21', 0, 10, '2015-01-21', '2015-01-23', NULL, NULL, 93, NULL, 'assigned', '', ''),
(135, 75, '2015-01-23', 0, 50, '2015-01-21', '2015-01-21', NULL, NULL, 73, NULL, 'assigned', 'Permis Moto Plateau - matin', ''),
(136, 75, '2015-01-23', 0, 100, '2015-03-16', '2015-03-20', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(137, 75, '2015-01-23', 0, 100, '2015-06-22', '2015-07-03', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(138, 75, '2015-01-23', 0, 100, '2015-09-21', '2015-09-25', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(139, 75, '2015-01-23', 0, 100, '2015-11-23', '2015-11-27', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(140, 106, '2015-01-23', 300, 2, '2015-01-15', '2015-02-27', NULL, NULL, 49, NULL, 'assigned', '', ''),
(141, 75, '2015-01-23', 0, 50, '2015-01-30', '2015-01-30', NULL, NULL, 73, NULL, 'assigned', 'Permis moto Conduite - matin', ''),
(142, 46, '2015-01-26', 0, 10, '2015-01-19', '2015-01-26', NULL, NULL, 113, NULL, 'assigned', '', ''),
(143, 24, '2015-01-26', 0, 20, '2015-01-26', '2015-01-26', NULL, NULL, 113, NULL, 'assigned', '', ''),
(144, 53, '2015-01-29', 0, 100, '2015-02-18', '2015-02-20', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(145, 53, '2015-01-27', 0, 100, '2015-01-23', '2015-01-23', NULL, NULL, 81, NULL, 'released', '', ''),
(146, 74, NULL, 300, 0, '2015-01-12', '2015-02-27', NULL, NULL, 62, NULL, 'released', 'Scripts de monitoring', NULL),
(147, 74, '2015-01-27', 300, 1, '2015-01-12', '2015-02-27', NULL, NULL, 62, NULL, 'assigned', 'Scripts de monitoring', ''),
(148, 72, '2015-01-27', 0, 10, '2015-01-27', '2015-02-04', NULL, NULL, 88, NULL, 'assigned', '', ''),
(149, 24, '2015-01-27', 0, 15, '2015-01-28', '2015-02-04', NULL, NULL, 88, NULL, 'assigned', '', ''),
(150, 75, '2015-01-27', 0, 50, '2015-01-30', '2015-01-30', NULL, NULL, 74, NULL, 'assigned', 'Permis moto Conduite - après-midi', ''),
(151, 35, '2015-01-29', 0, 100, '2015-01-29', '2015-01-29', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(152, 81, '2015-01-29', 0, 100, '2015-02-06', '2015-02-06', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(153, 24, '2015-01-29', 0, 10, '2015-01-27', '2015-02-06', NULL, NULL, 113, NULL, 'assigned', '', ''),
(154, 46, '2015-01-29', 0, 10, '2015-01-27', '2015-02-06', NULL, NULL, 113, NULL, 'assigned', '', ''),
(155, 70, '2015-01-29', 0, 20, '2015-01-27', '2015-02-06', NULL, NULL, 113, NULL, 'assigned', '', ''),
(156, 71, '2015-01-29', 0, 20, '2015-01-27', '2015-02-06', NULL, NULL, 113, NULL, 'assigned', '', ''),
(157, 72, '2015-01-29', 0, 10, '2015-01-27', '2015-02-06', NULL, NULL, 113, NULL, 'assigned', '', ''),
(158, 101, '2015-01-29', 0, 10, '2015-01-27', '2015-02-06', NULL, NULL, 113, NULL, 'assigned', '', ''),
(159, 24, '2015-01-29', 0, 5, '2015-01-26', '2015-02-06', NULL, NULL, 105, NULL, 'assigned', '', ''),
(160, 46, '2015-01-29', 0, 100, '2015-02-09', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(161, 46, '2015-01-29', 0, 100, '2015-04-20', '2015-04-24', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(162, 102, NULL, 0, 100, '2015-02-09', '2015-03-12', NULL, NULL, 74, NULL, 'turneddown', ' - journée(s) complète(s)', ''),
(163, 102, '2015-02-03', 0, 100, '2015-02-13', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(164, 84, '2015-03-05', 0, 100, '2015-03-02', '2015-03-03', NULL, NULL, 122, NULL, 'assigned', '', ''),
(165, 84, '2015-02-03', 0, 100, '2015-03-09', '2015-03-10', NULL, NULL, 124, NULL, 'assigned', '', ''),
(166, 84, '2015-02-03', 0, 100, '2015-02-02', '2015-02-03', NULL, NULL, 114, NULL, 'assigned', '', ''),
(167, 84, '2015-02-03', 0, 100, '2015-02-17', '2015-02-18', NULL, NULL, 118, NULL, 'assigned', '', ''),
(168, 84, '2015-02-03', 0, 100, '2015-02-23', '2015-02-24', NULL, NULL, 127, NULL, 'assigned', '', ''),
(169, 112, '2015-02-02', 0, 100, '2015-03-04', '2015-03-05', NULL, NULL, 123, NULL, 'assigned', '', ''),
(170, 112, '2015-02-02', 0, 100, '2015-03-17', '2015-03-18', NULL, NULL, 125, NULL, 'assigned', '', ''),
(171, 112, '2015-02-02', 0, 100, '2015-02-23', '2015-02-24', NULL, NULL, 120, NULL, 'assigned', '', ''),
(172, 112, '2015-02-02', 0, 100, '2015-02-19', '2015-02-20', NULL, NULL, 119, NULL, 'assigned', '', ''),
(173, 112, '2015-02-02', 0, 100, '2015-02-11', '2015-02-12', NULL, NULL, 116, NULL, 'assigned', '', ''),
(174, 112, '2015-02-02', 0, 100, '2015-02-05', '2015-02-06', NULL, NULL, 115, NULL, 'assigned', '', ''),
(175, 85, '2015-02-03', 0, 100, '2015-03-24', '2015-03-25', NULL, NULL, 126, NULL, 'assigned', '', ''),
(176, 85, '2015-02-03', 0, 100, '2015-03-11', '2015-03-13', NULL, NULL, 128, NULL, 'assigned', '', ''),
(177, 85, '2015-02-03', 0, 100, '2015-02-25', '2015-02-26', NULL, NULL, 121, NULL, 'assigned', '', ''),
(178, 85, '2015-02-03', 0, 100, '2015-02-16', '2015-02-17', NULL, NULL, 117, NULL, 'assigned', '', ''),
(179, 39, NULL, 0, 100, '2015-01-30', '2015-01-30', NULL, NULL, 74, NULL, 'turneddown', ' - journée(s) complète(s)', ''),
(180, 72, '2015-02-02', 0, 50, '2015-01-30', '2015-01-30', NULL, NULL, 73, NULL, 'assigned', ' - après-midi', ''),
(181, 72, '2015-02-03', 0, 100, '2015-02-04', '2015-02-06', NULL, NULL, 73, NULL, 'assigned', 'Vu avec P. CON TESSE - journée(s) complète(s)', ''),
(182, 24, '2015-02-02', 0, 100, '2015-10-05', '2015-10-23', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(183, 24, '2015-02-02', 0, 20, '2015-02-02', '2015-02-06', NULL, NULL, 129, NULL, 'assigned', '', ''),
(184, 75, '2015-02-03', 0, 50, '2015-02-03', '2015-02-03', NULL, NULL, 74, NULL, 'assigned', ' - après-midi', ''),
(185, 72, '2015-02-03', 0, 100, '2015-02-17', '2015-02-25', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(186, 102, '2015-02-06', 0, 100, '2015-02-09', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(187, 66, '2015-02-06', 0, 100, '2015-02-03', '2015-02-04', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(188, 66, NULL, 0, 100, '2015-02-03', '2015-02-04', NULL, NULL, 73, NULL, 'released', '- journée(s) complète(s)', NULL),
(189, 66, '2015-02-06', 0, 100, '2015-02-16', '2015-02-18', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(190, 76, '2015-02-06', 0, 100, '2015-02-12', '2015-02-17', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(191, 71, '2015-02-06', 0, 100, '2015-02-13', '2015-02-17', NULL, NULL, 73, NULL, 'assigned', 'Validé dans SRH - journée(s) complète(s)', ''),
(193, 68, '2015-02-06', 0, 100, '2015-02-13', '2015-03-16', NULL, NULL, 73, NULL, 'released', 'vacances - journée(s) complète(s)', ''),
(194, 77, '2015-02-06', 0, 100, '2015-02-09', '2015-02-10', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(195, 64, '2015-02-06', 0, 100, '2015-02-03', '2015-02-03', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(196, 77, '2015-02-06', 0, 100, '2015-02-11', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(197, 69, '2015-02-09', 300, 2, '2015-01-01', '2015-02-27', NULL, NULL, 62, NULL, 'assigned', 'Developpement, Implementation &amp;amp;amp; package Change management', ''),
(198, 35, '2015-02-09', 0, 100, '2015-02-09', '2015-02-19', NULL, NULL, 75, NULL, 'assigned', 'Congé paternité - journée(s) complète(s)', ''),
(199, 80, '2015-02-18', 0, 100, '2015-05-07', '2015-05-12', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(200, 80, '2015-02-18', 0, 100, '2015-05-15', '2015-05-19', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(201, 80, '2015-02-18', 0, 100, '2015-05-21', '2015-05-26', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(202, 80, '2015-02-18', 0, 100, '2015-05-28', '2015-06-02', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(203, 80, '2015-02-18', 0, 100, '2015-06-04', '2015-06-09', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(204, 80, '2015-02-18', 0, 100, '2015-06-11', '2015-06-12', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(205, 80, '2015-02-18', 0, 100, '2015-07-24', '2015-07-31', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(207, 35, '2015-02-09', 0, 100, '2015-02-02', '2015-02-04', NULL, NULL, 75, NULL, 'assigned', 'Naissance - journée(s) complète(s)', ''),
(208, 70, '2015-02-09', 0, 10, '2015-02-09', '2015-02-13', NULL, NULL, 138, NULL, 'assigned', '', ''),
(209, 101, '2015-02-09', 0, 10, '2015-02-09', '2015-02-13', NULL, NULL, 138, NULL, 'assigned', '', ''),
(210, 101, '2015-02-09', 0, 100, '2015-01-29', '2015-01-30', NULL, NULL, 81, NULL, 'assigned', '', ''),
(211, 74, '2015-02-10', 0, 100, '2015-05-21', '2015-05-27', NULL, NULL, 73, NULL, 'assigned', '5 jours Mai - journée(s) complète(s)', ''),
(212, 72, '2015-02-10', 0, 100, '2015-02-16', '2015-02-16', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(213, 39, '2015-02-06', 450, 50, '2015-02-06', '2015-02-10', NULL, NULL, 142, NULL, 'assigned', '[InterfacePeople]Inactive Cost Center to delete', NULL),
(214, 39, '2015-02-03', 450, 8, '2015-02-03', '2015-02-10', NULL, NULL, 143, NULL, 'assigned', 'TOP add Business Service for Remedy', NULL),
(216, 39, '2015-02-18', 0, 100, '2015-02-11', '2015-02-11', NULL, NULL, 75, NULL, 'assigned', 'Récupération d un jour de repose (Astreinte le dimanche 8/02/2015 - journée(s) complète(s)', ''),
(217, 85, '2015-02-10', 0, 100, '2015-02-09', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(222, 64, '2015-02-11', 0, 100, '2015-03-30', '2015-04-10', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(223, 64, '2015-02-10', 0, 100, '2015-04-13', '2015-04-13', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(224, 64, '2015-02-10', 0, 100, '2015-05-07', '2015-05-07', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(226, 24, '2015-04-14', 0, 10, '2015-02-12', '2015-04-17', NULL, NULL, 154, NULL, 'assigned', '', ''),
(227, 46, '2015-04-14', 0, 10, '2015-02-16', '2015-04-17', NULL, NULL, 154, NULL, 'assigned', '', ''),
(229, 68, '2015-02-12', 0, 100, '2015-02-13', '2015-02-17', NULL, NULL, 73, NULL, 'assigned', 'vacances - journée(s) complète(s)', ''),
(235, 75, '2015-02-12', 0, 100, '2015-02-18', '2015-02-18', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(236, 24, '2015-02-12', 0, 10, '2015-02-12', '2015-02-13', NULL, NULL, 105, NULL, 'assigned', '', ''),
(237, 24, '2015-02-12', 0, 10, '2015-02-12', '2015-02-13', NULL, NULL, 138, NULL, 'assigned', '', ''),
(238, 24, '2015-02-12', 0, 10, '2015-02-12', '2015-02-13', NULL, NULL, 160, NULL, 'assigned', '', ''),
(239, 65, '2015-02-12', 0, 25, '2015-02-01', '2015-12-31', NULL, NULL, 161, NULL, 'released', '', ''),
(240, 84, '2015-02-12', 0, 20, '2015-02-01', '2015-12-31', NULL, NULL, 161, NULL, 'assigned', '', ''),
(241, 72, '2015-02-18', 0, 50, '2015-02-13', '2015-02-13', NULL, NULL, 73, NULL, 'assigned', 'VU AVEC P CONTESSE - après-midi', ''),
(242, 103, '2015-02-18', 0, 100, '2015-04-13', '2015-04-17', NULL, NULL, 73, NULL, 'assigned', 'Déjà validée - journée(s) complète(s)', ''),
(243, 24, '2015-02-16', 0, 10, '2015-02-16', '2015-02-20', NULL, NULL, 179, NULL, 'assigned', '', ''),
(244, 24, '2015-02-17', 0, 100, '2015-03-09', '2015-03-09', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(245, 24, '2015-02-17', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(247, 101, '2015-02-23', 0, 100, '2015-06-12', '2015-06-12', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(248, 86, '2015-02-23', 0, 100, '2015-02-02', '2015-02-27', NULL, NULL, 185, NULL, 'assigned', '', ''),
(249, 86, '2015-02-23', 0, 100, '2015-03-02', '2015-03-31', NULL, NULL, 186, NULL, 'released', '', ''),
(250, 17, '2015-02-23', 0, 25, '2015-02-02', '2015-02-27', NULL, NULL, 185, NULL, 'assigned', '', ''),
(251, 17, '2015-02-23', 0, 25, '2015-03-02', '2015-03-31', NULL, NULL, 186, NULL, 'assigned', '', ''),
(252, 37, '2015-02-23', 0, 5, '2015-02-02', '2015-02-27', NULL, NULL, 185, NULL, 'assigned', '', ''),
(253, 37, '2015-02-23', 0, 5, '2015-03-02', '2015-03-31', NULL, NULL, 186, NULL, 'assigned', '', ''),
(254, 123, '2015-02-23', 0, 40, '2015-02-02', '2015-02-27', NULL, NULL, 187, NULL, 'assigned', '', ''),
(255, 123, '2015-02-27', 0, 40, '2015-03-02', '2015-03-31', NULL, NULL, 188, NULL, 'assigned', '', ''),
(256, 75, '2015-02-23', 0, 100, '2015-02-20', '2015-02-20', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(257, 85, '2015-02-23', 0, 100, '2015-02-26', '2015-02-27', NULL, NULL, 73, NULL, 'assigned', 'Impossible de saisir la journée du 20/02 - journée(s) complète(s)', ''),
(258, 85, '2015-02-23', 0, 100, '2015-02-20', '2015-02-20', NULL, NULL, 73, NULL, 'assigned', 'régul - journée(s) complète(s)', ''),
(259, 74, '2015-02-23', 0, 0, '2015-02-23', '2015-03-04', NULL, NULL, 174, NULL, 'released', '', ''),
(260, 84, '2015-02-23', 0, 0, '2015-02-16', '2015-03-27', NULL, NULL, 174, NULL, 'released', '', ''),
(261, 85, '2015-02-23', 0, 0, '2015-02-16', '2015-03-04', NULL, NULL, 174, NULL, 'released', '', ''),
(262, 66, '2015-02-25', 0, 20, '2015-02-26', '2015-03-04', NULL, NULL, 174, NULL, 'assigned', '', ''),
(263, 85, '2015-02-25', 0, 8, '2015-02-16', '2015-03-04', NULL, NULL, 174, NULL, 'assigned', '', ''),
(264, 74, '2015-02-25', 0, 13, '2015-02-23', '2015-03-04', NULL, NULL, 174, NULL, 'assigned', '', ''),
(265, 84, '2015-02-25', 0, 8, '2015-02-16', '2015-03-27', NULL, NULL, 174, NULL, 'assigned', '', ''),
(266, 129, '2015-03-13', 0, 40, '2015-02-26', '2015-03-09', NULL, NULL, 174, NULL, 'assigned', '', ''),
(267, 129, '2015-02-25', 0, 40, '2015-02-02', '2015-02-27', NULL, NULL, 189, NULL, 'assigned', '', ''),
(268, 129, '2015-02-27', 0, 40, '2015-03-02', '2015-03-31', NULL, NULL, 190, NULL, 'assigned', '', ''),
(269, 127, '2015-02-25', 0, 100, '2015-02-23', '2015-02-27', NULL, NULL, 73, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(270, 67, '2015-03-23', 0, 100, '2015-04-13', '2015-04-27', NULL, NULL, 73, 1, 'assigned', '- journée(s) complète(s)', ''),
(271, 127, '2015-02-25', 0, 100, '2015-02-02', '2015-02-27', NULL, NULL, 185, NULL, 'assigned', '', ''),
(272, 127, '2015-02-26', 0, 100, '2015-03-02', '2015-03-31', NULL, NULL, 186, NULL, 'assigned', '', ''),
(273, 46, '2015-02-25', 0, 5, '2015-02-02', '2015-03-31', NULL, NULL, 191, NULL, 'assigned', '', ''),
(274, 109, '2015-02-25', 0, 5, '2015-02-02', '2015-03-31', NULL, NULL, 191, NULL, 'assigned', '', ''),
(275, 109, '2015-02-25', 0, 10, '2015-02-02', '2015-03-31', NULL, NULL, 192, NULL, 'assigned', '', ''),
(276, 127, '2015-02-25', 0, 10, '2015-02-02', '2015-03-31', NULL, NULL, 192, NULL, 'assigned', '', ''),
(277, 127, '2015-02-26', 0, 20, '2015-03-02', '2015-03-31', NULL, NULL, 193, NULL, 'assigned', '', ''),
(278, 37, '2015-02-26', 0, 20, '2015-02-02', '2015-03-31', NULL, NULL, 193, NULL, 'assigned', '', ''),
(279, 17, '2015-02-26', 0, 20, '2015-02-02', '2015-03-31', NULL, NULL, 193, NULL, 'assigned', '', ''),
(280, 73, '2015-02-25', 0, 50, '2015-02-16', '2015-02-17', NULL, NULL, 193, NULL, 'assigned', '', ''),
(281, 24, '2015-02-25', 0, 50, '2015-02-23', '2015-02-24', NULL, NULL, 194, NULL, 'assigned', '', ''),
(282, 46, '2015-02-25', 0, 50, '2015-02-23', '2015-02-24', NULL, NULL, 194, NULL, 'assigned', '', ''),
(283, 24, '2015-02-25', 0, 20, '2015-02-24', '2015-02-24', NULL, NULL, 179, NULL, 'assigned', '', ''),
(284, 67, '2015-03-05', 0, 100, '2015-03-02', '2015-03-02', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(285, 84, '2015-02-27', 0, 20, '2015-01-01', '2015-03-31', NULL, NULL, 196, NULL, 'assigned', '', ''),
(286, 84, '2015-02-27', 0, 20, '2015-01-01', '2015-03-31', NULL, NULL, 195, NULL, 'assigned', '', ''),
(287, 84, '2015-02-27', 0, 40, '2015-02-23', '2015-02-27', NULL, NULL, 109, NULL, 'assigned', '', ''),
(288, 85, '2015-02-27', 0, 50, '2015-02-23', '2015-02-25', NULL, NULL, 109, NULL, 'assigned', '', ''),
(289, 109, '2015-02-26', 0, 50, '2015-02-02', '2015-02-27', NULL, NULL, 197, NULL, 'assigned', '', ''),
(290, 109, '2015-02-26', 0, 50, '2015-03-02', '2015-03-31', NULL, NULL, 198, NULL, 'assigned', '', ''),
(291, 127, '2015-02-26', 0, 30, '2015-02-09', '2015-02-13', NULL, NULL, 197, NULL, 'assigned', '', ''),
(292, 17, NULL, 0, 20, '2015-02-02', '2015-02-27', NULL, NULL, 193, NULL, 'released', '', NULL),
(293, 67, '2015-03-05', 0, 100, '2015-03-23', '2015-03-23', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(294, 66, '2015-03-05', 0, 100, '2015-03-26', '2015-03-27', NULL, NULL, 74, NULL, 'assigned', ' - journée(s) complète(s)', ''),
(295, 24, '2015-02-27', 0, 10, '2015-02-27', '2015-03-06', NULL, NULL, 199, 1, 'assigned', '', ''),
(296, 74, '2015-03-05', 0, 50, '2015-03-19', '2015-03-19', NULL, NULL, 73, 1, 'assigned', ' - après-midi', ''),
(297, 74, '2015-03-23', 0, 50, '2015-04-09', '2015-04-09', NULL, NULL, 73, 1, 'assigned', ' - matin', ''),
(298, 17, '2015-03-04', 0, 100, '2015-03-02', '2015-03-03', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(299, 24, '2015-03-02', 0, 50, '2015-03-02', '2015-03-03', NULL, NULL, 200, 7, 'assigned', '', ''),
(300, 127, '2015-03-02', 0, 15, '2015-03-02', '2015-03-03', NULL, NULL, 200, 1, 'assigned', '', ''),
(301, 72, '2015-03-05', 0, 100, '2015-03-03', '2015-03-03', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(302, 69, '2015-03-05', 0, 1, '2015-03-02', '2015-03-31', NULL, NULL, 62, NULL, 'assigned', '', ''),
(303, 39, '2015-03-05', 0, 40, '2015-03-02', '2015-03-31', NULL, NULL, 62, NULL, 'assigned', '', ''),
(304, 124, '2015-03-23', 0, 100, '2015-04-03', '2015-04-03', NULL, NULL, 75, 1, 'assigned', 'Congé sans solde - journée(s) complète(s)', ''),
(305, 69, '2015-03-05', 0, 100, '2015-03-04', '2015-03-05', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(306, 103, '2015-03-03', 450, 19, '2015-03-03', '2015-03-03', NULL, NULL, 203, 194, 'released', '', NULL),
(307, 73, '2015-03-04', 0, 100, '2015-03-02', '2015-03-31', NULL, NULL, 186, 1, 'assigned', '', ''),
(308, 17, '2015-03-04', 0, 10, '2015-03-02', '2015-03-31', NULL, NULL, 217, 1, 'assigned', '', ''),
(309, 127, '2015-03-04', 0, 10, '2015-03-02', '2015-03-31', NULL, NULL, 217, 1, 'assigned', '', ''),
(310, 73, '2015-03-04', 0, 20, '2015-03-04', '2015-03-31', NULL, NULL, 193, 1, 'assigned', '', ''),
(311, 35, '2015-03-05', 0, 50, '2015-03-12', '2015-03-12', NULL, NULL, 74, 1, 'assigned', ' - matin', ''),
(312, 76, '2015-03-05', 0, 100, '2015-03-06', '2015-03-06', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(313, 63, '2015-03-06', 0, 20, '2015-03-02', '2015-03-06', NULL, NULL, 228, 1, 'released', '', ''),
(314, 63, '2015-03-05', 0, 40, '2015-03-02', '2015-03-06', NULL, NULL, 229, 1, 'assigned', '', ''),
(315, 84, '2015-03-05', 0, 100, '2015-03-16', '2015-03-16', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(316, 84, '2015-03-05', 0, 100, '2015-03-19', '2015-03-19', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(317, 84, '2015-03-06', 0, 33, '2015-03-04', '2015-03-06', NULL, NULL, 111, 1, 'assigned', '', ''),
(318, 70, '2015-03-06', 0, 100, '2015-03-03', '2015-03-04', NULL, NULL, 75, 1, 'assigned', 'Maladie - journée(s) complète(s)', ''),
(319, 37, '2015-03-06', 0, 100, '2015-03-19', '2015-03-19', NULL, NULL, 73, 1, 'released', ' - journée(s) complète(s)', ''),
(320, 63, '2015-03-06', 0, 30, '2015-03-02', '2015-03-06', NULL, NULL, 228, 1, 'assigned', '', ''),
(321, 63, '2015-03-06', 0, 30, '2015-03-02', '2015-03-06', NULL, NULL, 279, 1, 'assigned', '', ''),
(322, 63, NULL, 0, 40, '2015-03-02', '2015-03-27', NULL, NULL, 161, 1, 'released', '', NULL),
(323, 65, '2015-03-19', 0, 50, '2015-03-02', '2015-04-03', NULL, NULL, 161, 1, 'assigned', '', ''),
(324, 74, '2015-03-06', 0, 80, '2015-03-02', '2015-03-06', NULL, NULL, 93, 1, 'assigned', '', ''),
(325, 37, '2015-03-23', 0, 100, '2015-04-20', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(326, 131, '2015-03-09', 0, 100, '2015-03-10', '2015-03-10', NULL, NULL, 74, 1, 'assigned', 'RTT Reliquat 2014 - journée(s) complète(s)', ''),
(327, 131, '2015-03-09', 0, 100, '2015-03-13', '2015-03-13', NULL, NULL, 74, 1, 'assigned', 'RTT Reliquat 2014 - journée(s) complète(s)', ''),
(328, 131, '2015-03-09', 0, 100, '2015-03-04', '2015-03-06', NULL, NULL, 169, 1, 'assigned', '', ''),
(329, 64, '2015-03-27', 0, 60, '2015-03-02', '2015-03-27', NULL, NULL, 169, 1, 'assigned', '', ''),
(330, 64, '2015-03-27', 0, 40, '2015-03-02', '2015-03-27', NULL, NULL, 172, 1, 'assigned', '', ''),
(331, 66, '2015-04-24', 0, 60, '2015-03-02', '2015-12-31', NULL, NULL, 172, 1, 'assigned', '', ''),
(332, 66, '2015-03-09', 0, 30, '2015-03-02', '2015-03-06', NULL, NULL, 169, 1, 'assigned', '', ''),
(333, 66, '2015-03-23', 0, 100, '2015-04-29', '2015-04-30', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(334, 71, '2015-03-23', 0, 100, '2015-07-27', '2015-08-07', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(335, 71, '2015-03-23', 0, 100, '2015-08-17', '2015-08-21', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(336, 53, '2015-03-09', 0, 20, '2015-03-02', '2015-03-27', NULL, NULL, 296, 1, 'assigned', '', ''),
(337, 17, '2015-03-09', 0, 20, '2015-03-02', '2015-03-31', NULL, NULL, 198, 1, 'assigned', '', ''),
(338, 123, '2015-03-10', 0, 100, '2015-03-09', '2015-03-13', NULL, NULL, 73, 1, 'assigned', 'Validé Paris - journée(s) complète(s)', ''),
(339, 37, '2015-03-23', 0, 100, '2015-05-29', '2015-05-29', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(340, 53, '2015-03-12', 0, 100, '2015-03-11', '2015-03-11', NULL, NULL, 75, 1, 'assigned', 'DECES BELLE MERE - journée(s) complète(s)', ''),
(342, 37, '2015-03-23', 0, 100, '2015-05-27', '2015-05-27', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(343, 37, '2015-03-23', 0, 100, '2015-05-06', '2015-05-06', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(344, 37, '2015-03-23', 0, 100, '2015-04-15', '2015-04-15', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(345, 37, '2015-03-12', 0, 100, '2015-03-25', '2015-03-25', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(346, 24, '2015-03-12', 0, 3, '2015-03-11', '2015-03-27', NULL, NULL, 370, 7, 'assigned', '', ''),
(347, 24, '2015-03-12', 0, 3, '2015-03-11', '2015-03-27', NULL, NULL, 369, 7, 'assigned', '', ''),
(348, 24, '2015-03-12', 0, 3, '2015-03-11', '2015-03-27', NULL, NULL, 371, 7, 'assigned', '', ''),
(349, 46, '2015-03-12', 0, 5, '2015-03-09', '2015-03-27', NULL, NULL, 370, 6, 'assigned', '', ''),
(350, 46, '2015-03-12', 0, 5, '2015-03-09', '2015-03-27', NULL, NULL, 369, 6, 'assigned', '', ''),
(351, 46, '2015-03-12', 0, 5, '2015-03-09', '2015-03-27', NULL, NULL, 371, 6, 'assigned', '', ''),
(352, 71, '2015-03-12', 0, 50, '2015-03-11', '2015-03-11', NULL, NULL, 195, 1, 'assigned', '', ''),
(353, 82, '2015-03-12', 0, 50, '2015-03-02', '2015-03-02', NULL, NULL, 380, 1, 'assigned', '', ''),
(354, 82, '2015-03-12', 0, 75, '2015-03-02', '2015-03-03', NULL, NULL, 376, 1, 'assigned', '', ''),
(355, 35, '2015-03-12', 0, 25, '2015-03-02', '2015-03-02', NULL, NULL, 375, 1, 'assigned', '', ''),
(356, 24, '2015-04-09', 0, 10, '2015-03-12', '2015-04-08', NULL, NULL, 373, 7, 'assigned', '', ''),
(357, 84, '2015-04-09', 0, 15, '2015-03-13', '2015-04-17', NULL, NULL, 373, 120, 'assigned', '', ''),
(358, 81, '2015-03-12', 0, 60, '2015-03-09', '2015-03-13', NULL, NULL, 386, 1, 'assigned', '', ''),
(359, 117, '2015-03-12', 0, 60, '2015-03-09', '2015-03-12', NULL, NULL, 385, 1, 'assigned', '', ''),
(360, 117, '2015-03-12', 0, 100, '2015-03-12', '2015-03-12', NULL, NULL, 387, 1, 'assigned', '', ''),
(361, 65, '2015-03-12', 0, 50, '2015-03-09', '2015-03-13', NULL, NULL, 387, 1, 'assigned', '', ''),
(362, 63, '2015-03-12', 0, 40, '2015-03-09', '2015-03-13', NULL, NULL, 265, NULL, 'assigned', '', ''),
(363, 63, '2015-03-12', 0, 40, '2015-03-09', '2015-03-13', NULL, NULL, 229, 1, 'assigned', '', ''),
(364, 63, '2015-03-12', 0, 20, '2015-03-09', '2015-03-13', NULL, NULL, 228, 1, 'assigned', '', ''),
(365, 66, '2015-04-24', 0, 40, '2015-03-09', '2015-12-31', NULL, NULL, 169, 1, 'assigned', '', ''),
(366, 131, '2015-03-30', 0, 60, '2015-03-09', '2015-04-03', NULL, NULL, 172, 1, 'assigned', '', ''),
(367, 86, '2015-04-21', 0, 100, '2015-03-02', '2015-04-24', NULL, NULL, 81, 1, 'assigned', '', ''),
(368, 109, '2015-03-13', 0, 10, '2015-03-02', '2015-03-31', NULL, NULL, 193, 5, 'assigned', '', ''),
(369, 66, '2015-03-23', 0, 100, '2015-05-29', '2015-06-01', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(371, 124, '2015-03-13', 0, 100, '2015-03-12', '2015-03-12', NULL, NULL, 75, 1, 'assigned', 'congé sans solde - journée(s) complète(s)', ''),
(372, 72, '2015-03-17', 0, 10, '2015-03-13', '2015-03-20', NULL, NULL, 417, 1, 'assigned', '', ''),
(373, 86, '2015-03-13', 0, 50, '2015-03-02', '2015-03-02', NULL, NULL, 186, 1, 'assigned', '', ''),
(374, 24, '2015-03-16', 0, 10, '2015-03-13', '2015-03-20', NULL, NULL, 417, 7, 'assigned', '', ''),
(375, 117, '2015-03-17', 0, 100, '2015-03-13', '2015-03-13', NULL, NULL, 419, 1, 'assigned', '', ''),
(376, 74, '2015-03-13', 0, 100, '2015-03-09', '2015-03-13', NULL, NULL, 93, 1, 'assigned', '', ''),
(377, 70, '2015-03-13', 0, 100, '2015-03-09', '2015-03-13', NULL, NULL, 393, 1, 'assigned', '', ''),
(378, 70, '2015-03-13', 0, 100, '2015-03-09', '2015-03-13', NULL, NULL, 396, 1, 'assigned', '', ''),
(379, 70, '2015-03-13', 0, 100, '2015-03-09', '2015-03-13', NULL, NULL, 413, 1, 'assigned', '', ''),
(380, 70, '2015-03-13', 0, 100, '2015-03-09', '2015-03-13', NULL, NULL, 416, 1, 'assigned', '', ''),
(381, 70, '2015-03-13', 0, 100, '2015-03-13', '2015-03-16', NULL, NULL, 406, 1, 'assigned', '', ''),
(382, 69, '2015-03-17', 0, 100, '2015-03-19', '2015-03-25', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(384, 80, '2015-03-17', 0, 100, '2015-03-16', '2015-03-20', NULL, NULL, 429, 1, 'assigned', '', ''),
(385, 80, '2015-03-17', 0, 10, '2015-03-23', '2015-03-23', NULL, NULL, 429, 1, 'assigned', '', ''),
(386, 80, '2015-03-17', 0, 89, '2015-03-23', '2015-03-27', NULL, NULL, 437, 1, 'assigned', '', ''),
(387, 82, '2015-03-17', 0, 90, '2015-03-09', '2015-03-13', NULL, NULL, 445, 1, 'assigned', '', ''),
(388, 129, '2015-03-16', 0, 20, '2015-03-12', '2015-03-31', NULL, NULL, 193, 1, 'assigned', '', ''),
(389, 82, '2015-03-17', 0, 87, '2015-03-04', '2015-03-05', NULL, NULL, 445, NULL, 'assigned', '', ''),
(390, 82, '2015-03-17', 0, 56, '2015-03-05', '2015-03-06', NULL, NULL, 441, 1, 'assigned', '', ''),
(391, 129, NULL, 0, 50, '2015-03-09', '2015-03-09', NULL, NULL, 174, 1, 'released', '', NULL),
(392, 85, '2015-03-17', 0, 100, '2015-03-17', '2015-03-18', NULL, NULL, 73, 1, 'assigned', 'A valider - journée(s) complète(s)', ''),
(393, 109, '2015-03-23', 0, 100, '2015-04-13', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(394, 17, '2015-03-23', 0, 100, '2015-03-16', '2015-03-17', NULL, NULL, 73, 1, 'assigned', 'Regul maladie - journée(s) complète(s)', ''),
(395, 17, '2015-03-23', 0, 100, '2015-03-27', '2015-03-27', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(396, 17, '2015-03-23', 0, 100, '2015-04-03', '2015-04-03', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(397, 17, '2015-03-23', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(398, 17, '2015-03-23', 0, 100, '2015-04-17', '2015-04-17', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(399, 17, '2015-03-23', 0, 100, '2015-04-24', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(400, 17, '2015-03-23', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(401, 17, '2015-03-23', 0, 100, '2015-05-07', '2015-05-07', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(402, 17, '2015-03-23', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(403, 71, '2015-03-18', 0, 50, '2015-03-18', '2015-03-18', NULL, NULL, 195, 1, 'assigned', '', ''),
(404, 74, '2015-03-27', 0, 20, '2015-03-17', '2015-03-23', NULL, NULL, 195, 1, 'assigned', '', ''),
(405, 131, '2015-03-18', 0, 10, '2015-03-16', '2015-03-31', NULL, NULL, 193, 1, 'assigned', '', ''),
(406, 66, '2015-03-18', 0, 10, '2015-03-16', '2015-03-31', NULL, NULL, 193, 1, 'assigned', '', ''),
(407, 39, '2015-03-23', 0, 100, '2015-05-04', '2015-05-22', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(408, 24, '2015-03-19', 0, 10, '2015-03-18', '2015-03-27', NULL, NULL, 194, 7, 'assigned', '', ''),
(409, 109, '2015-03-20', 0, 10, '2015-03-19', '2015-03-27', NULL, NULL, 373, 5, 'assigned', '', ''),
(410, 124, '2015-03-23', 0, 100, '2015-03-16', '2015-03-16', NULL, NULL, 75, 1, 'assigned', 'congé sans solde - journée(s) complète(s)', ''),
(411, 124, '2015-03-23', 0, 100, '2015-03-18', '2015-03-18', NULL, NULL, 75, 1, 'assigned', 'congé sans solde - journée(s) complète(s)', ''),
(412, 84, '2015-03-20', 0, 10, '2015-03-16', '2015-03-27', NULL, NULL, 110, 120, 'assigned', '', ''),
(413, 74, '2015-03-20', 0, 60, '2015-03-16', '2015-03-27', NULL, NULL, 93, 1, 'assigned', '', ''),
(414, 63, '2015-03-19', 0, 20, '2015-03-16', '2015-03-20', NULL, NULL, 265, NULL, 'assigned', '', ''),
(415, 63, '2015-03-19', 0, 20, '2015-03-16', '2015-03-20', NULL, NULL, 264, NULL, 'assigned', '', ''),
(416, 63, '2015-03-27', 0, 40, '2015-03-16', '2015-03-27', NULL, NULL, 276, NULL, 'released', '', ''),
(418, 65, '2015-03-23', 0, 50, '2015-03-23', '2015-03-23', NULL, NULL, 73, 1, 'assigned', ' - après-midi', ''),
(419, 81, '2015-03-20', 0, 100, '2015-03-16', '2015-03-16', NULL, NULL, 173, 1, 'assigned', '', ''),
(420, 81, '2015-03-20', 0, 75, '2015-03-19', '2015-03-19', NULL, NULL, 173, 1, 'assigned', '', ''),
(421, 81, '2015-03-20', 0, 100, '2015-03-20', '2015-03-20', NULL, NULL, 420, 1, 'assigned', '', ''),
(422, 81, '2015-03-20', 0, 75, '2015-03-17', '2015-03-17', NULL, NULL, 420, 1, 'assigned', '', ''),
(423, 81, '2015-03-20', 0, 25, '2015-03-17', '2015-03-17', NULL, NULL, 386, 1, 'assigned', '', ''),
(424, 81, '2015-03-20', 0, 25, '2015-03-18', '2015-03-18', NULL, NULL, 386, 1, 'assigned', '', ''),
(425, 117, '2015-03-20', 0, 100, '2015-03-16', '2015-03-17', NULL, NULL, 385, 1, 'assigned', '', ''),
(426, 76, '2015-03-20', 0, 50, '2015-03-16', '2015-03-16', NULL, NULL, 514, 1, 'assigned', '', ''),
(427, 70, '2015-03-20', 0, 77, '2015-03-16', '2015-03-17', NULL, NULL, 403, 1, 'assigned', '', ''),
(430, 70, '2015-03-20', 0, 30, '2015-03-20', '2015-03-20', NULL, NULL, 498, 1, 'assigned', '', ''),
(431, 77, '2015-03-20', 0, 75, '2015-03-19', '2015-03-19', NULL, NULL, 514, 1, 'assigned', '', ''),
(432, 77, '2015-03-20', 0, 100, '2015-03-20', '2015-03-20', NULL, NULL, 514, 1, 'assigned', '', ''),
(433, 70, '2015-03-20', 0, 64, '2015-03-20', '2015-03-20', NULL, NULL, 495, NULL, 'assigned', '', ''),
(434, 72, '2015-03-20', 0, 64, '2015-03-17', '2015-03-17', NULL, NULL, 496, 1, 'assigned', '', ''),
(435, 72, '2015-03-20', 0, 32, '2015-03-17', '2015-03-17', NULL, NULL, 497, 1, 'assigned', '', ''),
(436, 82, '2015-03-20', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(437, 80, '2015-03-20', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(438, 81, '2015-03-20', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(439, 77, '2015-03-20', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(440, 79, '2015-03-20', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(441, 137, '2015-04-10', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(442, 138, '2015-04-10', 0, 10, '2015-03-02', '2015-12-31', NULL, NULL, 170, 1, 'assigned', '', ''),
(443, 82, '2015-03-20', 0, 50, '2015-03-20', '2015-03-20', NULL, NULL, 173, 1, 'assigned', '', ''),
(444, 55, '2015-03-26', 0, 13, '2015-03-18', '2015-03-18', NULL, NULL, 492, 1, 'released', 'Réunion de lancement du projet', ''),
(445, 55, '2015-03-20', 0, 50, '2015-03-19', '2015-03-19', NULL, NULL, 492, 1, 'released', 'Lancement du planning des interviews et des templates associés', ''),
(446, 63, '2015-03-23', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(447, 63, '2015-03-23', 0, 100, '2015-04-17', '2015-04-17', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(448, 63, '2015-03-23', 0, 100, '2015-04-24', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(449, 63, '2015-03-23', 0, 100, '2015-05-07', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(450, 63, '2015-03-23', 0, 100, '2015-06-18', '2015-06-22', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(451, 131, '2015-03-23', 0, 100, '2015-03-25', '2015-03-25', NULL, NULL, 74, 1, 'assigned', 'RTT Reliquat 2014 - journée(s) complète(s)', ''),
(452, 131, '2015-03-23', 0, 100, '2015-03-31', '2015-03-31', NULL, NULL, 74, 1, 'assigned', 'RTT Reliquat 2014 - journée(s) complète(s)', ''),
(453, 65, '2015-03-20', 0, 32, '2015-03-19', '2015-03-19', NULL, NULL, 541, 1, 'assigned', '', ''),
(454, 65, '2015-03-20', 0, 77, '2015-03-20', '2015-03-20', NULL, NULL, 546, 1, 'assigned', '', ''),
(455, 17, '2015-03-23', 0, 100, '2015-05-22', '2015-05-22', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(456, 17, '2015-03-23', 0, 100, '2015-05-29', '2015-05-29', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(457, 17, '2015-03-23', 0, 100, '2015-06-05', '2015-06-05', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(458, 17, '2015-03-23', 0, 100, '2015-06-12', '2015-06-12', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(459, 117, '2015-03-23', 0, 100, '2015-03-18', '2015-03-19', NULL, NULL, 549, 1, 'assigned', '', ''),
(460, 117, '2015-03-23', 0, 100, '2015-03-20', '2015-03-20', NULL, NULL, 550, 1, 'assigned', '', ''),
(461, 84, '2015-03-23', 0, 50, '2015-04-02', '2015-04-02', NULL, NULL, 73, 1, 'assigned', 'Cérémonie Nationnalité - matin', ''),
(462, 85, '2015-03-23', 0, 50, '2015-03-16', '2015-03-20', NULL, NULL, 291, NULL, 'assigned', '', ''),
(463, 131, '2015-03-23', 0, 40, '2015-03-23', '2015-03-27', NULL, NULL, 253, NULL, 'assigned', '', ''),
(464, 117, '2015-03-23', 0, 100, '2015-03-25', '2015-03-25', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(465, 117, '2015-03-23', 0, 100, '2015-04-08', '2015-04-08', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(466, 117, '2015-03-23', 0, 100, '2015-04-13', '2015-04-13', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(467, 117, '2015-03-23', 0, 100, '2015-04-23', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(468, 117, '2015-03-23', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(469, 117, '2015-03-23', 0, 100, '2015-05-22', '2015-05-22', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(470, 53, '2015-03-23', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(471, 53, '2015-03-23', 0, 100, '2015-04-16', '2015-04-21', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(472, 39, '2015-03-25', 0, 50, '2015-03-24', '2015-03-24', NULL, NULL, 74, 1, 'assigned', ' - après-midi', ''),
(473, 39, '2015-03-25', 0, 100, '2015-03-27', '2015-03-27', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(475, 109, '2015-03-25', 0, 10, '2015-03-24', '2015-03-26', NULL, NULL, 558, 5, 'assigned', '', ''),
(476, 63, '2015-03-25', 0, 20, '2015-03-25', '2015-03-25', NULL, NULL, 195, 68, 'assigned', '', ''),
(477, 66, '2015-03-25', 0, 20, '2015-03-25', '2015-03-25', NULL, NULL, 195, 317, 'assigned', '', ''),
(478, 84, '2015-03-25', 0, 100, '2015-07-13', '2015-07-17', NULL, NULL, 73, 1, 'assigned', 'Vacances Tunisie - journée(s) complète(s)', ''),
(479, 84, '2015-03-25', 0, 100, '2015-08-24', '2015-09-04', NULL, NULL, 73, 1, 'assigned', 'Mariage/ Lune de miel - journée(s) complète(s)', ''),
(480, 75, '2015-03-25', 0, 50, '2015-03-27', '2015-03-27', NULL, NULL, 74, 1, 'assigned', 'Rendez vous notaire - après-midi', ''),
(481, 70, '2015-03-26', 0, 10, '2015-03-23', '2015-03-27', NULL, NULL, 369, 50, 'assigned', '', ''),
(482, 101, '2015-03-26', 0, 10, '2015-03-23', '2015-03-27', NULL, NULL, 369, 5, 'assigned', '', '');
INSERT INTO `teammember` (`idTeamMember`, `idEmployee`, `dateApproved`, `sellRate`, `fte`, `dateIn`, `dateOut`, `hours`, `expenses`, `idActivity`, `idSkill`, `status`, `commentsPM`, `commentsRM`) VALUES
(483, 77, '2015-03-26', 0, 100, '2015-03-30', '2015-03-31', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(484, 81, '2015-03-26', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 73, 1, 'assigned', 'pont de mai  - journée(s) complète(s)', ''),
(485, 124, '2015-03-26', 0, 100, '2015-03-23', '2015-03-23', NULL, NULL, 75, 1, 'assigned', 'congé sans solde - journée(s) complète(s)', ''),
(486, 80, '2015-03-26', 0, 50, '2015-03-27', '2015-03-27', NULL, NULL, 173, 1, 'assigned', '', ''),
(487, 102, '2015-03-26', 0, 100, '2015-04-13', '2015-04-17', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(488, 102, '2015-03-26', 0, 100, '2015-05-11', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(489, 55, '2015-03-26', 0, 25, '2015-03-16', '2015-03-27', NULL, NULL, 567, 1, 'assigned', '', ''),
(490, 72, '2015-03-26', 0, 100, '2015-04-07', '2015-04-08', NULL, NULL, 73, 1, 'assigned', 'Vu et validé avec P. CONTESSE - journée(s) complète(s)', ''),
(491, 72, '2015-03-26', 0, 100, '2015-04-13', '2015-04-13', NULL, NULL, 73, 1, 'assigned', 'Vu et validé avec P. CONTESSE - journée(s) complète(s)', ''),
(493, 39, '2015-03-26', 450, 19, '2015-03-23', '2015-04-15', NULL, NULL, 575, 194, 'assigned', 'Extract la liste des requests (statut = Waiting Approval et pas d approbateurs remontés sur la request)', NULL),
(494, 39, '2015-03-26', 450, 19, '2015-03-23', '2015-04-15', NULL, NULL, 576, 194, 'assigned', 'Extract la liste des requests (statut = Waiting Approval mais un approuveur a aprrouvé la request)', NULL),
(495, 117, '2015-03-27', 0, 100, '2015-03-23', '2015-03-23', NULL, NULL, 550, 1, 'assigned', '', ''),
(496, 117, '2015-03-27', 0, 100, '2015-03-26', '2015-03-27', NULL, NULL, 549, 1, 'assigned', '', ''),
(497, 117, '2015-03-27', 0, 100, '2015-03-24', '2015-03-24', NULL, NULL, 419, 1, 'assigned', '', ''),
(498, 81, '2015-03-27', 0, 50, '2015-03-23', '2015-03-23', NULL, NULL, 385, 1, 'assigned', '', ''),
(499, 81, '2015-03-27', 0, 55, '2015-03-23', '2015-03-27', NULL, NULL, 420, 1, 'assigned', '', ''),
(500, 74, '2015-03-27', 0, 20, '2015-03-30', '2015-04-03', NULL, NULL, 577, 1, 'assigned', '', ''),
(501, 63, '2015-03-27', 0, 50, '2015-03-23', '2015-03-27', NULL, NULL, 265, 1, 'assigned', '', ''),
(502, 65, '2015-03-30', 0, 50, '2015-03-26', '2015-03-26', NULL, NULL, 381, 185, 'assigned', '', ''),
(503, 65, '2015-03-30', 0, 50, '2015-04-07', '2015-04-07', NULL, NULL, 73, 1, 'assigned', ' - après-midi', ''),
(504, 65, '2015-03-30', 0, 100, '2015-04-16', '2015-04-21', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(505, 70, '2015-03-30', 0, 100, '2015-04-03', '2015-04-17', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(506, 81, '2015-03-31', 0, 75, '2015-03-30', '2015-03-30', NULL, NULL, 420, 1, 'assigned', '', ''),
(507, 81, '2015-03-31', 0, 75, '2015-03-31', '2015-03-31', NULL, NULL, 420, 1, 'assigned', '', ''),
(508, 66, '2015-04-07', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 74, 1, 'assigned', ' - matin', ''),
(509, 101, '2015-04-07', 0, 50, '2015-04-09', '2015-04-09', NULL, NULL, 74, 1, 'assigned', ' - après-midi', ''),
(510, 101, '2015-04-07', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(511, 101, '2015-04-07', 0, 100, '2015-05-26', '2015-05-29', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(512, 117, '2015-04-07', 0, 100, '2015-04-01', '2015-04-01', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(514, 131, '2015-04-07', 0, 100, '2015-04-20', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(515, 79, '2015-04-07', 0, 50, '2015-03-26', '2015-03-26', NULL, NULL, 341, 1, 'assigned', '', ''),
(516, 77, '2015-04-07', 0, 94, '2015-03-24', '2015-03-27', NULL, NULL, 346, 1, 'assigned', '', ''),
(517, 81, NULL, 0, 50, '2015-03-23', '2015-03-23', NULL, NULL, 386, 1, 'released', '', NULL),
(518, 77, '2015-04-07', 0, 25, '2015-03-23', '2015-03-23', NULL, NULL, 514, 1, 'assigned', '', ''),
(519, 79, '2015-04-07', 0, 50, '2015-03-25', '2015-03-25', NULL, NULL, 502, 1, 'assigned', '', ''),
(520, 137, '2015-04-10', 0, 100, '2015-04-01', '2015-04-01', NULL, NULL, 307, 1, 'assigned', '', ''),
(521, 137, '2015-04-10', 0, 100, '2015-03-31', '2015-03-31', NULL, NULL, 307, 1, 'assigned', '', ''),
(522, 137, '2015-04-10', 0, 25, '2015-03-30', '2015-03-30', NULL, NULL, 307, 1, 'assigned', '', ''),
(523, 138, '2015-04-10', 0, 50, '2015-03-23', '2015-03-23', NULL, NULL, 537, 1, 'assigned', '', ''),
(524, 73, '2015-04-07', 0, 100, '2015-06-12', '2015-06-12', NULL, NULL, 74, 1, 'assigned', 'Examen d''anglais - journée(s) complète(s)', ''),
(525, 73, '2015-04-01', 0, 50, '2015-04-01', '2015-04-30', NULL, NULL, 204, 1, 'assigned', '', ''),
(526, 17, '2015-04-01', 0, 25, '2015-04-01', '2015-04-30', NULL, NULL, 204, 1, 'assigned', '', ''),
(527, 37, '2015-04-01', 0, 25, '2015-04-01', '2015-04-30', NULL, NULL, 204, 1, 'assigned', '', ''),
(528, 127, '2015-04-01', 0, 100, '2015-04-01', '2015-04-30', NULL, NULL, 204, 1, 'assigned', '', ''),
(529, 109, '2015-04-28', 0, 50, '2015-04-01', '2015-04-30', NULL, NULL, 585, 5, 'assigned', '', ''),
(530, 17, '2015-04-01', 0, 20, '2015-04-01', '2015-04-30', NULL, NULL, 585, 1, 'assigned', '', ''),
(531, 123, '2015-04-10', 0, 40, '2015-04-01', '2015-04-30', NULL, NULL, 586, 1, 'assigned', '', ''),
(532, 123, '2015-04-10', 0, 40, '2015-05-01', '2015-05-29', NULL, NULL, 587, 1, 'assigned', '', ''),
(533, 123, '2015-04-10', 0, 40, '2015-06-01', '2015-06-30', NULL, NULL, 588, 1, 'assigned', '', ''),
(534, 17, '2015-04-01', 0, 20, '2015-04-01', '2015-04-30', NULL, NULL, 218, 1, 'assigned', '', ''),
(535, 37, '2015-04-01', 0, 10, '2015-04-01', '2015-04-10', NULL, NULL, 193, 1, 'assigned', '', ''),
(536, 132, '2015-04-07', 0, 100, '2015-03-30', '2015-04-03', NULL, NULL, 577, 1, 'assigned', '', ''),
(537, 140, '2015-04-10', 0, 1, '2015-03-23', '2015-03-31', NULL, NULL, 203, 1, 'assigned', '', ''),
(539, 70, '2015-04-07', 0, 50, '2015-03-26', '2015-03-26', NULL, NULL, 569, 1, 'assigned', '', ''),
(540, 70, '2015-04-07', 0, 25, '2015-03-25', '2015-03-25', NULL, NULL, 603, 1, 'assigned', '', ''),
(541, 70, '2015-04-07', 0, 100, '2015-03-27', '2015-03-27', NULL, NULL, 600, 1, 'assigned', '', ''),
(542, 71, '2015-04-07', 0, 50, '2015-03-23', '2015-03-23', NULL, NULL, 570, 1, 'assigned', '', ''),
(543, 71, '2015-04-07', 0, 50, '2015-03-24', '2015-03-24', NULL, NULL, 596, NULL, 'assigned', '', ''),
(544, 72, '2015-04-07', 0, 100, '2015-03-26', '2015-03-26', NULL, NULL, 601, 1, 'assigned', '', ''),
(545, 55, '2015-04-07', 0, 20, '2015-03-30', '2015-04-03', NULL, NULL, 577, 1, 'assigned', '', ''),
(546, 70, '2015-04-07', 0, 50, '2015-03-23', '2015-03-23', NULL, NULL, 171, 1, 'assigned', '', ''),
(547, 72, '2015-04-07', 0, 100, '2015-03-23', '2015-03-23', NULL, NULL, 171, 1, 'assigned', '', ''),
(548, 72, '2015-04-07', 0, 50, '2015-03-27', '2015-03-27', NULL, NULL, 168, 1, 'assigned', '', ''),
(549, 79, '2015-04-07', 0, 100, '2015-05-11', '2015-05-22', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(550, 70, '2015-04-07', 0, 75, '2015-04-01', '2015-04-01', NULL, NULL, 171, 1, 'assigned', '', ''),
(551, 70, '2015-04-07', 0, 75, '2015-03-30', '2015-03-30', NULL, NULL, 602, 1, 'assigned', '', ''),
(552, 70, '2015-04-07', 0, 25, '2015-03-30', '2015-03-30', NULL, NULL, 595, 1, 'assigned', '', ''),
(553, 70, '2015-04-07', 0, 75, '2015-04-02', '2015-04-02', NULL, NULL, 598, 1, 'assigned', '', ''),
(554, 70, '2015-04-07', 0, 25, '2015-04-02', '2015-04-02', NULL, NULL, 593, NULL, 'assigned', '', ''),
(555, 70, '2015-04-07', 0, 100, '2015-03-24', '2015-03-24', NULL, NULL, 604, 1, 'assigned', '', ''),
(556, 70, '2015-04-07', 0, 75, '2015-03-25', '2015-03-25', NULL, NULL, 604, 1, 'assigned', '', ''),
(557, 71, '2015-04-07', 0, 100, '2015-05-11', '2015-05-13', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(558, 84, '2015-04-02', 0, 30, '2015-04-01', '2015-05-31', NULL, NULL, 605, 124, 'assigned', '', ''),
(559, 109, '2015-04-02', 0, 10, '2015-04-01', '2015-05-31', NULL, NULL, 605, 5, 'assigned', '', ''),
(560, 71, '2015-04-02', 0, 10, '2015-04-01', '2015-05-31', NULL, NULL, 605, 119, 'assigned', '', ''),
(561, 84, '2015-04-16', 0, 20, '2015-04-01', '2015-04-20', NULL, NULL, 606, 1, 'assigned', '', ''),
(562, 70, '2015-04-07', 0, 25, '2015-03-26', '2015-03-26', NULL, NULL, 603, 1, 'assigned', '', ''),
(563, 70, '2015-04-07', 0, 25, '2015-03-26', '2015-03-26', NULL, NULL, 572, 1, 'assigned', '', ''),
(564, 70, '2015-04-07', 0, 100, '2015-03-31', '2015-03-31', NULL, NULL, 595, 1, 'assigned', '', ''),
(565, 70, '2015-04-07', 0, 25, '2015-04-01', '2015-04-01', NULL, NULL, 595, 1, 'assigned', '', ''),
(566, 71, '2015-04-07', 0, 75, '2015-03-30', '2015-03-30', NULL, NULL, 596, 1, 'assigned', '', ''),
(567, 71, '2015-04-07', 0, 50, '2015-04-01', '2015-04-01', NULL, NULL, 591, 1, 'assigned', '', ''),
(568, 71, '2015-04-07', 0, 50, '2015-04-02', '2015-04-02', NULL, NULL, 591, 1, 'assigned', '', ''),
(569, 71, '2015-04-07', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 591, 1, 'assigned', '', ''),
(570, 71, '2015-04-07', 0, 25, '2015-03-30', '2015-03-30', NULL, NULL, 171, 1, 'assigned', '', ''),
(571, 71, '2015-04-07', 0, 50, '2015-03-31', '2015-03-31', NULL, NULL, 171, 1, 'assigned', '', ''),
(572, 72, '2015-04-07', 0, 100, '2015-03-24', '2015-03-24', NULL, NULL, 604, 1, 'assigned', '', ''),
(573, 72, '2015-04-07', 0, 100, '2015-03-25', '2015-03-25', NULL, NULL, 604, 1, 'assigned', '', ''),
(574, 65, '2015-04-03', 0, 25, '2015-04-02', '2015-04-02', NULL, NULL, 571, 1, 'assigned', '', ''),
(575, 65, '2015-04-03', 0, 25, '2015-04-02', '2015-04-02', NULL, NULL, 597, 1, 'assigned', '', ''),
(576, 65, '2015-04-03', 0, 25, '2015-04-02', '2015-04-02', NULL, NULL, 592, 1, 'assigned', '', ''),
(577, 46, '2015-04-10', 0, 5, '2015-04-01', '2015-04-30', NULL, NULL, 585, 6, 'assigned', '', ''),
(578, 76, '2015-04-07', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 73, 1, 'assigned', ' - après-midi', ''),
(579, 65, '2015-04-03', 0, 100, '2015-04-03', '2015-04-03', NULL, NULL, 430, 185, 'assigned', '', ''),
(580, 80, '2015-04-07', 0, 100, '2015-03-30', '2015-03-31', NULL, NULL, 438, 1, 'assigned', '', ''),
(581, 80, '2015-04-07', 0, 100, '2015-04-01', '2015-04-01', NULL, NULL, 430, NULL, 'assigned', '', ''),
(582, 80, '2015-04-07', 0, 50, '2015-04-02', '2015-04-02', NULL, NULL, 430, 1, 'assigned', '', ''),
(583, 81, '2015-04-07', 0, 50, '2015-04-01', '2015-04-01', NULL, NULL, 420, 1, 'assigned', '', ''),
(584, 81, '2015-04-07', 0, 50, '2015-04-02', '2015-04-02', NULL, NULL, 420, 1, 'assigned', '', ''),
(585, 81, '2015-04-07', 0, 100, '2015-04-03', '2015-04-03', NULL, NULL, 420, 1, 'assigned', 'vu avec E Diaz: la tâche 2206 concerne la version MasterPlan improvement wave 4 (2.2.1), en cours de création. On compensera semaine prochaine.', ''),
(586, 137, '2015-04-10', 0, 25, '2015-03-25', '2015-03-25', NULL, NULL, 315, 1, 'assigned', '', ''),
(587, 137, '2015-04-10', 0, 25, '2015-03-25', '2015-03-25', NULL, NULL, 320, 1, 'assigned', '', ''),
(588, 137, '2015-04-10', 0, 25, '2015-03-30', '2015-03-30', NULL, NULL, 308, 1, 'assigned', '', ''),
(589, 137, '2015-04-10', 0, 100, '2015-03-31', '2015-03-31', NULL, NULL, 308, 1, 'assigned', '', ''),
(590, 137, '2015-04-10', 0, 100, '2015-04-01', '2015-04-01', NULL, NULL, 308, 1, 'assigned', '', ''),
(591, 137, '2015-04-10', 0, 100, '2015-04-02', '2015-04-02', NULL, NULL, 308, 1, 'assigned', '', ''),
(592, 137, '2015-04-10', 0, 100, '2015-04-03', '2015-04-03', NULL, NULL, 311, 1, 'assigned', '', ''),
(593, 71, '2015-04-07', 0, 75, '2015-04-09', '2015-04-09', NULL, NULL, 583, 119, 'assigned', '', ''),
(594, 74, '2015-04-07', 0, 100, '2015-04-08', '2015-04-08', NULL, NULL, 583, 177, 'assigned', '', ''),
(595, 74, '2015-04-07', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 621, 1, 'assigned', '', ''),
(600, 74, '2015-04-07', 0, 50, '2015-04-09', '2015-04-09', NULL, NULL, 621, 1, 'assigned', '', ''),
(601, 74, '2015-04-07', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 621, 1, 'assigned', '', ''),
(602, 132, '2015-04-07', 0, 100, '2015-04-07', '2015-04-10', NULL, NULL, 621, NULL, 'assigned', '', ''),
(603, 55, '2015-04-07', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 620, NULL, 'assigned', '', ''),
(604, 81, '2015-04-07', 0, 50, '2015-04-07', '2015-04-07', NULL, NULL, 420, 1, 'assigned', '', ''),
(605, 137, '2015-04-10', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 308, NULL, 'assigned', '', ''),
(606, 77, '2015-04-09', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(607, 79, '2015-04-09', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(608, 80, '2015-04-09', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(609, 81, '2015-04-09', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(610, 82, '2015-04-09', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(611, 138, '2015-04-10', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(612, 137, '2015-04-10', 0, 10, '2015-04-06', '2015-07-01', NULL, NULL, 173, 1, 'assigned', '', ''),
(613, 77, '2015-04-09', 0, 100, '2015-03-20', '2015-03-24', NULL, NULL, 73, 1, 'released', '- journée(s) complète(s)', ''),
(614, 84, '2015-04-09', 0, 10, '2015-04-07', '2015-05-15', NULL, NULL, 583, 124, 'assigned', '', ''),
(615, 81, '2015-04-10', 0, 25, '2015-04-08', '2015-04-08', NULL, NULL, 629, 1, 'assigned', '', ''),
(616, 81, '2015-04-10', 0, 75, '2015-04-08', '2015-04-08', NULL, NULL, 420, 1, 'assigned', '', ''),
(617, 109, '2015-04-09', 0, 5, '2015-04-01', '2015-04-30', NULL, NULL, 635, 1, 'assigned', '', ''),
(618, 84, '2015-04-09', 0, 5, '2015-04-01', '2015-04-30', NULL, NULL, 635, 120, 'assigned', '', ''),
(619, 71, '2015-04-09', 0, 5, '2015-04-01', '2015-04-30', NULL, NULL, 635, 119, 'assigned', '', ''),
(620, 55, '2015-04-10', 0, 100, '2015-04-20', '2015-04-21', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(621, 55, '2015-04-10', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(622, 109, '2015-04-09', 0, 50, '2015-04-07', '2015-04-07', NULL, NULL, 213, 1, 'assigned', '', ''),
(623, 81, '2015-04-10', 0, 25, '2015-04-09', '2015-04-09', NULL, NULL, 420, 1, 'assigned', '', ''),
(624, 117, '2015-04-10', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 628, 1, 'assigned', '', ''),
(625, 117, '2015-04-10', 0, 100, '2015-04-09', '2015-04-10', NULL, NULL, 628, 1, 'assigned', '', ''),
(626, 65, '2015-04-10', 0, 75, '2015-04-09', '2015-04-10', NULL, NULL, 421, 185, 'assigned', '', ''),
(627, 129, '2015-04-10', 0, 40, '2015-04-06', '2015-04-30', NULL, NULL, 213, 1, 'assigned', '', ''),
(628, 138, '2015-04-10', 0, 50, '2015-04-01', '2015-04-01', NULL, NULL, 643, 1, 'assigned', '', ''),
(629, 138, '2015-04-10', 0, 50, '2015-04-01', '2015-04-01', NULL, NULL, 649, 1, 'assigned', '', ''),
(630, 138, '2015-04-10', 0, 50, '2015-04-02', '2015-04-02', NULL, NULL, 643, 1, 'assigned', '', ''),
(631, 138, '2015-04-10', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 643, 1, 'assigned', '', ''),
(632, 138, '2015-04-10', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 649, 1, 'assigned', '', ''),
(633, 138, '2015-04-10', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 653, 1, 'assigned', '', ''),
(634, 138, '2015-04-10', 0, 100, '2015-04-08', '2015-04-08', NULL, NULL, 653, 1, 'assigned', '', ''),
(635, 138, '2015-04-10', 0, 100, '2015-04-09', '2015-04-09', NULL, NULL, 653, 1, 'assigned', '', ''),
(636, 138, '2015-04-10', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 653, 1, 'assigned', '', ''),
(637, 131, '2015-04-10', 0, 40, '2015-04-06', '2015-05-29', NULL, NULL, 169, 1, 'assigned', '', ''),
(638, 77, '2015-04-10', 0, 100, '2015-04-20', '2015-04-24', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(639, 131, '2015-04-10', 0, 40, '2015-04-06', '2015-04-17', NULL, NULL, 612, 1, 'assigned', '', ''),
(640, 63, '2015-04-10', 0, 60, '2015-04-06', '2015-04-10', NULL, NULL, 277, 1, 'assigned', '', ''),
(641, 139, '2015-04-10', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(642, 69, '2015-04-13', 0, 100, '2015-04-13', '2015-04-13', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(643, 63, '2015-04-10', 0, 100, '2015-04-13', '2015-04-15', NULL, NULL, 295, 1, 'released', '', ''),
(644, 63, NULL, 0, 20, '2015-04-13', '2015-04-15', NULL, NULL, 294, 1, 'released', '', NULL),
(645, 63, '2015-04-10', 0, 10, '2015-04-09', '2015-04-10', NULL, NULL, 272, 1, 'released', '', ''),
(646, 79, '2015-04-13', 0, 25, '2015-04-08', '2015-04-08', NULL, NULL, 366, 1, 'assigned', '', ''),
(647, 79, NULL, 0, 25, '2015-04-09', '2015-04-09', NULL, NULL, 623, 1, 'released', '', NULL),
(648, 79, '2015-04-13', 0, 25, '2015-04-09', '2015-04-09', NULL, NULL, 658, 1, 'assigned', '', ''),
(649, 79, '2015-04-13', 0, 25, '2015-04-09', '2015-04-09', NULL, NULL, 662, 1, 'assigned', '', ''),
(650, 79, '2015-04-13', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 662, 1, 'assigned', '', ''),
(651, 79, '2015-04-13', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 662, 1, 'assigned', '', ''),
(652, 79, '2015-04-13', 0, 0, '2015-04-01', '2015-04-01', NULL, NULL, 657, 1, 'assigned', '', ''),
(653, 79, '2015-04-13', 0, 0, '2015-04-01', '2015-04-01', NULL, NULL, 665, 1, 'assigned', '', ''),
(654, 77, '2015-04-13', 0, 100, '2015-04-01', '2015-04-01', NULL, NULL, 346, 1, 'assigned', '', ''),
(655, 77, '2015-04-14', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 530, 1, 'assigned', '', ''),
(656, 77, '2015-04-14', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 530, 1, 'assigned', '', ''),
(657, 77, '2015-04-14', 0, 50, '2015-04-08', '2015-04-08', NULL, NULL, 514, 1, 'assigned', '', ''),
(658, 77, '2015-04-14', 0, 50, '2015-04-08', '2015-04-08', NULL, NULL, 530, 1, 'assigned', '', ''),
(659, 77, '2015-04-14', 0, 100, '2015-04-09', '2015-04-09', NULL, NULL, 530, 1, 'assigned', '', ''),
(660, 77, '2015-04-14', 0, 50, '2015-04-10', '2015-04-10', NULL, NULL, 680, 1, 'assigned', '', ''),
(661, 77, '2015-04-14', 0, 50, '2015-04-10', '2015-04-10', NULL, NULL, 346, 1, 'assigned', '', ''),
(662, 80, '2015-04-15', 0, 75, '2015-04-09', '2015-04-09', NULL, NULL, 677, 1, 'assigned', 'CN-01776', ''),
(663, 80, '2015-04-15', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 677, 1, 'assigned', 'CN-01535 - 0.5j\nCN-01581 - 0.25j\nCN-01777 - 0.25j', ''),
(664, 63, '2015-04-13', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 294, 1, 'assigned', '', ''),
(665, 39, '2015-04-15', 0, 100, '2015-04-16', '2015-04-16', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(666, 80, '2015-04-15', 0, 100, '2015-04-03', '2015-04-03', NULL, NULL, 684, 1, 'assigned', '', ''),
(667, 80, '2015-04-15', 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 684, 1, 'assigned', '', ''),
(668, 80, '2015-04-15', 0, 50, '2015-04-08', '2015-04-08', NULL, NULL, 684, 1, 'assigned', '', ''),
(669, 82, '2015-04-15', 0, 100, '2015-04-10', '2015-04-10', NULL, NULL, 677, 1, 'assigned', '', ''),
(670, 63, '2015-04-14', 0, 50, '2015-04-14', '2015-04-15', NULL, NULL, 278, 1, 'released', '', ''),
(671, 63, '2015-04-14', 0, 20, '2015-04-16', '2015-04-16', NULL, NULL, 278, 1, 'assigned', '', ''),
(672, 63, '2015-04-14', 0, 100, '2015-04-17', '2015-04-17', NULL, NULL, 277, 1, 'released', '', ''),
(673, 77, '2015-04-14', 0, 50, '2015-04-02', '2015-04-02', NULL, NULL, 686, 1, 'assigned', '', ''),
(674, 77, '2015-04-14', 0, 50, '2015-04-03', '2015-04-03', NULL, NULL, 686, 1, 'assigned', '', ''),
(675, 65, '2015-04-14', 0, 32, '2015-04-13', '2015-04-13', NULL, NULL, 337, 185, 'assigned', '', ''),
(676, 65, '2015-04-14', 0, 16, '2015-04-13', '2015-04-13', NULL, NULL, 342, 185, 'assigned', '', ''),
(677, 65, '2015-04-14', 0, 16, '2015-04-14', '2015-04-14', NULL, NULL, 352, 185, 'assigned', '', ''),
(678, 65, '2015-04-14', 0, 48, '2015-04-14', '2015-04-14', NULL, NULL, 357, 185, 'assigned', '', ''),
(679, 65, '2015-04-14', 0, 32, '2015-04-14', '2015-04-14', NULL, NULL, 362, 185, 'assigned', '', ''),
(680, 63, '2015-04-22', 0, 100, '2015-04-14', '2015-04-20', NULL, NULL, 583, 174, 'assigned', '', ''),
(681, 74, '2015-04-29', 0, 25, '2015-04-16', '2015-04-29', NULL, NULL, 583, 177, 'assigned', '', ''),
(682, 39, '2015-04-15', 450, 19, '2015-04-15', '2015-04-20', NULL, NULL, 687, 194, 'assigned', 'Blocking Backlog requests caused by Approval Issue', NULL),
(683, 149, '2015-04-15', 0, 1, '2015-04-15', '2015-04-20', NULL, NULL, 687, NULL, 'assigned', '', ''),
(684, 149, '2015-04-15', 0, 1, '2015-03-23', '2015-04-03', NULL, NULL, 575, NULL, 'assigned', '', ''),
(685, 149, '2015-04-15', 0, 1, '2015-03-23', '2015-04-03', NULL, NULL, 576, NULL, 'assigned', '', ''),
(686, 140, '2015-04-16', 0, 1, '2015-03-23', '2015-04-03', NULL, NULL, 575, NULL, 'assigned', '', ''),
(687, 39, '2015-04-15', 264, 40, '2015-04-01', '2015-04-30', NULL, NULL, 62, NULL, 'assigned', '', ''),
(688, 75, '2015-04-15', 305, 1, '2015-04-01', '2015-04-30', NULL, NULL, 62, NULL, 'assigned', '', ''),
(689, 69, '2015-04-15', 264, 1, '2015-04-01', '2015-04-30', NULL, NULL, 62, NULL, 'assigned', '', ''),
(690, 53, '2015-04-15', 0, 100, '2015-04-22', '2015-04-22', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(691, 101, '2015-04-15', 0, 100, '2015-04-22', '2015-04-22', NULL, NULL, 73, 1, 'assigned', 'Pour consommer mon reliquat 2014/2015 - journée(s) complète(s)', ''),
(692, 101, '2015-04-15', 0, 100, '2015-04-29', '2015-04-29', NULL, NULL, 73, 1, 'assigned', 'Pour consommer mon reliquat 2014/2015 - journée(s) complète(s)', ''),
(693, 101, '2015-04-15', 0, 100, '2015-05-20', '2015-05-20', NULL, NULL, 73, 1, 'assigned', 'Pour consommer mon reliquat 2014/2015 - journée(s) complète(s)', ''),
(694, 132, '2015-04-15', 0, 100, '2015-04-13', '2015-04-17', NULL, NULL, 621, 1, 'assigned', '', ''),
(695, 74, '2015-04-15', 0, 100, '2015-04-13', '2015-04-15', NULL, NULL, 621, 1, 'assigned', '', ''),
(696, 55, '2015-04-15', 0, 100, '2015-04-13', '2015-04-14', NULL, NULL, 620, 1, 'released', '', ''),
(697, 81, '2015-04-15', 0, 100, '2015-04-13', '2015-04-14', NULL, NULL, 629, 1, 'assigned', '', ''),
(698, 81, '2015-04-15', 0, 50, '2015-04-15', '2015-04-15', NULL, NULL, 629, 1, 'assigned', '', ''),
(699, 81, '2015-04-15', 0, 25, '2015-04-15', '2015-04-15', NULL, NULL, 420, 1, 'assigned', '', ''),
(700, 81, '2015-04-15', 0, 100, '2015-04-16', '2015-04-17', NULL, NULL, 629, 1, 'assigned', '', ''),
(702, 77, '2015-04-15', 0, 50, '2015-04-13', '2015-04-13', NULL, NULL, 622, 1, 'assigned', '', ''),
(703, 77, '2015-04-15', 0, 100, '2015-04-14', '2015-04-14', NULL, NULL, 622, 1, 'assigned', '', ''),
(704, 77, '2015-04-15', 0, 100, '2015-04-15', '2015-04-15', NULL, NULL, 622, 1, 'assigned', '', ''),
(705, 77, '2015-04-15', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 622, 1, 'assigned', '', ''),
(706, 77, '2015-04-15', 0, 75, '2015-04-17', '2015-04-17', NULL, NULL, 622, 1, 'assigned', '', ''),
(707, 69, '2015-04-15', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 74, 1, 'assigned', ' - après-midi', ''),
(708, 69, '2015-04-15', 0, 100, '2015-04-17', '2015-04-17', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(709, 80, '2015-04-15', 0, 100, '2015-04-13', '2015-04-13', NULL, NULL, 677, 1, 'assigned', '', ''),
(710, 80, '2015-04-15', 0, 75, '2015-04-14', '2015-04-14', NULL, NULL, 677, 1, 'assigned', '', ''),
(711, 80, '2015-04-15', 0, 75, '2015-04-15', '2015-04-15', NULL, NULL, 677, 1, 'assigned', '', ''),
(712, 55, '2015-04-15', 0, 100, '2015-04-27', '2015-04-28', NULL, NULL, 620, 1, 'assigned', '', ''),
(713, 55, '2015-04-17', 0, 100, '2015-04-13', '2015-04-14', NULL, NULL, 620, 1, 'assigned', '', ''),
(714, 68, '2015-04-21', 0, 100, '2015-06-12', '2015-06-12', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(715, 17, '2015-04-17', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 73, 1, 'assigned', 'Validé Patrice/Philippe - après-midi', ''),
(716, 76, '2015-04-17', 0, 100, '2015-04-20', '2015-04-21', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(717, 76, '2015-04-17', 0, 50, '2015-04-22', '2015-04-23', NULL, NULL, 74, 1, 'assigned', ' - matin', ''),
(718, 76, '2015-04-17', 0, 50, '2015-04-23', '2015-04-23', NULL, NULL, 75, 1, 'assigned', 'Sans solde - après-midi', ''),
(719, 76, '2015-04-17', 0, 100, '2015-04-24', '2015-04-24', NULL, NULL, 75, 1, 'assigned', 'sans solde - journée(s) complète(s)', ''),
(720, 127, '2015-04-17', 0, 100, '2015-04-13', '2015-04-14', NULL, NULL, 218, 1, 'assigned', '', ''),
(721, 69, '2015-04-20', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 171, 1, 'assigned', '', ''),
(722, 142, '2015-04-21', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(723, 71, '2015-04-20', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 570, 1, 'assigned', '', ''),
(724, 71, '2015-04-20', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 596, 1, 'assigned', '', ''),
(725, 71, '2015-04-20', 0, 75, '2015-04-15', '2015-04-15', NULL, NULL, 596, NULL, 'assigned', '', ''),
(726, 71, '2015-04-20', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 540, 1, 'assigned', '', ''),
(727, 71, '2015-04-20', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 545, 1, 'assigned', '', ''),
(728, 72, '2015-04-20', 0, 100, '2015-04-14', '2015-04-14', NULL, NULL, 171, 1, 'assigned', '', ''),
(729, 72, '2015-04-20', 0, 100, '2015-04-15', '2015-04-15', NULL, NULL, 168, 1, 'assigned', '', ''),
(730, 139, '2015-04-20', 0, 100, '2015-04-13', '2015-04-17', NULL, NULL, 171, 1, 'assigned', '', ''),
(731, 138, '2015-04-20', 0, 100, '2015-04-13', '2015-04-13', NULL, NULL, 653, 1, 'assigned', '', ''),
(732, 138, '2015-04-20', 0, 25, '2015-04-14', '2015-04-14', NULL, NULL, 739, 1, 'assigned', '', ''),
(733, 138, '2015-04-20', 0, 100, '2015-04-15', '2015-04-16', NULL, NULL, 739, 1, 'assigned', '', ''),
(734, 138, '2015-04-20', 0, 75, '2015-04-17', '2015-04-17', NULL, NULL, 739, 1, 'assigned', '', ''),
(735, 82, '2015-04-20', 0, 25, '2015-04-13', '2015-04-13', NULL, NULL, 791, 1, 'assigned', '', ''),
(736, 82, '2015-04-20', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 791, 1, 'assigned', '', ''),
(737, 82, '2015-04-20', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 795, 1, 'assigned', '', ''),
(738, 82, '2015-04-20', 0, 50, '2015-04-15', '2015-04-15', NULL, NULL, 795, 1, 'assigned', '', ''),
(739, 82, '2015-04-20', 0, 75, '2015-04-16', '2015-04-16', NULL, NULL, 795, 1, 'assigned', '', ''),
(740, 82, '2015-04-20', 0, 100, '2015-04-17', '2015-04-17', NULL, NULL, 795, 1, 'assigned', '', ''),
(741, 79, '2015-04-20', 0, 75, '2015-04-13', '2015-04-13', NULL, NULL, 662, 1, 'assigned', '', ''),
(742, 79, '2015-04-20', 0, 75, '2015-04-14', '2015-04-14', NULL, NULL, 662, 1, 'assigned', '', ''),
(743, 79, '2015-04-20', 0, 50, '2015-04-15', '2015-04-15', NULL, NULL, 662, 1, 'assigned', '', ''),
(744, 79, '2015-04-20', 0, 75, '2015-04-16', '2015-04-16', NULL, NULL, 662, 1, 'assigned', '', ''),
(745, 79, '2015-04-20', 0, 50, '2015-04-17', '2015-04-17', NULL, NULL, 662, 1, 'assigned', '', ''),
(746, 80, '2015-04-20', 0, 25, '2015-04-16', '2015-04-16', NULL, NULL, 429, 1, 'assigned', '', ''),
(747, 80, '2015-04-20', 0, 75, '2015-04-16', '2015-04-16', NULL, NULL, 677, 1, 'assigned', '', ''),
(748, 80, '2015-04-20', 0, 75, '2015-04-17', '2015-04-17', NULL, NULL, 677, 1, 'assigned', '', ''),
(749, 80, '2015-04-20', 0, 25, '2015-04-17', '2015-04-17', NULL, NULL, 429, 1, 'assigned', '', ''),
(750, 117, '2015-04-20', 0, 100, '2015-04-15', '2015-04-15', NULL, NULL, 629, 1, 'assigned', '', ''),
(751, 117, '2015-04-20', 0, 100, '2015-04-14', '2015-04-14', NULL, NULL, 628, 1, 'assigned', '', ''),
(752, 117, '2015-04-20', 0, 100, '2015-04-16', '2015-04-17', NULL, NULL, 420, 1, 'assigned', '', ''),
(753, 81, '2015-04-20', 0, 100, '2015-04-17', '2015-04-17', NULL, NULL, 73, 1, 'assigned', 'Maux de tête - journée(s) complète(s)', ''),
(754, 73, '2015-04-21', 0, 25, '2015-04-13', '2015-04-13', NULL, NULL, 171, 1, 'assigned', '', ''),
(755, 73, '2015-04-21', 0, 25, '2015-04-14', '2015-04-14', NULL, NULL, 171, 1, 'assigned', '', ''),
(756, 73, '2015-04-21', 0, 25, '2015-04-16', '2015-04-16', NULL, NULL, 171, 1, 'assigned', '', ''),
(757, 73, '2015-04-21', 0, 25, '2015-04-17', '2015-04-17', NULL, NULL, 171, 1, 'assigned', '', ''),
(758, 73, '2015-04-21', 0, 50, '2015-04-13', '2015-04-13', NULL, NULL, 168, 1, 'assigned', '', ''),
(759, 73, '2015-04-21', 0, 50, '2015-04-14', '2015-04-14', NULL, NULL, 168, 1, 'assigned', '', ''),
(760, 73, '2015-04-21', 0, 50, '2015-04-15', '2015-04-15', NULL, NULL, 168, 1, 'assigned', '', ''),
(761, 73, '2015-04-21', 0, 50, '2015-04-16', '2015-04-16', NULL, NULL, 168, 1, 'assigned', '', ''),
(762, 73, '2015-04-21', 0, 50, '2015-04-17', '2015-04-17', NULL, NULL, 168, 1, 'assigned', '', ''),
(763, 75, '2015-04-23', 0, 50, '2015-05-12', '2015-05-12', NULL, NULL, 74, 1, 'assigned', ' - matin', ''),
(764, 75, '2015-04-23', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(765, 84, '2015-04-23', 0, 5, '2015-04-20', '2015-07-31', NULL, NULL, 822, 124, 'assigned', '', ''),
(766, 109, '2015-04-23', 0, 5, '2015-04-20', '2015-07-31', NULL, NULL, 822, 1, 'assigned', '', ''),
(767, 35, '2015-04-23', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(768, 81, '2015-04-23', 0, 25, '2015-04-20', '2015-04-21', NULL, NULL, 420, 1, 'assigned', '', ''),
(769, 81, '2015-04-23', 0, 25, '2015-04-20', '2015-04-20', NULL, NULL, 823, 1, 'assigned', 'takeover avec Marine Trentin', ''),
(770, 81, '2015-04-23', 0, 50, '2015-04-21', '2015-04-21', NULL, NULL, 629, 1, 'assigned', '', ''),
(771, 81, '2015-04-23', 0, 100, '2015-04-22', '2015-04-24', NULL, NULL, 629, 1, 'assigned', '', ''),
(772, 117, NULL, 0, 100, '2015-04-20', '2015-04-21', NULL, NULL, 629, 1, 'released', '', NULL),
(773, 117, '2015-04-23', 0, 100, '2015-04-20', '2015-04-21', NULL, NULL, 550, 1, 'assigned', '', ''),
(774, 117, '2015-04-23', 0, 75, '2015-04-22', '2015-04-22', NULL, NULL, 628, 1, 'assigned', '', ''),
(775, 117, '2015-04-23', 0, 25, '2015-04-22', '2015-04-22', NULL, NULL, 420, 1, 'assigned', '', ''),
(776, 74, '2015-04-23', 0, 25, '2015-04-20', '2015-04-20', NULL, NULL, 605, 177, 'assigned', '', ''),
(777, 24, '2015-04-23', 0, 100, '2015-07-23', '2015-07-28', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(778, 137, '2015-04-23', 0, 100, '2015-04-13', '2015-04-17', NULL, NULL, 853, 1, 'assigned', '', ''),
(779, 137, '2015-04-23', 0, 100, '2015-04-20', '2015-04-21', NULL, NULL, 853, 1, 'assigned', '', ''),
(780, 137, '2015-04-23', 0, 50, '2015-04-22', '2015-04-22', NULL, NULL, 853, 1, 'assigned', '', ''),
(781, 137, '2015-04-23', 0, 75, '2015-04-07', '2015-04-07', NULL, NULL, 853, 1, 'assigned', '', ''),
(782, 137, '2015-04-23', 0, 100, '2015-04-08', '2015-04-10', NULL, NULL, 853, 1, 'assigned', '', ''),
(783, 68, NULL, 264, 40, '2015-04-01', '2015-04-30', NULL, NULL, 559, 72, 'released', '', NULL),
(784, 101, NULL, 0, 5, '2015-04-01', '2015-04-30', NULL, NULL, 559, 5, 'released', '', NULL),
(785, 80, '2015-04-24', 0, 95, '2015-04-20', '2015-04-24', NULL, NULL, 857, 1, 'assigned', '', ''),
(786, 68, '2015-04-24', 0, 40, '2015-04-01', '2015-04-30', NULL, NULL, 559, 84, 'assigned', '', ''),
(787, 71, '2015-04-23', 0, 50, '2015-04-21', '2015-04-21', NULL, NULL, 834, 1, 'assigned', '', ''),
(788, 71, '2015-04-23', 0, 50, '2015-04-21', '2015-04-21', NULL, NULL, 781, 1, 'assigned', '', ''),
(789, 71, '2015-04-23', 0, 100, '2015-04-22', '2015-04-22', NULL, NULL, 781, 1, 'assigned', '', ''),
(790, 71, '2015-04-23', 0, 50, '2015-04-23', '2015-04-23', NULL, NULL, 776, 1, 'assigned', '', ''),
(791, 70, '2015-04-23', 0, 50, '2015-04-20', '2015-04-20', NULL, NULL, 168, 1, 'assigned', '', ''),
(792, 72, '2015-04-23', 0, 100, '2015-04-20', '2015-04-20', NULL, NULL, 171, 1, 'assigned', '', ''),
(793, 70, '2015-04-23', 0, 50, '2015-04-20', '2015-04-20', NULL, NULL, 593, 1, 'assigned', '', ''),
(794, 70, '2015-04-23', 0, 25, '2015-04-24', '2015-04-24', NULL, NULL, 836, 1, 'assigned', '', ''),
(795, 70, '2015-04-23', 0, 75, '2015-04-24', '2015-04-24', NULL, NULL, 833, 1, 'assigned', '', ''),
(796, 65, '2015-04-24', 0, 100, '2015-04-23', '2015-04-23', NULL, NULL, 312, 1, 'assigned', '', ''),
(797, 65, '2015-04-24', 0, 76, '2015-04-24', '2015-04-24', NULL, NULL, 312, 1, 'assigned', '', ''),
(798, 65, '2015-04-24', 0, 32, '2015-04-24', '2015-04-24', NULL, NULL, 304, 1, 'assigned', '', ''),
(799, 64, '2015-04-24', 0, 100, '2015-04-20', '2015-04-20', NULL, NULL, 316, 1, 'assigned', '', ''),
(800, 64, '2015-04-24', 0, 100, '2015-04-21', '2015-04-21', NULL, NULL, 503, 1, 'assigned', '', ''),
(801, 64, '2015-04-24', 0, 44, '2015-04-22', '2015-04-22', NULL, NULL, 503, 1, 'assigned', '', ''),
(802, 127, '2015-04-24', 0, 100, '2015-04-27', '2015-04-30', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(803, 64, '2015-04-24', 0, 56, '2015-04-22', '2015-04-22', NULL, NULL, 667, 1, 'assigned', '', ''),
(804, 69, '2015-04-24', 0, 75, '2015-04-14', '2015-04-14', NULL, NULL, 184, 1, 'assigned', '', ''),
(805, 69, '2015-04-24', 0, 100, '2015-04-20', '2015-04-20', NULL, NULL, 184, 1, 'assigned', '', ''),
(806, 69, '2015-04-24', 0, 100, '2015-04-21', '2015-04-22', NULL, NULL, 171, 1, 'assigned', '', ''),
(807, 69, '2015-04-24', 0, 100, '2015-04-23', '2015-04-24', NULL, NULL, 168, 1, 'assigned', '', ''),
(808, 71, '2015-04-24', 0, 100, '2015-04-20', '2015-04-20', NULL, NULL, 591, 1, 'assigned', '', ''),
(809, 24, '2015-04-23', 0, 30, '2015-04-24', '2015-05-07', NULL, NULL, 859, 7, 'assigned', '', ''),
(810, 24, '2015-04-27', 0, 30, '2015-05-18', '2015-05-28', NULL, NULL, 859, 7, 'assigned', '', ''),
(811, 46, '2015-04-27', 0, 30, '2015-04-27', '2015-05-28', NULL, NULL, 859, 6, 'assigned', '', ''),
(812, 72, '2015-04-24', 0, 100, '2015-04-24', '2015-04-24', NULL, NULL, 168, 1, 'assigned', '', ''),
(813, 139, '2015-04-24', 0, 100, '2015-04-20', '2015-04-24', NULL, NULL, 171, 1, 'assigned', '', ''),
(814, 73, '2015-04-24', 0, 25, '2015-04-20', '2015-04-20', NULL, NULL, 171, 1, 'assigned', '', ''),
(815, 73, '2015-04-24', 0, 50, '2015-04-21', '2015-04-21', NULL, NULL, 171, 1, 'assigned', '', ''),
(816, 73, '2015-04-24', 0, 25, '2015-04-23', '2015-04-23', NULL, NULL, 171, 1, 'assigned', '', ''),
(817, 73, '2015-04-24', 0, 25, '2015-04-24', '2015-04-24', NULL, NULL, 171, 1, 'assigned', '', ''),
(818, 73, '2015-04-24', 0, 50, '2015-04-20', '2015-04-20', NULL, NULL, 168, 1, 'assigned', '', ''),
(819, 73, '2015-04-24', 0, 25, '2015-04-21', '2015-04-21', NULL, NULL, 168, 1, 'assigned', '', ''),
(820, 73, '2015-04-24', 0, 25, '2015-04-22', '2015-04-22', NULL, NULL, 168, 1, 'assigned', '', ''),
(821, 73, '2015-04-24', 0, 25, '2015-04-23', '2015-04-24', NULL, NULL, 168, 1, 'assigned', '', ''),
(822, 70, '2015-04-24', 0, 100, '2015-04-21', '2015-04-23', NULL, NULL, 771, 1, 'assigned', '', ''),
(823, 72, '2015-04-24', 0, 100, '2015-04-22', '2015-04-23', NULL, NULL, 847, 1, 'assigned', '', ''),
(824, 150, '2015-04-24', 190, 100, '2015-04-21', '2015-04-21', NULL, NULL, 49, 1, 'assigned', '', ''),
(825, 64, NULL, 0, 20, '2015-03-30', '2015-12-31', NULL, NULL, 169, 1, 'released', '', NULL),
(826, 64, '2015-04-24', 0, 20, '2015-03-30', '2015-12-31', NULL, NULL, 168, 1, 'assigned', '', ''),
(827, 64, '2015-04-24', 0, 20, '2015-03-30', '2015-12-31', NULL, NULL, 172, 1, 'assigned', '', ''),
(828, 72, '2015-04-24', 0, 75, '2015-04-21', '2015-04-21', NULL, NULL, 863, 1, 'assigned', '', ''),
(829, 72, '2015-04-24', 0, 25, '2015-04-21', '2015-04-21', NULL, NULL, 864, 1, 'assigned', '', ''),
(830, 74, '2015-04-24', 0, 60, '2015-04-20', '2015-04-24', NULL, NULL, 743, 180, 'assigned', 'Sprint 2 semaine 1', ''),
(831, 132, '2015-04-24', 0, 100, '2015-04-20', '2015-04-24', NULL, NULL, 743, 142, 'assigned', '', 'spint 2 semaine 1'),
(832, 82, '2015-04-27', 0, 25, '2015-04-20', '2015-04-20', NULL, NULL, 853, 1, 'assigned', '', ''),
(833, 137, '2015-04-27', 0, 100, '2015-04-30', '2015-05-04', NULL, NULL, 74, 1, 'assigned', '2Jrs - journée(s) complète(s)', ''),
(834, 82, '2015-04-27', 0, 75, '2015-04-20', '2015-04-20', NULL, NULL, 873, 1, 'assigned', '', ''),
(835, 82, '2015-04-27', 0, 50, '2015-04-21', '2015-04-21', NULL, NULL, 881, 1, 'assigned', '', ''),
(836, 82, '2015-04-27', 0, 50, '2015-04-21', '2015-04-21', NULL, NULL, 791, 1, 'assigned', '', ''),
(837, 82, '2015-04-27', 0, 50, '2015-04-22', '2015-04-22', NULL, NULL, 885, 1, 'assigned', '', ''),
(838, 82, '2015-04-27', 0, 75, '2015-04-23', '2015-04-24', NULL, NULL, 877, 1, 'assigned', '', ''),
(839, 79, '2015-04-27', 0, 100, '2015-04-22', '2015-04-24', NULL, NULL, 662, 1, 'assigned', '', ''),
(840, 138, '2015-04-27', 0, 100, '2015-04-20', '2015-04-23', NULL, NULL, 739, 1, 'assigned', '', ''),
(841, 138, '2015-04-27', 0, 75, '2015-04-24', '2015-04-24', NULL, NULL, 648, 1, 'assigned', '', ''),
(842, 55, '2015-04-27', 0, 60, '2015-04-27', '2015-05-29', NULL, NULL, 859, 1, 'assigned', '', ''),
(843, 74, '2015-04-27', 0, 100, '2015-05-13', '2015-05-15', NULL, NULL, 73, 1, 'assigned', '2 - journée(s) complète(s)', ''),
(844, 70, '2015-04-27', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(845, 66, '2015-04-27', 0, 100, '2015-07-13', '2015-07-13', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(846, 151, '2015-04-27', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 910, 1, 'assigned', '', ''),
(847, 84, '2015-04-27', 0, 67, '2015-04-28', '2015-04-30', NULL, NULL, 912, 124, 'assigned', '', ''),
(848, 151, '2015-04-27', 0, 67, '2015-04-28', '2015-04-30', NULL, NULL, 911, 1, 'assigned', '', ''),
(849, 151, '2015-04-27', 0, 33, '2015-04-28', '2015-04-30', NULL, NULL, 913, 1, 'assigned', '', ''),
(850, 151, '2015-04-27', 0, 100, '2015-05-04', '2015-06-30', NULL, NULL, 913, 1, 'assigned', '', ''),
(851, 65, '2015-04-27', 0, 25, '2015-04-27', '2015-04-27', NULL, NULL, 910, 185, 'assigned', '', ''),
(852, 74, '2015-04-29', 0, 100, '2015-04-27', '2015-04-29', NULL, NULL, 743, 1, 'assigned', '', ''),
(853, 132, '2015-04-29', 0, 100, '2015-04-27', '2015-04-30', NULL, NULL, 743, 1, 'assigned', '', ''),
(854, 132, '2015-04-29', 0, 100, '2015-05-04', '2015-05-06', NULL, NULL, 73, 1, 'assigned', 'Examens école - journée(s) complète(s)', ''),
(855, 81, '2015-04-29', 0, 100, '2015-04-27', '2015-04-30', NULL, NULL, 629, 1, 'assigned', '', ''),
(856, 72, '2015-04-29', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 168, 1, 'assigned', '', ''),
(857, 72, '2015-04-29', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 171, 1, 'assigned', '', ''),
(858, 72, '2015-04-29', 0, 75, '2015-04-29', '2015-04-29', NULL, NULL, 171, 1, 'assigned', '', ''),
(859, 72, '2015-04-29', 0, 25, '2015-04-29', '2015-04-29', NULL, NULL, 847, 1, 'assigned', '', ''),
(860, 70, '2015-04-29', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 590, 1, 'assigned', '', ''),
(861, 70, '2015-04-29', 0, 50, '2015-04-28', '2015-04-28', NULL, NULL, 590, 1, 'assigned', '', ''),
(862, 70, '2015-04-29', 0, 50, '2015-04-28', '2015-04-28', NULL, NULL, 780, 1, 'assigned', '', ''),
(863, 70, '2015-04-29', 0, 100, '2015-04-29', '2015-04-29', NULL, NULL, 780, 1, 'assigned', '', ''),
(864, 70, '2015-04-29', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 775, 1, 'assigned', '', ''),
(865, 71, '2015-04-29', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 776, 1, 'assigned', '', ''),
(866, 65, '2015-04-29', 0, 38, '2015-04-28', '2015-04-28', NULL, NULL, 782, 1, 'assigned', '', ''),
(867, 65, '2015-04-29', 0, 38, '2015-04-28', '2015-04-28', NULL, NULL, 777, 1, 'assigned', '', ''),
(868, 55, '2015-04-29', 0, 100, '2015-04-22', '2015-04-24', NULL, NULL, 81, 1, 'assigned', '', ''),
(869, 65, '2015-04-29', 0, 32, '2015-04-27', '2015-04-27', NULL, NULL, 527, 1, 'assigned', '', ''),
(870, 65, '2015-04-29', 0, 24, '2015-04-28', '2015-04-28', NULL, NULL, 523, 185, 'assigned', '', ''),
(871, 65, '2015-04-29', 0, 32, '2015-04-30', '2015-04-30', NULL, NULL, 519, 185, 'assigned', '', ''),
(872, 65, '2015-04-29', 0, 16, '2015-04-30', '2015-04-30', NULL, NULL, 511, 185, 'assigned', '', ''),
(873, 137, '2015-04-29', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 853, 1, 'assigned', '', ''),
(874, 80, '2015-04-29', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 857, 1, 'assigned', '', ''),
(875, 69, '2015-04-29', 0, 100, '2015-04-30', '2015-05-04', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(876, 71, '2015-04-29', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 73, 1, 'assigned', ' - journée(s) complète(s)', ''),
(877, 73, '2015-04-29', 0, 50, '2015-04-27', '2015-04-27', NULL, NULL, 168, 1, 'assigned', '', ''),
(878, 73, '2015-04-29', 0, 25, '2015-04-28', '2015-04-30', NULL, NULL, 168, 1, 'assigned', '', ''),
(879, 73, '2015-04-29', 0, 25, '2015-04-27', '2015-04-30', NULL, NULL, 171, 1, 'assigned', '', ''),
(880, 101, '2015-04-28', 0, 25, '2015-04-27', '2015-04-27', NULL, NULL, 585, 5, 'assigned', '', ''),
(881, 64, '2015-04-29', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 535, 1, 'assigned', '', ''),
(882, 64, '2015-04-29', 0, 50, '2015-04-29', '2015-04-29', NULL, NULL, 535, 1, 'assigned', '', ''),
(883, 53, '2015-04-29', 0, 10, '2015-05-04', '2015-05-07', NULL, NULL, 859, 5, 'assigned', '', ''),
(884, 102, '2015-04-29', 0, 10, '2015-05-04', '2015-05-07', NULL, NULL, 859, 5, 'assigned', '', ''),
(885, 101, '2015-04-29', 0, 10, '2015-05-04', '2015-05-07', NULL, NULL, 859, 5, 'assigned', '', ''),
(886, 67, '2015-04-29', 0, 5, '2015-04-28', '2015-04-29', NULL, NULL, 859, 162, 'assigned', '', ''),
(887, 77, '2015-04-29', 0, 5, '2015-04-28', '2015-04-29', NULL, NULL, 859, 1, 'assigned', '', ''),
(888, 68, '2015-04-29', 0, 5, '2015-04-29', '2015-04-29', NULL, NULL, 859, 1, 'assigned', '', ''),
(889, 24, '2015-04-29', 0, 50, '2015-04-28', '2015-04-28', NULL, NULL, 917, 7, 'assigned', '', ''),
(890, 46, '2015-04-29', 0, 50, '2015-04-28', '2015-04-28', NULL, NULL, 917, 6, 'assigned', '', ''),
(891, 117, '2015-04-29', 0, 100, '2015-04-27', '2015-04-28', NULL, NULL, 550, 1, 'assigned', '', ''),
(892, 117, '2015-04-29', 0, 100, '2015-04-29', '2015-04-30', NULL, NULL, 549, 1, 'assigned', '', ''),
(893, 137, '2015-04-30', 0, 100, '2015-04-28', '2015-04-28', NULL, NULL, 849, 1, 'assigned', 'take over', ''),
(894, 73, '2015-04-30', 0, 50, '2015-05-04', '2015-05-29', NULL, NULL, 205, 1, 'assigned', '', ''),
(895, 17, '2015-04-30', 0, 25, '2015-05-04', '2015-05-07', NULL, NULL, 205, 1, 'assigned', '', ''),
(896, 17, '2015-04-30', 0, 100, '2015-05-19', '2015-05-29', NULL, NULL, 205, 1, 'assigned', '', ''),
(897, 127, '2015-04-30', 0, 100, '2015-05-04', '2015-05-15', NULL, NULL, 205, 1, 'assigned', '', ''),
(898, 129, '2015-04-30', 0, 40, '2015-05-04', '2015-05-18', NULL, NULL, 214, 1, 'assigned', '', ''),
(899, 46, '2015-04-30', 0, 5, '2015-05-04', '2015-05-29', NULL, NULL, 914, 6, 'assigned', '', ''),
(900, 46, '2015-04-30', 0, 5, '2015-06-01', '2015-06-30', NULL, NULL, 915, 6, 'assigned', '', ''),
(901, 109, '2015-04-30', 0, 50, '2015-05-04', '2015-05-29', NULL, NULL, 914, 5, 'assigned', '', ''),
(902, 109, '2015-04-30', 0, 50, '2015-06-01', '2015-06-30', NULL, NULL, 915, 5, 'assigned', '', ''),
(903, 17, '2015-04-30', 0, 20, '2015-05-04', '2015-05-29', NULL, NULL, 914, 1, 'assigned', '', ''),
(904, 17, '2015-04-30', 0, 20, '2015-06-01', '2015-06-30', NULL, NULL, 915, 1, 'assigned', '', ''),
(905, 17, '2015-04-30', 0, 20, '2015-05-04', '2015-05-29', NULL, NULL, 219, 1, 'assigned', '', ''),
(906, 17, '2015-04-30', 0, 20, '2015-06-01', '2015-06-30', NULL, NULL, 220, 1, 'assigned', '', ''),
(907, 39, '2015-04-30', 0, 0, '2015-04-27', '2015-06-30', NULL, NULL, 916, NULL, 'assigned', '', ''),
(908, 138, '2015-04-30', 0, 100, '2015-04-27', '2015-04-27', NULL, NULL, 648, 1, 'assigned', '', ''),
(909, 138, '2015-04-30', 0, 75, '2015-04-28', '2015-04-28', NULL, NULL, 648, 1, 'assigned', '', ''),
(910, 138, '2015-04-30', 0, 25, '2015-04-28', '2015-04-28', NULL, NULL, 714, NULL, 'assigned', '', ''),
(911, 138, '2015-04-30', 0, 75, '2015-04-29', '2015-04-29', NULL, NULL, 714, 1, 'assigned', '', ''),
(912, 138, '2015-04-30', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 714, 1, 'assigned', '', ''),
(913, 77, '2015-04-29', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 622, 1, 'assigned', 'study', ''),
(914, 82, '2015-04-29', 0, 50, '2015-04-27', '2015-04-27', NULL, NULL, 881, 1, 'assigned', '', ''),
(915, 82, '2015-04-29', 0, 50, '2015-04-27', '2015-04-28', NULL, NULL, 791, 1, 'assigned', '', ''),
(916, 109, '2015-04-30', 0, 100, '2015-05-15', '2015-05-15', NULL, NULL, 74, 1, 'assigned', ' - journée(s) complète(s)', ''),
(917, 77, '2015-04-29', 0, 100, '2015-04-29', '2015-04-29', NULL, NULL, 938, 1, 'assigned', '', ''),
(918, 79, '2015-04-29', 0, 100, '2015-04-27', '2015-04-28', NULL, NULL, 662, 1, 'assigned', '', ''),
(919, 79, '2015-04-29', 0, 50, '2015-04-29', '2015-04-29', NULL, NULL, 662, 1, 'assigned', '', ''),
(920, 79, '2015-04-29', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 662, 1, 'assigned', '', ''),
(921, 69, '2015-04-29', 0, 50, '2015-04-29', '2015-04-29', NULL, NULL, 171, 1, 'assigned', '', ''),
(922, 69, '2015-04-29', 0, 50, '2015-04-29', '2015-04-29', NULL, NULL, 168, 1, 'assigned', '', ''),
(923, 137, '2015-04-30', 0, 100, '2015-04-30', '2015-04-30', NULL, NULL, 73, 1, 'assigned', '', ''),
(924, 137, '2015-04-30', 0, 100, '2015-05-04', '2015-05-04', NULL, NULL, 73, 1, 'assigned', '', ''),
(925, 68, '2015-04-30', 0, 100, '2015-05-11', '2015-05-11', NULL, NULL, 73, 1, 'assigned', 'vacances - journée(s) complète(s)', ''),
(926, 72, NULL, 0, 100, '2015-05-11', '2015-05-18', NULL, NULL, 73, 1, 'preassigned', 'Validé avec P. CONTESSE - journée(s) complète(s)', NULL),
(927, 139, NULL, 0, 100, '2015-04-27', '2015-04-30', NULL, NULL, 171, 1, 'preassigned', '', NULL),
(928, 39, '2015-04-30', 0, 1, '2015-04-24', '2015-06-30', NULL, NULL, 860, NULL, 'assigned', '', ''),
(929, 68, '2015-04-30', 0, 1, '2015-04-22', '2015-06-30', NULL, NULL, 916, NULL, 'assigned', '', ''),
(930, 68, '2015-04-30', 0, 1, '2015-04-24', '2015-06-30', NULL, NULL, 860, NULL, 'assigned', '', ''),
(931, 39, '2015-04-30', 0, 1, '2015-04-28', '2015-06-30', NULL, NULL, 964, NULL, 'assigned', '', ''),
(932, 39, '2015-04-30', 0, 1, '2015-04-29', '2015-06-30', NULL, NULL, 966, NULL, 'assigned', '', ''),
(933, 68, '2015-04-30', 0, 1, '2015-04-28', '2015-06-30', NULL, NULL, 964, NULL, 'assigned', '', ''),
(934, 68, '2015-04-30', 0, 1, '2015-04-29', '2015-06-30', NULL, NULL, 966, NULL, 'assigned', '', ''),
(935, 140, NULL, 0, 100, '2015-04-07', '2015-04-07', NULL, NULL, 898, 1, 'preassigned', '', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `timesheet`
--

DROP TABLE IF EXISTS `timesheet`;
CREATE TABLE IF NOT EXISTS `timesheet` (
`idTimeSheet` int(10) unsigned NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idActivity` int(11) DEFAULT NULL,
  `idOperation` int(11) DEFAULT NULL,
  `initDate` date NOT NULL,
  `endDate` date NOT NULL,
  `status` varchar(10) DEFAULT NULL,
  `hoursDay1` double DEFAULT NULL,
  `hoursDay2` double DEFAULT NULL,
  `hoursDay3` double DEFAULT NULL,
  `hoursDay4` double DEFAULT NULL,
  `hoursDay5` double DEFAULT NULL,
  `hoursDay6` double DEFAULT NULL,
  `hoursDay7` double DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=2570 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `timesheet`
--

INSERT INTO `timesheet` (`idTimeSheet`, `idEmployee`, `idActivity`, `idOperation`, `initDate`, `endDate`, `status`, `hoursDay1`, `hoursDay2`, `hoursDay3`, `hoursDay4`, `hoursDay5`, `hoursDay6`, `hoursDay7`) VALUES
(15, 24, 13, NULL, '2014-11-17', '2014-11-23', 'app0', NULL, NULL, NULL, NULL, 7.5, NULL, NULL),
(16, 24, 13, NULL, '2014-11-24', '2014-11-30', 'app0', 7.5, 7.5, 7.5, 7.5, 7.5, NULL, NULL),
(17, 24, 13, NULL, '2014-12-01', '2014-12-07', 'app3', 7.5, 7.5, 7.5, 7.5, 7.5, NULL, NULL),
(18, 24, 13, NULL, '2014-12-08', '2014-12-14', 'app3', 7.5, 7.5, 7.5, 7.5, 7.5, NULL, NULL),
(19, 24, 13, NULL, '2014-12-15', '2014-12-21', 'app3', 7.5, 7.5, 7.5, 7.5, 7.5, NULL, NULL),
(20, 24, 13, NULL, '2014-12-22', '2014-12-28', 'app3', 7, 7, 4, NULL, NULL, NULL, NULL),
(21, 24, 13, NULL, '2014-12-29', '2015-01-04', 'app3', 7.5, 7.5, 7.5, NULL, NULL, NULL, NULL),
(22, 46, 12, NULL, '2014-11-17', '2014-11-23', 'app3', NULL, NULL, NULL, NULL, 3.75, NULL, NULL),
(23, 46, 12, NULL, '2014-11-24', '2014-11-30', 'app3', 3.75, 3.75, 3.75, 3.75, 3.75, NULL, NULL),
(24, 46, 12, NULL, '2014-12-01', '2014-12-07', 'app3', 3.75, 3.75, 3.75, 3.75, 3.75, NULL, NULL),
(25, 46, 12, NULL, '2014-12-08', '2014-12-14', 'app3', 3.75, 3.75, 3.75, 3.75, 3.75, NULL, NULL),
(26, 46, 12, NULL, '2014-12-15', '2014-12-21', 'app3', 3.75, 3.75, 3.75, 3.75, 3.75, NULL, NULL),
(27, 46, 12, NULL, '2014-12-22', '2014-12-28', 'app3', 3.75, 3.75, 3.75, 3.75, NULL, NULL, NULL),
(28, 46, 12, NULL, '2014-12-29', '2015-01-04', 'app3', 3.75, 3.75, 3.75, NULL, NULL, NULL, NULL),
(29, 35, 40, NULL, '2014-12-01', '2014-12-07', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(30, 35, 40, NULL, '2014-12-08', '2014-12-14', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(31, 35, 40, NULL, '2014-12-15', '2014-12-21', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(32, 35, 40, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(33, 96, 43, NULL, '2014-12-15', '2014-12-21', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(34, 96, 43, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(35, 96, 42, NULL, '2014-12-08', '2014-12-14', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(36, 96, 42, NULL, '2014-12-15', '2014-12-21', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(37, 35, 38, NULL, '2014-12-01', '2014-12-07', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(38, 96, 38, NULL, '2014-12-01', '2014-12-07', 'app3', 8, 10, NULL, NULL, NULL, NULL, NULL),
(39, 35, 46, NULL, '2015-01-05', '2015-01-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(40, 35, 46, NULL, '2015-01-12', '2015-01-18', 'app0', 0.8, 0.8, NULL, NULL, NULL, NULL, NULL),
(41, 35, 47, NULL, '2015-01-05', '2015-01-11', 'app0', NULL, NULL, NULL, 0.8, 0.8, NULL, NULL),
(42, 35, 47, NULL, '2015-01-12', '2015-01-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(43, 35, 47, NULL, '2015-01-19', '2015-01-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(44, 35, 48, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(45, 24, 32, NULL, '2014-12-01', '2014-12-07', 'app3', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(46, 24, 32, NULL, '2014-12-08', '2014-12-14', 'app3', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(47, 24, 80, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(48, 24, 80, NULL, '2015-01-05', '2015-01-11', 'app3', 8, 10, 8, 12, 10, NULL, NULL),
(49, 24, 80, NULL, '2015-01-12', '2015-01-18', 'app3', 10, 6, 8, 10, 8, NULL, NULL),
(50, 24, 80, NULL, '2015-01-19', '2015-01-25', 'app3', 6, 7, 8, 10, 8, NULL, NULL),
(51, 24, 80, NULL, '2015-01-26', '2015-02-01', 'app3', 10, 12, 6, 8, 6, NULL, NULL),
(52, 24, 80, NULL, '2015-02-02', '2015-02-08', 'app3', 5, 7, 11, 8, 9, NULL, NULL),
(53, 24, 80, NULL, '2015-02-09', '2015-02-15', 'app3', 10, 13, 13, 7, 10, NULL, NULL),
(54, 24, 80, NULL, '2015-02-16', '2015-02-22', 'app3', 11, 13, 10, 12.5, 10, NULL, NULL),
(55, 24, 80, NULL, '2015-02-23', '2015-03-01', 'app3', 11.5, 5, 8, 8, 8, NULL, NULL),
(56, 24, 80, NULL, '2015-03-02', '2015-03-08', 'app3', 11, 3.5, 12, 12, 10, NULL, NULL),
(57, 24, 80, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 2, 10.5, 8, 8, NULL, NULL),
(58, 24, 80, NULL, '2015-03-16', '2015-03-22', 'app3', 5.5, 8, 8, 7, 9, NULL, NULL),
(59, 24, 80, NULL, '2015-03-23', '2015-03-29', 'app3', 9, 9.5, 8, 8.5, 8, NULL, NULL),
(60, 24, 80, NULL, '2015-03-30', '2015-04-05', 'app3', 8, 8.5, 11, 11.5, 10, NULL, NULL),
(61, 24, 80, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, 8, 11.5, 11, NULL, NULL),
(62, 24, 80, NULL, '2015-04-13', '2015-04-19', 'app3', 10, 10.5, 11, 11.5, 10, NULL, NULL),
(63, 24, 80, NULL, '2015-04-20', '2015-04-26', 'app3', 11, 11, 11, 10, 6, NULL, NULL),
(64, 24, 80, NULL, '2015-04-27', '2015-05-03', 'app3', 4.5, 5.5, 8, 5, NULL, NULL, NULL),
(65, 24, 80, NULL, '2015-05-04', '2015-05-10', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(66, 24, 80, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(67, 24, 80, NULL, '2015-05-18', '2015-05-24', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(68, 24, 80, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(69, 24, 80, NULL, '2015-06-01', '2015-06-07', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(70, 24, 80, NULL, '2015-06-08', '2015-06-14', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(71, 24, 80, NULL, '2015-06-15', '2015-06-21', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(72, 24, 80, NULL, '2015-06-22', '2015-06-28', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(73, 24, 80, NULL, '2015-06-29', '2015-07-05', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(74, 24, 80, NULL, '2015-07-06', '2015-07-12', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(75, 24, 80, NULL, '2015-07-13', '2015-07-19', 'app0', 8, NULL, 8, 8, 8, NULL, NULL),
(76, 24, 80, NULL, '2015-07-20', '2015-07-26', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(77, 24, 80, NULL, '2015-07-27', '2015-08-02', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(78, 24, 80, NULL, '2015-08-03', '2015-08-09', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(79, 24, 80, NULL, '2015-08-10', '2015-08-16', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(80, 24, 80, NULL, '2015-08-17', '2015-08-23', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(81, 24, 80, NULL, '2015-08-24', '2015-08-30', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(82, 24, 80, NULL, '2015-08-31', '2015-09-06', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(83, 24, 80, NULL, '2015-09-07', '2015-09-13', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(84, 24, 80, NULL, '2015-09-14', '2015-09-20', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(85, 24, 80, NULL, '2015-09-21', '2015-09-27', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(86, 24, 80, NULL, '2015-09-28', '2015-10-04', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(87, 24, 80, NULL, '2015-10-05', '2015-10-11', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(88, 24, 80, NULL, '2015-10-12', '2015-10-18', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(89, 24, 80, NULL, '2015-10-19', '2015-10-25', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(90, 24, 80, NULL, '2015-10-26', '2015-11-01', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(91, 24, 80, NULL, '2015-11-02', '2015-11-08', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(92, 24, 80, NULL, '2015-11-09', '2015-11-15', 'app0', 8, 8, NULL, 8, 8, NULL, NULL),
(93, 24, 80, NULL, '2015-11-16', '2015-11-22', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(94, 24, 80, NULL, '2015-11-23', '2015-11-29', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(95, 24, 80, NULL, '2015-11-30', '2015-12-06', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(96, 24, 80, NULL, '2015-12-07', '2015-12-13', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(97, 24, 80, NULL, '2015-12-14', '2015-12-20', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(98, 24, 80, NULL, '2015-12-21', '2015-12-27', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(99, 24, 80, NULL, '2015-12-28', '2016-01-03', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(100, 46, 80, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(101, 46, 80, NULL, '2015-01-05', '2015-01-11', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(102, 46, 80, NULL, '2015-01-12', '2015-01-18', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(103, 46, 80, NULL, '2015-01-19', '2015-01-25', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(104, 46, 80, NULL, '2015-01-26', '2015-02-01', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(105, 46, 80, NULL, '2015-02-02', '2015-02-08', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(106, 46, 80, NULL, '2015-02-09', '2015-02-15', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(107, 46, 80, NULL, '2015-02-16', '2015-02-22', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(108, 46, 80, NULL, '2015-02-23', '2015-03-01', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(109, 46, 80, NULL, '2015-03-02', '2015-03-08', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(110, 46, 80, NULL, '2015-03-09', '2015-03-15', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(111, 46, 80, NULL, '2015-03-16', '2015-03-22', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(112, 46, 80, NULL, '2015-03-23', '2015-03-29', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(113, 46, 80, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(114, 46, 80, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, 4, 4, 4, NULL, NULL),
(115, 46, 80, NULL, '2015-04-13', '2015-04-19', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(116, 46, 80, NULL, '2015-04-20', '2015-04-26', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(117, 46, 80, NULL, '2015-04-27', '2015-05-03', 'app1', 4, 4, 4, 4, NULL, NULL, NULL),
(118, 46, 80, NULL, '2015-05-04', '2015-05-10', 'app0', 4, 4, 4, 4, NULL, NULL, NULL),
(119, 46, 80, NULL, '2015-05-11', '2015-05-17', 'app0', 4, 4, 4, NULL, 4, NULL, NULL),
(120, 46, 80, NULL, '2015-05-18', '2015-05-24', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(121, 46, 80, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 4, 4, 4, 4, NULL, NULL),
(122, 46, 80, NULL, '2015-06-01', '2015-06-07', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(123, 46, 80, NULL, '2015-06-08', '2015-06-14', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(124, 46, 80, NULL, '2015-06-15', '2015-06-21', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(125, 46, 80, NULL, '2015-06-22', '2015-06-28', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(126, 46, 80, NULL, '2015-06-29', '2015-07-05', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(127, 46, 80, NULL, '2015-07-06', '2015-07-12', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(128, 46, 80, NULL, '2015-07-13', '2015-07-19', 'app0', 4, NULL, 4, 4, 4, NULL, NULL),
(129, 46, 80, NULL, '2015-07-20', '2015-07-26', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(130, 46, 80, NULL, '2015-07-27', '2015-08-02', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(131, 46, 80, NULL, '2015-08-03', '2015-08-09', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(132, 46, 80, NULL, '2015-08-10', '2015-08-16', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(133, 46, 80, NULL, '2015-08-17', '2015-08-23', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(134, 46, 80, NULL, '2015-08-24', '2015-08-30', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(135, 46, 80, NULL, '2015-08-31', '2015-09-06', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(136, 46, 80, NULL, '2015-09-07', '2015-09-13', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(137, 46, 80, NULL, '2015-09-14', '2015-09-20', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(138, 46, 80, NULL, '2015-09-21', '2015-09-27', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(139, 46, 80, NULL, '2015-09-28', '2015-10-04', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(140, 46, 80, NULL, '2015-10-05', '2015-10-11', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(141, 46, 80, NULL, '2015-10-12', '2015-10-18', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(142, 46, 80, NULL, '2015-10-19', '2015-10-25', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(143, 46, 80, NULL, '2015-10-26', '2015-11-01', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(144, 46, 80, NULL, '2015-11-02', '2015-11-08', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(145, 46, 80, NULL, '2015-11-09', '2015-11-15', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(146, 46, 80, NULL, '2015-11-16', '2015-11-22', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(147, 46, 80, NULL, '2015-11-23', '2015-11-29', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(148, 46, 80, NULL, '2015-11-30', '2015-12-06', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(149, 46, 80, NULL, '2015-12-07', '2015-12-13', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(150, 46, 80, NULL, '2015-12-14', '2015-12-20', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(151, 46, 80, NULL, '2015-12-21', '2015-12-27', 'app0', 4, 4, 4, NULL, NULL, NULL, NULL),
(152, 46, 80, NULL, '2015-12-28', '2016-01-03', 'app0', 4, 4, 4, 4, NULL, NULL, NULL),
(155, 101, 74, NULL, '2015-01-05', '2015-01-11', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(156, 102, 17, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(157, 75, 17, NULL, '2014-12-22', '2014-12-28', 'app0', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(165, 69, 73, NULL, '2015-01-05', '2015-01-11', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(168, 79, 73, NULL, '2015-01-05', '2015-01-11', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(169, 17, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(170, 39, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(171, 39, 16, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(172, 68, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(173, 68, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(174, 73, 16, NULL, '2014-12-15', '2014-12-21', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(175, 73, 16, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(176, 74, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(177, 75, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(178, 53, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(179, 63, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(180, 63, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(181, 66, 16, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(182, 66, 16, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(183, 64, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(184, 64, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(185, 65, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(186, 65, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(187, 76, 16, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(188, 76, 16, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(189, 77, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(190, 81, 16, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(191, 81, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(192, 80, 16, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(193, 35, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(194, 86, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(195, 71, 16, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(196, 70, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(197, 103, 16, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(198, 103, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(199, 82, 16, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(200, 69, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(201, 72, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(202, 79, 16, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(203, 79, 16, NULL, '2014-12-22', '2014-12-28', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(204, 72, 17, NULL, '2014-12-29', '2015-01-04', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(205, 24, 84, NULL, '2014-12-22', '2014-12-28', 'app3', NULL, NULL, 1.5, NULL, NULL, NULL, NULL),
(206, 24, 84, NULL, '2014-12-29', '2015-01-04', 'app3', 1.6, 1.6, 1.6, NULL, NULL, NULL, NULL),
(207, 24, 86, NULL, '2015-01-05', '2015-01-11', 'app0', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(208, 24, 86, NULL, '2015-01-12', '2015-01-18', 'app3', 1, 2, NULL, NULL, NULL, NULL, NULL),
(209, 24, 86, NULL, '2015-01-19', '2015-01-25', 'app0', NULL, NULL, 0, 0, NULL, NULL, NULL),
(210, 24, 85, NULL, '2014-12-22', '2014-12-28', 'app3', NULL, NULL, 5, NULL, NULL, NULL, NULL),
(211, 24, 85, NULL, '2014-12-29', '2015-01-04', 'app3', 2.64, 2.64, 2.64, NULL, NULL, NULL, NULL),
(212, 46, 16, NULL, '2014-12-22', '2014-12-28', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(213, 46, 16, NULL, '2014-12-29', '2015-01-04', 'app3', 8, 8, 8, NULL, NULL, NULL, NULL),
(214, 24, 94, NULL, '2014-12-08', '2014-12-14', 'app3', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(215, 24, 92, NULL, '2014-12-22', '2014-12-28', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(216, 24, 95, NULL, '2014-12-08', '2014-12-14', 'app3', 2.4, 2.4, 2.4, 2.4, 2.4, NULL, NULL),
(217, 24, 95, NULL, '2014-12-15', '2014-12-21', 'app3', 2.4, 2.4, 2.4, 2.4, 2.4, NULL, NULL),
(218, 24, 93, NULL, '2014-12-08', '2014-12-14', 'app3', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(219, 24, 93, NULL, '2014-12-15', '2014-12-21', 'app3', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(220, 24, 93, NULL, '2014-12-22', '2014-12-28', 'app3', 1.6, 1.6, 1.6, NULL, NULL, NULL, NULL),
(221, 24, 96, NULL, '2014-12-29', '2015-01-04', 'app3', 1.2, 1.2, 1.2, NULL, NULL, NULL, NULL),
(222, 24, 96, NULL, '2015-01-05', '2015-01-11', 'app0', 0, NULL, NULL, NULL, NULL, NULL, NULL),
(223, 24, 96, NULL, '2015-01-12', '2015-01-18', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(224, 39, 17, NULL, '2014-12-29', '2015-01-04', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(225, 39, 17, NULL, '2014-12-22', '2014-12-28', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(226, 82, 73, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(227, 106, 62, NULL, '2014-12-08', '2014-12-14', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(228, 106, 62, NULL, '2014-12-15', '2014-12-21', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(229, 106, 62, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(230, 106, 62, NULL, '2014-12-29', '2015-01-04', 'app0', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(231, 106, 62, NULL, '2015-01-05', '2015-01-11', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(232, 106, 62, NULL, '2015-01-12', '2015-01-18', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(233, 106, 62, NULL, '2015-01-19', '2015-01-25', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(234, 106, 62, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(235, 106, 62, NULL, '2015-02-02', '2015-02-08', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(236, 106, 62, NULL, '2015-02-09', '2015-02-15', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(237, 106, 62, NULL, '2015-02-16', '2015-02-22', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(238, 106, 62, NULL, '2015-02-23', '2015-03-01', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(239, 101, 63, NULL, '2014-12-01', '2014-12-07', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(240, 101, 63, NULL, '2014-12-08', '2014-12-14', 'app3', 0, 0, 2, 0, 0, NULL, NULL),
(241, 101, 63, NULL, '2014-12-15', '2014-12-21', 'app3', 0, 0, 2, 0, 0, NULL, NULL),
(242, 101, 63, NULL, '2014-12-22', '2014-12-28', 'app0', 0, 0, 0, NULL, NULL, NULL, NULL),
(243, 101, 63, NULL, '2014-12-29', '2015-01-04', 'app0', 0, 0, 0, NULL, NULL, NULL, NULL),
(244, 101, 63, NULL, '2015-01-05', '2015-01-11', 'app3', 0, 0, 0, 2, 0, NULL, NULL),
(245, 101, 63, NULL, '2015-01-12', '2015-01-18', 'app3', 0, 2, 0, 0, 0, NULL, NULL),
(246, 101, 63, NULL, '2015-01-19', '2015-01-25', 'app3', 0, 2, 0, 0, 0, NULL, NULL),
(247, 101, 63, NULL, '2015-01-26', '2015-02-01', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(248, 101, 63, NULL, '2015-02-02', '2015-02-08', 'app3', 0, 2, 0, 0, 0, NULL, NULL),
(249, 101, 63, NULL, '2015-02-09', '2015-02-15', 'app3', 0, 4, 0, 0, 0, NULL, NULL),
(250, 101, 63, NULL, '2015-02-16', '2015-02-22', 'app3', 0, 2, 0, 0, 0, NULL, NULL),
(251, 101, 63, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, 0, 4, 0, 0, NULL, NULL),
(252, 101, 63, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(253, 101, 63, NULL, '2015-03-09', '2015-03-15', 'app3', 0, 2, 0, 0, 0, NULL, NULL),
(254, 101, 63, NULL, '2015-03-16', '2015-03-22', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(255, 101, 63, NULL, '2015-03-23', '2015-03-29', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(256, 101, 63, NULL, '2015-03-30', '2015-04-05', 'app3', 0, 2, 0, 0, 0, NULL, NULL),
(257, 101, 63, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(258, 101, 63, NULL, '2015-04-13', '2015-04-19', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(259, 101, 63, NULL, '2015-04-20', '2015-04-26', 'app3', 1, 0, 0, 0, 0, NULL, NULL),
(260, 101, 63, NULL, '2015-04-27', '2015-05-03', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(261, 101, 63, NULL, '2015-05-04', '2015-05-10', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(262, 101, 63, NULL, '2015-05-11', '2015-05-17', 'app0', 0.4, 0.4, 0.4, NULL, 0.4, NULL, NULL),
(263, 101, 63, NULL, '2015-05-18', '2015-05-24', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(264, 101, 63, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(265, 101, 63, NULL, '2015-06-01', '2015-06-07', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(266, 101, 63, NULL, '2015-06-08', '2015-06-14', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(267, 101, 63, NULL, '2015-06-15', '2015-06-21', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(268, 101, 63, NULL, '2015-06-22', '2015-06-28', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(269, 101, 63, NULL, '2015-06-29', '2015-07-05', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(270, 101, 63, NULL, '2015-07-06', '2015-07-12', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(271, 101, 63, NULL, '2015-07-13', '2015-07-19', 'app0', 0.4, NULL, 0.4, 0.4, 0.4, NULL, NULL),
(272, 101, 63, NULL, '2015-07-20', '2015-07-26', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(273, 101, 63, NULL, '2015-07-27', '2015-08-02', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(274, 101, 63, NULL, '2015-08-03', '2015-08-09', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(275, 101, 63, NULL, '2015-08-10', '2015-08-16', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(276, 101, 63, NULL, '2015-08-17', '2015-08-23', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(277, 101, 63, NULL, '2015-08-24', '2015-08-30', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(278, 101, 63, NULL, '2015-08-31', '2015-09-06', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(279, 101, 63, NULL, '2015-09-07', '2015-09-13', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(280, 101, 63, NULL, '2015-09-14', '2015-09-20', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(281, 101, 63, NULL, '2015-09-21', '2015-09-27', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(282, 101, 63, NULL, '2015-09-28', '2015-10-04', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(283, 101, 63, NULL, '2015-10-05', '2015-10-11', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(284, 101, 63, NULL, '2015-10-12', '2015-10-18', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(285, 101, 63, NULL, '2015-10-19', '2015-10-25', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(286, 101, 63, NULL, '2015-10-26', '2015-11-01', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(287, 101, 63, NULL, '2015-11-02', '2015-11-08', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(288, 101, 63, NULL, '2015-11-09', '2015-11-15', 'app0', 0.4, 0.4, NULL, 0.4, 0.4, NULL, NULL),
(289, 101, 63, NULL, '2015-11-16', '2015-11-22', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(290, 101, 63, NULL, '2015-11-23', '2015-11-29', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(291, 101, 63, NULL, '2015-11-30', '2015-12-06', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(292, 101, 63, NULL, '2015-12-07', '2015-12-13', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(293, 101, 63, NULL, '2015-12-14', '2015-12-20', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(294, 101, 63, NULL, '2015-12-21', '2015-12-27', 'app0', 0.4, 0.4, 0.4, NULL, NULL, NULL, NULL),
(295, 101, 63, NULL, '2015-12-28', '2016-01-03', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(296, 68, 49, NULL, '2014-12-08', '2014-12-14', 'app0', NULL, NULL, 0, 0, 0, NULL, NULL),
(297, 68, 49, NULL, '2014-12-15', '2014-12-21', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(298, 68, 49, NULL, '2014-12-22', '2014-12-28', 'app0', 0, 0, 0, NULL, NULL, NULL, NULL),
(299, 68, 49, NULL, '2014-12-29', '2015-01-04', 'app0', 0, 0, 0, NULL, NULL, NULL, NULL),
(300, 68, 49, NULL, '2015-01-05', '2015-01-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(301, 68, 49, NULL, '2015-01-12', '2015-01-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(302, 68, 49, NULL, '2015-01-19', '2015-01-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(303, 68, 49, NULL, '2015-01-26', '2015-02-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(304, 68, 49, NULL, '2015-02-02', '2015-02-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(305, 68, 49, NULL, '2015-02-09', '2015-02-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(306, 68, 49, NULL, '2015-02-16', '2015-02-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(307, 68, 49, NULL, '2015-02-23', '2015-03-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(308, 68, 49, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(309, 68, 49, NULL, '2015-03-09', '2015-03-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(310, 68, 49, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(311, 68, 49, NULL, '2015-03-23', '2015-03-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(312, 68, 49, NULL, '2015-03-30', '2015-04-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(313, 68, 49, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(314, 68, 49, NULL, '2015-04-13', '2015-04-19', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(315, 68, 49, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(316, 68, 49, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(317, 68, 49, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(318, 68, 49, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(319, 68, 49, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(320, 68, 49, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(321, 68, 49, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(322, 68, 49, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(323, 68, 49, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(324, 68, 49, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(325, 68, 49, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(326, 68, 49, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(327, 68, 49, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(328, 68, 49, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(329, 68, 49, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(330, 68, 49, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(331, 68, 49, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(332, 68, 49, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(333, 68, 49, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(334, 68, 49, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(335, 68, 49, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(336, 68, 49, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(337, 68, 49, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(338, 68, 49, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(339, 68, 49, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(340, 68, 49, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(341, 68, 49, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(342, 68, 49, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(343, 68, 49, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(344, 68, 49, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(345, 68, 49, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(346, 68, 49, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(347, 68, 49, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(348, 68, 49, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(349, 68, 49, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(350, 68, 49, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(351, 68, 49, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(352, 71, 49, NULL, '2014-12-08', '2014-12-14', 'app0', NULL, NULL, 0, 0, 0, NULL, NULL),
(353, 71, 49, NULL, '2014-12-15', '2014-12-21', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(354, 71, 49, NULL, '2014-12-22', '2014-12-28', 'app3', 0, 0, 4, NULL, NULL, NULL, NULL),
(355, 71, 49, NULL, '2014-12-29', '2015-01-04', 'app0', 0, 0, 0, NULL, NULL, NULL, NULL),
(356, 71, 49, NULL, '2015-01-05', '2015-01-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(357, 71, 49, NULL, '2015-01-12', '2015-01-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(358, 71, 49, NULL, '2015-01-19', '2015-01-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(359, 71, 49, NULL, '2015-01-26', '2015-02-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(360, 71, 49, NULL, '2015-02-02', '2015-02-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(361, 71, 49, NULL, '2015-02-09', '2015-02-15', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(362, 71, 49, NULL, '2015-02-16', '2015-02-22', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(363, 71, 49, NULL, '2015-02-23', '2015-03-01', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(364, 71, 49, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(365, 71, 49, NULL, '2015-03-09', '2015-03-15', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(366, 71, 49, NULL, '2015-03-16', '2015-03-22', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(367, 71, 49, NULL, '2015-03-23', '2015-03-29', 'app3', 4, 0, 0, 0, 0, NULL, NULL),
(368, 71, 49, NULL, '2015-03-30', '2015-04-05', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(369, 71, 49, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(370, 71, 49, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(371, 71, 49, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(372, 71, 49, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(373, 71, 49, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(374, 71, 49, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(375, 71, 49, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(376, 71, 49, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(377, 71, 49, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(378, 71, 49, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(379, 71, 49, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(380, 71, 49, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(381, 71, 49, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(382, 71, 49, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(383, 71, 49, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(384, 71, 49, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(385, 71, 49, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(386, 71, 49, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(387, 71, 49, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(388, 71, 49, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(389, 71, 49, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(390, 71, 49, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(391, 71, 49, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(392, 71, 49, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(393, 71, 49, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(394, 71, 49, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(395, 71, 49, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(396, 71, 49, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(397, 71, 49, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(398, 71, 49, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(399, 71, 49, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(400, 71, 49, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(401, 71, 49, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(402, 71, 49, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(403, 71, 49, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(404, 71, 49, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(405, 71, 49, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(406, 71, 49, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(407, 71, 49, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(408, 39, 49, NULL, '2014-12-08', '2014-12-14', 'app3', NULL, NULL, 1, 1, NULL, NULL, NULL),
(409, 39, 49, NULL, '2014-12-15', '2014-12-21', 'app3', 5, 5, 2, 2, 3, NULL, NULL),
(410, 39, 49, NULL, '2014-12-22', '2014-12-28', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(411, 39, 49, NULL, '2014-12-29', '2015-01-04', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(412, 39, 49, NULL, '2015-01-05', '2015-01-11', 'app3', 4, 6, 4, 3, 6, NULL, NULL),
(413, 39, 49, NULL, '2015-01-12', '2015-01-18', 'app3', 6, 6, 4, 2, 2, NULL, NULL),
(414, 39, 49, NULL, '2015-01-19', '2015-01-25', 'app3', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(415, 39, 49, NULL, '2015-01-26', '2015-02-01', 'app3', 6, 6, 4, 4, 6, NULL, NULL),
(416, 39, 49, NULL, '2015-02-02', '2015-02-08', 'app3', 4, 2.4, 4, 6, 5, NULL, NULL),
(417, 39, 49, NULL, '2015-02-09', '2015-02-15', 'app3', 5, 6, NULL, 6, 5, NULL, NULL),
(418, 39, 49, NULL, '2015-02-16', '2015-02-22', 'app3', 2, 2, 5, 1, 4, NULL, NULL),
(419, 39, 49, NULL, '2015-02-23', '2015-03-01', 'app3', 3, 4, 3, 2, 4, NULL, NULL),
(420, 39, 49, NULL, '2015-03-02', '2015-03-08', 'app3', 2, 4, 2, 4, 4, NULL, NULL),
(421, 39, 49, NULL, '2015-03-09', '2015-03-15', 'app3', 2, 2, 6, 8, 4, NULL, NULL),
(422, 39, 49, NULL, '2015-03-16', '2015-03-22', 'app3', 2, 2, 6, 4, NULL, NULL, NULL),
(423, 39, 49, NULL, '2015-03-23', '2015-03-29', 'app3', 6, NULL, NULL, NULL, NULL, NULL, NULL),
(424, 39, 49, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 6, 6, 8, 2, NULL, NULL),
(425, 39, 49, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, 6, 2, 0, NULL, NULL),
(426, 39, 49, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, 4, NULL, 6, NULL, NULL),
(427, 39, 49, NULL, '2015-04-20', '2015-04-26', 'app1', 6, 6, 4, 6, 6, NULL, NULL),
(428, 39, 49, NULL, '2015-04-27', '2015-05-03', 'app1', 3, 2, NULL, 2, NULL, NULL, NULL),
(429, 39, 49, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(430, 39, 49, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(431, 39, 49, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(432, 39, 49, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(433, 39, 49, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(434, 39, 49, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(435, 39, 49, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(436, 39, 49, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(437, 39, 49, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(438, 39, 49, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(439, 39, 49, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(440, 39, 49, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(441, 39, 49, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(442, 39, 49, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(443, 39, 49, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(444, 39, 49, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(445, 39, 49, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(446, 39, 49, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(447, 39, 49, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(448, 39, 49, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(449, 39, 49, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(450, 39, 49, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(451, 39, 49, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(452, 39, 49, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(453, 39, 49, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(454, 39, 49, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(455, 39, 49, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(456, 39, 49, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(457, 39, 49, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(458, 39, 49, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(459, 39, 49, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(460, 39, 49, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(461, 39, 49, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(462, 39, 49, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(463, 39, 49, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(464, 39, 62, NULL, '2014-12-08', '2014-12-14', 'app3', NULL, NULL, 1, 5, NULL, NULL, NULL),
(465, 39, 62, NULL, '2014-12-15', '2014-12-21', 'app3', 3, 3, NULL, NULL, 1, NULL, NULL),
(466, 39, 62, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(467, 39, 62, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(468, 39, 62, NULL, '2015-01-05', '2015-01-11', 'app3', NULL, 2, 2, NULL, 2, NULL, NULL),
(469, 39, 62, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, NULL, 4, 4, NULL, NULL),
(470, 39, 62, NULL, '2015-01-19', '2015-01-25', 'app3', 0, 2.5, 8, 4, NULL, NULL, NULL),
(471, 39, 62, NULL, '2015-01-26', '2015-02-01', 'app3', 2, 2, NULL, NULL, 2, NULL, NULL),
(472, 39, 62, NULL, '2015-02-02', '2015-02-08', 'app3', 4, 2, 2, 2, 2.4, NULL, NULL),
(473, 39, 62, NULL, '2015-02-09', '2015-02-15', 'app3', 3, 1, NULL, 2, 3, NULL, NULL),
(474, 39, 62, NULL, '2015-02-16', '2015-02-22', 'app3', 2, 1, 1, NULL, 4, NULL, NULL),
(475, 39, 62, NULL, '2015-02-23', '2015-03-01', 'app3', 5, 2, 4, NULL, 2, NULL, NULL),
(476, 39, 63, NULL, '2014-12-01', '2014-12-07', 'app0', 0, 0, 0, 0, 0.01, NULL, NULL),
(477, 39, 63, NULL, '2014-12-08', '2014-12-14', 'app3', 0, 0, 2, 0, NULL, NULL, NULL),
(478, 39, 63, NULL, '2014-12-15', '2014-12-21', 'app3', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(479, 39, 63, NULL, '2014-12-22', '2014-12-28', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(480, 39, 63, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(481, 39, 63, NULL, '2015-01-05', '2015-01-11', 'app3', NULL, NULL, NULL, 3, NULL, NULL, NULL),
(482, 39, 63, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, 2, NULL, NULL, NULL, NULL, NULL),
(483, 39, 63, NULL, '2015-01-19', '2015-01-25', 'app3', NULL, 1.5, NULL, NULL, NULL, NULL, NULL),
(484, 39, 63, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, 0, NULL, NULL, NULL, NULL, NULL),
(485, 39, 63, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, 3, NULL, NULL, NULL, NULL, NULL),
(486, 39, 63, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, 1, NULL, NULL, NULL, NULL, NULL),
(487, 39, 63, NULL, '2015-02-16', '2015-02-22', 'app3', NULL, 1, NULL, NULL, NULL, NULL, NULL),
(488, 39, 63, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(489, 39, 63, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(490, 39, 63, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 2, NULL, NULL, NULL, NULL, NULL),
(491, 39, 63, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(492, 39, 63, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(493, 39, 63, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, NULL, 5, NULL, NULL),
(494, 39, 63, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(495, 39, 63, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(496, 39, 63, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 2, NULL, NULL, NULL, NULL, NULL),
(497, 39, 63, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(498, 39, 63, NULL, '2015-05-04', '2015-05-10', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(499, 39, 63, NULL, '2015-05-11', '2015-05-17', 'app0', 0.4, 0.4, 0.4, NULL, 0.4, NULL, NULL),
(500, 39, 63, NULL, '2015-05-18', '2015-05-24', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(501, 39, 63, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(502, 39, 63, NULL, '2015-06-01', '2015-06-07', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(503, 39, 63, NULL, '2015-06-08', '2015-06-14', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(504, 39, 63, NULL, '2015-06-15', '2015-06-21', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(505, 39, 63, NULL, '2015-06-22', '2015-06-28', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(506, 39, 63, NULL, '2015-06-29', '2015-07-05', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(507, 39, 63, NULL, '2015-07-06', '2015-07-12', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(508, 39, 63, NULL, '2015-07-13', '2015-07-19', 'app0', 0.4, NULL, 0.4, 0.4, 0.4, NULL, NULL),
(509, 39, 63, NULL, '2015-07-20', '2015-07-26', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(510, 39, 63, NULL, '2015-07-27', '2015-08-02', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(511, 39, 63, NULL, '2015-08-03', '2015-08-09', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(512, 39, 63, NULL, '2015-08-10', '2015-08-16', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(513, 39, 63, NULL, '2015-08-17', '2015-08-23', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(514, 39, 63, NULL, '2015-08-24', '2015-08-30', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(515, 39, 63, NULL, '2015-08-31', '2015-09-06', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(516, 39, 63, NULL, '2015-09-07', '2015-09-13', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(517, 39, 63, NULL, '2015-09-14', '2015-09-20', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(518, 39, 63, NULL, '2015-09-21', '2015-09-27', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(519, 39, 63, NULL, '2015-09-28', '2015-10-04', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(520, 39, 63, NULL, '2015-10-05', '2015-10-11', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(521, 39, 63, NULL, '2015-10-12', '2015-10-18', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(522, 39, 63, NULL, '2015-10-19', '2015-10-25', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(523, 39, 63, NULL, '2015-10-26', '2015-11-01', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(524, 39, 63, NULL, '2015-11-02', '2015-11-08', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(525, 39, 63, NULL, '2015-11-09', '2015-11-15', 'app0', 0.4, 0.4, NULL, 0.4, 0.4, NULL, NULL),
(526, 39, 63, NULL, '2015-11-16', '2015-11-22', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(527, 39, 63, NULL, '2015-11-23', '2015-11-29', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(528, 39, 63, NULL, '2015-11-30', '2015-12-06', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(529, 39, 63, NULL, '2015-12-07', '2015-12-13', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(530, 39, 63, NULL, '2015-12-14', '2015-12-20', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(531, 39, 63, NULL, '2015-12-21', '2015-12-27', 'app0', 0.4, 0.4, 0.4, NULL, NULL, NULL, NULL),
(532, 39, 63, NULL, '2015-12-28', '2016-01-03', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(533, 24, 98, NULL, '2014-12-29', '2015-01-04', 'app3', NULL, 0.8, 0.8, NULL, NULL, NULL, NULL),
(534, 24, 98, NULL, '2015-01-05', '2015-01-11', 'app1', 0, NULL, 1, NULL, NULL, NULL, NULL),
(535, 46, 63, NULL, '2014-12-01', '2014-12-07', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(536, 46, 63, NULL, '2014-12-08', '2014-12-14', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(537, 46, 63, NULL, '2014-12-15', '2014-12-21', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(538, 46, 63, NULL, '2014-12-22', '2014-12-28', 'app3', 0.08, 0.08, 0.08, NULL, NULL, NULL, NULL),
(539, 46, 63, NULL, '2014-12-29', '2015-01-04', 'app3', 0.08, 0.08, 0.08, NULL, NULL, NULL, NULL),
(540, 46, 63, NULL, '2015-01-05', '2015-01-11', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(541, 46, 63, NULL, '2015-01-12', '2015-01-18', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(542, 46, 63, NULL, '2015-01-19', '2015-01-25', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(543, 46, 63, NULL, '2015-01-26', '2015-02-01', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(544, 46, 63, NULL, '2015-02-02', '2015-02-08', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(545, 46, 63, NULL, '2015-02-09', '2015-02-15', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(546, 46, 63, NULL, '2015-02-16', '2015-02-22', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(547, 46, 63, NULL, '2015-02-23', '2015-03-01', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(548, 46, 63, NULL, '2015-03-02', '2015-03-08', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(549, 46, 63, NULL, '2015-03-09', '2015-03-15', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(550, 46, 63, NULL, '2015-03-16', '2015-03-22', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(551, 46, 63, NULL, '2015-03-23', '2015-03-29', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(552, 46, 63, NULL, '2015-03-30', '2015-04-05', 'app3', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(553, 46, 63, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(554, 46, 63, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, 1, NULL, NULL, NULL),
(555, 46, 63, NULL, '2015-04-20', '2015-04-26', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(556, 46, 63, NULL, '2015-04-27', '2015-05-03', 'app1', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(557, 46, 63, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(558, 46, 63, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(559, 46, 63, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(560, 46, 63, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(561, 46, 63, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(562, 46, 63, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(563, 46, 63, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(564, 46, 63, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(565, 46, 63, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(566, 46, 63, NULL, '2015-07-06', '2015-07-12', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(567, 46, 63, NULL, '2015-07-13', '2015-07-19', 'app0', 0.08, NULL, 0.08, 0.08, 0.08, NULL, NULL),
(568, 46, 63, NULL, '2015-07-20', '2015-07-26', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(569, 46, 63, NULL, '2015-07-27', '2015-08-02', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(570, 46, 63, NULL, '2015-08-03', '2015-08-09', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(571, 46, 63, NULL, '2015-08-10', '2015-08-16', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(572, 46, 63, NULL, '2015-08-17', '2015-08-23', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(573, 46, 63, NULL, '2015-08-24', '2015-08-30', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(574, 46, 63, NULL, '2015-08-31', '2015-09-06', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(575, 46, 63, NULL, '2015-09-07', '2015-09-13', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(576, 46, 63, NULL, '2015-09-14', '2015-09-20', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(577, 46, 63, NULL, '2015-09-21', '2015-09-27', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(578, 46, 63, NULL, '2015-09-28', '2015-10-04', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL);
INSERT INTO `timesheet` (`idTimeSheet`, `idEmployee`, `idActivity`, `idOperation`, `initDate`, `endDate`, `status`, `hoursDay1`, `hoursDay2`, `hoursDay3`, `hoursDay4`, `hoursDay5`, `hoursDay6`, `hoursDay7`) VALUES
(579, 46, 63, NULL, '2015-10-05', '2015-10-11', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(580, 46, 63, NULL, '2015-10-12', '2015-10-18', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(581, 46, 63, NULL, '2015-10-19', '2015-10-25', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(582, 46, 63, NULL, '2015-10-26', '2015-11-01', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(583, 46, 63, NULL, '2015-11-02', '2015-11-08', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(584, 46, 63, NULL, '2015-11-09', '2015-11-15', 'app0', 0.08, 0.08, NULL, 0.08, 0.08, NULL, NULL),
(585, 46, 63, NULL, '2015-11-16', '2015-11-22', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(586, 46, 63, NULL, '2015-11-23', '2015-11-29', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(587, 46, 63, NULL, '2015-11-30', '2015-12-06', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(588, 46, 63, NULL, '2015-12-07', '2015-12-13', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(589, 46, 63, NULL, '2015-12-14', '2015-12-20', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(590, 46, 63, NULL, '2015-12-21', '2015-12-27', 'app0', 0.08, 0.08, 0.08, NULL, NULL, NULL, NULL),
(591, 46, 63, NULL, '2015-12-28', '2016-01-03', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(592, 24, 97, NULL, '2014-12-29', '2015-01-04', 'app3', NULL, NULL, 0.8, NULL, NULL, NULL, NULL),
(593, 24, 97, NULL, '2015-01-05', '2015-01-11', 'app1', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(594, 24, 85, NULL, '2015-01-05', '2015-01-11', 'app3', 2, NULL, 2, NULL, 2, NULL, NULL),
(595, 24, 85, NULL, '2015-01-12', '2015-01-18', 'app3', 2, 2, 2, 2, 2, NULL, NULL),
(596, 24, 85, NULL, '2015-01-19', '2015-01-25', 'app3', 3, 2, 2, 2, 1, NULL, NULL),
(597, 24, 85, NULL, '2015-01-26', '2015-02-01', 'app3', 0, 0, 0, 4, 4, NULL, NULL),
(598, 46, 91, NULL, '2015-01-12', '2015-01-18', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(599, 46, 91, NULL, '2015-01-19', '2015-01-25', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(600, 24, 88, NULL, '2015-01-05', '2015-01-11', 'app3', 0.8, 0.8, 2, 0.8, 0.8, NULL, NULL),
(601, 24, 88, NULL, '2015-01-12', '2015-01-18', 'app3', 1, 0.8, 0.8, 1, 0.8, NULL, NULL),
(602, 112, 99, NULL, '2015-01-05', '2015-01-11', 'app0', NULL, NULL, 8, 8, NULL, NULL, NULL),
(603, 85, 78, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(604, 85, 78, NULL, '2015-01-05', '2015-01-11', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(605, 85, 78, NULL, '2015-01-12', '2015-01-18', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(606, 85, 78, NULL, '2015-01-19', '2015-01-25', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(607, 85, 78, NULL, '2015-01-26', '2015-02-01', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(608, 85, 78, NULL, '2015-02-02', '2015-02-08', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(609, 85, 78, NULL, '2015-02-09', '2015-02-15', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(610, 85, 78, NULL, '2015-02-16', '2015-02-22', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(611, 85, 78, NULL, '2015-02-23', '2015-03-01', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(612, 85, 78, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(613, 85, 78, NULL, '2015-03-09', '2015-03-15', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(614, 85, 78, NULL, '2015-03-16', '2015-03-22', 'app3', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(615, 85, 78, NULL, '2015-03-23', '2015-03-29', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(616, 85, 78, NULL, '2015-03-30', '2015-04-05', 'app0', 0.16, 0.16, NULL, NULL, NULL, NULL, NULL),
(617, 84, 78, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(618, 84, 78, NULL, '2015-01-05', '2015-01-11', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(619, 84, 78, NULL, '2015-01-12', '2015-01-18', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(620, 84, 78, NULL, '2015-01-19', '2015-01-25', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(621, 84, 78, NULL, '2015-01-26', '2015-02-01', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(622, 84, 78, NULL, '2015-02-02', '2015-02-08', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(623, 84, 78, NULL, '2015-02-09', '2015-02-15', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(624, 84, 78, NULL, '2015-02-16', '2015-02-22', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(625, 84, 78, NULL, '2015-02-23', '2015-03-01', 'app1', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(626, 84, 78, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(627, 84, 78, NULL, '2015-03-09', '2015-03-15', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(628, 84, 78, NULL, '2015-03-16', '2015-03-22', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(629, 84, 78, NULL, '2015-03-23', '2015-03-29', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(630, 84, 78, NULL, '2015-03-30', '2015-04-05', 'app0', 0.4, 0.4, NULL, NULL, NULL, NULL, NULL),
(631, 72, 73, NULL, '2015-01-05', '2015-01-11', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(632, 72, 88, NULL, '2015-01-05', '2015-01-11', 'app0', NULL, 1.2, 1.2, 1.2, 1.2, NULL, NULL),
(633, 72, 88, NULL, '2015-01-12', '2015-01-18', 'app0', 1.2, 1.2, 1.2, 1.2, 1.2, NULL, NULL),
(634, 24, 89, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, 1, 2, NULL, NULL, NULL, NULL),
(635, 24, 89, NULL, '2015-01-19', '2015-01-25', 'app0', 0, 0, NULL, NULL, NULL, NULL, NULL),
(636, 24, 89, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(637, 24, 101, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, 2, 1, 1.2, NULL, NULL),
(638, 102, 101, NULL, '2015-01-12', '2015-01-18', 'app0', NULL, NULL, 1.6, 1.6, 1.6, NULL, NULL),
(639, 24, 104, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, 1, 0, 0, NULL, NULL, NULL),
(640, 24, 104, NULL, '2015-02-09', '2015-02-15', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(641, 24, 103, NULL, '2015-01-05', '2015-01-11', 'app3', 4, 4, 4, 0, 0, NULL, NULL),
(642, 24, 103, NULL, '2015-01-12', '2015-01-18', 'app3', 1.6, 4, 1.6, 1.6, 1.6, NULL, NULL),
(643, 24, 103, NULL, '2015-01-19', '2015-01-25', 'app3', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(644, 24, 103, NULL, '2015-01-26', '2015-02-01', 'app3', 0, 0, 2, 0, 0, NULL, NULL),
(645, 102, 101, NULL, '2015-01-19', '2015-01-25', 'app0', 1.6, NULL, NULL, NULL, NULL, NULL, NULL),
(646, 24, 101, NULL, '2015-01-19', '2015-01-25', 'app3', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(647, 46, 101, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, NULL, 0.8, 0.8, NULL, NULL),
(648, 46, 101, NULL, '2015-01-19', '2015-01-25', 'app3', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(649, 24, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(650, 70, 73, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(651, 76, 106, NULL, '2015-01-19', '2015-01-25', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(652, 71, 106, NULL, '2015-01-19', '2015-01-25', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(653, 46, 105, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, NULL, 0.8, 0.8, NULL, NULL),
(654, 46, 105, NULL, '2015-01-19', '2015-01-25', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(655, 24, 105, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, NULL, 1, 0, NULL, NULL),
(656, 24, 105, NULL, '2015-01-19', '2015-01-25', 'app3', 1, 1.5, 0, 0, 0, NULL, NULL),
(657, 72, 88, NULL, '2015-01-19', '2015-01-25', 'app0', 1.2, 1.2, 1.2, 1.2, 1.2, NULL, NULL),
(658, 24, 88, NULL, '2015-01-19', '2015-01-25', 'app3', 1, 1, NULL, NULL, NULL, NULL, NULL),
(659, 46, 88, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, NULL, 0.8, 0.8, NULL, NULL),
(660, 46, 88, NULL, '2015-01-19', '2015-01-25', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(661, 46, 88, NULL, '2015-01-26', '2015-02-01', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(662, 24, 112, NULL, '2015-01-19', '2015-01-25', 'app3', 1, 2, 1, 0.5, 1, NULL, NULL),
(663, 24, 93, NULL, '2015-01-19', '2015-01-25', 'app1', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(664, 109, 74, NULL, '2015-02-09', '2015-02-15', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(665, 102, 112, NULL, '2015-01-19', '2015-01-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(666, 75, 73, NULL, '2015-03-16', '2015-03-22', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(667, 75, 73, NULL, '2015-06-22', '2015-06-28', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(668, 75, 73, NULL, '2015-06-29', '2015-07-05', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(669, 75, 73, NULL, '2015-09-21', '2015-09-27', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(670, 75, 73, NULL, '2015-11-23', '2015-11-29', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(671, 75, 73, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(672, 75, 73, NULL, '2015-01-19', '2015-01-25', 'app0', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(673, 109, 73, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, 8, 8, 8, 8, NULL, NULL),
(674, 106, 49, NULL, '2015-01-12', '2015-01-18', 'app3', NULL, NULL, NULL, 4, 4, NULL, NULL),
(675, 106, 49, NULL, '2015-01-19', '2015-01-25', 'app3', 4, 8, 8, 4, NULL, NULL, NULL),
(676, 106, 49, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(677, 106, 49, NULL, '2015-02-02', '2015-02-08', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(678, 106, 49, NULL, '2015-02-09', '2015-02-15', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(679, 106, 49, NULL, '2015-02-16', '2015-02-22', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(680, 106, 49, NULL, '2015-02-23', '2015-03-01', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(681, 46, 113, NULL, '2015-01-19', '2015-01-25', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(682, 46, 113, NULL, '2015-01-26', '2015-02-01', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(683, 24, 113, NULL, '2015-01-26', '2015-02-01', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(684, 24, 88, NULL, '2015-01-26', '2015-02-01', 'app3', NULL, NULL, 4, 2, 4, NULL, NULL),
(685, 24, 88, NULL, '2015-02-02', '2015-02-08', 'app3', 1, 2, NULL, NULL, NULL, NULL, NULL),
(686, 75, 74, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(687, 53, 81, NULL, '2015-01-19', '2015-01-25', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(688, 72, 88, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(689, 72, 88, NULL, '2015-02-02', '2015-02-08', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(690, 74, 62, NULL, '2015-01-12', '2015-01-18', 'app3', 4, NULL, NULL, NULL, 4, NULL, NULL),
(691, 74, 62, NULL, '2015-01-19', '2015-01-25', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(692, 74, 62, NULL, '2015-01-26', '2015-02-01', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(693, 74, 62, NULL, '2015-02-02', '2015-02-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(694, 74, 62, NULL, '2015-02-09', '2015-02-15', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(695, 74, 62, NULL, '2015-02-16', '2015-02-22', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(696, 74, 62, NULL, '2015-02-23', '2015-03-01', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(697, 46, 113, NULL, '2015-02-02', '2015-02-08', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(698, 24, 113, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, NULL, NULL, 3, 1, NULL, NULL),
(699, 24, 105, NULL, '2015-01-26', '2015-02-01', 'app3', 1, 0, 0, 0, 0, NULL, NULL),
(700, 24, 105, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, NULL, NULL, 1, NULL, NULL, NULL),
(701, 101, 113, NULL, '2015-01-26', '2015-02-01', 'app3', NULL, 1, 0, 0, 0, NULL, NULL),
(702, 101, 113, NULL, '2015-02-02', '2015-02-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(703, 72, 113, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(704, 72, 113, NULL, '2015-02-02', '2015-02-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(705, 71, 113, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(706, 71, 113, NULL, '2015-02-02', '2015-02-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(707, 70, 113, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(708, 70, 113, NULL, '2015-02-02', '2015-02-08', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(709, 35, 74, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(710, 81, 73, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(711, 53, 73, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, 8, 8, 8, NULL, NULL),
(712, 46, 73, NULL, '2015-04-20', '2015-04-26', 'app1', 8, 8, 8, 8, 8, NULL, NULL),
(713, 46, 73, NULL, '2015-02-09', '2015-02-15', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(714, 72, 73, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(715, 112, 120, NULL, '2015-02-23', '2015-03-01', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(716, 112, 119, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(717, 112, 116, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, 8, 8, NULL, NULL, NULL),
(718, 112, 115, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(719, 112, 125, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(720, 112, 123, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, 8, 8, NULL, NULL, NULL),
(721, 24, 73, NULL, '2015-10-05', '2015-10-11', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(722, 24, 73, NULL, '2015-10-12', '2015-10-18', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(723, 24, 73, NULL, '2015-10-19', '2015-10-25', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(724, 24, 129, NULL, '2015-02-02', '2015-02-08', 'app3', 8, 1, 1.5, 1.5, 1.5, NULL, NULL),
(725, 84, 127, NULL, '2015-02-23', '2015-03-01', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(726, 85, 121, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, 8, 8, NULL, NULL, NULL),
(727, 84, 118, NULL, '2015-02-16', '2015-02-22', 'app1', NULL, 8, 8, NULL, NULL, NULL, NULL),
(728, 85, 117, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(729, 84, 114, NULL, '2015-02-02', '2015-02-08', 'app1', 8, 8, NULL, NULL, NULL, NULL, NULL),
(730, 85, 126, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(731, 84, 124, NULL, '2015-03-09', '2015-03-15', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(732, 85, 128, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, 8, 8, 8, NULL, NULL),
(733, 75, 74, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(734, 72, 73, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(735, 72, 73, NULL, '2015-02-23', '2015-03-01', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(736, 72, 73, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, NULL, 8, 8, 8, NULL, NULL),
(737, 102, 73, NULL, '2015-02-09', '2015-02-15', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(738, 64, 74, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(739, 77, 74, NULL, '2015-02-09', '2015-02-15', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(740, 66, 74, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(741, 77, 73, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, 8, 8, 8, NULL, NULL),
(748, 71, 73, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(749, 71, 73, NULL, '2015-02-16', '2015-02-22', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(750, 76, 73, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(751, 76, 73, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(752, 66, 73, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(754, 35, 75, NULL, '2015-02-09', '2015-02-15', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(755, 35, 75, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(756, 35, 75, NULL, '2015-02-02', '2015-02-08', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(757, 69, 62, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(758, 69, 62, NULL, '2015-01-05', '2015-01-11', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(759, 69, 62, NULL, '2015-01-12', '2015-01-18', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(760, 69, 62, NULL, '2015-01-19', '2015-01-25', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(761, 69, 62, NULL, '2015-01-26', '2015-02-01', 'app0', 0.16, 0.16, 0.16, 0.16, 0.16, NULL, NULL),
(762, 69, 62, NULL, '2015-02-02', '2015-02-08', 'app3', 2, 2, NULL, NULL, NULL, NULL, NULL),
(763, 69, 62, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(764, 69, 62, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(765, 69, 62, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, 8, 8, NULL, NULL, NULL, NULL),
(766, 101, 138, NULL, '2015-02-09', '2015-02-15', 'app3', 1, 1, 2, 0, 0, NULL, NULL),
(767, 70, 138, NULL, '2015-02-09', '2015-02-15', 'app3', 4, 4, 0, 0, 0, NULL, NULL),
(768, 101, 81, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(769, 74, 73, NULL, '2015-05-18', '2015-05-24', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(770, 74, 73, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(771, 39, 142, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, NULL, NULL, NULL, 0.64, NULL, NULL),
(772, 39, 143, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, 0.64, NULL, NULL, NULL, NULL, NULL),
(773, 64, 74, NULL, '2015-04-13', '2015-04-19', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(774, 64, 74, NULL, '2015-05-04', '2015-05-10', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(775, 85, 73, NULL, '2015-02-09', '2015-02-15', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(783, 64, 73, NULL, '2015-03-30', '2015-04-05', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(784, 64, 73, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(785, 46, 154, NULL, '2015-02-16', '2015-02-22', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(786, 46, 154, NULL, '2015-02-23', '2015-03-01', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(787, 24, 154, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, NULL, 1, 0.8, NULL, NULL),
(788, 24, 154, NULL, '2015-02-16', '2015-02-22', 'app3', 1, 0.8, 3, 0.8, 0.8, NULL, NULL),
(789, 24, 154, NULL, '2015-02-23', '2015-03-01', 'app3', 1, 0.5, 3, 3, 3, NULL, NULL),
(790, 68, 73, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(791, 68, 73, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(797, 75, 74, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, 8, NULL, 8, NULL, NULL),
(798, 24, 160, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, NULL, 1, NULL, NULL, NULL),
(799, 24, 138, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, NULL, 2, 1, NULL, NULL),
(800, 24, 105, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, NULL, 1, 0.5, NULL, NULL),
(801, 84, 161, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(802, 84, 161, NULL, '2015-02-02', '2015-02-08', 'app1', NULL, NULL, NULL, 4, 8, NULL, NULL),
(803, 84, 161, NULL, '2015-02-09', '2015-02-15', 'app1', NULL, 2, NULL, NULL, 6, NULL, NULL),
(804, 84, 161, NULL, '2015-02-16', '2015-02-22', 'app1', 1.5, NULL, NULL, NULL, NULL, NULL, NULL),
(805, 84, 161, NULL, '2015-02-23', '2015-03-01', 'app1', 2, NULL, NULL, NULL, 6, NULL, NULL),
(806, 84, 161, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 0, 1.6, 1.6, NULL, NULL),
(807, 84, 161, NULL, '2015-03-09', '2015-03-15', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(808, 84, 161, NULL, '2015-03-16', '2015-03-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(809, 84, 161, NULL, '2015-03-23', '2015-03-29', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(810, 84, 161, NULL, '2015-03-30', '2015-04-05', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(811, 84, 161, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(812, 84, 161, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(813, 84, 161, NULL, '2015-04-20', '2015-04-26', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(814, 84, 161, NULL, '2015-04-27', '2015-05-03', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(815, 84, 161, NULL, '2015-05-04', '2015-05-10', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(816, 84, 161, NULL, '2015-05-11', '2015-05-17', 'app0', 1.6, 1.6, 1.6, NULL, 1.6, NULL, NULL),
(817, 84, 161, NULL, '2015-05-18', '2015-05-24', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(818, 84, 161, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(819, 84, 161, NULL, '2015-06-01', '2015-06-07', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(820, 84, 161, NULL, '2015-06-08', '2015-06-14', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(821, 84, 161, NULL, '2015-06-15', '2015-06-21', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(822, 84, 161, NULL, '2015-06-22', '2015-06-28', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(823, 84, 161, NULL, '2015-06-29', '2015-07-05', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(824, 84, 161, NULL, '2015-07-06', '2015-07-12', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(825, 84, 161, NULL, '2015-07-13', '2015-07-19', 'app0', 1.6, NULL, 1.6, 1.6, 1.6, NULL, NULL),
(826, 84, 161, NULL, '2015-07-20', '2015-07-26', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(827, 84, 161, NULL, '2015-07-27', '2015-08-02', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(828, 84, 161, NULL, '2015-08-03', '2015-08-09', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(829, 84, 161, NULL, '2015-08-10', '2015-08-16', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(830, 84, 161, NULL, '2015-08-17', '2015-08-23', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(831, 84, 161, NULL, '2015-08-24', '2015-08-30', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(832, 84, 161, NULL, '2015-08-31', '2015-09-06', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(833, 84, 161, NULL, '2015-09-07', '2015-09-13', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(834, 84, 161, NULL, '2015-09-14', '2015-09-20', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(835, 84, 161, NULL, '2015-09-21', '2015-09-27', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(836, 84, 161, NULL, '2015-09-28', '2015-10-04', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(837, 84, 161, NULL, '2015-10-05', '2015-10-11', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(838, 84, 161, NULL, '2015-10-12', '2015-10-18', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(839, 84, 161, NULL, '2015-10-19', '2015-10-25', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(840, 84, 161, NULL, '2015-10-26', '2015-11-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(841, 84, 161, NULL, '2015-11-02', '2015-11-08', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(842, 84, 161, NULL, '2015-11-09', '2015-11-15', 'app0', 1.6, 1.6, NULL, 1.6, 1.6, NULL, NULL),
(843, 84, 161, NULL, '2015-11-16', '2015-11-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(844, 84, 161, NULL, '2015-11-23', '2015-11-29', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(845, 84, 161, NULL, '2015-11-30', '2015-12-06', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(846, 84, 161, NULL, '2015-12-07', '2015-12-13', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(847, 84, 161, NULL, '2015-12-14', '2015-12-20', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(848, 84, 161, NULL, '2015-12-21', '2015-12-27', 'app0', 1.6, 1.6, 1.6, NULL, NULL, NULL, NULL),
(849, 84, 161, NULL, '2015-12-28', '2016-01-03', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(850, 65, 161, NULL, '2015-01-26', '2015-02-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(851, 65, 161, NULL, '2015-02-02', '2015-02-08', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(852, 65, 161, NULL, '2015-02-09', '2015-02-15', 'app0', 8, 8, NULL, 0, 0, NULL, NULL),
(853, 65, 161, NULL, '2015-02-16', '2015-02-22', 'app0', 8, 8, NULL, 0, 0, NULL, NULL),
(854, 65, 161, NULL, '2015-02-23', '2015-03-01', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(855, 65, 161, NULL, '2015-03-02', '2015-03-08', 'app3', 8, 8, NULL, 0, 0, NULL, NULL),
(856, 65, 161, NULL, '2015-03-09', '2015-03-15', 'app3', 8, 8, NULL, 0, 0, NULL, NULL),
(857, 65, 161, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 8, NULL, 0, 0, NULL, NULL),
(858, 65, 161, NULL, '2015-03-23', '2015-03-29', 'app3', 4, 8, NULL, 4, 0, NULL, NULL),
(859, 65, 161, NULL, '2015-03-30', '2015-04-05', 'app3', 8, 8, NULL, 0, 0, NULL, NULL),
(860, 65, 161, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, NULL, 4, 0, NULL, NULL),
(861, 65, 161, NULL, '2015-04-13', '2015-04-19', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(862, 65, 161, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, NULL, 0, 0, NULL, NULL),
(863, 65, 161, NULL, '2015-04-27', '2015-05-03', 'app0', 4, 4, NULL, 4, NULL, NULL, NULL),
(864, 65, 161, NULL, '2015-05-04', '2015-05-10', 'app0', 4, 4, NULL, 4, NULL, NULL, NULL),
(865, 65, 161, NULL, '2015-05-11', '2015-05-17', 'app0', 4, 4, NULL, NULL, 4, NULL, NULL),
(866, 65, 161, NULL, '2015-05-18', '2015-05-24', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(867, 65, 161, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 4, NULL, 4, 4, NULL, NULL),
(868, 65, 161, NULL, '2015-06-01', '2015-06-07', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(869, 65, 161, NULL, '2015-06-08', '2015-06-14', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(870, 65, 161, NULL, '2015-06-15', '2015-06-21', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(871, 65, 161, NULL, '2015-06-22', '2015-06-28', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(872, 65, 161, NULL, '2015-06-29', '2015-07-05', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(873, 65, 161, NULL, '2015-07-06', '2015-07-12', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(874, 65, 161, NULL, '2015-07-13', '2015-07-19', 'app0', 4, NULL, NULL, 4, 4, NULL, NULL),
(875, 65, 161, NULL, '2015-07-20', '2015-07-26', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(876, 65, 161, NULL, '2015-07-27', '2015-08-02', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(877, 65, 161, NULL, '2015-08-03', '2015-08-09', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(878, 65, 161, NULL, '2015-08-10', '2015-08-16', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(879, 65, 161, NULL, '2015-08-17', '2015-08-23', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(880, 65, 161, NULL, '2015-08-24', '2015-08-30', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(881, 65, 161, NULL, '2015-08-31', '2015-09-06', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(882, 65, 161, NULL, '2015-09-07', '2015-09-13', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(883, 65, 161, NULL, '2015-09-14', '2015-09-20', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(884, 65, 161, NULL, '2015-09-21', '2015-09-27', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(885, 65, 161, NULL, '2015-09-28', '2015-10-04', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(886, 65, 161, NULL, '2015-10-05', '2015-10-11', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(887, 65, 161, NULL, '2015-10-12', '2015-10-18', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(888, 65, 161, NULL, '2015-10-19', '2015-10-25', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(889, 65, 161, NULL, '2015-10-26', '2015-11-01', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(890, 65, 161, NULL, '2015-11-02', '2015-11-08', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(891, 65, 161, NULL, '2015-11-09', '2015-11-15', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(892, 65, 161, NULL, '2015-11-16', '2015-11-22', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(893, 65, 161, NULL, '2015-11-23', '2015-11-29', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(894, 65, 161, NULL, '2015-11-30', '2015-12-06', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(895, 65, 161, NULL, '2015-12-07', '2015-12-13', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(896, 65, 161, NULL, '2015-12-14', '2015-12-20', 'app0', 4, 4, NULL, 4, 4, NULL, NULL),
(897, 65, 161, NULL, '2015-12-21', '2015-12-27', 'app0', 4, 4, NULL, NULL, NULL, NULL, NULL),
(898, 65, 161, NULL, '2015-12-28', '2016-01-03', 'app0', 4, 4, NULL, 4, NULL, NULL, NULL),
(899, 24, 179, NULL, '2015-02-16', '2015-02-22', 'app3', 0.5, NULL, 0.5, NULL, 1, NULL, NULL),
(900, 24, 74, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(901, 24, 74, NULL, '2015-03-09', '2015-03-15', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(902, 103, 73, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(903, 80, 73, NULL, '2015-07-20', '2015-07-26', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(904, 80, 73, NULL, '2015-07-27', '2015-08-02', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(905, 80, 73, NULL, '2015-06-08', '2015-06-14', 'app0', 8, 8, NULL, 8, 8, NULL, NULL),
(906, 80, 73, NULL, '2015-06-01', '2015-06-07', 'app0', 8, 8, NULL, 8, 8, NULL, NULL),
(907, 80, 73, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 8, NULL, 8, 8, NULL, NULL),
(908, 80, 73, NULL, '2015-05-18', '2015-05-24', 'app0', 8, 8, NULL, 8, 8, NULL, NULL),
(909, 80, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, NULL, NULL, 8, NULL, NULL),
(910, 80, 73, NULL, '2015-05-04', '2015-05-10', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(911, 72, 73, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(912, 39, 75, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(913, 123, 187, NULL, '2015-02-02', '2015-02-08', 'app3', 8, 8, 0, 8, 0, NULL, NULL),
(914, 123, 187, NULL, '2015-02-09', '2015-02-15', 'app3', 8, 8, 8, NULL, NULL, NULL, NULL),
(915, 123, 187, NULL, '2015-02-16', '2015-02-22', 'app3', 8, 8, 0, 0, 0, NULL, NULL),
(916, 123, 187, NULL, '2015-02-23', '2015-03-01', 'app3', 8, 8, 0, 0, 0, NULL, NULL),
(917, 37, 186, NULL, '2015-03-02', '2015-03-08', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(918, 37, 186, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(919, 37, 186, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(920, 37, 186, NULL, '2015-03-23', '2015-03-29', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(921, 37, 186, NULL, '2015-03-30', '2015-04-05', 'app0', 0, 0, NULL, NULL, NULL, NULL, NULL),
(922, 17, 186, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 0, 4, 2, 0, NULL, NULL),
(923, 17, 186, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(924, 17, 186, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(925, 17, 186, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(926, 17, 186, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(927, 86, 186, NULL, '2015-03-02', '2015-03-08', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(932, 37, 185, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(933, 37, 185, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(934, 37, 185, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(935, 37, 185, NULL, '2015-02-23', '2015-03-01', 'app3', 8, NULL, NULL, NULL, 8, NULL, NULL),
(936, 17, 185, NULL, '2015-02-02', '2015-02-08', 'app0', 2, 2, 2, 2, 2, NULL, NULL),
(937, 17, 185, NULL, '2015-02-09', '2015-02-15', 'app0', 2, 2, 2, 2, 2, NULL, NULL),
(938, 17, 185, NULL, '2015-02-16', '2015-02-22', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(939, 17, 185, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, 8, 8, 8, NULL, NULL, NULL),
(940, 86, 185, NULL, '2015-02-02', '2015-02-08', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(941, 86, 185, NULL, '2015-02-09', '2015-02-15', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(942, 86, 185, NULL, '2015-02-16', '2015-02-22', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(943, 86, 185, NULL, '2015-02-23', '2015-03-01', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(944, 101, 74, NULL, '2015-06-08', '2015-06-14', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(945, 85, 73, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(947, 85, 73, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(948, 85, 174, NULL, '2015-02-16', '2015-02-22', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(949, 85, 174, NULL, '2015-02-23', '2015-03-01', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(950, 85, 174, NULL, '2015-03-02', '2015-03-08', 'app3', 4, 8, NULL, NULL, NULL, NULL, NULL),
(951, 84, 174, NULL, '2015-02-16', '2015-02-22', 'app1', 0, 0, 0, 0, 4, NULL, NULL),
(952, 84, 174, NULL, '2015-02-23', '2015-03-01', 'app1', 0, 4, 6, 0, 0, NULL, NULL),
(953, 84, 174, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 1, 0, 0, NULL, NULL),
(954, 84, 174, NULL, '2015-03-09', '2015-03-15', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(955, 84, 174, NULL, '2015-03-16', '2015-03-22', 'app0', 0, 0, 3, 0, NULL, NULL, NULL),
(956, 84, 174, NULL, '2015-03-23', '2015-03-29', 'app0', 3, 2, 0, 0, 0, NULL, NULL),
(957, 74, 174, NULL, '2015-02-23', '2015-03-01', 'app1', 4, 0, 0, 0, 0, NULL, NULL),
(958, 74, 174, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 4, 0, NULL, NULL, NULL, NULL),
(959, 46, 191, NULL, '2015-02-02', '2015-02-08', 'app1', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(960, 46, 191, NULL, '2015-02-09', '2015-02-15', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(961, 46, 191, NULL, '2015-02-16', '2015-02-22', 'app1', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(962, 46, 191, NULL, '2015-02-23', '2015-03-01', 'app1', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(963, 46, 191, NULL, '2015-03-02', '2015-03-08', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(964, 46, 191, NULL, '2015-03-09', '2015-03-15', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(965, 46, 191, NULL, '2015-03-16', '2015-03-22', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(966, 46, 191, NULL, '2015-03-23', '2015-03-29', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(967, 46, 191, NULL, '2015-03-30', '2015-04-05', 'app3', 0.4, 0.4, NULL, NULL, NULL, NULL, NULL),
(968, 129, 189, NULL, '2015-02-02', '2015-02-08', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(969, 129, 189, NULL, '2015-02-09', '2015-02-15', 'app3', 8, 4, NULL, NULL, NULL, NULL, NULL),
(970, 129, 189, NULL, '2015-02-16', '2015-02-22', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(971, 129, 189, NULL, '2015-02-23', '2015-03-01', 'app3', 8, 4, NULL, NULL, NULL, NULL, NULL),
(972, 129, 174, NULL, '2015-02-23', '2015-03-01', 'app1', NULL, NULL, NULL, 8, 8, NULL, NULL),
(973, 129, 174, NULL, '2015-03-02', '2015-03-08', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(974, 46, 194, NULL, '2015-02-23', '2015-03-01', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(975, 24, 194, NULL, '2015-02-23', '2015-03-01', 'app3', 1, 6, NULL, NULL, NULL, NULL, NULL),
(976, 24, 179, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, 1.5, NULL, NULL, NULL, NULL, NULL),
(977, 127, 192, NULL, '2015-02-02', '2015-02-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(978, 127, 192, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(979, 127, 192, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(980, 127, 192, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(981, 127, 192, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(982, 127, 192, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 3, NULL, NULL, NULL, NULL),
(983, 127, 192, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 2, 2, NULL, NULL, NULL, NULL),
(984, 127, 192, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(985, 127, 192, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(986, 109, 192, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, 4, 4, 4, NULL, NULL, NULL),
(987, 109, 192, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(988, 109, 192, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(989, 109, 192, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(990, 109, 192, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, NULL, 4, 4, NULL, NULL, NULL),
(991, 109, 192, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(992, 109, 192, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(993, 109, 192, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(994, 109, 192, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(995, 109, 191, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(996, 109, 191, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(997, 109, 191, NULL, '2015-02-16', '2015-02-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(998, 109, 191, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(999, 109, 191, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1000, 109, 191, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1001, 109, 191, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1002, 109, 191, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1003, 109, 191, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1004, 73, 193, NULL, '2015-02-16', '2015-02-22', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(1005, 127, 185, NULL, '2015-02-02', '2015-02-08', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1006, 127, 185, NULL, '2015-02-09', '2015-02-15', 'app3', 4, 8, 0, 8, 8, NULL, NULL),
(1007, 127, 185, NULL, '2015-02-16', '2015-02-22', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1008, 127, 185, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1009, 127, 73, NULL, '2015-02-23', '2015-03-01', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1010, 66, 174, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, 1.6, 1.6, NULL, NULL),
(1011, 66, 174, NULL, '2015-03-02', '2015-03-08', 'app0', 4, 0, 0, NULL, NULL, NULL, NULL),
(1013, 17, 193, NULL, '2015-02-02', '2015-02-08', 'app3', 4, 4, NULL, 2, 2, NULL, NULL),
(1014, 17, 193, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, 6, NULL, NULL, NULL, NULL, NULL),
(1015, 17, 193, NULL, '2015-02-16', '2015-02-22', 'app3', NULL, 4, NULL, 2, NULL, NULL, NULL),
(1016, 17, 193, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1017, 17, 193, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 0, 4, 0, 6, NULL, NULL),
(1018, 17, 193, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1019, 17, 193, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1020, 17, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1021, 17, 193, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1022, 37, 193, NULL, '2015-02-02', '2015-02-08', 'app3', 8, 8, NULL, 8, 4, NULL, NULL),
(1023, 37, 193, NULL, '2015-02-09', '2015-02-15', 'app3', NULL, 2, NULL, 8, NULL, NULL, NULL),
(1024, 37, 193, NULL, '2015-02-16', '2015-02-22', 'app3', 4, 8, NULL, NULL, NULL, NULL, NULL),
(1025, 37, 193, NULL, '2015-02-23', '2015-03-01', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1026, 37, 193, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1027, 37, 193, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1028, 37, 193, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1029, 37, 193, NULL, '2015-03-23', '2015-03-29', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1030, 37, 193, NULL, '2015-03-30', '2015-04-05', 'app3', 0, 4, 0, 0, 0, NULL, NULL),
(1031, 127, 193, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1032, 127, 193, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 4, NULL, 6, NULL, NULL, NULL),
(1033, 127, 193, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1034, 127, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1035, 127, 193, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1036, 127, 186, NULL, '2015-03-02', '2015-03-08', 'app3', 6, 6.5, 8, 6, 8, NULL, NULL),
(1037, 127, 186, NULL, '2015-03-09', '2015-03-15', 'app3', 7, 4, 5, 2, 8, NULL, NULL),
(1038, 127, 186, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 6, 6, 4, 8, NULL, NULL),
(1039, 127, 186, NULL, '2015-03-23', '2015-03-29', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1040, 127, 186, NULL, '2015-03-30', '2015-04-05', 'app3', 8, 4, NULL, NULL, NULL, NULL, NULL),
(1041, 109, 198, NULL, '2015-03-02', '2015-03-08', 'app3', 8, 8, 4, 4, 4, NULL, NULL),
(1042, 109, 198, NULL, '2015-03-09', '2015-03-15', 'app3', 4, 4, 4, NULL, NULL, NULL, NULL),
(1043, 109, 198, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 6, 4, 6, NULL, NULL, NULL),
(1044, 109, 198, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, 4, 4, 3, 4, NULL, NULL),
(1045, 109, 198, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(1046, 127, 197, NULL, '2015-02-09', '2015-02-15', 'app3', 4, NULL, 8, NULL, NULL, NULL, NULL),
(1047, 109, 197, NULL, '2015-02-02', '2015-02-08', 'app3', NULL, NULL, 4, 4, NULL, NULL, NULL),
(1048, 109, 197, NULL, '2015-02-09', '2015-02-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1049, 109, 197, NULL, '2015-02-16', '2015-02-22', 'app3', 2, 2, 8, NULL, 2, NULL, NULL),
(1050, 109, 197, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, NULL, 8, 8, 4, NULL, NULL),
(1051, 129, 190, NULL, '2015-03-02', '2015-03-08', 'app3', 4, 8, 0, 4, 0, 0, 0),
(1052, 129, 190, NULL, '2015-03-09', '2015-03-15', 'app3', 4, 8, NULL, NULL, NULL, NULL, NULL),
(1053, 129, 190, NULL, '2015-03-16', '2015-03-22', 'app3', 4, 8, NULL, NULL, NULL, NULL, NULL),
(1054, 129, 190, NULL, '2015-03-23', '2015-03-29', 'app3', 4, 8, NULL, NULL, NULL, NULL, NULL),
(1055, 129, 190, NULL, '2015-03-30', '2015-04-05', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1056, 123, 188, NULL, '2015-03-02', '2015-03-08', 'app3', 8, NULL, 8, NULL, NULL, NULL, NULL),
(1057, 123, 188, NULL, '2015-03-09', '2015-03-15', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1058, 123, 188, NULL, '2015-03-16', '2015-03-22', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1059, 123, 188, NULL, '2015-03-23', '2015-03-29', 'app3', 8, NULL, NULL, NULL, 8, NULL, NULL),
(1060, 123, 188, NULL, '2015-03-30', '2015-04-05', 'app0', 3.2, 3.2, NULL, NULL, NULL, NULL, NULL),
(1061, 24, 199, NULL, '2015-02-23', '2015-03-01', 'app3', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(1062, 24, 199, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, 0.5, NULL, NULL, NULL, NULL, NULL),
(1063, 84, 109, NULL, '2015-02-23', '2015-03-01', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1064, 85, 109, NULL, '2015-02-23', '2015-03-01', 'app0', 4, 4, 4, NULL, NULL, NULL, NULL),
(1065, 84, 195, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1066, 84, 195, NULL, '2015-01-05', '2015-01-11', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1067, 84, 195, NULL, '2015-01-12', '2015-01-18', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1068, 84, 195, NULL, '2015-01-19', '2015-01-25', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1069, 84, 195, NULL, '2015-01-26', '2015-02-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1070, 84, 195, NULL, '2015-02-02', '2015-02-08', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1071, 84, 195, NULL, '2015-02-09', '2015-02-15', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1072, 84, 195, NULL, '2015-02-16', '2015-02-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1073, 84, 195, NULL, '2015-02-23', '2015-03-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1074, 84, 195, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 1.5, 0, 0, NULL, NULL),
(1075, 84, 195, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 8, 8, 8, NULL, NULL),
(1076, 84, 195, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 6, 6.5, NULL, 8, NULL, NULL),
(1077, 84, 195, NULL, '2015-03-23', '2015-03-29', 'app3', 6, 4, 4, 8, 8, NULL, NULL),
(1078, 84, 195, NULL, '2015-03-30', '2015-04-05', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1079, 84, 196, NULL, '2014-12-29', '2015-01-04', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1080, 84, 196, NULL, '2015-01-05', '2015-01-11', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1081, 84, 196, NULL, '2015-01-12', '2015-01-18', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1082, 84, 196, NULL, '2015-01-19', '2015-01-25', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1083, 84, 196, NULL, '2015-01-26', '2015-02-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1084, 84, 196, NULL, '2015-02-02', '2015-02-08', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1085, 84, 196, NULL, '2015-02-09', '2015-02-15', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1086, 84, 196, NULL, '2015-02-16', '2015-02-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1087, 84, 196, NULL, '2015-02-23', '2015-03-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1088, 84, 196, NULL, '2015-03-02', '2015-03-08', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1089, 84, 196, NULL, '2015-03-09', '2015-03-15', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1090, 84, 196, NULL, '2015-03-16', '2015-03-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1091, 84, 196, NULL, '2015-03-23', '2015-03-29', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1092, 84, 196, NULL, '2015-03-30', '2015-04-05', 'app0', 1.6, 1.6, NULL, NULL, NULL, NULL, NULL),
(1093, 24, 200, NULL, '2015-03-02', '2015-03-08', 'app3', 1, 8, NULL, NULL, NULL, NULL, NULL),
(1094, 127, 200, NULL, '2015-03-02', '2015-03-08', 'app3', 1, 1.5, NULL, NULL, NULL, NULL, NULL),
(1095, 103, 203, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, 1.5, NULL, 1.5, 1.5, NULL, NULL),
(1096, 73, 193, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, NULL, 4, 2, 0, NULL, NULL),
(1097, 73, 193, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1098, 73, 193, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1099, 73, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1100, 73, 193, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1101, 73, 186, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 0, 4, 6, 8, NULL, NULL),
(1102, 73, 186, NULL, '2015-03-09', '2015-03-15', 'app3', 3, 3, 8, 4, 8, NULL, NULL),
(1103, 73, 186, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 8, 4, 2, 4, NULL, NULL),
(1104, 73, 186, NULL, '2015-03-23', '2015-03-29', 'app3', 4, 3, 3, 3, 4, NULL, NULL),
(1105, 73, 186, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 4, NULL, NULL, NULL, NULL, NULL),
(1106, 17, 217, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 0, 0, 4, 2, NULL, NULL),
(1107, 17, 217, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1108, 17, 217, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1109, 17, 217, NULL, '2015-03-23', '2015-03-29', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(1110, 17, 217, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1111, 127, 217, NULL, '2015-03-02', '2015-03-08', 'app3', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(1112, 127, 217, NULL, '2015-03-09', '2015-03-15', 'app3', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(1113, 127, 217, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1114, 127, 217, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1115, 127, 217, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1116, 17, 73, NULL, '2015-03-02', '2015-03-08', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1117, 67, 74, NULL, '2015-03-02', '2015-03-08', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1118, 67, 74, NULL, '2015-03-23', '2015-03-29', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1119, 66, 74, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1120, 69, 74, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1121, 35, 74, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1122, 63, 229, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 8, 8, 0, 0, NULL, NULL),
(1123, 63, 228, NULL, '2015-03-02', '2015-03-08', 'app3', 8, 0, 0, 4, 0, NULL, NULL),
(1124, 69, 62, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1125, 69, 62, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1126, 69, 62, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1127, 69, 62, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1128, 69, 62, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1129, 84, 73, NULL, '2015-03-16', '2015-03-22', 'app3', 8, NULL, NULL, 8, NULL, NULL, NULL),
(1130, 74, 73, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1131, 72, 73, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1132, 76, 73, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1133, 39, 62, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, 4, 2, 4, 2, NULL, NULL),
(1134, 39, 62, NULL, '2015-03-09', '2015-03-15', 'app3', 2, 4, NULL, NULL, 4, NULL, NULL),
(1135, 39, 62, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1136, 39, 62, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1137, 39, 62, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, 2, 3.2, 3.2, 3.2, NULL, NULL),
(1138, 84, 122, NULL, '2015-03-02', '2015-03-08', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1139, 46, 154, NULL, '2015-03-02', '2015-03-08', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1140, 46, 154, NULL, '2015-03-09', '2015-03-15', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1141, 24, 154, NULL, '2015-03-02', '2015-03-08', 'app3', 1, 1, 1, 1, 1, NULL, NULL),
(1142, 24, 154, NULL, '2015-03-09', '2015-03-15', 'app3', 0.8, 10, 1, 1, 3, NULL, NULL),
(1143, 84, 111, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, 2.64, 2.64, 2.64, NULL, NULL),
(1144, 70, 75, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(1145, 63, 279, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 0, 0, 4, 8, NULL, NULL);
INSERT INTO `timesheet` (`idTimeSheet`, `idEmployee`, `idActivity`, `idOperation`, `initDate`, `endDate`, `status`, `hoursDay1`, `hoursDay2`, `hoursDay3`, `hoursDay4`, `hoursDay5`, `hoursDay6`, `hoursDay7`) VALUES
(1146, 74, 93, NULL, '2015-03-02', '2015-03-08', 'app3', 4, 4, 8, 8, 8, NULL, NULL),
(1147, 131, 169, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, NULL, 8, 8, 8, NULL, NULL),
(1148, 64, 169, NULL, '2015-03-02', '2015-03-08', 'app3', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1149, 64, 169, NULL, '2015-03-09', '2015-03-15', 'app0', 8, 8, 4.8, 4.8, 0, NULL, NULL),
(1150, 64, 169, NULL, '2015-03-16', '2015-03-22', 'app3', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1151, 66, 169, NULL, '2015-03-02', '2015-03-08', 'app3', 4, 8, 0, 0, 0, NULL, NULL),
(1152, 64, 172, NULL, '2015-03-02', '2015-03-08', 'app3', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1153, 64, 172, NULL, '2015-03-09', '2015-03-15', 'app0', 3.2, 3.2, 8, 8, 0, NULL, NULL),
(1154, 64, 172, NULL, '2015-03-16', '2015-03-22', 'app3', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1155, 66, 172, NULL, '2015-03-02', '2015-03-08', 'app3', 0, 0, 8, 8, 8, NULL, NULL),
(1156, 53, 296, NULL, '2015-03-02', '2015-03-08', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1157, 53, 296, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1158, 53, 296, NULL, '2015-03-16', '2015-03-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1159, 53, 296, NULL, '2015-03-23', '2015-03-29', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(1160, 131, 74, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 8, NULL, NULL, 8, NULL, NULL),
(1161, 17, 198, NULL, '2015-03-02', '2015-03-08', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1162, 17, 198, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1163, 17, 198, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1164, 17, 198, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1165, 17, 198, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1166, 123, 73, NULL, '2015-03-09', '2015-03-15', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1167, 24, 371, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 0.24, NULL, NULL, NULL, NULL),
(1168, 24, 371, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1169, 24, 371, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1170, 46, 371, NULL, '2015-03-09', '2015-03-15', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1171, 46, 371, NULL, '2015-03-16', '2015-03-22', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1172, 46, 371, NULL, '2015-03-23', '2015-03-29', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1173, 24, 369, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 0.24, NULL, NULL, NULL, NULL),
(1174, 24, 369, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1175, 24, 369, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(1176, 46, 369, NULL, '2015-03-09', '2015-03-15', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1177, 46, 369, NULL, '2015-03-16', '2015-03-22', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1178, 46, 369, NULL, '2015-03-23', '2015-03-29', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1179, 46, 370, NULL, '2015-03-09', '2015-03-15', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1180, 46, 370, NULL, '2015-03-16', '2015-03-22', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1181, 46, 370, NULL, '2015-03-23', '2015-03-29', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1182, 24, 370, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 0.24, NULL, NULL, NULL, NULL),
(1183, 24, 370, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1184, 24, 370, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1185, 71, 195, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1186, 24, 373, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, NULL, 3, 1, NULL, NULL),
(1187, 24, 373, NULL, '2015-03-16', '2015-03-22', 'app3', 0.8, 1, 2, 2, 2, NULL, NULL),
(1188, 24, 373, NULL, '2015-03-23', '2015-03-29', 'app3', 1, 2, 4, 4, 2, NULL, NULL),
(1189, 66, 172, NULL, '2015-03-09', '2015-03-15', 'app3', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1190, 66, 172, NULL, '2015-03-16', '2015-03-22', 'app3', 0, 0, 8, 8, 0, NULL, NULL),
(1191, 63, 265, NULL, '2015-03-09', '2015-03-15', 'app3', 0, 0, 0, 8, 8, NULL, NULL),
(1192, 63, 229, NULL, '2015-03-09', '2015-03-15', 'app3', 0, 8, 8, 0, 0, NULL, NULL),
(1193, 63, 228, NULL, '2015-03-09', '2015-03-15', 'app3', 8, 0, 0, 0, 0, NULL, NULL),
(1194, 66, 169, NULL, '2015-03-09', '2015-03-15', 'app3', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1195, 66, 169, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 8, 0, 0, 0, NULL, NULL),
(1196, 131, 172, NULL, '2015-03-09', '2015-03-15', 'app3', 8, 0, 8, 8, 0, NULL, NULL),
(1197, 82, 376, NULL, '2015-03-02', '2015-03-08', 'app1', 4, 8, NULL, NULL, NULL, NULL, NULL),
(1198, 35, 375, NULL, '2015-03-02', '2015-03-08', 'app0', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(1199, 82, 380, NULL, '2015-03-02', '2015-03-08', 'app1', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1200, 65, 387, NULL, '2015-03-09', '2015-03-15', 'app1', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1201, 117, 387, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1202, 81, 386, NULL, '2015-03-09', '2015-03-15', 'app1', 8, 8, 8, 0, 0, NULL, NULL),
(1203, 117, 385, NULL, '2015-03-09', '2015-03-15', 'app0', 4.8, 4.8, 4.8, 4.8, NULL, NULL, NULL),
(1204, 37, 73, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1205, 84, 373, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, 1.2, NULL, NULL),
(1206, 84, 373, NULL, '2015-03-16', '2015-03-22', 'app3', 1.2, 1.2, 1.5, 1.2, 1.2, NULL, NULL),
(1207, 84, 373, NULL, '2015-03-23', '2015-03-29', 'app3', 2, 4, 4, 1.2, 1.2, NULL, NULL),
(1208, 53, 75, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1209, 109, 193, NULL, '2015-03-02', '2015-03-08', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1210, 109, 193, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1211, 109, 193, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1212, 109, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1213, 109, 193, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1214, 124, NULL, 4, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1216, 86, 81, NULL, '2015-03-02', '2015-03-08', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1217, 86, 81, NULL, '2015-03-09', '2015-03-15', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1218, 86, 81, NULL, '2015-03-16', '2015-03-22', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1219, 86, 81, NULL, '2015-03-23', '2015-03-29', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1220, 86, 81, NULL, '2015-03-30', '2015-04-05', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1221, 124, 75, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1222, 74, 93, NULL, '2015-03-09', '2015-03-15', 'app1', 8, 8, 8, 8, 8, NULL, NULL),
(1223, 70, 406, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1224, 70, 406, NULL, '2015-03-16', '2015-03-22', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(1225, 70, 416, NULL, '2015-03-09', '2015-03-15', 'app3', 0, 0, 6, 0, 0, NULL, NULL),
(1226, 70, 413, NULL, '2015-03-09', '2015-03-15', 'app3', 0, 0, 0, 8, 4, NULL, NULL),
(1227, 70, 396, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, 4, 2, 0, 0, NULL, NULL),
(1228, 70, 393, NULL, '2015-03-09', '2015-03-15', 'app3', 8, 4, 0, 0, 0, NULL, NULL),
(1230, 129, 174, NULL, '2015-03-09', '2015-03-15', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1231, 129, 193, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1232, 129, 193, NULL, '2015-03-16', '2015-03-22', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1233, 129, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1234, 129, 193, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1235, 24, 417, NULL, '2015-03-09', '2015-03-15', 'app3', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(1236, 24, 417, NULL, '2015-03-16', '2015-03-22', 'app3', 2, 1.5, NULL, 1.5, NULL, NULL, NULL),
(1237, 46, 154, NULL, '2015-03-16', '2015-03-22', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1238, 24, 154, NULL, '2015-03-16', '2015-03-22', 'app3', 6, 0.8, 1.5, 0.8, 1, NULL, NULL),
(1239, 82, 441, NULL, '2015-03-02', '2015-03-08', 'app1', NULL, NULL, NULL, 2, 7, NULL, NULL),
(1240, 82, 445, NULL, '2015-03-02', '2015-03-08', 'app1', NULL, NULL, 8, 6, NULL, NULL, NULL),
(1241, 82, 445, NULL, '2015-03-09', '2015-03-15', 'app1', 7.2, 7.2, 7.2, 7.2, 7.2, NULL, NULL),
(1242, 117, 419, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1243, 80, 429, NULL, '2015-03-23', '2015-03-29', 'app1', 0.8, NULL, NULL, NULL, NULL, NULL, NULL),
(1244, 80, 429, NULL, '2015-03-16', '2015-03-22', 'app1', 8, 8, 6, 8, 8, NULL, NULL),
(1245, 80, 437, NULL, '2015-03-23', '2015-03-29', 'app1', 7.2, 8, 8, 8, 2, NULL, NULL),
(1246, 69, 73, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1247, 69, 73, NULL, '2015-03-23', '2015-03-29', 'app3', 8, 8, 8, NULL, NULL, NULL, NULL),
(1248, 85, 73, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 8, 8, NULL, NULL, NULL, NULL),
(1249, 72, 417, NULL, '2015-03-09', '2015-03-15', 'app0', NULL, NULL, NULL, NULL, 0.8, NULL, NULL),
(1250, 72, 417, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1251, 66, 193, NULL, '2015-03-16', '2015-03-22', 'app3', 0, 0, 0, 0, 8, NULL, NULL),
(1252, 66, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1253, 66, 193, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 0, NULL, NULL, NULL, NULL, NULL),
(1254, 131, 193, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 0, 0, 0, 0, NULL, NULL),
(1255, 131, 193, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1256, 131, 193, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 0, NULL, NULL, NULL, NULL, NULL),
(1257, 74, 195, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 1.6, 0, 0, 0, NULL, NULL),
(1258, 71, 195, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1259, 24, 194, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, 1, 2, NULL, NULL, NULL),
(1260, 24, 194, NULL, '2015-03-23', '2015-03-29', 'app3', 1, 0.5, NULL, NULL, NULL, NULL, NULL),
(1261, 74, 93, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 6.4, 8, 4, 8, NULL, NULL),
(1262, 74, 93, NULL, '2015-03-23', '2015-03-29', 'app3', 7, 8, 8, 8, 8, NULL, NULL),
(1263, 63, 276, NULL, '2015-03-16', '2015-03-22', 'app3', 8, 8, 0, 0, 0, NULL, NULL),
(1264, 63, 264, NULL, '2015-03-16', '2015-03-22', 'app3', 0, 0, 8, 0, 0, NULL, NULL),
(1265, 63, 265, NULL, '2015-03-16', '2015-03-22', 'app3', 0, 0, 0, 8, 8, NULL, NULL),
(1266, 131, 172, NULL, '2015-03-16', '2015-03-22', 'app3', 0, 8, 8, 8, 8, NULL, NULL),
(1267, 77, 170, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1268, 77, 170, NULL, '2015-03-09', '2015-03-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1269, 77, 170, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1270, 77, 170, NULL, '2015-03-23', '2015-03-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1271, 77, 170, NULL, '2015-03-30', '2015-04-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1272, 77, 170, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1273, 77, 170, NULL, '2015-04-13', '2015-04-19', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1274, 77, 170, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1275, 77, 170, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1276, 77, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1277, 77, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1278, 77, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1279, 77, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1280, 77, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1281, 77, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1282, 77, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1283, 77, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1284, 77, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1285, 77, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1286, 77, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1287, 77, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1288, 77, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1289, 77, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1290, 77, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1291, 77, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1292, 77, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1293, 77, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1294, 77, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1295, 77, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1296, 77, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1297, 77, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1298, 77, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1299, 77, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1300, 77, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1301, 77, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1302, 77, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1303, 77, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1304, 77, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1305, 77, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1306, 77, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1307, 77, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1308, 77, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1309, 77, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1310, 77, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1311, 79, 170, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1312, 79, 170, NULL, '2015-03-09', '2015-03-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1313, 79, 170, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1314, 79, 170, NULL, '2015-03-23', '2015-03-29', 'app1', 0, 0, 0, 0, 2, NULL, NULL),
(1315, 79, 170, NULL, '2015-03-30', '2015-04-05', 'app1', 0, 0, 0, 4, 0, NULL, NULL),
(1316, 79, 170, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 4, 2, 4, 0, NULL, NULL),
(1317, 79, 170, NULL, '2015-04-13', '2015-04-19', 'app1', 2, 2, 0, 0, 0, NULL, NULL),
(1318, 79, 170, NULL, '2015-04-20', '2015-04-26', 'app1', 0, 8, 0, 0, 0, NULL, NULL),
(1319, 79, 170, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1320, 79, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1321, 79, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1322, 79, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1323, 79, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1324, 79, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1325, 79, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1326, 79, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1327, 79, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1328, 79, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1329, 79, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1330, 79, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1331, 79, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1332, 79, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1333, 79, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1334, 79, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1335, 79, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1336, 79, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1337, 79, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1338, 79, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1339, 79, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1340, 79, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1341, 79, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1342, 79, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1343, 79, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1344, 79, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1345, 79, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1346, 79, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1347, 79, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1348, 79, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1349, 79, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1350, 79, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1351, 79, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1352, 79, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1353, 79, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1354, 79, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1355, 81, 170, NULL, '2015-03-02', '2015-03-08', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1356, 81, 170, NULL, '2015-03-09', '2015-03-15', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1357, 81, 170, NULL, '2015-03-16', '2015-03-22', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1358, 81, 170, NULL, '2015-03-23', '2015-03-29', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1359, 81, 170, NULL, '2015-03-30', '2015-04-05', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1360, 81, 170, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1361, 81, 170, NULL, '2015-04-13', '2015-04-19', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1362, 81, 170, NULL, '2015-04-20', '2015-04-26', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1363, 81, 170, NULL, '2015-04-27', '2015-05-03', 'app1', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1364, 81, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1365, 81, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1366, 81, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1367, 81, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1368, 81, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1369, 81, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1370, 81, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1371, 81, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1372, 81, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1373, 81, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1374, 81, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1375, 81, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1376, 81, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1377, 81, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1378, 81, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1379, 81, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1380, 81, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1381, 81, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1382, 81, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1383, 81, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1384, 81, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1385, 81, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1386, 81, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1387, 81, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1388, 81, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1389, 81, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1390, 81, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1391, 81, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1392, 81, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1393, 81, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1394, 81, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1395, 81, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1396, 81, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1397, 81, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1398, 81, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1399, 80, 170, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1400, 80, 170, NULL, '2015-03-09', '2015-03-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1401, 80, 170, NULL, '2015-03-16', '2015-03-22', 'app1', 0, 0, 2, 0, 0, NULL, NULL),
(1402, 80, 170, NULL, '2015-03-23', '2015-03-29', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1403, 80, 170, NULL, '2015-03-30', '2015-04-05', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1404, 80, 170, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(1405, 80, 170, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1406, 80, 170, NULL, '2015-04-20', '2015-04-26', 'app1', 0, 0, 0, 2, 0, NULL, NULL),
(1407, 80, 170, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1408, 80, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1409, 80, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1410, 80, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1411, 80, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1412, 80, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1413, 80, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1414, 80, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1415, 80, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1416, 80, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1417, 80, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1418, 80, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1419, 80, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1420, 80, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1421, 80, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1422, 80, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1423, 80, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1424, 80, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1425, 80, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1426, 80, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1427, 80, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1428, 80, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1429, 80, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1430, 80, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1431, 80, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1432, 80, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1433, 80, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1434, 80, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1435, 80, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1436, 80, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1437, 80, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1438, 80, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1439, 80, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1440, 80, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1441, 80, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1442, 80, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1443, 82, 170, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1444, 82, 170, NULL, '2015-03-09', '2015-03-15', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1445, 82, 170, NULL, '2015-03-16', '2015-03-22', 'app1', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1446, 82, 170, NULL, '2015-03-23', '2015-03-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1447, 82, 170, NULL, '2015-03-30', '2015-04-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1448, 82, 170, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 0, 2, 2, 0, NULL, NULL),
(1449, 82, 170, NULL, '2015-04-13', '2015-04-19', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1450, 82, 170, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1451, 82, 170, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1452, 82, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1453, 82, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1454, 82, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1455, 82, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1456, 82, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1457, 82, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1458, 82, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1459, 82, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1460, 82, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1461, 82, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1462, 82, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1463, 82, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1464, 82, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1465, 82, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1466, 82, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1467, 82, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1468, 82, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1469, 82, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1470, 82, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1471, 82, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1472, 82, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1473, 82, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1474, 82, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1475, 82, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1476, 82, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1477, 82, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1478, 82, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1479, 82, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1480, 82, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1481, 82, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1482, 82, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1483, 82, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1484, 82, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1485, 82, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1486, 82, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1487, 72, 497, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 2.56, NULL, NULL, NULL, NULL, NULL),
(1488, 72, 496, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, 5.12, NULL, NULL, NULL, NULL, NULL),
(1489, 70, 498, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, NULL, 2, NULL, NULL),
(1490, 70, 495, NULL, '2015-03-16', '2015-03-22', 'app3', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(1493, 70, 403, NULL, '2015-03-16', '2015-03-22', 'app3', 6, 6, NULL, NULL, NULL, NULL, NULL),
(1494, 81, 420, NULL, '2015-03-16', '2015-03-22', 'app1', NULL, 6, NULL, NULL, 8, NULL, NULL),
(1495, 81, 386, NULL, '2015-03-16', '2015-03-22', 'app1', NULL, 2, 2, NULL, NULL, NULL, NULL),
(1496, 117, 385, NULL, '2015-03-16', '2015-03-22', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1497, 77, 514, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, 6, 8, NULL, NULL),
(1498, 76, 514, NULL, '2015-03-16', '2015-03-22', 'app0', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1499, 82, 173, NULL, '2015-03-16', '2015-03-22', 'app1', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1500, 81, 173, NULL, '2015-03-16', '2015-03-22', 'app1', 8, NULL, NULL, 6, NULL, NULL, NULL),
(1501, 84, 110, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1502, 84, 110, NULL, '2015-03-23', '2015-03-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1503, 55, 492, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, 1.04, 4, NULL, NULL, NULL),
(1504, 109, 373, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1505, 109, 373, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, 2, 1, 4, NULL, NULL, NULL),
(1506, 65, 541, NULL, '2015-03-16', '2015-03-22', 'app1', NULL, NULL, NULL, 2.6, NULL, NULL, NULL),
(1507, 65, 546, NULL, '2015-03-16', '2015-03-22', 'app1', NULL, NULL, NULL, NULL, 6.16, NULL, NULL),
(1508, 117, 550, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1509, 117, 549, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, 8, 8, NULL, NULL, NULL),
(1510, 85, 291, NULL, '2015-03-16', '2015-03-22', 'app3', 4, 4, 4, 4, 4, NULL, NULL),
(1511, 131, 253, NULL, '2015-03-23', '2015-03-29', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1512, 131, 74, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1513, 131, 74, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1514, 53, 74, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1515, 53, 74, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1516, 53, 74, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1517, 37, 74, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1518, 37, 74, NULL, '2015-05-04', '2015-05-10', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1519, 66, 74, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, NULL, 8, 8, NULL, NULL, NULL),
(1520, 17, 73, NULL, '2015-03-16', '2015-03-22', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1521, 37, 74, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1522, 17, 73, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1523, 17, 73, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1524, 17, 73, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1525, 17, 73, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1526, 17, 73, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1527, 17, 73, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1528, 17, 73, NULL, '2015-05-04', '2015-05-10', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1529, 17, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1530, 17, 73, NULL, '2015-05-18', '2015-05-24', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1531, 17, 73, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1532, 17, 73, NULL, '2015-06-01', '2015-06-07', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1533, 17, 73, NULL, '2015-06-08', '2015-06-14', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1534, 37, 73, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1535, 37, 73, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1536, 39, 73, NULL, '2015-05-04', '2015-05-10', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(1537, 39, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(1538, 39, 73, NULL, '2015-05-18', '2015-05-24', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1539, 63, 73, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1540, 63, 73, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1541, 63, 73, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1542, 63, 73, NULL, '2015-05-04', '2015-05-10', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1543, 63, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(1544, 63, 73, NULL, '2015-06-15', '2015-06-21', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1545, 63, 73, NULL, '2015-06-22', '2015-06-28', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1546, 65, 73, NULL, '2015-03-23', '2015-03-29', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1547, 66, 73, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1548, 66, 73, NULL, '2015-06-01', '2015-06-07', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1549, 67, 73, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1550, 67, 73, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1551, 67, 73, NULL, '2015-04-27', '2015-05-03', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1552, 71, 73, NULL, '2015-07-27', '2015-08-02', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1553, 71, 73, NULL, '2015-08-03', '2015-08-09', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1554, 71, 73, NULL, '2015-08-17', '2015-08-23', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1555, 74, 73, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1556, 84, 73, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1557, 109, 73, NULL, '2015-04-13', '2015-04-19', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1558, 109, 73, NULL, '2015-04-20', '2015-04-26', 'app1', 8, 8, 8, 8, 8, NULL, NULL),
(1559, 117, 73, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1560, 117, 73, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1561, 117, 73, NULL, '2015-04-13', '2015-04-19', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1562, 117, 73, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1563, 117, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1564, 117, 73, NULL, '2015-05-18', '2015-05-24', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1565, 124, 75, NULL, '2015-03-16', '2015-03-22', 'app0', 8, NULL, 8, NULL, NULL, NULL, NULL),
(1566, 124, 75, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1567, 75, 74, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1568, 39, 74, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, 4, NULL, NULL, 8, NULL, NULL),
(1569, 84, 73, NULL, '2015-08-24', '2015-08-30', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1570, 84, 73, NULL, '2015-08-31', '2015-09-06', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1571, 84, 73, NULL, '2015-07-13', '2015-07-19', 'app0', 8, NULL, 8, 8, 8, NULL, NULL),
(1572, 66, 195, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1573, 63, 195, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, 0, NULL, NULL, NULL, NULL),
(1574, 109, 558, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, 1, 1, 1, NULL, NULL, NULL),
(1575, 80, 173, NULL, '2015-03-23', '2015-03-29', 'app1', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(1576, 55, 567, NULL, '2015-03-16', '2015-03-22', 'app3', 0, 0, 2, 0, 8, NULL, NULL),
(1577, 55, 567, NULL, '2015-03-23', '2015-03-29', 'app3', 0, 8, 8, 8, 8, NULL, NULL),
(1578, 77, 74, NULL, '2015-03-30', '2015-04-05', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1579, 102, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(1580, 102, 73, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1581, 81, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1582, 101, 369, NULL, '2015-03-23', '2015-03-29', 'app3', 0, 0, 0, 0, 1, NULL, NULL),
(1583, 70, 369, NULL, '2015-03-23', '2015-03-29', 'app3', 4, 0, 0, 0, 0, NULL, NULL),
(1584, 124, 75, NULL, '2015-03-23', '2015-03-29', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1585, 72, 73, NULL, '2015-04-13', '2015-04-19', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1586, 72, 73, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(1589, 39, 575, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(1590, 39, 575, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, NULL, 1, NULL, NULL),
(1591, 39, 576, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, 1, NULL, NULL, NULL, NULL),
(1592, 39, 576, NULL, '2015-03-23', '2015-04-05', 'app0', 1.5, 1.5, NULL, NULL, NULL, NULL, NULL),
(1593, 86, 81, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(1594, 74, 195, NULL, '2015-03-23', '2015-03-29', 'app3', 1, NULL, NULL, NULL, NULL, NULL, NULL),
(1595, 24, 373, NULL, '2015-03-30', '2015-04-05', 'app3', 3, 3, 0.8, 0.8, 1, NULL, NULL),
(1596, 64, 169, NULL, '2015-03-23', '2015-03-29', 'app3', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1597, 66, 169, NULL, '2015-03-23', '2015-03-29', 'app3', 3.2, 3.2, 4, 3.2, 3.2, NULL, NULL),
(1598, 66, 172, NULL, '2015-03-23', '2015-03-29', 'app3', 8, 8, 4.8, 4.8, 4.8, NULL, NULL),
(1599, 64, 172, NULL, '2015-03-23', '2015-03-29', 'app3', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1600, 74, 577, NULL, '2015-03-30', '2015-04-05', 'app3', 0, 0, 0, 4, 4, NULL, NULL),
(1601, 81, 385, NULL, '2015-03-23', '2015-03-29', 'app1', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1602, 117, 419, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1603, 81, 420, NULL, '2015-03-23', '2015-03-29', 'app1', 4.4, 4.4, 4.4, 4.4, 4.4, NULL, NULL),
(1604, 117, 549, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1605, 117, 550, NULL, '2015-03-23', '2015-03-29', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1606, 131, 172, NULL, '2015-03-23', '2015-03-29', 'app3', 0, 0, 0, 8, 8, NULL, NULL),
(1607, 63, 276, NULL, '2015-03-23', '2015-03-29', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1608, 63, 265, NULL, '2015-03-23', '2015-03-29', 'app3', NULL, NULL, 4, 8, 8, NULL, NULL),
(1609, 65, 381, NULL, '2015-03-23', '2015-03-29', 'app1', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1610, 70, 73, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1611, 70, 73, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(1612, 70, 73, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1613, 65, 73, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, 8, 8, NULL, NULL),
(1614, 65, 73, NULL, '2015-04-20', '2015-04-26', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1615, 65, 73, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1617, 131, 172, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 0, 8, 8, 8, NULL, NULL),
(1618, 66, 172, NULL, '2015-03-30', '2015-04-05', 'app3', 4, 4, 4.8, 4.8, 4.8, NULL, NULL),
(1619, 66, 169, NULL, '2015-03-30', '2015-04-05', 'app3', 0, 4, 3.2, 3.2, 3.2, NULL, NULL),
(1620, 46, 154, NULL, '2015-03-23', '2015-03-29', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1621, 46, 154, NULL, '2015-03-30', '2015-04-05', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1622, 46, 154, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1623, 24, 154, NULL, '2015-03-23', '2015-03-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1624, 24, 154, NULL, '2015-03-30', '2015-04-05', 'app3', 1.5, 0.8, 1, 0.8, 0.8, NULL, NULL),
(1625, 24, 154, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 0.8, 2, 0.8, 0.8, NULL, NULL),
(1626, 81, 420, NULL, '2015-03-30', '2015-04-05', 'app1', 6, 6, 4, 4, 8, NULL, NULL),
(1627, 37, 193, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1628, 73, 204, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 2, 2, 4, NULL, NULL),
(1629, 73, 204, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 2, 2, 2, 4, NULL, NULL),
(1630, 73, 204, NULL, '2015-04-13', '2015-04-19', 'app3', 2, 2, 4, 4, 4, NULL, NULL),
(1631, 73, 204, NULL, '2015-04-20', '2015-04-26', 'app3', 2, 2, 6, 4, 4, NULL, NULL),
(1632, 73, 204, NULL, '2015-04-27', '2015-05-03', 'app3', 2, 4, 4, 4, NULL, NULL, NULL),
(1633, 17, 204, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1634, 17, 204, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, 8, 8, 8, NULL, NULL),
(1635, 17, 204, NULL, '2015-04-13', '2015-04-19', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1636, 17, 204, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1637, 17, 204, NULL, '2015-04-27', '2015-05-03', 'app3', 8, 8, 8, 8, NULL, NULL, NULL),
(1638, 37, 204, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 0, 1, 0, NULL, NULL),
(1639, 37, 204, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 2, 2, 2, 2, NULL, NULL),
(1640, 37, 204, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1641, 37, 204, NULL, '2015-04-20', '2015-04-26', 'app0', 2, 2, 2, 2, 2, NULL, NULL),
(1642, 37, 204, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1643, 127, 204, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 8, 8, 8, NULL, NULL),
(1644, 127, 204, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1645, 127, 204, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, 8, 8, 8, NULL, NULL),
(1646, 127, 204, NULL, '2015-04-20', '2015-04-26', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1647, 127, 204, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(1648, 17, 218, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1649, 17, 218, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1650, 17, 218, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1651, 17, 218, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1652, 17, 218, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1653, 109, 585, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 8, 8, 4, NULL, NULL),
(1654, 109, 585, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 3, 3, 3, 4, NULL, NULL),
(1655, 109, 585, NULL, '2015-04-13', '2015-04-19', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(1656, 17, 585, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(1657, 17, 585, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1658, 17, 585, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1659, 17, 585, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1660, 17, 585, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1661, 84, 605, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 8, 4, 4, NULL, NULL),
(1662, 84, 605, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, 4, 6, 8, NULL, NULL),
(1663, 84, 605, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 4, 7, 5, 8, NULL, NULL),
(1664, 84, 605, NULL, '2015-04-20', '2015-04-26', 'app3', 4, 2, 4, 8, 8, NULL, NULL),
(1665, 84, 605, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1666, 84, 605, NULL, '2015-05-04', '2015-05-10', 'app0', 2.4, 2.4, 2.4, 2.4, NULL, NULL, NULL),
(1667, 84, 605, NULL, '2015-05-11', '2015-05-17', 'app0', 2.4, 2.4, 2.4, NULL, 2.4, NULL, NULL),
(1668, 84, 605, NULL, '2015-05-18', '2015-05-24', 'app0', 2.4, 2.4, 2.4, 2.4, 2.4, NULL, NULL),
(1669, 84, 605, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 2.4, 2.4, 2.4, 2.4, NULL, NULL),
(1670, 109, 605, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1671, 109, 605, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, 1, 5, 2, NULL, NULL),
(1672, 109, 605, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1673, 109, 605, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1674, 109, 605, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1675, 109, 605, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1676, 109, 605, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1677, 109, 605, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1678, 109, 605, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1679, 71, 605, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0, 0, 0, NULL, NULL),
(1680, 71, 605, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(1681, 71, 605, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1682, 71, 605, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1683, 71, 605, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1684, 71, 605, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1685, 71, 605, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1686, 71, 605, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1687, 71, 605, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL);
INSERT INTO `timesheet` (`idTimeSheet`, `idEmployee`, `idActivity`, `idOperation`, `initDate`, `endDate`, `status`, `hoursDay1`, `hoursDay2`, `hoursDay3`, `hoursDay4`, `hoursDay5`, `hoursDay6`, `hoursDay7`) VALUES
(1688, 65, 571, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1689, 65, 592, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1690, 65, 430, NULL, '2015-03-30', '2015-04-05', 'app1', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1691, 65, 597, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1692, 71, 591, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, 4, 4, 4, NULL, NULL),
(1693, 70, 593, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1694, 71, 596, NULL, '2015-03-30', '2015-04-05', 'app3', 6, NULL, NULL, NULL, NULL, NULL, NULL),
(1695, 71, 596, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1696, 70, 598, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, 6, NULL, NULL, NULL),
(1697, 70, 595, NULL, '2015-03-30', '2015-04-05', 'app0', 2, 8, 2, NULL, NULL, NULL, NULL),
(1698, 71, 570, NULL, '2015-03-23', '2015-03-29', 'app0', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1699, 70, 572, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(1700, 70, 569, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1701, 70, 602, NULL, '2015-03-30', '2015-04-05', 'app0', 6, NULL, NULL, NULL, NULL, NULL, NULL),
(1702, 72, 601, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(1703, 70, 603, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, 2, 2, NULL, NULL, NULL),
(1704, 70, 600, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1705, 81, 420, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 4, 6, 2, NULL, NULL, NULL),
(1706, 80, 430, NULL, '2015-03-30', '2015-04-05', 'app1', NULL, NULL, 8, 4, NULL, NULL, NULL),
(1707, 79, 341, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1708, 77, 346, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, 7.5200000000000005, 7.5200000000000005, 7.5200000000000005, 7.5200000000000005, NULL, NULL),
(1709, 79, 502, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1710, 77, 514, NULL, '2015-03-23', '2015-03-29', 'app0', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(1711, 80, 438, NULL, '2015-03-30', '2015-04-05', 'app1', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1712, 132, 621, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, 8, 8, 8, NULL, NULL),
(1713, 74, 621, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 8, NULL, 4, 4, NULL, NULL),
(1714, 73, 74, NULL, '2015-06-08', '2015-06-14', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1715, 117, 74, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1716, 101, 74, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(1717, 66, 74, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1718, 55, 577, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1719, 132, 577, NULL, '2015-03-30', '2015-04-05', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(1720, 55, 620, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1721, 76, 73, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1722, 71, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(1723, 79, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(1724, 79, 73, NULL, '2015-05-18', '2015-05-24', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(1725, 131, 73, NULL, '2015-04-20', '2015-04-26', 'app1', 8, 8, 8, 8, 8, NULL, NULL),
(1726, 101, 73, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(1727, 101, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1728, 72, 604, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(1729, 70, 604, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, 8, 6, NULL, NULL, NULL, NULL),
(1730, 74, 583, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(1731, 71, 583, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, NULL, 6, NULL, NULL, NULL),
(1732, 71, 171, NULL, '2015-03-30', '2015-04-05', 'app3', 2, 4, NULL, NULL, NULL, NULL, NULL),
(1733, 70, 171, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 6, NULL, NULL, NULL, NULL),
(1734, 72, 171, NULL, '2015-03-23', '2015-03-29', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(1735, 70, 171, NULL, '2015-03-23', '2015-03-29', 'app0', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1736, 72, 168, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1737, 84, 606, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 1.6, 1.6, 1.6, NULL, NULL),
(1738, 24, 373, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, NULL, 1.5, NULL, NULL, NULL, NULL),
(1739, 82, 173, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 0, 0, 2, 0, NULL, NULL),
(1740, 82, 173, NULL, '2015-04-13', '2015-04-19', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1741, 82, 173, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1742, 82, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1743, 82, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1744, 82, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1745, 82, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1746, 82, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1747, 82, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1748, 82, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1749, 82, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1750, 82, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1751, 82, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1752, 81, 173, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1753, 81, 173, NULL, '2015-04-13', '2015-04-19', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1754, 81, 173, NULL, '2015-04-20', '2015-04-26', 'app1', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1755, 81, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1756, 81, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1757, 81, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1758, 81, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1759, 81, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1760, 81, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1761, 81, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1762, 81, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1763, 81, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1764, 81, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1765, 80, 173, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 0, 4, 2, 0, NULL, NULL),
(1766, 80, 173, NULL, '2015-04-13', '2015-04-19', 'app1', 0, 2, 2, 0, 0, NULL, NULL),
(1767, 80, 173, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1768, 80, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1769, 80, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1770, 80, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1771, 80, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1772, 80, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1773, 80, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1774, 80, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1775, 80, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1776, 80, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1777, 80, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1778, 79, 173, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(1779, 79, 173, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1780, 79, 173, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 8, 0, 0, 0, NULL, NULL),
(1781, 79, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1782, 79, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1783, 79, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1784, 79, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1785, 79, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1786, 79, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1787, 79, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1788, 79, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1789, 79, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1790, 79, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1791, 77, 173, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1792, 77, 173, NULL, '2015-04-13', '2015-04-19', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1793, 77, 173, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1794, 77, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1795, 77, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1796, 77, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1797, 77, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1798, 77, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1799, 77, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1800, 77, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1801, 77, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1802, 77, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1803, 77, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1804, 77, 73, NULL, '2015-03-16', '2015-03-22', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1805, 77, 73, NULL, '2015-03-23', '2015-03-29', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1806, 84, 583, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, 1, 1, 0, NULL, NULL),
(1807, 84, 583, NULL, '2015-04-13', '2015-04-19', 'app3', 6, 4, 1, 3, NULL, NULL, NULL),
(1808, 84, 583, NULL, '2015-04-20', '2015-04-26', 'app3', 4, 2, 4, NULL, NULL, NULL, NULL),
(1809, 84, 583, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(1810, 84, 583, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1811, 84, 583, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1813, 109, 635, NULL, '2015-03-30', '2015-04-05', 'app1', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1814, 109, 635, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 1, NULL, NULL, 2, NULL, NULL),
(1815, 109, 635, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1816, 109, 635, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1817, 109, 635, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1818, 84, 635, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0.4, 0.4, 0.4, NULL, NULL),
(1819, 84, 635, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1820, 84, 635, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1821, 84, 635, NULL, '2015-04-20', '2015-04-26', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1822, 84, 635, NULL, '2015-04-27', '2015-05-03', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(1823, 71, 635, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0, 0, 0, NULL, NULL),
(1824, 71, 635, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(1825, 71, 635, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1826, 71, 635, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1827, 71, 635, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1828, 109, 213, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1829, 84, 606, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 1.6, 3, 1, 1.6, NULL, NULL),
(1830, 84, 373, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(1831, 84, 373, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 1.2, 1.2, 1.2, 1.2, NULL, NULL),
(1832, 84, 373, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1833, 65, 421, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, NULL, NULL, 4, 8, NULL, NULL),
(1834, 66, 172, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1835, 66, 172, NULL, '2015-04-13', '2015-04-19', 'app3', 4.8, 1.8, 4.8, 4.8, 4.8, NULL, NULL),
(1836, 66, 172, NULL, '2015-04-20', '2015-04-26', 'app3', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1837, 66, 172, NULL, '2015-04-27', '2015-05-03', 'app3', 4.8, 4.8, 0, 0, NULL, NULL, NULL),
(1838, 66, 172, NULL, '2015-05-04', '2015-05-10', 'app0', 4.8, 4.8, 4.8, 4.8, NULL, NULL, NULL),
(1839, 66, 172, NULL, '2015-05-11', '2015-05-17', 'app0', 4.8, 4.8, 4.8, NULL, 4.8, NULL, NULL),
(1840, 66, 172, NULL, '2015-05-18', '2015-05-24', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1841, 66, 172, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(1842, 66, 169, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1843, 66, 169, NULL, '2015-04-13', '2015-04-19', 'app3', 3.2, 2.2, 3.2, 3.2, 3.2, NULL, NULL),
(1844, 66, 169, NULL, '2015-04-20', '2015-04-26', 'app3', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1845, 66, 169, NULL, '2015-04-27', '2015-05-03', 'app3', 3.2, 3.2, 0, 0, NULL, NULL, NULL),
(1846, 66, 169, NULL, '2015-05-04', '2015-05-10', 'app0', 3.2, 3.2, 3.2, 3.2, NULL, NULL, NULL),
(1847, 66, 169, NULL, '2015-05-11', '2015-05-17', 'app0', 3.2, 3.2, 3.2, NULL, 3.2, NULL, NULL),
(1848, 66, 169, NULL, '2015-05-18', '2015-05-24', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1849, 66, 169, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1850, 131, 612, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 0, 0, 8, 8, NULL, NULL),
(1851, 131, 612, NULL, '2015-04-13', '2015-04-19', 'app3', 7, 7, 8, 8, 8, NULL, NULL),
(1852, 131, 169, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, 8, 0, 0, NULL, NULL),
(1853, 131, 169, NULL, '2015-04-13', '2015-04-19', 'app3', 1, 1, 0, 0, 0, NULL, NULL),
(1854, 131, 169, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1855, 131, 169, NULL, '2015-04-27', '2015-05-03', 'app1', 8, 8, 8, 8, NULL, NULL, NULL),
(1856, 131, 169, NULL, '2015-05-04', '2015-05-10', 'app0', 3.2, 3.2, 3.2, 3.2, NULL, NULL, NULL),
(1857, 131, 169, NULL, '2015-05-11', '2015-05-17', 'app0', 3.2, 3.2, 3.2, NULL, 3.2, NULL, NULL),
(1858, 131, 169, NULL, '2015-05-18', '2015-05-24', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1859, 131, 169, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1860, 63, 277, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, 8, 8, NULL, NULL, NULL),
(1861, 137, 308, NULL, '2015-03-30', '2015-04-05', 'app0', 2, 8, 8, 8, NULL, NULL, NULL),
(1862, 137, 307, NULL, '2015-03-30', '2015-04-05', 'app0', 2, 8, 8, NULL, NULL, NULL, NULL),
(1863, 137, 315, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(1864, 137, 320, NULL, '2015-03-23', '2015-03-29', 'app0', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(1865, 138, 537, NULL, '2015-03-23', '2015-03-29', 'app1', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(1866, 140, 203, NULL, '2015-03-23', '2015-03-29', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(1867, 140, 203, NULL, '2015-03-30', '2015-04-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(1868, 137, 170, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1869, 137, 170, NULL, '2015-03-09', '2015-03-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1870, 137, 170, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1871, 137, 170, NULL, '2015-03-23', '2015-03-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1872, 137, 170, NULL, '2015-03-30', '2015-04-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1873, 137, 170, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1874, 137, 170, NULL, '2015-04-13', '2015-04-19', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1875, 137, 170, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1876, 137, 170, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1877, 137, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1878, 137, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1879, 137, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1880, 137, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1881, 137, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1882, 137, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1883, 137, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1884, 137, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1885, 137, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1886, 137, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1887, 137, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1888, 137, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1889, 137, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1890, 137, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1891, 137, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1892, 137, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1893, 137, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1894, 137, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1895, 137, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1896, 137, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1897, 137, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1898, 137, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1899, 137, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1900, 137, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1901, 137, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1902, 137, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1903, 137, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1904, 137, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1905, 137, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1906, 137, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1907, 137, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1908, 137, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1909, 137, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1910, 137, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1911, 137, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1912, 138, 170, NULL, '2015-03-02', '2015-03-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1913, 138, 170, NULL, '2015-03-09', '2015-03-15', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1914, 138, 170, NULL, '2015-03-16', '2015-03-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1915, 138, 170, NULL, '2015-03-23', '2015-03-29', 'app1', 0, 8, 0, 0, 0, NULL, NULL),
(1916, 138, 170, NULL, '2015-03-30', '2015-04-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1917, 138, 170, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(1918, 138, 170, NULL, '2015-04-13', '2015-04-19', 'app1', NULL, 6, NULL, NULL, NULL, NULL, NULL),
(1919, 138, 170, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1920, 138, 170, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1921, 138, 170, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1922, 138, 170, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1923, 138, 170, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1924, 138, 170, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1925, 138, 170, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1926, 138, 170, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1927, 138, 170, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1928, 138, 170, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1929, 138, 170, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1930, 138, 170, NULL, '2015-07-06', '2015-07-12', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1931, 138, 170, NULL, '2015-07-13', '2015-07-19', 'app0', 0.8, NULL, 0.8, 0.8, 0.8, NULL, NULL),
(1932, 138, 170, NULL, '2015-07-20', '2015-07-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1933, 138, 170, NULL, '2015-07-27', '2015-08-02', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1934, 138, 170, NULL, '2015-08-03', '2015-08-09', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1935, 138, 170, NULL, '2015-08-10', '2015-08-16', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1936, 138, 170, NULL, '2015-08-17', '2015-08-23', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1937, 138, 170, NULL, '2015-08-24', '2015-08-30', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1938, 138, 170, NULL, '2015-08-31', '2015-09-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1939, 138, 170, NULL, '2015-09-07', '2015-09-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1940, 138, 170, NULL, '2015-09-14', '2015-09-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1941, 138, 170, NULL, '2015-09-21', '2015-09-27', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1942, 138, 170, NULL, '2015-09-28', '2015-10-04', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1943, 138, 170, NULL, '2015-10-05', '2015-10-11', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1944, 138, 170, NULL, '2015-10-12', '2015-10-18', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1945, 138, 170, NULL, '2015-10-19', '2015-10-25', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1946, 138, 170, NULL, '2015-10-26', '2015-11-01', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1947, 138, 170, NULL, '2015-11-02', '2015-11-08', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1948, 138, 170, NULL, '2015-11-09', '2015-11-15', 'app0', 0.8, 0.8, NULL, 0.8, 0.8, NULL, NULL),
(1949, 138, 170, NULL, '2015-11-16', '2015-11-22', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1950, 138, 170, NULL, '2015-11-23', '2015-11-29', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1951, 138, 170, NULL, '2015-11-30', '2015-12-06', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1952, 138, 170, NULL, '2015-12-07', '2015-12-13', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1953, 138, 170, NULL, '2015-12-14', '2015-12-20', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1954, 138, 170, NULL, '2015-12-21', '2015-12-27', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1955, 138, 170, NULL, '2015-12-28', '2016-01-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1956, 138, 643, NULL, '2015-03-30', '2015-04-05', 'app1', NULL, NULL, 4, 4, 4, NULL, NULL),
(1957, 137, 308, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1958, 137, 311, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(1959, 138, 653, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, 8, 8, 8, NULL, NULL),
(1960, 138, 649, NULL, '2015-03-30', '2015-04-05', 'app1', NULL, NULL, 4, NULL, 4, NULL, NULL),
(1961, 129, 213, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(1962, 129, 213, NULL, '2015-04-13', '2015-04-19', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1963, 129, 213, NULL, '2015-04-20', '2015-04-26', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1964, 129, 213, NULL, '2015-04-27', '2015-05-03', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1965, 46, 585, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0.4, 0.4, 0.4, NULL, NULL),
(1966, 46, 585, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1967, 46, 585, NULL, '2015-04-13', '2015-04-19', 'app3', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1968, 46, 585, NULL, '2015-04-20', '2015-04-26', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(1969, 46, 585, NULL, '2015-04-27', '2015-05-03', 'app3', 0, 0, 0, 0.2, NULL, NULL, NULL),
(1970, 123, 588, NULL, '2015-06-01', '2015-06-07', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1971, 123, 588, NULL, '2015-06-08', '2015-06-14', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1972, 123, 588, NULL, '2015-06-15', '2015-06-21', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1973, 123, 588, NULL, '2015-06-22', '2015-06-28', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1974, 123, 588, NULL, '2015-06-29', '2015-07-05', 'app0', 3.2, 3.2, NULL, NULL, NULL, NULL, NULL),
(1975, 123, 587, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(1976, 123, 587, NULL, '2015-05-04', '2015-05-10', 'app0', 3.2, 3.2, 3.2, 3.2, NULL, NULL, NULL),
(1977, 123, 587, NULL, '2015-05-11', '2015-05-17', 'app0', 3.2, 3.2, 3.2, NULL, 3.2, NULL, NULL),
(1978, 123, 587, NULL, '2015-05-18', '2015-05-24', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1979, 123, 587, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(1980, 123, 586, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 3.2, 3.2, 3.2, NULL, NULL),
(1981, 123, 586, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(1982, 123, 586, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 8, NULL, 8, NULL, NULL, NULL),
(1983, 123, 586, NULL, '2015-04-20', '2015-04-26', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(1984, 123, 586, NULL, '2015-04-27', '2015-05-03', 'app3', 4, 8, NULL, NULL, NULL, NULL, NULL),
(1985, 137, 173, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1986, 137, 173, NULL, '2015-04-13', '2015-04-19', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1987, 137, 173, NULL, '2015-04-20', '2015-04-26', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(1988, 137, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(1989, 137, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(1990, 137, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(1991, 137, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1992, 137, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1993, 137, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1994, 137, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1995, 137, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1996, 137, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(1997, 137, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(1998, 138, 173, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(1999, 138, 173, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2000, 138, 173, NULL, '2015-04-20', '2015-04-26', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2001, 138, 173, NULL, '2015-04-27', '2015-05-03', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(2002, 138, 173, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(2003, 138, 173, NULL, '2015-05-11', '2015-05-17', 'app0', 0.8, 0.8, 0.8, NULL, 0.8, NULL, NULL),
(2004, 138, 173, NULL, '2015-05-18', '2015-05-24', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2005, 138, 173, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2006, 138, 173, NULL, '2015-06-01', '2015-06-07', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2007, 138, 173, NULL, '2015-06-08', '2015-06-14', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2008, 138, 173, NULL, '2015-06-15', '2015-06-21', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2009, 138, 173, NULL, '2015-06-22', '2015-06-28', 'app0', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2010, 138, 173, NULL, '2015-06-29', '2015-07-05', 'app0', 0.8, 0.8, 0.8, NULL, NULL, NULL, NULL),
(2011, 81, 629, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(2012, 117, 628, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, NULL, 8, 8, NULL, NULL),
(2013, 139, 74, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2014, 77, 73, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2015, 55, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2016, 55, 73, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2017, 63, 295, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(2018, 63, 272, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, 0.8, 0.8, NULL, NULL),
(2019, 77, 346, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2020, 79, 366, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(2021, 79, 665, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0, NULL, NULL, NULL, NULL),
(2022, 79, 658, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, 2, NULL, NULL, NULL),
(2023, 79, 657, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0, NULL, NULL, NULL, NULL),
(2024, 79, 662, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(2025, 79, 662, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, 2, 8, NULL, NULL),
(2026, 69, 74, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, 4, 8, NULL, NULL),
(2027, 63, 294, NULL, '2015-04-13', '2015-04-19', 'app3', 8, NULL, NULL, 4, NULL, NULL, NULL),
(2028, 46, 154, NULL, '2015-04-13', '2015-04-19', 'app3', 0.8, 0.8, 0.8, 0.8, 0.8, NULL, NULL),
(2029, 24, 154, NULL, '2015-04-13', '2015-04-19', 'app3', 1, 1, NULL, NULL, NULL, NULL, NULL),
(2030, 63, 278, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 4, 4, 4, NULL, NULL, NULL),
(2031, 63, 277, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2032, 65, 337, NULL, '2015-04-13', '2015-04-19', 'app3', 2.56, NULL, NULL, NULL, NULL, NULL, NULL),
(2033, 65, 342, NULL, '2015-04-13', '2015-04-19', 'app3', 1.28, NULL, NULL, NULL, NULL, NULL, NULL),
(2034, 65, 352, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 1.28, NULL, NULL, NULL, NULL, NULL),
(2035, 65, 357, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 3.84, NULL, NULL, NULL, NULL, NULL),
(2036, 65, 362, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 2.56, NULL, NULL, NULL, NULL, NULL),
(2037, 77, 680, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(2038, 77, 346, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(2039, 77, 514, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(2040, 77, 530, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 8, 4, 8, NULL, NULL, NULL),
(2041, 77, 530, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, 4, NULL, NULL),
(2042, 77, 686, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, 4, 4, NULL, NULL),
(2043, 39, 687, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2044, 39, 687, NULL, '2015-04-20', '2015-04-26', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2045, 149, 687, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(2046, 149, 687, NULL, '2015-04-20', '2015-04-26', 'app0', 0.08, NULL, NULL, NULL, NULL, NULL, NULL),
(2047, 149, 576, NULL, '2015-03-23', '2015-03-29', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2048, 149, 576, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(2049, 149, 575, NULL, '2015-03-23', '2015-03-29', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2050, 149, 575, NULL, '2015-03-30', '2015-04-05', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(2051, 80, 684, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2052, 80, 684, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, 8, 4, NULL, NULL, NULL, NULL),
(2053, 82, 677, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2054, 80, 677, NULL, '2015-04-06', '2015-04-12', 'app1', NULL, NULL, NULL, 6, 8, NULL, NULL),
(2055, 101, 73, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2056, 101, 73, NULL, '2015-05-18', '2015-05-24', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2057, 101, 73, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2058, 53, 73, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2059, 39, 73, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2060, 74, 583, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, NULL, 2, 2, NULL, NULL),
(2061, 63, 583, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, 4, 4, NULL, NULL, NULL, NULL),
(2062, 69, 62, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2063, 69, 62, NULL, '2015-04-13', '2015-04-19', 'app3', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2064, 69, 62, NULL, '2015-04-20', '2015-04-26', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2065, 69, 62, NULL, '2015-04-27', '2015-05-03', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2066, 75, 62, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 0.08, 0.08, 0.08, NULL, NULL),
(2067, 75, 62, NULL, '2015-04-06', '2015-04-12', 'app3', NULL, 0, 2, 0, 0, NULL, NULL),
(2068, 75, 62, NULL, '2015-04-13', '2015-04-19', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2069, 75, 62, NULL, '2015-04-20', '2015-04-26', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2070, 75, 62, NULL, '2015-04-27', '2015-05-03', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2071, 39, 62, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, NULL, 0, 0, 0, NULL, NULL),
(2072, 39, 62, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, NULL, NULL, NULL, NULL, NULL),
(2073, 39, 62, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2074, 39, 62, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2075, 55, 620, NULL, '2015-04-13', '2015-04-19', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2076, 55, 620, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2077, 81, 629, NULL, '2015-04-13', '2015-04-19', 'app1', 8, 8, 4, 8, 8, NULL, NULL),
(2079, 81, 420, NULL, '2015-04-13', '2015-04-19', 'app1', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(2080, 74, 621, NULL, '2015-04-13', '2015-04-19', 'app1', 8, 8, 8, NULL, NULL, NULL, NULL),
(2081, 132, 621, NULL, '2015-04-13', '2015-04-19', 'app1', 8, 8, 8, 8, 8, NULL, NULL),
(2082, 80, 677, NULL, '2015-04-13', '2015-04-19', 'app1', 8, 6, 6, 6, 6, NULL, NULL),
(2083, 77, 622, NULL, '2015-04-13', '2015-04-19', 'app0', 4, 8, 8, 4, 6, NULL, NULL),
(2084, 140, 575, NULL, '2015-03-23', '2015-03-29', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2085, 140, 575, NULL, '2015-03-30', '2015-04-05', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2086, 84, 606, NULL, '2015-04-13', '2015-04-19', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2087, 84, 606, NULL, '2015-04-20', '2015-04-26', 'app0', 1.6, NULL, NULL, NULL, NULL, NULL, NULL),
(2088, 86, 81, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2091, 76, 74, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 4, 4, NULL, NULL, NULL),
(2092, 76, 73, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2093, 76, 75, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, 4, 8, NULL, NULL),
(2094, 127, 218, NULL, '2015-04-13', '2015-04-19', 'app3', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2095, 82, 791, NULL, '2015-04-13', '2015-04-19', 'app1', 2, 4, NULL, NULL, NULL, NULL, NULL),
(2096, 82, 795, NULL, '2015-04-13', '2015-04-19', 'app1', NULL, 4, 4, 6, 8, NULL, NULL),
(2097, 71, 596, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, 4, 6, NULL, NULL, NULL, NULL),
(2098, 71, 570, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2099, 117, 629, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2100, 117, 628, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(2101, 117, 420, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(2102, 71, 545, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(2103, 71, 540, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(2104, 80, 429, NULL, '2015-04-13', '2015-04-19', 'app1', NULL, NULL, NULL, 2, 2, NULL, NULL),
(2105, 79, 662, NULL, '2015-04-13', '2015-04-19', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2106, 81, 73, NULL, '2015-04-13', '2015-04-19', 'app1', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2107, 139, 171, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2108, 72, 171, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(2109, 69, 171, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2110, 72, 168, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2111, 138, 653, NULL, '2015-04-13', '2015-04-19', 'app1', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2112, 138, 739, NULL, '2015-04-13', '2015-04-19', 'app1', NULL, 2, 8, 8, 6, NULL, NULL),
(2113, 73, 168, NULL, '2015-04-13', '2015-04-19', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2114, 73, 171, NULL, '2015-04-13', '2015-04-19', 'app0', 2, 2, NULL, 2, 2, NULL, NULL),
(2115, 68, 73, NULL, '2015-06-08', '2015-06-14', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2116, 142, 74, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2117, 86, 81, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2118, 63, 583, NULL, '2015-04-20', '2015-04-26', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(2119, 24, 74, NULL, '2015-07-20', '2015-07-26', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(2120, 24, 74, NULL, '2015-07-27', '2015-08-02', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2121, 81, 629, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, 4, 8, 8, 8, NULL, NULL),
(2122, 117, 628, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 6, NULL, NULL, NULL, NULL),
(2123, 117, 550, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2124, 81, 420, NULL, '2015-04-20', '2015-04-26', 'app1', 2, 2, NULL, NULL, NULL, NULL, NULL),
(2125, 117, 420, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(2126, 84, 822, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2127, 84, 822, NULL, '2015-04-27', '2015-05-03', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2128, 84, 822, NULL, '2015-05-04', '2015-05-10', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(2129, 84, 822, NULL, '2015-05-11', '2015-05-17', 'app0', 0.4, 0.4, 0.4, NULL, 0.4, NULL, NULL),
(2130, 84, 822, NULL, '2015-05-18', '2015-05-24', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2131, 84, 822, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2132, 84, 822, NULL, '2015-06-01', '2015-06-07', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2133, 84, 822, NULL, '2015-06-08', '2015-06-14', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2134, 84, 822, NULL, '2015-06-15', '2015-06-21', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2135, 84, 822, NULL, '2015-06-22', '2015-06-28', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2136, 84, 822, NULL, '2015-06-29', '2015-07-05', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2137, 84, 822, NULL, '2015-07-06', '2015-07-12', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2138, 84, 822, NULL, '2015-07-13', '2015-07-19', 'app0', 0.4, NULL, 0.4, 0.4, 0.4, NULL, NULL),
(2139, 84, 822, NULL, '2015-07-20', '2015-07-26', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2140, 84, 822, NULL, '2015-07-27', '2015-08-02', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2141, 109, 822, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2142, 109, 822, NULL, '2015-04-27', '2015-05-03', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2143, 109, 822, NULL, '2015-05-04', '2015-05-10', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(2144, 109, 822, NULL, '2015-05-11', '2015-05-17', 'app0', 0.4, 0.4, 0.4, NULL, 0.4, NULL, NULL),
(2145, 109, 822, NULL, '2015-05-18', '2015-05-24', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2146, 109, 822, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2147, 109, 822, NULL, '2015-06-01', '2015-06-07', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2148, 109, 822, NULL, '2015-06-08', '2015-06-14', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2149, 109, 822, NULL, '2015-06-15', '2015-06-21', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2150, 109, 822, NULL, '2015-06-22', '2015-06-28', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2151, 109, 822, NULL, '2015-06-29', '2015-07-05', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2152, 109, 822, NULL, '2015-07-06', '2015-07-12', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2153, 109, 822, NULL, '2015-07-13', '2015-07-19', 'app0', 0.4, NULL, 0.4, 0.4, 0.4, NULL, NULL),
(2154, 109, 822, NULL, '2015-07-20', '2015-07-26', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2155, 109, 822, NULL, '2015-07-27', '2015-08-02', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2156, 75, 74, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, 4, NULL, NULL, 8, NULL, NULL),
(2157, 35, 74, NULL, '2015-04-27', '2015-05-03', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2158, 81, 823, NULL, '2015-04-20', '2015-04-26', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2159, 74, 605, NULL, '2015-04-20', '2015-04-26', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2160, 71, 781, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 4, 8, NULL, NULL, NULL, NULL),
(2161, 71, 776, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(2162, 71, 834, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2163, 70, 593, NULL, '2015-04-20', '2015-04-26', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(2164, 72, 171, NULL, '2015-04-20', '2015-04-26', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2165, 70, 168, NULL, '2015-04-20', '2015-04-26', 'app3', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(2166, 70, 833, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(2167, 70, 836, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, NULL, NULL, 2, NULL, NULL),
(2168, 137, 853, NULL, '2015-04-13', '2015-04-19', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2169, 137, 853, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, 4, NULL, NULL, NULL, NULL),
(2170, 137, 853, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 6, 8, 8, 8, NULL, NULL),
(2171, 46, 859, NULL, '2015-04-27', '2015-05-03', 'app1', 2.4, 2.4, 2.4, 2.4, NULL, NULL, NULL),
(2172, 46, 859, NULL, '2015-05-04', '2015-05-10', 'app0', 2.4, 2.4, 2.4, 2.4, NULL, NULL, NULL),
(2173, 46, 859, NULL, '2015-05-11', '2015-05-17', 'app0', 2.4, 2.4, 2.4, NULL, 2.4, NULL, NULL),
(2174, 46, 859, NULL, '2015-05-18', '2015-05-24', 'app0', 2.4, 2.4, 2.4, 2.4, 2.4, NULL, NULL),
(2175, 46, 859, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 2.4, 2.4, 2.4, NULL, NULL, NULL),
(2176, 24, 859, NULL, '2015-05-18', '2015-05-24', 'app0', 2.4, 2.4, 2.4, 2.4, 2.4, NULL, NULL),
(2177, 24, 859, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 2.4, 2.4, 2.4, NULL, NULL, NULL),
(2178, 24, 859, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, NULL, NULL, 5, NULL, NULL),
(2179, 24, 859, NULL, '2015-04-27', '2015-05-03', 'app3', 7, 2, 3, 5, NULL, NULL, NULL),
(2180, 24, 859, NULL, '2015-05-04', '2015-05-10', 'app0', 2.4, 2.4, 2.4, 2.4, NULL, NULL, NULL),
(2181, 65, 304, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, NULL, NULL, NULL, 2, NULL, NULL),
(2182, 64, 667, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, NULL, 4.48, NULL, NULL, NULL, NULL),
(2183, 64, 503, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, 8, 3.52, NULL, NULL, NULL, NULL),
(2184, 65, 312, NULL, '2015-04-20', '2015-04-26', 'app1', NULL, NULL, NULL, 8, 6, NULL, NULL),
(2185, 64, 316, NULL, '2015-04-20', '2015-04-26', 'app1', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2186, 80, 857, NULL, '2015-04-20', '2015-04-26', 'app1', 8, 8, 8, 6, 8, NULL, NULL),
(2187, 71, 591, NULL, '2015-04-20', '2015-04-26', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2188, 69, 184, NULL, '2015-04-20', '2015-04-26', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2189, 69, 184, NULL, '2015-04-13', '2015-04-19', 'app0', NULL, 6, NULL, NULL, NULL, NULL, NULL),
(2190, 72, 168, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2191, 73, 171, NULL, '2015-04-20', '2015-04-26', 'app3', 2, 4, NULL, 2, 2, NULL, NULL),
(2192, 139, 171, NULL, '2015-04-20', '2015-04-26', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(2193, 69, 171, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, 8, 8, NULL, NULL, NULL, NULL),
(2194, 73, 168, NULL, '2015-04-20', '2015-04-26', 'app3', 4, 2, 2, 2, 2, NULL, NULL),
(2195, 69, 168, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, 8, 8, NULL, NULL),
(2196, 68, 559, NULL, '2015-03-30', '2015-04-05', 'app0', NULL, NULL, 3.2, 3.2, 3.2, NULL, NULL),
(2197, 68, 559, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2198, 68, 559, NULL, '2015-04-13', '2015-04-19', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2199, 68, 559, NULL, '2015-04-20', '2015-04-26', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2200, 68, 559, NULL, '2015-04-27', '2015-05-03', 'app0', 3.2, 3.2, 3.2, 3.2, NULL, NULL, NULL),
(2201, 127, 73, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(2202, 70, 771, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 8, 8, 8, NULL, NULL, NULL),
(2203, 72, 847, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, NULL, 8, 8, NULL, NULL, NULL),
(2204, 64, 168, NULL, '2015-03-30', '2015-04-05', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2205, 64, 168, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2206, 64, 168, NULL, '2015-04-13', '2015-04-19', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2207, 64, 168, NULL, '2015-04-20', '2015-04-26', 'app3', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2208, 64, 168, NULL, '2015-04-27', '2015-05-03', 'app1', 2, 2, 0, 0, NULL, NULL, NULL),
(2209, 64, 168, NULL, '2015-05-04', '2015-05-10', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(2210, 64, 168, NULL, '2015-05-11', '2015-05-17', 'app0', 1.6, 1.6, 1.6, NULL, 1.6, NULL, NULL),
(2211, 64, 168, NULL, '2015-05-18', '2015-05-24', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2212, 64, 168, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2213, 64, 168, NULL, '2015-06-01', '2015-06-07', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2214, 64, 168, NULL, '2015-06-08', '2015-06-14', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2215, 64, 168, NULL, '2015-06-15', '2015-06-21', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2216, 64, 168, NULL, '2015-06-22', '2015-06-28', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2217, 64, 168, NULL, '2015-06-29', '2015-07-05', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2218, 64, 168, NULL, '2015-07-06', '2015-07-12', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2219, 64, 168, NULL, '2015-07-13', '2015-07-19', 'app0', 1.6, NULL, 1.6, 1.6, 1.6, NULL, NULL);
INSERT INTO `timesheet` (`idTimeSheet`, `idEmployee`, `idActivity`, `idOperation`, `initDate`, `endDate`, `status`, `hoursDay1`, `hoursDay2`, `hoursDay3`, `hoursDay4`, `hoursDay5`, `hoursDay6`, `hoursDay7`) VALUES
(2220, 64, 168, NULL, '2015-07-20', '2015-07-26', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2221, 64, 168, NULL, '2015-07-27', '2015-08-02', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2222, 64, 168, NULL, '2015-08-03', '2015-08-09', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2223, 64, 168, NULL, '2015-08-10', '2015-08-16', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2224, 64, 168, NULL, '2015-08-17', '2015-08-23', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2225, 64, 168, NULL, '2015-08-24', '2015-08-30', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2226, 64, 168, NULL, '2015-08-31', '2015-09-06', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2227, 64, 168, NULL, '2015-09-07', '2015-09-13', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2228, 64, 168, NULL, '2015-09-14', '2015-09-20', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2229, 64, 168, NULL, '2015-09-21', '2015-09-27', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2230, 64, 168, NULL, '2015-09-28', '2015-10-04', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2231, 64, 168, NULL, '2015-10-05', '2015-10-11', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2232, 64, 168, NULL, '2015-10-12', '2015-10-18', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2233, 64, 168, NULL, '2015-10-19', '2015-10-25', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2234, 64, 168, NULL, '2015-10-26', '2015-11-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2235, 64, 168, NULL, '2015-11-02', '2015-11-08', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2236, 64, 168, NULL, '2015-11-09', '2015-11-15', 'app0', 1.6, 1.6, NULL, 1.6, 1.6, NULL, NULL),
(2237, 64, 168, NULL, '2015-11-16', '2015-11-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2238, 64, 168, NULL, '2015-11-23', '2015-11-29', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2239, 64, 168, NULL, '2015-11-30', '2015-12-06', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2240, 64, 168, NULL, '2015-12-07', '2015-12-13', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2241, 64, 168, NULL, '2015-12-14', '2015-12-20', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2242, 64, 168, NULL, '2015-12-21', '2015-12-27', 'app0', 1.6, 1.6, 1.6, NULL, NULL, NULL, NULL),
(2243, 64, 168, NULL, '2015-12-28', '2016-01-03', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(2244, 66, 172, NULL, '2015-06-01', '2015-06-07', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2245, 66, 172, NULL, '2015-06-08', '2015-06-14', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2246, 66, 172, NULL, '2015-06-15', '2015-06-21', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2247, 66, 172, NULL, '2015-06-22', '2015-06-28', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2248, 66, 172, NULL, '2015-06-29', '2015-07-05', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2249, 66, 172, NULL, '2015-07-06', '2015-07-12', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2250, 66, 172, NULL, '2015-07-13', '2015-07-19', 'app0', 4.8, NULL, 4.8, 4.8, 4.8, NULL, NULL),
(2251, 66, 172, NULL, '2015-07-20', '2015-07-26', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2252, 66, 172, NULL, '2015-07-27', '2015-08-02', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2253, 66, 172, NULL, '2015-08-03', '2015-08-09', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2254, 66, 172, NULL, '2015-08-10', '2015-08-16', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2255, 66, 172, NULL, '2015-08-17', '2015-08-23', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2256, 66, 172, NULL, '2015-08-24', '2015-08-30', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2257, 66, 172, NULL, '2015-08-31', '2015-09-06', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2258, 66, 172, NULL, '2015-09-07', '2015-09-13', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2259, 66, 172, NULL, '2015-09-14', '2015-09-20', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2260, 66, 172, NULL, '2015-09-21', '2015-09-27', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2261, 66, 172, NULL, '2015-09-28', '2015-10-04', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2262, 66, 172, NULL, '2015-10-05', '2015-10-11', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2263, 66, 172, NULL, '2015-10-12', '2015-10-18', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2264, 66, 172, NULL, '2015-10-19', '2015-10-25', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2265, 66, 172, NULL, '2015-10-26', '2015-11-01', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2266, 66, 172, NULL, '2015-11-02', '2015-11-08', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2267, 66, 172, NULL, '2015-11-09', '2015-11-15', 'app0', 4.8, 4.8, NULL, 4.8, 4.8, NULL, NULL),
(2268, 66, 172, NULL, '2015-11-16', '2015-11-22', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2269, 66, 172, NULL, '2015-11-23', '2015-11-29', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2270, 66, 172, NULL, '2015-11-30', '2015-12-06', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2271, 66, 172, NULL, '2015-12-07', '2015-12-13', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2272, 66, 172, NULL, '2015-12-14', '2015-12-20', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2273, 66, 172, NULL, '2015-12-21', '2015-12-27', 'app0', 4.8, 4.8, 4.8, NULL, NULL, NULL, NULL),
(2274, 66, 172, NULL, '2015-12-28', '2016-01-03', 'app0', 4.8, 4.8, 4.8, 4.8, NULL, NULL, NULL),
(2275, 66, 169, NULL, '2015-06-01', '2015-06-07', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2276, 66, 169, NULL, '2015-06-08', '2015-06-14', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2277, 66, 169, NULL, '2015-06-15', '2015-06-21', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2278, 66, 169, NULL, '2015-06-22', '2015-06-28', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2279, 66, 169, NULL, '2015-06-29', '2015-07-05', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2280, 66, 169, NULL, '2015-07-06', '2015-07-12', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2281, 66, 169, NULL, '2015-07-13', '2015-07-19', 'app0', 3.2, NULL, 3.2, 3.2, 3.2, NULL, NULL),
(2282, 66, 169, NULL, '2015-07-20', '2015-07-26', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2283, 66, 169, NULL, '2015-07-27', '2015-08-02', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2284, 66, 169, NULL, '2015-08-03', '2015-08-09', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2285, 66, 169, NULL, '2015-08-10', '2015-08-16', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2286, 66, 169, NULL, '2015-08-17', '2015-08-23', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2287, 66, 169, NULL, '2015-08-24', '2015-08-30', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2288, 66, 169, NULL, '2015-08-31', '2015-09-06', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2289, 66, 169, NULL, '2015-09-07', '2015-09-13', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2290, 66, 169, NULL, '2015-09-14', '2015-09-20', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2291, 66, 169, NULL, '2015-09-21', '2015-09-27', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2292, 66, 169, NULL, '2015-09-28', '2015-10-04', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2293, 66, 169, NULL, '2015-10-05', '2015-10-11', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2294, 66, 169, NULL, '2015-10-12', '2015-10-18', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2295, 66, 169, NULL, '2015-10-19', '2015-10-25', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2296, 66, 169, NULL, '2015-10-26', '2015-11-01', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2297, 66, 169, NULL, '2015-11-02', '2015-11-08', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2298, 66, 169, NULL, '2015-11-09', '2015-11-15', 'app0', 3.2, 3.2, NULL, 3.2, 3.2, NULL, NULL),
(2299, 66, 169, NULL, '2015-11-16', '2015-11-22', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2300, 66, 169, NULL, '2015-11-23', '2015-11-29', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2301, 66, 169, NULL, '2015-11-30', '2015-12-06', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2302, 66, 169, NULL, '2015-12-07', '2015-12-13', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2303, 66, 169, NULL, '2015-12-14', '2015-12-20', 'app0', 3.2, 3.2, 3.2, 3.2, 3.2, NULL, NULL),
(2304, 66, 169, NULL, '2015-12-21', '2015-12-27', 'app0', 3.2, 3.2, 3.2, NULL, NULL, NULL, NULL),
(2305, 66, 169, NULL, '2015-12-28', '2016-01-03', 'app0', 3.2, 3.2, 3.2, 3.2, NULL, NULL, NULL),
(2306, 64, 172, NULL, '2015-03-30', '2015-04-05', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2307, 64, 172, NULL, '2015-04-06', '2015-04-12', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2308, 64, 172, NULL, '2015-04-13', '2015-04-19', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2309, 64, 172, NULL, '2015-04-20', '2015-04-26', 'app1', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2310, 64, 172, NULL, '2015-04-27', '2015-05-03', 'app1', 6, 6, 4, 0, NULL, NULL, NULL),
(2311, 64, 172, NULL, '2015-05-04', '2015-05-10', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(2312, 64, 172, NULL, '2015-05-11', '2015-05-17', 'app0', 1.6, 1.6, 1.6, NULL, 1.6, NULL, NULL),
(2313, 64, 172, NULL, '2015-05-18', '2015-05-24', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2314, 64, 172, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2315, 64, 172, NULL, '2015-06-01', '2015-06-07', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2316, 64, 172, NULL, '2015-06-08', '2015-06-14', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2317, 64, 172, NULL, '2015-06-15', '2015-06-21', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2318, 64, 172, NULL, '2015-06-22', '2015-06-28', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2319, 64, 172, NULL, '2015-06-29', '2015-07-05', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2320, 64, 172, NULL, '2015-07-06', '2015-07-12', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2321, 64, 172, NULL, '2015-07-13', '2015-07-19', 'app0', 1.6, NULL, 1.6, 1.6, 1.6, NULL, NULL),
(2322, 64, 172, NULL, '2015-07-20', '2015-07-26', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2323, 64, 172, NULL, '2015-07-27', '2015-08-02', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2324, 64, 172, NULL, '2015-08-03', '2015-08-09', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2325, 64, 172, NULL, '2015-08-10', '2015-08-16', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2326, 64, 172, NULL, '2015-08-17', '2015-08-23', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2327, 64, 172, NULL, '2015-08-24', '2015-08-30', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2328, 64, 172, NULL, '2015-08-31', '2015-09-06', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2329, 64, 172, NULL, '2015-09-07', '2015-09-13', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2330, 64, 172, NULL, '2015-09-14', '2015-09-20', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2331, 64, 172, NULL, '2015-09-21', '2015-09-27', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2332, 64, 172, NULL, '2015-09-28', '2015-10-04', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2333, 64, 172, NULL, '2015-10-05', '2015-10-11', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2334, 64, 172, NULL, '2015-10-12', '2015-10-18', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2335, 64, 172, NULL, '2015-10-19', '2015-10-25', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2336, 64, 172, NULL, '2015-10-26', '2015-11-01', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2337, 64, 172, NULL, '2015-11-02', '2015-11-08', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2338, 64, 172, NULL, '2015-11-09', '2015-11-15', 'app0', 1.6, 1.6, NULL, 1.6, 1.6, NULL, NULL),
(2339, 64, 172, NULL, '2015-11-16', '2015-11-22', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2340, 64, 172, NULL, '2015-11-23', '2015-11-29', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2341, 64, 172, NULL, '2015-11-30', '2015-12-06', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2342, 64, 172, NULL, '2015-12-07', '2015-12-13', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2343, 64, 172, NULL, '2015-12-14', '2015-12-20', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2344, 64, 172, NULL, '2015-12-21', '2015-12-27', 'app0', 1.6, 1.6, 1.6, NULL, NULL, NULL, NULL),
(2345, 64, 172, NULL, '2015-12-28', '2016-01-03', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(2346, 72, 864, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 2, NULL, NULL, NULL, NULL, NULL),
(2347, 72, 863, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 6, NULL, NULL, NULL, NULL, NULL),
(2348, 150, 49, NULL, '2015-04-20', '2015-04-26', 'app3', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(2349, 74, 743, NULL, '2015-04-20', '2015-04-26', 'app3', 6, 8, 8, 2, 0, NULL, NULL),
(2350, 132, 743, NULL, '2015-04-20', '2015-04-26', 'app3', 8, 8, 8, 8, 8, NULL, NULL),
(2351, 138, 648, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, 6, NULL, NULL),
(2352, 138, 739, NULL, '2015-04-20', '2015-04-26', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(2353, 137, 74, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2354, 137, 74, NULL, '2015-05-04', '2015-05-10', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2355, 82, 877, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, 6, 6, NULL, NULL),
(2356, 82, 791, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2357, 82, 881, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2358, 82, 885, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(2359, 82, 873, NULL, '2015-04-20', '2015-04-26', 'app0', 6, NULL, NULL, NULL, NULL, NULL, NULL),
(2360, 82, 853, NULL, '2015-04-20', '2015-04-26', 'app0', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2361, 79, 662, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 8, 8, 8, NULL, NULL),
(2362, 151, 911, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 8, 8, 8, NULL, NULL, NULL),
(2363, 84, 912, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, 8, NULL, 8, NULL, NULL, NULL),
(2364, 151, 913, NULL, '2015-05-04', '2015-05-10', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(2365, 151, 913, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(2366, 151, 913, NULL, '2015-05-18', '2015-05-24', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2367, 151, 913, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(2368, 151, 913, NULL, '2015-06-01', '2015-06-07', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2369, 151, 913, NULL, '2015-06-08', '2015-06-14', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2370, 151, 913, NULL, '2015-06-15', '2015-06-21', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2371, 151, 913, NULL, '2015-06-22', '2015-06-28', 'app0', 8, 8, 8, 8, 8, NULL, NULL),
(2372, 151, 913, NULL, '2015-06-29', '2015-07-05', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2373, 151, 913, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 2.64, 2.64, 2.64, NULL, NULL, NULL),
(2374, 66, 73, NULL, '2015-07-13', '2015-07-19', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2375, 70, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2376, 74, 73, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, 8, NULL, 8, NULL, NULL),
(2377, 151, 910, NULL, '2015-04-27', '2015-05-03', 'app3', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2378, 55, 859, NULL, '2015-04-27', '2015-05-03', 'app0', 4.8, 4.8, 4.8, 4.8, NULL, NULL, NULL),
(2379, 55, 859, NULL, '2015-05-04', '2015-05-10', 'app0', 4.8, 4.8, 4.8, 4.8, NULL, NULL, NULL),
(2380, 55, 859, NULL, '2015-05-11', '2015-05-17', 'app0', 4.8, 4.8, 4.8, NULL, 4.8, NULL, NULL),
(2381, 55, 859, NULL, '2015-05-18', '2015-05-24', 'app0', 4.8, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2382, 55, 859, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 4.8, 4.8, 4.8, 4.8, NULL, NULL),
(2383, 65, 910, NULL, '2015-04-27', '2015-05-03', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2384, 109, 585, NULL, '2015-04-20', '2015-04-26', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2385, 109, 585, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, 8, 8, 8, NULL, NULL, NULL),
(2386, 101, 585, NULL, '2015-04-27', '2015-05-03', 'app3', 2, NULL, NULL, NULL, NULL, NULL, NULL),
(2387, 65, 777, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 3.04, NULL, NULL, NULL, NULL, NULL),
(2388, 71, 776, NULL, '2015-04-27', '2015-05-03', 'app1', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2389, 70, 775, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2390, 65, 782, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 3.04, NULL, NULL, NULL, NULL, NULL),
(2391, 70, 780, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 4, 8, NULL, NULL, NULL, NULL),
(2392, 80, 857, NULL, '2015-04-27', '2015-05-03', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2393, 70, 590, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 4, NULL, NULL, NULL, NULL, NULL),
(2394, 81, 629, NULL, '2015-04-27', '2015-05-03', 'app1', 8, 8, 8, 8, NULL, NULL, NULL),
(2395, 65, 511, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 1.28, NULL, NULL, NULL),
(2396, 65, 519, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 2.56, NULL, NULL, NULL),
(2397, 65, 523, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 1.92, NULL, NULL, NULL, NULL, NULL),
(2398, 65, 527, NULL, '2015-04-27', '2015-05-03', 'app0', 2.56, NULL, NULL, NULL, NULL, NULL, NULL),
(2399, 64, 535, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, NULL, 4, 8, NULL, NULL, NULL),
(2400, 132, 743, NULL, '2015-04-27', '2015-05-03', 'app1', 8, 8, 8, 8, NULL, NULL, NULL),
(2401, 74, 743, NULL, '2015-04-27', '2015-05-03', 'app1', 6, 6, 6, NULL, NULL, NULL, NULL),
(2402, 53, 859, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(2403, 77, 859, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 0.4, 0.4, NULL, NULL, NULL, NULL),
(2404, 101, 859, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(2405, 69, 74, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2406, 69, 74, NULL, '2015-05-04', '2015-05-10', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2407, 55, 81, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 8, 8, 8, NULL, NULL),
(2408, 71, 73, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2409, 132, 73, NULL, '2015-05-04', '2015-05-10', 'app0', 8, 8, 8, NULL, NULL, NULL, NULL),
(2410, 72, 847, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, NULL, 2, NULL, NULL, NULL, NULL),
(2411, 72, 171, NULL, '2015-04-27', '2015-05-03', 'app1', 8, NULL, 6, NULL, NULL, NULL, NULL),
(2412, 73, 171, NULL, '2015-04-27', '2015-05-03', 'app0', 2, 2, 2, 2, NULL, NULL, NULL),
(2413, 73, 168, NULL, '2015-04-27', '2015-05-03', 'app0', 4, 2, 2, 2, NULL, NULL, NULL),
(2414, 72, 168, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2415, 102, 859, NULL, '2015-05-04', '2015-05-10', 'app0', 0.8, 0.8, 0.8, 0.8, NULL, NULL, NULL),
(2416, 68, 859, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 0.4, NULL, NULL, NULL, NULL),
(2417, 67, 859, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 0.4, 0.4, NULL, NULL, NULL, NULL),
(2418, 137, 853, NULL, '2015-04-27', '2015-05-03', 'app1', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2419, 46, 917, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2420, 24, 917, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, 4, NULL, NULL, NULL, NULL, NULL),
(2421, 74, 583, NULL, '2015-04-20', '2015-04-26', 'app0', 2, 2, 2, 2, 2, NULL, NULL),
(2422, 74, 583, NULL, '2015-04-27', '2015-05-03', 'app3', 2, 2, 2, NULL, NULL, NULL, NULL),
(2423, 82, 791, NULL, '2015-04-27', '2015-05-03', 'app0', 4, 4, NULL, NULL, NULL, NULL, NULL),
(2424, 82, 881, NULL, '2015-04-27', '2015-05-03', 'app0', 4, NULL, NULL, NULL, NULL, NULL, NULL),
(2425, 117, 550, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 8, NULL, NULL, NULL, NULL, NULL),
(2426, 117, 549, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 8, 8, NULL, NULL, NULL),
(2427, 77, 938, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 8, NULL, NULL, NULL, NULL),
(2428, 79, 662, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 8, 4, 8, NULL, NULL, NULL),
(2429, 39, 916, NULL, '2015-04-27', '2015-05-03', 'app3', 3, 3, 4, 1, NULL, NULL, NULL),
(2430, 39, 916, NULL, '2015-05-04', '2015-05-10', 'app0', 0, 0, 0, 0, NULL, NULL, NULL),
(2431, 39, 916, NULL, '2015-05-11', '2015-05-17', 'app0', 0, 0, 0, NULL, 0, NULL, NULL),
(2432, 39, 916, NULL, '2015-05-18', '2015-05-24', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2433, 39, 916, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0, 0, 0, 0, NULL, NULL),
(2434, 39, 916, NULL, '2015-06-01', '2015-06-07', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2435, 39, 916, NULL, '2015-06-08', '2015-06-14', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2436, 39, 916, NULL, '2015-06-15', '2015-06-21', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2437, 39, 916, NULL, '2015-06-22', '2015-06-28', 'app0', 0, 0, 0, 0, 0, NULL, NULL),
(2438, 39, 916, NULL, '2015-06-29', '2015-07-05', 'app0', 0, 0, NULL, NULL, NULL, NULL, NULL),
(2439, 69, 171, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(2440, 69, 168, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 4, NULL, NULL, NULL, NULL),
(2441, 77, 622, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 8, NULL, NULL, NULL),
(2442, 138, 714, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 2, 6, 8, NULL, NULL, NULL),
(2443, 138, 648, NULL, '2015-04-27', '2015-05-03', 'app0', 8, 6, NULL, NULL, NULL, NULL, NULL),
(2444, 129, 214, NULL, '2015-05-04', '2015-05-10', 'app0', 3.2, 3.2, 3.2, 3.2, NULL, NULL, NULL),
(2445, 129, 214, NULL, '2015-05-11', '2015-05-17', 'app0', 3.2, 3.2, 3.2, NULL, 3.2, NULL, NULL),
(2446, 129, 214, NULL, '2015-05-18', '2015-05-24', 'app0', 3.2, NULL, NULL, NULL, NULL, NULL, NULL),
(2447, 46, 915, NULL, '2015-06-01', '2015-06-07', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2448, 46, 915, NULL, '2015-06-08', '2015-06-14', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2449, 46, 915, NULL, '2015-06-15', '2015-06-21', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2450, 46, 915, NULL, '2015-06-22', '2015-06-28', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2451, 46, 915, NULL, '2015-06-29', '2015-07-05', 'app0', 0.4, 0.4, NULL, NULL, NULL, NULL, NULL),
(2452, 46, 914, NULL, '2015-05-04', '2015-05-10', 'app0', 0.4, 0.4, 0.4, 0.4, NULL, NULL, NULL),
(2453, 46, 914, NULL, '2015-05-11', '2015-05-17', 'app0', 0.4, 0.4, 0.4, NULL, 0.4, NULL, NULL),
(2454, 46, 914, NULL, '2015-05-18', '2015-05-24', 'app0', 0.4, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2455, 46, 914, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.4, 0.4, 0.4, 0.4, NULL, NULL),
(2456, 137, 73, NULL, '2015-05-04', '2015-05-10', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2457, 137, 73, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, 0, NULL, NULL, NULL),
(2458, 137, 849, NULL, '2015-04-27', '2015-05-03', 'app1', NULL, 8, NULL, NULL, NULL, NULL, NULL),
(2459, 127, 205, NULL, '2015-05-04', '2015-05-10', 'app0', 8, 8, 8, 8, NULL, NULL, NULL),
(2460, 127, 205, NULL, '2015-05-11', '2015-05-17', 'app0', 8, 8, 8, NULL, 8, NULL, NULL),
(2461, 17, 205, NULL, '2015-05-18', '2015-05-24', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(2462, 17, 205, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 8, 8, 8, 8, NULL, NULL),
(2463, 17, 205, NULL, '2015-05-04', '2015-05-10', 'app0', 2, 2, 2, 2, NULL, NULL, NULL),
(2464, 73, 205, NULL, '2015-05-04', '2015-05-10', 'app0', 4, 4, 4, 4, NULL, NULL, NULL),
(2465, 73, 205, NULL, '2015-05-11', '2015-05-17', 'app0', 4, 4, 4, NULL, 4, NULL, NULL),
(2466, 73, 205, NULL, '2015-05-18', '2015-05-24', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2467, 73, 205, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 4, 4, 4, 4, NULL, NULL),
(2468, 17, 915, NULL, '2015-06-01', '2015-06-07', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2469, 17, 915, NULL, '2015-06-08', '2015-06-14', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2470, 17, 915, NULL, '2015-06-15', '2015-06-21', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2471, 17, 915, NULL, '2015-06-22', '2015-06-28', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2472, 17, 915, NULL, '2015-06-29', '2015-07-05', 'app0', 1.6, 1.6, NULL, NULL, NULL, NULL, NULL),
(2473, 109, 915, NULL, '2015-06-01', '2015-06-07', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2474, 109, 915, NULL, '2015-06-08', '2015-06-14', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2475, 109, 915, NULL, '2015-06-15', '2015-06-21', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2476, 109, 915, NULL, '2015-06-22', '2015-06-28', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2477, 109, 915, NULL, '2015-06-29', '2015-07-05', 'app0', 4, 4, NULL, NULL, NULL, NULL, NULL),
(2478, 17, 914, NULL, '2015-05-04', '2015-05-10', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(2479, 17, 914, NULL, '2015-05-11', '2015-05-17', 'app0', 1.6, 1.6, 1.6, NULL, 1.6, NULL, NULL),
(2480, 17, 914, NULL, '2015-05-18', '2015-05-24', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2481, 17, 914, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2482, 109, 914, NULL, '2015-05-04', '2015-05-10', 'app0', 4, 4, 4, 4, NULL, NULL, NULL),
(2483, 109, 914, NULL, '2015-05-11', '2015-05-17', 'app0', 4, 4, 4, NULL, 4, NULL, NULL),
(2484, 109, 914, NULL, '2015-05-18', '2015-05-24', 'app0', 4, 4, 4, 4, 4, NULL, NULL),
(2485, 109, 914, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 4, 4, 4, 4, NULL, NULL),
(2486, 17, 220, NULL, '2015-06-01', '2015-06-07', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2487, 17, 220, NULL, '2015-06-08', '2015-06-14', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2488, 17, 220, NULL, '2015-06-15', '2015-06-21', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2489, 17, 220, NULL, '2015-06-22', '2015-06-28', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2490, 17, 220, NULL, '2015-06-29', '2015-07-05', 'app0', 1.6, 1.6, NULL, NULL, NULL, NULL, NULL),
(2491, 17, 219, NULL, '2015-05-04', '2015-05-10', 'app0', 1.6, 1.6, 1.6, 1.6, NULL, NULL, NULL),
(2492, 17, 219, NULL, '2015-05-11', '2015-05-17', 'app0', 1.6, 1.6, 1.6, NULL, 1.6, NULL, NULL),
(2493, 17, 219, NULL, '2015-05-18', '2015-05-24', 'app0', 1.6, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2494, 17, 219, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 1.6, 1.6, 1.6, 1.6, NULL, NULL),
(2495, 109, 74, NULL, '2015-05-11', '2015-05-17', 'app0', NULL, NULL, NULL, NULL, 8, NULL, NULL),
(2496, 68, 73, NULL, '2015-05-11', '2015-05-17', 'app0', 8, NULL, NULL, NULL, NULL, NULL, NULL),
(2497, 68, 860, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, 0.08, NULL, NULL),
(2498, 68, 860, NULL, '2015-04-27', '2015-05-03', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2499, 68, 860, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2500, 68, 860, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2501, 68, 860, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2502, 68, 860, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2503, 68, 860, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2504, 68, 860, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2505, 68, 860, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2506, 68, 860, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2507, 68, 860, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(2508, 68, 966, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, 0.08, 0.08, NULL, NULL, NULL),
(2509, 68, 966, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2510, 68, 966, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2511, 68, 966, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2512, 68, 966, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2513, 68, 966, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2514, 68, 966, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2515, 68, 966, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2516, 68, 966, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2517, 68, 966, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(2518, 39, 860, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, NULL, NULL, 0.08, NULL, NULL),
(2519, 39, 860, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, 1, 2, 1, NULL, NULL, NULL),
(2520, 39, 860, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2521, 39, 860, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2522, 39, 860, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2523, 39, 860, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2524, 39, 860, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2525, 39, 860, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2526, 39, 860, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2527, 39, 860, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2528, 39, 860, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(2529, 39, 966, NULL, '2015-04-27', '2015-05-03', 'app3', NULL, NULL, NULL, 4, NULL, NULL, NULL),
(2530, 39, 966, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2531, 39, 966, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2532, 39, 966, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2533, 39, 966, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2534, 39, 966, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2535, 39, 966, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2536, 39, 966, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2537, 39, 966, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2538, 39, 966, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(2539, 68, 964, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2540, 68, 964, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2541, 68, 964, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2542, 68, 964, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2543, 68, 964, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2544, 68, 964, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2545, 68, 964, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2546, 68, 964, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2547, 68, 964, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2548, 68, 964, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(2549, 39, 964, NULL, '2015-04-27', '2015-05-03', 'app0', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2550, 39, 964, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2551, 39, 964, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2552, 39, 964, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2553, 39, 964, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2554, 39, 964, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2555, 39, 964, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2556, 39, 964, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2557, 39, 964, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2558, 39, 964, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL),
(2559, 68, 916, NULL, '2015-04-20', '2015-04-26', 'app0', NULL, NULL, 0.08, 0.08, 0.08, NULL, NULL),
(2560, 68, 916, NULL, '2015-04-27', '2015-05-03', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2561, 68, 916, NULL, '2015-05-04', '2015-05-10', 'app0', 0.08, 0.08, 0.08, 0.08, NULL, NULL, NULL),
(2562, 68, 916, NULL, '2015-05-11', '2015-05-17', 'app0', 0.08, 0.08, 0.08, NULL, 0.08, NULL, NULL),
(2563, 68, 916, NULL, '2015-05-18', '2015-05-24', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2564, 68, 916, NULL, '2015-05-25', '2015-05-31', 'app0', NULL, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2565, 68, 916, NULL, '2015-06-01', '2015-06-07', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2566, 68, 916, NULL, '2015-06-08', '2015-06-14', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2567, 68, 916, NULL, '2015-06-15', '2015-06-21', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2568, 68, 916, NULL, '2015-06-22', '2015-06-28', 'app0', 0.08, 0.08, 0.08, 0.08, 0.08, NULL, NULL),
(2569, 68, 916, NULL, '2015-06-29', '2015-07-05', 'app0', 0.08, 0.08, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `timesheetcomment`
--

DROP TABLE IF EXISTS `timesheetcomment`;
CREATE TABLE IF NOT EXISTS `timesheetcomment` (
`idTemesheetComment` int(10) unsigned NOT NULL,
  `previousStatus` varchar(10) NOT NULL,
  `actualStatus` varchar(10) NOT NULL,
  `idTimeSheet` int(10) unsigned NOT NULL,
  `contentComment` varchar(1000) NOT NULL,
  `commentDate` datetime NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1548 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `timesheetcomment`
--

INSERT INTO `timesheetcomment` (`idTemesheetComment`, `previousStatus`, `actualStatus`, `idTimeSheet`, `contentComment`, `commentDate`) VALUES
(9, 'app0', 'app1', 22, 'OK c''est bon', '2014-11-21 16:02:10'),
(10, 'app0', 'app1', 38, '', '2014-12-03 17:53:18'),
(11, 'app1', 'app3', 38, '', '2014-12-03 17:55:35'),
(12, 'app0', 'app1', 45, '', '2014-12-23 16:40:02'),
(13, 'app0', 'app1', 17, '', '2014-12-23 16:40:02'),
(14, 'app0', 'app1', 46, '', '2014-12-23 16:40:20'),
(15, 'app0', 'app1', 18, '', '2014-12-23 16:40:20'),
(16, 'app0', 'app1', 218, '', '2014-12-23 16:40:20'),
(17, 'app0', 'app1', 216, '', '2014-12-23 16:40:20'),
(18, 'app0', 'app1', 214, '', '2014-12-23 16:40:20'),
(19, 'app0', 'app1', 19, '', '2014-12-23 16:40:34'),
(20, 'app0', 'app1', 219, '', '2014-12-23 16:40:34'),
(21, 'app0', 'app1', 217, '', '2014-12-23 16:40:34'),
(22, 'app1', 'app3', 19, '', '2014-12-23 16:43:53'),
(23, 'app1', 'app3', 219, '', '2014-12-23 16:43:53'),
(24, 'app1', 'app3', 217, '', '2014-12-23 16:43:53'),
(25, 'app1', 'app3', 18, '', '2014-12-23 16:44:01'),
(26, 'app1', 'app3', 46, '', '2014-12-23 16:44:01'),
(27, 'app1', 'app3', 218, '', '2014-12-23 16:44:01'),
(28, 'app1', 'app3', 214, '', '2014-12-23 16:44:01'),
(29, 'app1', 'app3', 216, '', '2014-12-23 16:44:01'),
(30, 'app1', 'app3', 17, '', '2014-12-23 16:44:16'),
(31, 'app1', 'app3', 45, '', '2014-12-23 16:44:16'),
(32, 'app0', 'app1', 210, '', '2014-12-24 14:05:51'),
(33, 'app0', 'app1', 205, '', '2014-12-24 14:05:51'),
(34, 'app0', 'app1', 20, '', '2014-12-24 14:05:52'),
(35, 'app0', 'app1', 220, '', '2014-12-24 14:05:52'),
(36, 'app0', 'app1', 215, '', '2014-12-24 14:05:52'),
(37, 'app1', 'app3', 20, '', '2014-12-30 07:59:33'),
(38, 'app1', 'app3', 205, '', '2014-12-30 07:59:33'),
(39, 'app1', 'app3', 210, '', '2014-12-30 07:59:33'),
(40, 'app1', 'app3', 215, '', '2014-12-30 07:59:33'),
(41, 'app1', 'app3', 220, '', '2014-12-30 07:59:33'),
(42, 'app0', 'app1', 411, '', '2014-12-30 13:48:37'),
(43, 'app0', 'app1', 224, '', '2014-12-30 13:48:40'),
(44, 'app0', 'app1', 477, '', '2014-12-30 13:49:02'),
(45, 'app0', 'app1', 464, '', '2014-12-30 13:49:05'),
(46, 'app0', 'app1', 408, '', '2014-12-30 13:49:07'),
(47, 'app0', 'app1', 478, '', '2014-12-30 13:49:16'),
(48, 'app0', 'app1', 465, '', '2014-12-30 13:49:19'),
(49, 'app0', 'app1', 409, '', '2014-12-30 13:49:22'),
(50, 'app0', 'app1', 410, '', '2014-12-30 13:49:32'),
(51, 'app0', 'app1', 225, '', '2014-12-30 13:49:35'),
(52, 'app0', 'app1', 241, '', '2014-12-30 13:51:56'),
(53, 'app0', 'app1', 240, '', '2014-12-30 13:52:15'),
(54, 'app0', 'app1', 476, '', '2014-12-30 14:38:28'),
(55, 'app1', 'app3', 411, '', '2014-12-30 14:39:36'),
(56, 'app1', 'app3', 410, '', '2014-12-30 14:39:46'),
(57, 'app1', 'app3', 241, '', '2014-12-30 14:39:56'),
(58, 'app1', 'app3', 409, '', '2014-12-30 14:39:56'),
(59, 'app1', 'app3', 478, '', '2014-12-30 14:39:56'),
(60, 'app1', 'app3', 240, '', '2014-12-30 14:40:05'),
(61, 'app1', 'app3', 408, '', '2014-12-30 14:40:05'),
(62, 'app1', 'app3', 477, '', '2014-12-30 14:40:05'),
(63, 'app1', 'app0', 476, '', '2014-12-30 14:40:15'),
(64, 'app1', 'app3', 465, '', '2014-12-30 14:46:18'),
(65, 'app1', 'app3', 464, '', '2014-12-30 14:48:00'),
(66, 'app0', 'app1', 354, '', '2014-12-30 14:51:27'),
(67, 'app1', 'app3', 354, '', '2014-12-30 14:53:40'),
(68, 'app0', 'app1', 227, '', '2014-12-30 14:55:37'),
(69, 'app0', 'app1', 228, '', '2014-12-30 14:55:55'),
(70, 'app0', 'app1', 229, '', '2014-12-30 14:56:07'),
(71, 'app0', 'app1', 230, '', '2014-12-30 14:56:23'),
(72, 'app1', 'app3', 230, '', '2014-12-30 14:56:51'),
(73, 'app1', 'app3', 229, '', '2014-12-30 14:56:57'),
(74, 'app1', 'app3', 228, '', '2014-12-30 14:57:04'),
(75, 'app1', 'app3', 227, '', '2014-12-30 14:57:11'),
(76, 'app0', 'app1', 211, '', '2014-12-31 14:15:20'),
(77, 'app0', 'app1', 206, '', '2014-12-31 14:15:20'),
(78, 'app0', 'app1', 21, '', '2014-12-31 14:15:20'),
(79, 'app0', 'app1', 221, '', '2014-12-31 14:15:20'),
(80, 'app1', 'app3', 21, '', '2014-12-31 14:15:44'),
(81, 'app1', 'app3', 206, '', '2014-12-31 14:15:44'),
(82, 'app1', 'app3', 211, '', '2014-12-31 14:15:44'),
(83, 'app1', 'app3', 221, '', '2014-12-31 14:15:45'),
(84, 'app0', 'app1', 592, '', '2014-12-31 14:59:31'),
(85, 'app0', 'app1', 533, '', '2014-12-31 14:59:31'),
(86, 'app1', 'app3', 592, '', '2014-12-31 15:00:11'),
(87, 'app1', 'app3', 533, '', '2014-12-31 15:00:13'),
(88, 'app0', 'app1', 481, '', '2015-01-08 15:48:30'),
(89, 'app0', 'app1', 468, '', '2015-01-08 15:57:05'),
(90, 'app0', 'app1', 412, '', '2015-01-08 15:57:09'),
(91, 'app1', 'app0', 468, '', '2015-01-13 17:02:17'),
(92, 'app0', 'app1', 468, '', '2015-01-13 17:03:48'),
(93, 'app1', 'app3', 468, '', '2015-01-13 17:04:32'),
(94, 'app0', 'app1', 600, '', '2015-01-14 15:27:09'),
(95, 'app0', 'app1', 594, '', '2015-01-14 15:27:09'),
(96, 'app0', 'app1', 48, '', '2015-01-14 15:27:09'),
(97, 'app0', 'app1', 593, '', '2015-01-14 15:27:09'),
(98, 'app0', 'app1', 534, '', '2015-01-14 15:27:09'),
(99, 'app0', 'app1', 155, '', '2015-01-14 17:16:57'),
(100, 'app0', 'app1', 244, '', '2015-01-14 17:17:01'),
(101, 'app0', 'app1', 245, '', '2015-01-14 17:17:51'),
(102, 'app1', 'app0', 48, '', '2015-01-15 08:58:43'),
(103, 'app1', 'app0', 594, '', '2015-01-15 08:58:51'),
(104, 'app1', 'app0', 600, '', '2015-01-15 08:58:51'),
(105, 'app0', 'app1', 600, '', '2015-01-15 09:00:20'),
(106, 'app0', 'app1', 594, '', '2015-01-15 09:00:20'),
(107, 'app0', 'app1', 641, '', '2015-01-15 09:00:20'),
(108, 'app0', 'app1', 48, '', '2015-01-15 09:00:20'),
(109, 'app1', 'app0', 245, '', '2015-01-15 17:46:52'),
(110, 'app0', 'app1', 245, '', '2015-01-15 17:47:19'),
(111, 'app1', 'app0', 244, '', '2015-01-15 17:48:07'),
(112, 'app1', 'app0', 245, '', '2015-01-15 17:48:18'),
(113, 'app0', 'app1', 244, '', '2015-01-15 17:49:07'),
(114, 'app0', 'app1', 245, '', '2015-01-15 17:49:19'),
(115, 'app1', 'app3', 481, '', '2015-01-15 17:50:07'),
(116, 'app1', 'app3', 244, '', '2015-01-15 17:50:14'),
(117, 'app1', 'app3', 412, '', '2015-01-15 17:50:39'),
(118, 'app1', 'app3', 245, '', '2015-01-15 17:50:46'),
(119, 'app0', 'app1', 232, '', '2015-01-15 18:04:11'),
(120, 'app1', 'app0', 232, '', '2015-01-15 18:05:38'),
(121, 'app0', 'app1', 232, '', '2015-01-15 18:06:56'),
(122, 'app1', 'app0', 232, '', '2015-01-16 18:53:53'),
(123, 'app0', 'app1', 601, '', '2015-01-19 07:07:19'),
(124, 'app0', 'app1', 634, '', '2015-01-19 07:07:19'),
(125, 'app0', 'app1', 595, '', '2015-01-19 07:07:19'),
(126, 'app0', 'app1', 637, '', '2015-01-19 07:07:19'),
(127, 'app0', 'app1', 208, '', '2015-01-19 07:07:19'),
(128, 'app0', 'app1', 642, '', '2015-01-19 07:07:19'),
(129, 'app0', 'app1', 49, '', '2015-01-19 07:07:19'),
(130, 'app1', 'app3', 49, '', '2015-01-19 07:08:05'),
(131, 'app1', 'app3', 595, '', '2015-01-19 07:08:05'),
(132, 'app1', 'app3', 208, '', '2015-01-19 07:08:05'),
(133, 'app1', 'app3', 601, '', '2015-01-19 07:08:05'),
(134, 'app1', 'app3', 634, '', '2015-01-19 07:08:05'),
(135, 'app1', 'app3', 637, '', '2015-01-19 07:08:05'),
(136, 'app1', 'app3', 642, '', '2015-01-19 07:08:05'),
(137, 'app0', 'app1', 655, '', '2015-01-20 06:55:31'),
(138, 'app0', 'app1', 482, '', '2015-01-21 11:13:37'),
(139, 'app0', 'app1', 469, '', '2015-01-21 11:13:46'),
(140, 'app0', 'app1', 413, '', '2015-01-21 11:13:51'),
(141, 'app1', 'app3', 469, '', '2015-01-21 11:20:59'),
(142, 'app1', 'app3', 655, '', '2015-01-21 14:45:42'),
(143, 'app1', 'app3', 48, '', '2015-01-21 14:45:53'),
(144, 'app1', 'app3', 594, '', '2015-01-21 14:45:53'),
(145, 'app1', 'app3', 600, '', '2015-01-21 14:45:53'),
(146, 'app1', 'app3', 641, '', '2015-01-21 14:45:53'),
(147, 'app0', 'app1', 658, '', '2015-01-26 08:03:14'),
(148, 'app0', 'app1', 596, '', '2015-01-26 08:03:14'),
(149, 'app0', 'app1', 662, '', '2015-01-26 08:03:14'),
(150, 'app0', 'app1', 646, '', '2015-01-26 08:03:14'),
(151, 'app0', 'app1', 656, '', '2015-01-26 08:03:14'),
(152, 'app0', 'app1', 643, '', '2015-01-26 08:03:14'),
(153, 'app0', 'app1', 50, '', '2015-01-26 08:03:14'),
(154, 'app0', 'app1', 663, '', '2015-01-26 08:03:14'),
(155, 'app1', 'app3', 50, '', '2015-01-26 08:03:49'),
(156, 'app1', 'app3', 596, '', '2015-01-26 08:03:49'),
(157, 'app1', 'app3', 658, '', '2015-01-26 08:03:49'),
(158, 'app1', 'app3', 646, '', '2015-01-26 08:03:49'),
(159, 'app1', 'app3', 656, '', '2015-01-26 08:03:49'),
(160, 'app1', 'app3', 662, '', '2015-01-26 08:03:49'),
(161, 'app1', 'app3', 643, '', '2015-01-26 08:03:49'),
(162, 'app0', 'app1', 674, '', '2015-01-26 15:31:34'),
(163, 'app0', 'app1', 675, '', '2015-01-26 15:35:04'),
(164, 'app0', 'app1', 483, '', '2015-01-26 16:11:04'),
(165, 'app0', 'app1', 414, '', '2015-01-26 16:12:36'),
(166, 'app0', 'app1', 470, '', '2015-01-26 16:12:41'),
(167, 'app1', 'app3', 470, '', '2015-01-26 16:14:59'),
(168, 'app0', 'app1', 543, '', '2015-01-29 08:02:06'),
(169, 'app0', 'app1', 661, '', '2015-01-29 08:02:06'),
(170, 'app0', 'app1', 682, '', '2015-01-29 08:02:06'),
(171, 'app0', 'app1', 104, '', '2015-01-29 08:02:06'),
(172, 'app0', 'app1', 542, '', '2015-01-29 08:02:43'),
(173, 'app0', 'app1', 660, '', '2015-01-29 08:02:43'),
(174, 'app0', 'app1', 648, '', '2015-01-29 08:02:43'),
(175, 'app0', 'app1', 654, '', '2015-01-29 08:02:43'),
(176, 'app0', 'app1', 681, '', '2015-01-29 08:02:43'),
(177, 'app0', 'app1', 103, '', '2015-01-29 08:02:43'),
(178, 'app0', 'app1', 541, '', '2015-01-29 08:02:57'),
(179, 'app0', 'app1', 659, '', '2015-01-29 08:02:57'),
(180, 'app0', 'app1', 647, '', '2015-01-29 08:02:57'),
(181, 'app0', 'app1', 653, '', '2015-01-29 08:02:57'),
(182, 'app0', 'app1', 102, '', '2015-01-29 08:02:57'),
(183, 'app0', 'app1', 540, '', '2015-01-29 08:03:04'),
(184, 'app0', 'app1', 101, '', '2015-01-29 08:03:04'),
(185, 'app0', 'app1', 539, '', '2015-01-29 08:03:16'),
(186, 'app0', 'app1', 213, '', '2015-01-29 08:03:16'),
(187, 'app0', 'app1', 28, '', '2015-01-29 08:03:16'),
(188, 'app0', 'app1', 538, '', '2015-01-29 08:03:37'),
(189, 'app0', 'app1', 212, '', '2015-01-29 08:03:37'),
(190, 'app0', 'app1', 27, '', '2015-01-29 08:03:37'),
(191, 'app0', 'app1', 537, '', '2015-01-29 08:03:46'),
(192, 'app0', 'app1', 26, '', '2015-01-29 08:03:46'),
(193, 'app0', 'app1', 536, '', '2015-01-29 08:03:56'),
(194, 'app0', 'app1', 25, '', '2015-01-29 08:03:56'),
(195, 'app0', 'app1', 535, '', '2015-01-29 08:04:07'),
(196, 'app0', 'app1', 24, '', '2015-01-29 08:04:07'),
(197, 'app0', 'app1', 23, '', '2015-01-29 08:04:14'),
(198, 'app0', 'app1', 471, '', '2015-01-29 17:36:55'),
(199, 'app0', 'app1', 415, '', '2015-01-29 17:42:45'),
(200, 'app0', 'app1', 684, '', '2015-02-02 07:13:47'),
(201, 'app0', 'app1', 597, '', '2015-02-02 07:13:47'),
(202, 'app0', 'app1', 699, '', '2015-02-02 07:13:47'),
(203, 'app0', 'app1', 683, '', '2015-02-02 07:13:47'),
(204, 'app0', 'app1', 644, '', '2015-02-02 07:13:47'),
(205, 'app0', 'app1', 51, '', '2015-02-02 07:13:47'),
(206, 'app0', 'app1', 690, '', '2015-02-03 11:22:22'),
(207, 'app0', 'app1', 691, '', '2015-02-03 11:22:52'),
(208, 'app3', 'app0', 228, '', '2015-02-03 11:30:01'),
(209, 'app0', 'app1', 228, '', '2015-02-03 11:30:34'),
(210, 'app3', 'app0', 227, '', '2015-02-03 11:32:00'),
(211, 'app1', 'app0', 228, '', '2015-02-03 11:32:27'),
(212, 'app3', 'app0', 229, '', '2015-02-03 11:32:36'),
(213, 'app3', 'app0', 230, '', '2015-02-03 11:32:44'),
(214, 'app0', 'app1', 228, '', '2015-02-03 11:34:52'),
(215, 'app1', 'app3', 228, '', '2015-02-03 11:36:59'),
(216, 'app1', 'app3', 690, '', '2015-02-03 11:37:18'),
(217, 'app1', 'app3', 691, '', '2015-02-03 11:37:28'),
(218, 'app0', 'app1', 246, '', '2015-02-03 15:04:30'),
(219, 'app0', 'app1', 701, '', '2015-02-03 15:06:01'),
(220, 'app0', 'app1', 248, '', '2015-02-03 15:11:48'),
(221, 'app1', 'app3', 535, '', '2015-02-04 16:11:40'),
(222, 'app1', 'app3', 536, '', '2015-02-04 16:11:56'),
(223, 'app1', 'app3', 537, '', '2015-02-04 16:12:13'),
(224, 'app1', 'app3', 538, '', '2015-02-04 16:12:27'),
(225, 'app1', 'app3', 539, '', '2015-02-04 16:12:37'),
(226, 'app1', 'app3', 540, '', '2015-02-04 16:12:45'),
(227, 'app1', 'app3', 482, '', '2015-02-04 16:12:53'),
(228, 'app1', 'app3', 541, '', '2015-02-04 16:12:57'),
(229, 'app1', 'app3', 674, '', '2015-02-04 16:13:16'),
(230, 'app1', 'app3', 414, '', '2015-02-04 16:13:31'),
(231, 'app1', 'app3', 483, '', '2015-02-04 16:13:36'),
(232, 'app1', 'app3', 542, '', '2015-02-04 16:13:41'),
(233, 'app1', 'app3', 246, '', '2015-02-04 16:13:45'),
(234, 'app1', 'app3', 675, '', '2015-02-04 16:13:49'),
(235, 'app1', 'app3', 415, '', '2015-02-04 16:14:00'),
(236, 'app1', 'app3', 543, '', '2015-02-04 16:14:04'),
(237, 'app1', 'app3', 413, '', '2015-02-04 16:14:24'),
(238, 'app1', 'app3', 471, '', '2015-02-05 13:03:43'),
(239, 'app0', 'app1', 685, '', '2015-02-06 07:00:07'),
(240, 'app0', 'app1', 724, '', '2015-02-06 07:00:07'),
(241, 'app0', 'app1', 700, '', '2015-02-06 07:00:07'),
(242, 'app0', 'app1', 698, '', '2015-02-06 07:00:07'),
(243, 'app0', 'app1', 639, '', '2015-02-06 07:00:07'),
(244, 'app0', 'app1', 52, '', '2015-02-06 07:00:07'),
(245, 'app1', 'app3', 52, '', '2015-02-06 07:00:35'),
(246, 'app1', 'app3', 639, '', '2015-02-06 07:00:35'),
(247, 'app1', 'app3', 685, '', '2015-02-06 07:00:35'),
(248, 'app1', 'app3', 700, '', '2015-02-06 07:00:35'),
(249, 'app1', 'app3', 698, '', '2015-02-06 07:00:35'),
(250, 'app1', 'app3', 724, '', '2015-02-06 07:00:35'),
(252, 'app1', 'app3', 104, '', '2015-02-06 18:02:19'),
(253, 'app1', 'app3', 661, '', '2015-02-06 18:02:19'),
(254, 'app1', 'app3', 682, '', '2015-02-06 18:02:19'),
(255, 'app1', 'app3', 51, '', '2015-02-06 18:02:19'),
(256, 'app1', 'app3', 597, '', '2015-02-06 18:02:19'),
(257, 'app1', 'app3', 684, '', '2015-02-06 18:02:19'),
(258, 'app1', 'app3', 699, '', '2015-02-06 18:02:19'),
(259, 'app1', 'app3', 683, '', '2015-02-06 18:02:19'),
(260, 'app1', 'app3', 644, '', '2015-02-06 18:02:19'),
(261, 'app1', 'app3', 701, '', '2015-02-06 18:02:19'),
(262, 'app1', 'app3', 103, '', '2015-02-06 18:02:29'),
(263, 'app1', 'app3', 648, '', '2015-02-06 18:02:29'),
(264, 'app1', 'app3', 654, '', '2015-02-06 18:02:29'),
(265, 'app1', 'app3', 660, '', '2015-02-06 18:02:29'),
(266, 'app1', 'app3', 681, '', '2015-02-06 18:02:29'),
(267, 'app1', 'app3', 102, '', '2015-02-06 18:02:38'),
(268, 'app1', 'app3', 647, '', '2015-02-06 18:02:38'),
(269, 'app1', 'app3', 653, '', '2015-02-06 18:02:38'),
(270, 'app1', 'app3', 659, '', '2015-02-06 18:02:38'),
(271, 'app1', 'app3', 101, '', '2015-02-06 18:02:46'),
(272, 'app1', 'app3', 28, '', '2015-02-06 18:02:52'),
(273, 'app1', 'app3', 27, '', '2015-02-06 18:03:01'),
(274, 'app1', 'app3', 26, '', '2015-02-06 18:03:08'),
(275, 'app1', 'app3', 25, '', '2015-02-06 18:03:15'),
(276, 'app1', 'app3', 24, '', '2015-02-06 18:03:21'),
(277, 'app1', 'app3', 23, '', '2015-02-06 18:03:28'),
(278, 'app1', 'app3', 22, '', '2015-02-06 18:03:36'),
(279, 'app0', 'app1', 544, '', '2015-02-06 19:10:46'),
(280, 'app0', 'app1', 697, '', '2015-02-06 19:10:55'),
(281, 'app0', 'app1', 105, '', '2015-02-06 19:10:58'),
(283, 'app1', 'app3', 105, '', '2015-02-09 12:00:19'),
(284, 'app1', 'app3', 697, '', '2015-02-09 12:00:19'),
(285, 'app0', 'app1', 767, '', '2015-02-10 09:53:59'),
(286, 'app1', 'app0', 767, 'à modifier en 4 heures', '2015-02-10 10:56:57'),
(287, 'app1', 'app3', 544, '', '2015-02-11 15:29:12'),
(288, 'app1', 'app3', 248, '', '2015-02-11 15:29:15'),
(289, 'app0', 'app1', 748, '', '2015-02-12 10:04:51'),
(290, 'app0', 'app1', 485, '', '2015-02-12 10:06:31'),
(291, 'app0', 'app1', 472, '', '2015-02-12 10:06:31'),
(292, 'app0', 'app1', 416, '', '2015-02-12 10:06:31'),
(293, 'app0', 'app1', 771, '', '2015-02-12 10:06:31'),
(294, 'app0', 'app1', 772, '', '2015-02-12 10:06:31'),
(295, 'app1', 'app3', 472, '', '2015-02-12 10:10:09'),
(296, 'app1', 'app3', 772, '', '2015-02-12 10:10:56'),
(297, 'app1', 'app0', 771, '', '2015-02-12 10:11:03'),
(298, 'app0', 'app1', 771, '', '2015-02-12 10:11:49'),
(299, 'app1', 'app3', 771, '', '2015-02-12 10:12:09'),
(300, 'app0', 'app1', 486, '', '2015-02-12 10:12:46'),
(301, 'app0', 'app1', 473, '', '2015-02-12 10:13:13'),
(302, 'app0', 'app1', 417, '', '2015-02-12 10:13:13'),
(303, 'app0', 'app1', 767, '', '2015-02-12 11:04:23'),
(309, 'app0', 'app1', 787, '', '2015-02-12 16:57:45'),
(310, 'app0', 'app1', 799, '', '2015-02-12 16:57:45'),
(311, 'app0', 'app1', 800, '', '2015-02-12 16:57:45'),
(312, 'app0', 'app1', 798, '', '2015-02-12 16:57:46'),
(313, 'app0', 'app1', 640, '', '2015-02-12 16:57:46'),
(314, 'app0', 'app1', 53, '', '2015-02-12 16:57:46'),
(315, 'app1', 'app3', 53, '', '2015-02-12 16:58:29'),
(316, 'app1', 'app3', 640, '', '2015-02-12 16:58:29'),
(317, 'app1', 'app3', 800, '', '2015-02-12 16:58:29'),
(318, 'app1', 'app3', 799, '', '2015-02-12 16:58:29'),
(319, 'app1', 'app3', 787, '', '2015-02-12 16:58:29'),
(320, 'app1', 'app3', 798, '', '2015-02-12 16:58:30'),
(321, 'app1', 'app3', 767, '', '2015-02-12 16:58:30'),
(322, 'app0', 'app1', 766, '', '2015-02-12 17:00:22'),
(323, 'app0', 'app1', 249, '', '2015-02-12 17:00:42'),
(324, 'app1', 'app0', 249, '', '2015-02-12 17:01:32'),
(325, 'app1', 'app3', 417, '', '2015-02-12 17:01:45'),
(326, 'app1', 'app3', 486, '', '2015-02-12 17:01:45'),
(327, 'app0', 'app1', 249, '', '2015-02-12 17:02:24'),
(328, 'app1', 'app3', 249, '', '2015-02-12 17:02:40'),
(329, 'app1', 'app3', 416, '', '2015-02-12 17:02:54'),
(330, 'app1', 'app3', 485, '', '2015-02-12 17:02:54'),
(331, 'app0', 'app1', 852, '', '2015-02-12 17:22:18'),
(332, 'app1', 'app3', 852, '', '2015-02-12 17:22:57'),
(333, 'app1', 'app3', 748, '', '2015-02-12 18:41:21'),
(334, 'app1', 'app3', 766, '', '2015-02-12 18:41:43'),
(335, 'app0', 'app1', 729, '', '2015-02-13 09:59:21'),
(336, 'app0', 'app1', 802, '', '2015-02-13 10:01:57'),
(337, 'app1', 'app3', 473, '', '2015-02-13 13:35:17'),
(338, 'app0', 'app1', 803, '', '2015-02-13 15:15:49'),
(339, 'app0', 'app1', 912, '', '2015-02-18 17:06:16'),
(340, 'app0', 'app1', 487, '', '2015-02-18 17:06:57'),
(342, 'app0', 'app1', 911, '', '2015-02-19 11:51:00'),
(350, 'app0', 'app1', 853, '', '2015-02-19 16:28:20'),
(351, 'app0', 'app1', 727, '', '2015-02-19 16:54:02'),
(352, 'app0', 'app1', 804, '', '2015-02-19 16:54:58'),
(353, 'app0', 'app1', 788, '', '2015-02-20 06:56:05'),
(354, 'app0', 'app1', 899, '', '2015-02-20 06:56:05'),
(355, 'app0', 'app1', 54, '', '2015-02-20 06:56:05'),
(356, 'app1', 'app3', 54, '', '2015-02-20 06:56:42'),
(357, 'app1', 'app3', 788, '', '2015-02-20 06:56:42'),
(358, 'app1', 'app3', 899, '', '2015-02-20 06:56:42'),
(359, 'app0', 'app1', 250, '', '2015-02-20 08:34:25'),
(360, 'app1', 'app3', 250, '', '2015-02-20 08:35:31'),
(361, 'app1', 'app3', 487, '', '2015-02-20 08:35:31'),
(362, 'app3', 'app0', 250, '', '2015-02-20 08:35:45'),
(363, 'app0', 'app1', 250, '', '2015-02-20 08:36:00'),
(364, 'app1', 'app3', 250, '', '2015-02-20 08:36:24'),
(365, 'app0', 'app1', 749, '', '2015-02-23 09:51:44'),
(366, 'app0', 'app1', 474, '', '2015-02-23 18:15:37'),
(367, 'app0', 'app1', 418, '', '2015-02-23 18:15:42'),
(368, 'app1', 'app3', 474, '', '2015-02-23 18:17:37'),
(369, 'app0', 'app1', 940, '', '2015-02-24 17:55:04'),
(370, 'app0', 'app1', 941, '', '2015-02-24 17:55:29'),
(371, 'app0', 'app1', 942, '', '2015-02-24 17:55:51'),
(372, 'app0', 'app1', 943, '', '2015-02-24 17:56:04'),
(373, 'app0', 'app1', 673, '', '2015-02-24 23:19:23'),
(374, 'app0', 'app1', 664, '', '2015-02-24 23:19:27'),
(375, 'app1', 'app3', 940, '', '2015-02-24 23:20:40'),
(376, 'app1', 'app3', 941, '', '2015-02-24 23:21:06'),
(377, 'app1', 'app3', 942, '', '2015-02-24 23:21:44'),
(378, 'app1', 'app3', 943, '', '2015-02-24 23:21:56'),
(379, 'app0', 'app1', 696, '', '2015-02-25 14:48:40'),
(380, 'app0', 'app1', 913, '', '2015-02-25 14:52:59'),
(381, 'app0', 'app1', 914, '', '2015-02-25 14:53:27'),
(382, 'app0', 'app1', 915, '', '2015-02-25 14:53:48'),
(383, 'app0', 'app1', 916, '', '2015-02-25 14:54:10'),
(384, 'app1', 'app0', 696, '', '2015-02-25 14:59:45'),
(385, 'app0', 'app1', 957, '', '2015-02-25 15:09:49'),
(386, 'app0', 'app1', 625, '', '2015-02-25 15:30:57'),
(387, 'app0', 'app1', 805, '', '2015-02-25 15:31:20'),
(388, 'app0', 'app1', 952, '', '2015-02-25 15:34:15'),
(389, 'app0', 'app1', 951, '', '2015-02-25 15:35:43'),
(390, 'app0', 'app1', 1009, '', '2015-02-25 23:36:13'),
(391, 'app0', 'app1', 1007, '', '2015-02-25 23:37:47'),
(392, 'app0', 'app1', 1006, '', '2015-02-25 23:41:05'),
(393, 'app0', 'app1', 1005, '', '2015-02-25 23:42:53'),
(394, 'app1', 'app3', 915, '', '2015-02-25 23:45:35'),
(395, 'app1', 'app3', 1007, '', '2015-02-25 23:45:35'),
(396, 'app1', 'app3', 914, '', '2015-02-25 23:45:51'),
(397, 'app1', 'app3', 1006, '', '2015-02-25 23:45:51'),
(398, 'app1', 'app3', 913, '', '2015-02-25 23:46:06'),
(399, 'app1', 'app3', 1005, '', '2015-02-25 23:46:06'),
(400, 'app1', 'app3', 916, '', '2015-02-25 23:47:01'),
(401, 'app0', 'app1', 939, '', '2015-02-25 23:54:47'),
(402, 'app0', 'app1', 789, '', '2015-02-26 08:06:29'),
(403, 'app0', 'app1', 976, '', '2015-02-26 08:06:29'),
(404, 'app0', 'app1', 975, '', '2015-02-26 08:06:29'),
(405, 'app0', 'app1', 55, '', '2015-02-26 08:06:29'),
(406, 'app1', 'app3', 55, '', '2015-02-26 08:06:48'),
(407, 'app1', 'app3', 789, '', '2015-02-26 08:06:48'),
(408, 'app1', 'app3', 976, '', '2015-02-26 08:06:48'),
(409, 'app1', 'app3', 975, '', '2015-02-26 08:06:48'),
(410, 'app0', 'app1', 1013, '', '2015-02-26 12:09:46'),
(411, 'app0', 'app1', 1014, '', '2015-02-26 12:10:22'),
(412, 'app0', 'app1', 938, '', '2015-02-26 12:18:23'),
(413, 'app0', 'app1', 1015, '', '2015-02-26 12:18:26'),
(415, 'app0', 'app1', 935, '', '2015-02-26 12:23:50'),
(416, 'app0', 'app1', 1024, '', '2015-02-26 12:24:38'),
(417, 'app0', 'app1', 1023, '', '2015-02-26 14:03:02'),
(418, 'app0', 'app1', 932, '', '2015-02-26 14:05:07'),
(419, 'app0', 'app1', 1022, '', '2015-02-26 14:05:07'),
(420, 'app0', 'app1', 1004, '', '2015-02-26 14:10:57'),
(421, 'app0', 'app1', 1046, '', '2015-02-26 14:14:14'),
(422, 'app0', 'app1', 1047, '', '2015-02-26 14:45:31'),
(423, 'app0', 'app1', 995, '', '2015-02-26 14:45:31'),
(424, 'app0', 'app1', 986, '', '2015-02-26 14:45:31'),
(425, 'app0', 'app1', 1049, '', '2015-02-26 14:58:16'),
(426, 'app0', 'app1', 1050, '', '2015-02-26 15:02:39'),
(427, 'app0', 'app1', 968, '', '2015-02-26 15:05:00'),
(428, 'app0', 'app1', 969, '', '2015-02-26 15:05:18'),
(429, 'app0', 'app1', 970, '', '2015-02-26 15:05:39'),
(430, 'app0', 'app1', 971, '', '2015-02-26 15:06:05'),
(431, 'app0', 'app1', 972, '', '2015-02-26 15:07:30'),
(432, 'app1', 'app3', 1013, '', '2015-02-26 15:12:50'),
(433, 'app1', 'app3', 995, '', '2015-02-26 15:12:50'),
(434, 'app1', 'app3', 986, '', '2015-02-26 15:12:50'),
(435, 'app1', 'app3', 1047, '', '2015-02-26 15:12:50'),
(436, 'app1', 'app3', 932, '', '2015-02-26 15:12:50'),
(437, 'app1', 'app3', 1022, '', '2015-02-26 15:12:50'),
(438, 'app1', 'app3', 968, '', '2015-02-26 15:12:50'),
(439, 'app1', 'app3', 1014, '', '2015-02-26 15:14:19'),
(440, 'app1', 'app3', 1023, '', '2015-02-26 15:14:19'),
(441, 'app1', 'app3', 1046, '', '2015-02-26 15:14:19'),
(442, 'app1', 'app3', 969, '', '2015-02-26 15:14:19'),
(443, 'app1', 'app3', 938, '', '2015-02-26 15:15:44'),
(444, 'app1', 'app3', 1015, '', '2015-02-26 15:15:44'),
(445, 'app1', 'app3', 1049, '', '2015-02-26 15:15:44'),
(446, 'app1', 'app3', 1024, '', '2015-02-26 15:15:44'),
(447, 'app1', 'app3', 1004, '', '2015-02-26 15:15:44'),
(448, 'app1', 'app3', 970, '', '2015-02-26 15:15:44'),
(449, 'app1', 'app3', 939, '', '2015-02-26 15:18:15'),
(450, 'app1', 'app3', 935, '', '2015-02-26 15:18:18'),
(451, 'app1', 'app3', 971, '', '2015-02-26 15:18:27'),
(452, 'app1', 'app3', 1050, '', '2015-02-26 15:20:30'),
(453, 'app0', 'app1', 1061, '', '2015-02-27 08:30:39'),
(454, 'app1', 'app3', 1061, '', '2015-02-27 08:31:58'),
(455, 'app0', 'app1', 959, '', '2015-02-27 09:07:53'),
(456, 'app0', 'app1', 713, '', '2015-02-27 09:08:29'),
(457, 'app0', 'app1', 546, '', '2015-02-27 09:09:29'),
(458, 'app0', 'app1', 785, '', '2015-02-27 09:09:29'),
(459, 'app0', 'app1', 107, '', '2015-02-27 09:09:29'),
(460, 'app0', 'app1', 961, '', '2015-02-27 09:09:29'),
(461, 'app0', 'app1', 547, '', '2015-02-27 09:09:48'),
(462, 'app0', 'app1', 786, '', '2015-02-27 09:09:48'),
(463, 'app0', 'app1', 974, '', '2015-02-27 09:09:48'),
(464, 'app0', 'app1', 108, '', '2015-02-27 09:09:48'),
(465, 'app0', 'app1', 962, '', '2015-02-27 09:09:48'),
(466, 'app0', 'app1', 251, '', '2015-02-27 11:56:26'),
(467, 'app1', 'app3', 547, '', '2015-02-27 14:05:09'),
(468, 'app1', 'app3', 251, '', '2015-02-27 14:05:09'),
(469, 'app1', 'app3', 546, '', '2015-02-27 14:05:22'),
(470, 'app1', 'app3', 418, '', '2015-02-27 14:05:27'),
(471, 'app1', 'app3', 107, '', '2015-02-27 15:57:52'),
(472, 'app1', 'app3', 785, '', '2015-02-27 15:57:52'),
(473, 'app1', 'app3', 108, '', '2015-02-27 15:58:00'),
(474, 'app1', 'app3', 786, '', '2015-02-27 15:58:00'),
(475, 'app1', 'app3', 974, '', '2015-02-27 15:58:00'),
(476, 'app0', 'app1', 927, '', '2015-03-03 23:51:35'),
(477, 'app0', 'app1', 1094, '', '2015-03-04 14:59:42'),
(478, 'app1', 'app3', 927, '', '2015-03-04 16:07:52'),
(479, 'app0', 'app1', 762, '', '2015-03-05 12:17:23'),
(480, 'app0', 'app1', 765, '', '2015-03-05 12:17:51'),
(481, 'app1', 'app3', 765, '', '2015-03-05 14:17:26'),
(482, 'app1', 'app3', 762, '', '2015-03-05 14:17:48'),
(483, 'app0', 'app1', 488, '', '2015-03-05 14:25:14'),
(484, 'app0', 'app1', 475, '', '2015-03-05 14:25:14'),
(485, 'app0', 'app1', 419, '', '2015-03-05 14:25:14'),
(486, 'app1', 'app3', 475, '', '2015-03-05 14:32:29'),
(487, 'app0', 'app1', 1138, '', '2015-03-05 15:06:13'),
(488, 'app0', 'app1', 1111, '', '2015-03-05 16:19:38'),
(489, 'app0', 'app1', 1036, '', '2015-03-05 16:19:38'),
(490, 'app0', 'app1', 981, '', '2015-03-05 16:19:38'),
(491, 'app0', 'app1', 1101, '', '2015-03-05 16:29:37'),
(492, 'app0', 'app1', 1096, '', '2015-03-05 16:29:37'),
(493, 'app0', 'app1', 1041, '', '2015-03-05 17:11:35'),
(494, 'app0', 'app1', 990, '', '2015-03-05 17:11:36'),
(495, 'app1', 'app3', 990, '', '2015-03-05 17:19:17'),
(496, 'app1', 'app3', 1041, '', '2015-03-05 17:19:17'),
(497, 'app0', 'app1', 1116, '', '2015-03-05 17:23:23'),
(498, 'app0', 'app1', 1106, '', '2015-03-05 17:23:26'),
(499, 'app0', 'app1', 922, '', '2015-03-05 17:23:27'),
(500, 'app0', 'app1', 1017, '', '2015-03-05 17:23:29'),
(501, 'app0', 'app1', 1141, '', '2015-03-06 07:32:05'),
(502, 'app0', 'app1', 1062, '', '2015-03-06 07:32:05'),
(503, 'app0', 'app1', 1093, '', '2015-03-06 07:32:05'),
(504, 'app0', 'app1', 56, '', '2015-03-06 07:32:05'),
(505, 'app1', 'app3', 56, '', '2015-03-06 07:36:56'),
(506, 'app1', 'app3', 1141, '', '2015-03-06 07:36:56'),
(507, 'app1', 'app3', 1062, '', '2015-03-06 07:36:56'),
(508, 'app1', 'app3', 1093, '', '2015-03-06 07:36:56'),
(509, 'app1', 'app3', 1094, '', '2015-03-06 07:36:56'),
(510, 'app0', 'app1', 917, 'Le reste est du bundle tools Airbus', '2015-03-06 09:57:23'),
(511, 'app0', 'app1', 973, '', '2015-03-06 10:46:26'),
(512, 'app0', 'app1', 1051, '', '2015-03-06 10:46:26'),
(513, 'app0', 'app1', 958, 'ouf', '2015-03-06 10:56:48'),
(514, 'app0', 'app1', 950, '', '2015-03-06 11:07:14'),
(515, 'app1', 'app3', 1096, '', '2015-03-06 11:12:08'),
(516, 'app1', 'app3', 1101, '', '2015-03-06 11:12:08'),
(517, 'app1', 'app3', 1051, '', '2015-03-06 11:12:16'),
(518, 'app1', 'app3', 981, '', '2015-03-06 11:12:45'),
(519, 'app1', 'app3', 1036, '', '2015-03-06 11:12:46'),
(520, 'app1', 'app3', 1111, '', '2015-03-06 11:12:46'),
(521, 'app1', 'app0', 917, '', '2015-03-06 11:13:12'),
(522, 'app1', 'app0', 1017, 'Vendredi à modifier', '2015-03-06 11:17:05'),
(523, 'app1', 'app3', 922, '', '2015-03-06 11:18:42'),
(524, 'app1', 'app3', 1106, '', '2015-03-06 11:18:42'),
(525, 'app0', 'app1', 1017, '', '2015-03-06 11:24:00'),
(526, 'app1', 'app0', 1017, 'rejet', '2015-03-06 11:27:35'),
(527, 'app0', 'app1', 1017, '', '2015-03-06 11:28:24'),
(528, 'app1', 'app3', 1017, '', '2015-03-06 12:15:07'),
(529, 'app0', 'app1', 917, '', '2015-03-06 12:15:53'),
(530, 'app0', 'app1', 1026, '', '2015-03-06 12:15:53'),
(531, 'app1', 'app3', 917, '', '2015-03-06 12:18:25'),
(532, 'app1', 'app3', 1026, '', '2015-03-06 12:18:25'),
(533, 'app3', 'app0', 917, 'c''est en heure et non en jours!', '2015-03-06 12:29:35'),
(534, 'app0', 'app1', 917, '', '2015-03-06 12:30:29'),
(535, 'app3', 'app0', 1026, '', '2015-03-06 12:34:08'),
(536, 'app0', 'app1', 1026, '', '2015-03-06 12:36:05'),
(537, 'app0', 'app1', 548, '', '2015-03-06 12:46:49'),
(538, 'app0', 'app1', 1139, '', '2015-03-06 12:46:57'),
(539, 'app0', 'app1', 109, '', '2015-03-06 12:47:03'),
(540, 'app0', 'app1', 963, '', '2015-03-06 12:47:07'),
(541, 'app1', 'app3', 963, '', '2015-03-06 14:12:14'),
(542, 'app1', 'app3', 917, '', '2015-03-06 14:13:41'),
(543, 'app1', 'app3', 1026, '', '2015-03-06 14:13:55'),
(544, 'app0', 'app1', 1056, '', '2015-03-06 14:24:32'),
(545, 'app1', 'app3', 1056, '', '2015-03-06 14:24:52'),
(546, 'app0', 'app1', 1123, '', '2015-03-06 15:19:55'),
(547, 'app0', 'app1', 1122, '', '2015-03-06 15:19:55'),
(548, 'app0', 'app1', 1145, '', '2015-03-06 15:19:55'),
(549, 'app1', 'app3', 1122, '', '2015-03-06 15:24:07'),
(550, 'app1', 'app3', 1123, '', '2015-03-06 15:24:07'),
(551, 'app1', 'app3', 1145, '', '2015-03-06 15:24:07'),
(552, 'app1', 'app3', 958, '', '2015-03-06 15:29:11'),
(553, 'app0', 'app1', 1146, '', '2015-03-06 15:47:07'),
(554, 'app1', 'app0', 1146, '', '2015-03-06 15:48:23'),
(555, 'app0', 'app1', 1146, '', '2015-03-06 15:49:35'),
(556, 'app1', 'app0', 853, '', '2015-03-06 15:56:58'),
(557, 'app3', 'app0', 852, '', '2015-03-06 15:57:19'),
(558, 'app1', 'app0', 957, '', '2015-03-06 17:28:10'),
(559, 'app0', 'app1', 957, '', '2015-03-06 17:30:40'),
(560, 'app0', 'app1', 1133, '', '2015-03-06 18:24:58'),
(561, 'app0', 'app1', 420, '', '2015-03-06 18:24:58'),
(562, 'app1', 'app3', 1133, '', '2015-03-06 18:25:23'),
(563, 'app0', 'app1', 1147, '', '2015-03-09 15:29:35'),
(564, 'app0', 'app1', 1011, '', '2015-03-09 15:40:52'),
(565, 'app0', 'app1', 1151, '', '2015-03-09 15:40:52'),
(566, 'app0', 'app1', 1155, '', '2015-03-09 15:40:52'),
(567, 'app1', 'app3', 1151, '', '2015-03-09 15:42:08'),
(568, 'app1', 'app3', 1155, '', '2015-03-09 15:42:08'),
(569, 'app1', 'app3', 1146, '', '2015-03-09 15:42:08'),
(570, 'app1', 'app3', 1147, '', '2015-03-09 15:42:08'),
(571, 'app0', 'app1', 1148, '', '2015-03-09 15:45:50'),
(572, 'app0', 'app1', 1152, '', '2015-03-09 15:45:50'),
(573, 'app1', 'app3', 1148, '', '2015-03-09 15:47:36'),
(574, 'app1', 'app3', 1152, '', '2015-03-09 15:47:36'),
(575, 'app0', 'app1', 1156, '', '2015-03-09 16:56:12'),
(576, 'app1', 'app3', 1156, '', '2015-03-09 16:56:50'),
(577, 'app0', 'app1', 855, '', '2015-03-10 09:00:32'),
(578, 'app0', 'app1', 1027, '', '2015-03-12 09:27:11'),
(579, 'app0', 'app1', 731, '', '2015-03-12 11:40:12'),
(580, 'app0', 'app1', 1075, '', '2015-03-12 11:41:55'),
(581, 'app1', 'app0', 1075, '', '2015-03-12 11:42:45'),
(582, 'app0', 'app1', 1075, '', '2015-03-12 11:43:51'),
(583, 'app0', 'app1', 1185, '', '2015-03-12 15:53:49'),
(584, 'app1', 'app3', 1185, '', '2015-03-12 15:55:31'),
(585, 'app1', 'app3', 731, '', '2015-03-12 15:55:41'),
(586, 'app0', 'app1', 1102, '', '2015-03-12 16:54:29'),
(587, 'app0', 'app1', 856, '', '2015-03-12 16:56:41'),
(588, 'app0', 'app1', 1194, '', '2015-03-12 17:21:41'),
(589, 'app0', 'app1', 1189, '', '2015-03-12 17:21:41'),
(590, 'app0', 'app1', 1193, '', '2015-03-12 17:23:01'),
(591, 'app0', 'app1', 1192, '', '2015-03-12 17:23:01'),
(592, 'app0', 'app1', 1191, '', '2015-03-12 17:23:01'),
(593, 'app1', 'app3', 1191, '', '2015-03-12 17:25:12'),
(594, 'app1', 'app3', 1192, '', '2015-03-12 17:25:12'),
(595, 'app1', 'app3', 1193, '', '2015-03-12 17:25:12'),
(596, 'app1', 'app3', 856, '', '2015-03-12 17:25:12'),
(597, 'app1', 'app3', 1189, '', '2015-03-12 17:25:12'),
(598, 'app1', 'app3', 1194, '', '2015-03-12 17:25:12'),
(599, 'app0', 'app1', 1112, '', '2015-03-12 17:29:05'),
(600, 'app0', 'app1', 1037, '', '2015-03-12 17:29:05'),
(601, 'app0', 'app1', 1032, '', '2015-03-12 17:29:05'),
(602, 'app0', 'app1', 982, '', '2015-03-12 17:29:05'),
(603, 'app0', 'app1', 1196, '', '2015-03-12 17:44:12'),
(604, 'app0', 'app1', 1160, '', '2015-03-12 17:44:25'),
(605, 'app0', 'app1', 1200, '', '2015-03-12 17:48:04'),
(606, 'app0', 'app1', 1042, '', '2015-03-13 07:30:08'),
(607, 'app0', 'app1', 1000, '', '2015-03-13 07:30:08'),
(608, 'app0', 'app1', 991, '', '2015-03-13 07:30:08'),
(609, 'app1', 'app0', 1000, '', '2015-03-13 07:31:03'),
(610, 'app0', 'app1', 1000, '', '2015-03-13 07:31:45'),
(611, 'app0', 'app1', 1202, '', '2015-03-13 09:00:10'),
(612, 'app0', 'app1', 1197, '', '2015-03-13 09:48:04'),
(613, 'app0', 'app1', 1199, '', '2015-03-13 09:48:09'),
(614, 'app0', 'app1', 1018, '', '2015-03-13 11:17:37'),
(615, 'app0', 'app1', 923, '', '2015-03-13 11:17:40'),
(616, 'app0', 'app1', 1107, '', '2015-03-13 11:17:43'),
(617, 'app1', 'app0', 1027, '', '2015-03-13 12:19:48'),
(618, 'app0', 'app1', 490, '', '2015-03-13 12:45:29'),
(619, 'app0', 'app1', 1134, '', '2015-03-13 12:45:29'),
(620, 'app0', 'app1', 421, '', '2015-03-13 12:45:29'),
(621, 'app0', 'app1', 1208, '', '2015-03-13 14:47:38'),
(622, 'app0', 'app1', 1157, '', '2015-03-13 14:47:38'),
(623, 'app1', 'app3', 1196, '', '2015-03-13 14:48:50'),
(624, 'app1', 'app3', 1157, '', '2015-03-13 14:48:57'),
(625, 'app1', 'app3', 855, '', '2015-03-13 14:49:06'),
(626, 'app0', 'app1', 1228, '', '2015-03-13 16:04:17'),
(627, 'app0', 'app1', 1227, '', '2015-03-13 16:04:19'),
(628, 'app0', 'app1', 1226, '', '2015-03-13 16:04:21'),
(629, 'app0', 'app1', 1225, '', '2015-03-13 16:04:23'),
(630, 'app0', 'app1', 1223, '', '2015-03-13 16:04:25'),
(631, 'app1', 'app0', 1228, '', '2015-03-13 16:17:55'),
(632, 'app1', 'app0', 1102, 'Vendredi à modifier.', '2015-03-13 16:19:16'),
(633, 'app0', 'app1', 1102, '', '2015-03-13 16:20:41'),
(634, 'app1', 'app3', 1000, '', '2015-03-13 16:22:09'),
(635, 'app1', 'app3', 991, '', '2015-03-13 16:22:09'),
(636, 'app1', 'app3', 1042, '', '2015-03-13 16:22:09'),
(637, 'app0', 'app1', 1228, '', '2015-03-13 16:22:14'),
(638, 'app1', 'app3', 1228, '', '2015-03-13 16:22:30'),
(639, 'app1', 'app3', 1227, '', '2015-03-13 16:22:32'),
(640, 'app1', 'app3', 1226, '', '2015-03-13 16:22:33'),
(641, 'app1', 'app3', 1225, '', '2015-03-13 16:22:35'),
(642, 'app1', 'app3', 1223, '', '2015-03-13 16:22:36'),
(643, 'app1', 'app3', 1102, '', '2015-03-13 16:22:50'),
(644, 'app0', 'app1', 1125, '', '2015-03-13 16:24:11'),
(645, 'app1', 'app3', 1032, '', '2015-03-13 16:27:16'),
(646, 'app1', 'app3', 982, '', '2015-03-13 16:27:20'),
(647, 'app1', 'app3', 1037, '', '2015-03-13 16:27:43'),
(648, 'app1', 'app3', 1112, '', '2015-03-13 16:27:58'),
(649, 'app1', 'app3', 1018, '', '2015-03-13 16:28:33'),
(650, 'app1', 'app3', 1107, '', '2015-03-13 16:28:48'),
(651, 'app1', 'app3', 923, '', '2015-03-13 16:29:10'),
(652, 'app0', 'app1', 1052, '', '2015-03-13 16:36:17'),
(655, 'app0', 'app1', 1230, '', '2015-03-13 17:13:51'),
(656, 'app1', 'app3', 1075, '', '2015-03-13 17:14:20'),
(657, 'app1', 'app3', 1230, '', '2015-03-13 17:14:28'),
(658, 'app1', 'app3', 109, '', '2015-03-16 07:41:58'),
(659, 'app1', 'app3', 1139, '', '2015-03-16 07:41:58'),
(660, 'app0', 'app1', 1142, '', '2015-03-16 07:45:17'),
(661, 'app0', 'app1', 1182, '', '2015-03-16 07:45:17'),
(662, 'app0', 'app1', 1173, '', '2015-03-16 07:45:17'),
(663, 'app0', 'app1', 1167, '', '2015-03-16 07:45:17'),
(664, 'app0', 'app1', 1186, '', '2015-03-16 07:45:17'),
(665, 'app0', 'app1', 901, '', '2015-03-16 07:45:17'),
(666, 'app0', 'app1', 57, '', '2015-03-16 07:45:17'),
(667, 'app0', 'app1', 1235, '', '2015-03-16 07:47:00'),
(668, 'app1', 'app3', 57, '', '2015-03-16 07:47:34'),
(669, 'app1', 'app3', 1142, '', '2015-03-16 07:47:34'),
(670, 'app1', 'app3', 1167, '', '2015-03-16 07:47:34'),
(671, 'app1', 'app3', 1173, '', '2015-03-16 07:47:34'),
(672, 'app1', 'app3', 1182, '', '2015-03-16 07:47:34'),
(673, 'app1', 'app3', 1186, '', '2015-03-16 07:47:34'),
(674, 'app1', 'app3', 1235, '', '2015-03-16 07:47:34'),
(675, 'app0', 'app1', 1129, '', '2015-03-18 14:25:51'),
(676, 'app0', 'app1', 1257, '', '2015-03-19 09:21:28'),
(677, 'app0', 'app1', 1130, '', '2015-03-19 09:21:31'),
(678, 'app0', 'app1', 1258, '', '2015-03-19 09:48:51'),
(679, 'app0', 'app1', 1206, '', '2015-03-19 10:13:12'),
(680, 'app0', 'app1', 1195, '', '2015-03-19 10:16:39'),
(681, 'app0', 'app1', 1190, '', '2015-03-19 10:16:39'),
(682, 'app0', 'app1', 1251, '', '2015-03-19 10:16:39'),
(683, 'app1', 'app0', 1190, '', '2015-03-19 10:22:13'),
(684, 'app1', 'app0', 1195, '', '2015-03-19 10:23:10'),
(685, 'app1', 'app0', 1251, '', '2015-03-19 10:25:59'),
(686, 'app0', 'app1', 1195, '', '2015-03-19 10:27:13'),
(687, 'app0', 'app1', 1190, '', '2015-03-19 10:27:13'),
(688, 'app0', 'app1', 1251, '', '2015-03-19 10:27:13'),
(689, 'app0', 'app1', 1076, '', '2015-03-19 10:30:56'),
(690, 'app1', 'app3', 1258, '', '2015-03-19 10:38:33'),
(691, 'app1', 'app3', 1257, '', '2015-03-19 10:38:49'),
(692, 'app1', 'app0', 1076, '', '2015-03-19 10:39:28'),
(693, 'app0', 'app1', 955, '', '2015-03-19 10:40:36'),
(694, 'app0', 'app1', 1076, '', '2015-03-19 10:40:40'),
(695, 'app1', 'app3', 955, '', '2015-03-19 10:44:29'),
(696, 'app1', 'app3', 1076, '', '2015-03-19 10:44:39'),
(697, 'app3', 'app0', 1076, '', '2015-03-19 10:44:58'),
(698, 'app3', 'app0', 955, '', '2015-03-19 10:45:25'),
(699, 'app0', 'app1', 1076, '', '2015-03-19 10:46:52'),
(700, 'app0', 'app1', 955, '', '2015-03-19 10:46:55'),
(701, 'app0', 'app1', 1150, '', '2015-03-19 10:58:19'),
(702, 'app0', 'app1', 1154, '', '2015-03-19 10:58:20'),
(703, 'app0', 'app1', 1222, '', '2015-03-19 11:54:46'),
(704, 'app0', 'app1', 1261, '', '2015-03-19 12:13:46'),
(705, 'app1', 'app3', 1150, '', '2015-03-19 12:16:21'),
(706, 'app1', 'app3', 1154, '', '2015-03-19 12:16:21'),
(707, 'app1', 'app3', 1190, '', '2015-03-19 12:16:21'),
(708, 'app1', 'app3', 1195, '', '2015-03-19 12:16:21'),
(709, 'app1', 'app3', 1261, '', '2015-03-19 12:16:21'),
(710, 'app0', 'app1', 1038, '', '2015-03-19 14:01:54'),
(711, 'app0', 'app1', 1033, '', '2015-03-19 14:01:54'),
(712, 'app0', 'app1', 983, '', '2015-03-19 14:01:54'),
(713, 'app0', 'app1', 1263, '', '2015-03-19 14:50:30'),
(714, 'app0', 'app1', 1264, '', '2015-03-19 14:50:30'),
(715, 'app0', 'app1', 1265, '', '2015-03-19 14:50:30'),
(716, 'app0', 'app1', 1240, '', '2015-03-19 15:04:26'),
(717, 'app0', 'app1', 1239, '', '2015-03-19 15:04:28'),
(718, 'app0', 'app1', 1241, 'Uniquement 7,2 heures par jour ?', '2015-03-19 15:04:50'),
(719, 'app0', 'app1', 1224, '', '2015-03-19 16:36:57'),
(720, 'app1', 'app3', 1224, '', '2015-03-19 16:38:11'),
(721, 'app0', 'app1', 1053, '', '2015-03-19 16:43:30'),
(722, 'app0', 'app1', 1232, '', '2015-03-19 16:43:30'),
(723, 'app0', 'app1', 1058, '', '2015-03-19 16:43:56'),
(724, 'app0', 'app1', 1043, '', '2015-03-19 16:50:35'),
(725, 'app0', 'app1', 1211, '', '2015-03-19 16:50:35'),
(726, 'app0', 'app1', 992, '', '2015-03-19 16:50:35'),
(727, 'app1', 'app3', 1053, '', '2015-03-19 16:51:10'),
(728, 'app1', 'app3', 1232, '', '2015-03-19 16:51:10'),
(729, 'app1', 'app3', 992, '', '2015-03-19 16:51:23'),
(730, 'app1', 'app3', 1211, '', '2015-03-19 16:51:23'),
(731, 'app1', 'app3', 1043, '', '2015-03-19 16:51:23'),
(732, 'app1', 'app3', 1058, '', '2015-03-19 16:51:23'),
(733, 'app1', 'app3', 1251, '', '2015-03-19 16:51:31'),
(734, 'app1', 'app3', 983, '', '2015-03-19 16:51:48'),
(735, 'app1', 'app3', 1033, '', '2015-03-19 16:51:48'),
(736, 'app1', 'app3', 1038, '', '2015-03-19 16:51:48'),
(737, 'app0', 'app1', 857, '', '2015-03-19 17:56:26'),
(738, 'app0', 'app1', 1266, '', '2015-03-19 17:56:43'),
(739, 'app0', 'app1', 1254, '', '2015-03-19 17:56:43'),
(740, 'app0', 'app1', 1103, '', '2015-03-19 17:58:50'),
(741, 'app1', 'app3', 1263, '', '2015-03-19 17:59:35'),
(742, 'app1', 'app3', 1264, '', '2015-03-19 17:59:35'),
(743, 'app1', 'app3', 1265, '', '2015-03-19 17:59:35'),
(744, 'app1', 'app3', 857, '', '2015-03-19 17:59:35'),
(745, 'app1', 'app3', 1266, '', '2015-03-19 17:59:35'),
(746, 'app1', 'app3', 1103, '', '2015-03-19 18:01:26'),
(747, 'app1', 'app3', 1254, '', '2015-03-19 18:01:26'),
(748, 'app0', 'app1', 924, '', '2015-03-19 18:10:33'),
(749, 'app1', 'app3', 924, '', '2015-03-19 21:52:51'),
(750, 'app0', 'app1', 1028, '', '2015-03-20 09:43:43'),
(751, 'app0', 'app1', 1445, '', '2015-03-20 10:55:08'),
(752, 'app0', 'app1', 1499, '', '2015-03-20 10:55:10'),
(753, 'app0', 'app1', 1244, '', '2015-03-20 10:55:18'),
(754, 'app0', 'app1', 1401, '', '2015-03-20 10:55:18'),
(755, 'app0', 'app1', 1444, '', '2015-03-20 10:55:34'),
(756, 'app0', 'app1', 1493, '', '2015-03-20 11:20:30'),
(759, 'app0', 'app1', 1490, '', '2015-03-20 11:20:35'),
(760, 'app0', 'app1', 1489, '', '2015-03-20 11:20:37'),
(761, 'app1', 'app3', 1493, '', '2015-03-20 11:21:19'),
(764, 'app1', 'app3', 1490, '', '2015-03-20 11:21:24'),
(765, 'app1', 'app3', 1489, '', '2015-03-20 11:21:25'),
(766, 'app0', 'app1', 1488, '', '2015-03-20 11:26:03'),
(767, 'app0', 'app1', 1487, '', '2015-03-20 11:26:05'),
(768, 'app1', 'app3', 1488, '', '2015-03-20 11:26:46'),
(769, 'app1', 'app3', 1487, '', '2015-03-20 11:26:48'),
(770, 'app1', 'app0', 955, '', '2015-03-20 15:39:05'),
(771, 'app1', 'app0', 1076, '', '2015-03-20 15:39:12'),
(772, 'app0', 'app1', 1076, '', '2015-03-20 15:40:12'),
(773, 'app0', 'app1', 955, '', '2015-03-20 15:40:36'),
(774, 'app1', 'app3', 955, '', '2015-03-20 15:41:24'),
(775, 'app1', 'app3', 1076, '', '2015-03-20 15:41:31'),
(776, 'app0', 'app1', 1238, '', '2015-03-23 07:41:43'),
(777, 'app0', 'app1', 1236, '', '2015-03-23 07:41:43'),
(778, 'app0', 'app1', 1187, '', '2015-03-23 07:41:43'),
(779, 'app0', 'app1', 1259, '', '2015-03-23 07:41:43'),
(780, 'app0', 'app1', 58, '', '2015-03-23 07:41:43'),
(781, 'app1', 'app3', 58, '', '2015-03-23 07:42:25'),
(782, 'app1', 'app3', 1187, '', '2015-03-23 07:42:25'),
(783, 'app1', 'app3', 1236, '', '2015-03-23 07:42:25'),
(784, 'app1', 'app3', 1238, '', '2015-03-23 07:42:26'),
(785, 'app1', 'app3', 1259, '', '2015-03-23 07:42:26'),
(786, 'app1', 'app3', 1206, '', '2015-03-23 07:42:26'),
(787, 'app0', 'app1', 1358, '', '2015-03-23 07:55:44'),
(788, 'app0', 'app1', 1507, '', '2015-03-23 09:48:34'),
(789, 'app0', 'app1', 1506, '', '2015-03-23 09:48:40'),
(790, 'app0', 'app1', 1248, '', '2015-03-23 11:34:14'),
(791, 'app0', 'app1', 614, '', '2015-03-23 11:34:14'),
(792, 'app0', 'app1', 1510, '', '2015-03-23 11:34:14'),
(793, 'app1', 'app3', 1510, '', '2015-03-23 11:35:23'),
(794, 'app0', 'app1', 367, '', '2015-03-26 09:50:24'),
(795, 'app0', 'app1', 1576, '', '2015-03-26 16:23:20'),
(796, 'app0', 'app1', 1577, '', '2015-03-26 16:23:56'),
(797, 'app0', 'app1', 1207, '', '2015-03-26 16:29:52'),
(798, 'app1', 'app0', 1207, '', '2015-03-26 16:36:22'),
(799, 'app0', 'app1', 1077, '', '2015-03-26 16:39:59'),
(800, 'app0', 'app1', 956, '', '2015-03-26 16:40:32'),
(801, 'app0', 'app1', 1207, '', '2015-03-26 17:06:42'),
(802, 'app1', 'app3', 956, '', '2015-03-26 17:07:39'),
(803, 'app1', 'app3', 1077, '', '2015-03-26 17:08:23'),
(804, 'app3', 'app0', 956, '', '2015-03-26 17:09:01'),
(805, 'app3', 'app0', 1077, '', '2015-03-26 17:09:44'),
(806, 'app0', 'app1', 1077, '', '2015-03-26 17:11:21'),
(807, 'app0', 'app1', 956, '', '2015-03-26 17:11:25'),
(808, 'app1', 'app3', 1077, '', '2015-03-26 17:12:21'),
(809, 'app1', 'app3', 956, '', '2015-03-26 17:12:31'),
(810, 'app0', 'app1', 1039, '', '2015-03-26 17:34:06'),
(811, 'app0', 'app1', 1546, '', '2015-03-26 18:07:24'),
(812, 'app0', 'app1', 858, '', '2015-03-26 18:07:30'),
(813, 'app0', 'app1', 1505, '', '2015-03-26 22:35:01'),
(814, 'app0', 'app1', 1574, '', '2015-03-26 22:35:22'),
(815, 'app0', 'app1', 1044, '', '2015-03-26 22:37:46'),
(816, 'app1', 'app3', 1044, '', '2015-03-26 22:39:03'),
(817, 'app1', 'app3', 1039, '', '2015-03-26 22:39:13'),
(818, 'app3', 'app0', 1044, '', '2015-03-26 22:48:19'),
(819, 'app0', 'app1', 1044, '', '2015-03-26 22:48:57'),
(820, 'app1', 'app3', 1044, '', '2015-03-26 22:49:51'),
(821, 'app0', 'app1', 1054, '', '2015-03-26 23:11:33'),
(822, 'app0', 'app1', 1059, '', '2015-03-26 23:12:25'),
(823, 'app1', 'app3', 1059, '', '2015-03-26 23:13:16'),
(824, 'app1', 'app3', 1054, '', '2015-03-26 23:13:16'),
(825, 'app0', 'app1', 1245, '', '2015-03-27 08:06:35'),
(826, 'app0', 'app1', 1243, '', '2015-03-27 08:06:35'),
(827, 'app0', 'app1', 1575, '', '2015-03-27 08:06:35'),
(828, 'app0', 'app1', 1262, '', '2015-03-27 08:30:41'),
(829, 'app3', 'app0', 1077, '', '2015-03-27 08:51:43'),
(830, 'app0', 'app1', 1077, '', '2015-03-27 08:52:17'),
(831, 'app1', 'app3', 1077, '', '2015-03-27 08:52:38'),
(832, 'app0', 'app1', 1594, '', '2015-03-27 08:55:21'),
(833, 'app1', 'app3', 1594, '', '2015-03-27 09:06:47'),
(834, 'app0', 'app1', 1109, '', '2015-03-27 11:03:40'),
(835, 'app0', 'app1', 1104, '', '2015-03-27 11:46:36'),
(836, 'app1', 'app3', 1104, '', '2015-03-27 11:58:25'),
(837, 'app1', 'app3', 1109, '', '2015-03-27 12:00:01'),
(838, 'app1', 'app3', 367, '', '2015-03-27 12:09:47'),
(839, 'app1', 'app3', 421, '', '2015-03-27 12:10:11'),
(840, 'app1', 'app3', 490, '', '2015-03-27 12:10:11'),
(841, 'app1', 'app3', 548, '', '2015-03-27 12:10:26'),
(842, 'app1', 'app3', 420, '', '2015-03-27 12:10:26'),
(843, 'app1', 'app3', 419, '', '2015-03-27 12:10:35'),
(844, 'app1', 'app3', 488, '', '2015-03-27 12:10:35'),
(845, 'app0', 'app1', 255, '', '2015-03-27 12:11:50'),
(846, 'app0', 'app1', 1582, '', '2015-03-27 12:12:49'),
(847, 'app0', 'app1', 253, '', '2015-03-27 12:14:20'),
(848, 'app1', 'app3', 255, '', '2015-03-27 12:16:14'),
(849, 'app1', 'app3', 253, '', '2015-03-27 12:16:35'),
(850, 'app3', 'app0', 255, '', '2015-03-27 12:17:35'),
(851, 'app1', 'app3', 1582, '', '2015-03-27 13:20:06'),
(852, 'app1', 'app3', 1505, '', '2015-03-27 13:20:06'),
(853, 'app1', 'app3', 1574, '', '2015-03-27 13:20:06'),
(854, 'app1', 'app3', 1207, '', '2015-03-27 13:20:06'),
(855, 'app0', 'app1', 1175, '', '2015-03-27 13:21:56'),
(856, 'app0', 'app1', 1188, '', '2015-03-27 13:21:56'),
(857, 'app0', 'app1', 1260, '', '2015-03-27 13:21:56'),
(858, 'app0', 'app1', 59, '', '2015-03-27 13:21:56'),
(859, 'app1', 'app3', 59, '', '2015-03-27 13:22:53'),
(860, 'app1', 'app3', 1260, '', '2015-03-27 13:22:53'),
(861, 'app1', 'app3', 1175, '', '2015-03-27 13:22:53'),
(862, 'app1', 'app3', 1188, '', '2015-03-27 13:22:53'),
(863, 'app0', 'app1', 1204, '', '2015-03-27 13:51:09'),
(864, 'app1', 'app0', 1245, 'TOP à saisir', '2015-03-27 14:21:30'),
(865, 'app0', 'app1', 551, '', '2015-03-27 14:46:34'),
(866, 'app0', 'app1', 1181, '', '2015-03-27 14:46:36'),
(867, 'app0', 'app1', 1178, '', '2015-03-27 14:46:38'),
(868, 'app0', 'app1', 1172, '', '2015-03-27 14:46:42'),
(869, 'app0', 'app1', 112, '', '2015-03-27 14:46:48'),
(870, 'app0', 'app1', 966, '', '2015-03-27 14:46:48'),
(871, 'app0', 'app1', 550, '', '2015-03-27 14:47:04'),
(872, 'app0', 'app1', 1237, '', '2015-03-27 14:47:04'),
(873, 'app0', 'app1', 1180, '', '2015-03-27 14:47:04'),
(874, 'app0', 'app1', 1177, '', '2015-03-27 14:47:04'),
(875, 'app0', 'app1', 1171, '', '2015-03-27 14:47:04'),
(876, 'app0', 'app1', 111, '', '2015-03-27 14:47:04'),
(877, 'app0', 'app1', 965, '', '2015-03-27 14:47:04'),
(878, 'app0', 'app1', 549, '', '2015-03-27 14:47:20'),
(879, 'app0', 'app1', 1140, '', '2015-03-27 14:47:20'),
(880, 'app0', 'app1', 1179, '', '2015-03-27 14:47:20'),
(881, 'app0', 'app1', 1176, '', '2015-03-27 14:47:20'),
(882, 'app0', 'app1', 1170, '', '2015-03-27 14:47:20'),
(883, 'app0', 'app1', 110, '', '2015-03-27 14:47:20'),
(884, 'app0', 'app1', 964, '', '2015-03-27 14:47:20'),
(885, 'app0', 'app1', 1512, '', '2015-03-27 14:59:05'),
(886, 'app0', 'app1', 1606, '', '2015-03-27 14:59:05'),
(887, 'app0', 'app1', 1511, '', '2015-03-27 14:59:05'),
(888, 'app1', 'app3', 858, '', '2015-03-27 15:15:57'),
(889, 'app1', 'app3', 1262, '', '2015-03-27 15:16:08'),
(890, 'app1', 'app3', 1511, '', '2015-03-27 15:16:12'),
(891, 'app1', 'app3', 1606, '', '2015-03-27 15:16:15'),
(892, 'app0', 'app1', 1572, '', '2015-03-27 15:19:53'),
(893, 'app0', 'app1', 1119, '', '2015-03-27 15:19:53'),
(894, 'app0', 'app1', 1597, '', '2015-03-27 15:19:53'),
(895, 'app0', 'app1', 1598, '', '2015-03-27 15:19:53'),
(896, 'app0', 'app1', 1596, '', '2015-03-27 15:21:38'),
(897, 'app0', 'app1', 1599, '', '2015-03-27 15:21:38'),
(898, 'app0', 'app1', 1573, '', '2015-03-27 15:22:57'),
(899, 'app0', 'app1', 1607, '', '2015-03-27 15:22:57'),
(900, 'app0', 'app1', 1608, '', '2015-03-27 15:22:57'),
(901, 'app1', 'app3', 1607, '', '2015-03-27 15:24:53'),
(902, 'app1', 'app3', 1608, '', '2015-03-27 15:24:53'),
(903, 'app1', 'app3', 1596, '', '2015-03-27 15:24:53'),
(904, 'app1', 'app3', 1599, '', '2015-03-27 15:24:53'),
(905, 'app1', 'app3', 1597, '', '2015-03-27 15:24:53'),
(906, 'app1', 'app3', 1598, '', '2015-03-27 15:24:53'),
(907, 'app1', 'app0', 1575, '', '2015-03-27 15:28:57'),
(908, 'app0', 'app1', 1245, '', '2015-03-27 15:29:51'),
(909, 'app0', 'app1', 1575, '', '2015-03-27 15:29:52'),
(910, 'app0', 'app1', 1583, '', '2015-03-27 15:36:57'),
(911, 'app1', 'app0', 1573, '', '2015-03-30 11:16:29'),
(912, 'app1', 'app0', 1572, '', '2015-03-30 11:16:39'),
(913, 'app0', 'app1', 1572, '', '2015-03-30 14:18:57'),
(914, 'app1', 'app3', 1138, '', '2015-03-30 14:41:34'),
(915, 'app1', 'app3', 1011, '', '2015-03-30 14:41:52'),
(916, 'app1', 'app3', 950, '', '2015-03-30 14:44:17'),
(917, 'app1', 'app3', 614, '', '2015-03-30 14:48:06'),
(918, 'app1', 'app0', 973, '', '2015-03-30 14:57:04'),
(919, 'app0', 'app1', 973, '', '2015-03-30 14:58:31'),
(920, 'app0', 'app1', 1359, '', '2015-03-30 15:01:01'),
(921, 'app1', 'app3', 1572, '', '2015-03-30 15:01:35'),
(922, 'app1', 'app3', 973, '', '2015-03-30 15:14:50'),
(923, 'app3', 'app0', 956, '', '2015-03-30 15:31:37'),
(924, 'app3', 'app0', 955, '', '2015-03-30 15:31:53'),
(925, 'app3', 'app0', 1077, '', '2015-03-30 15:33:24'),
(926, 'app3', 'app0', 1076, '', '2015-03-30 15:33:58'),
(927, 'app0', 'app1', 1077, '', '2015-03-30 15:34:36'),
(928, 'app0', 'app1', 1076, '', '2015-03-30 15:38:53'),
(929, 'app1', 'app3', 1076, '', '2015-03-30 15:39:40'),
(930, 'app3', 'app0', 1011, '', '2015-03-30 15:47:44'),
(931, 'app3', 'app0', 1257, '', '2015-03-30 15:52:12'),
(932, 'app0', 'app1', 1257, '', '2015-03-30 15:59:34'),
(933, 'app1', 'app3', 1257, '', '2015-03-30 16:04:47'),
(934, 'app1', 'app3', 1077, '', '2015-03-30 16:04:58'),
(935, 'app0', 'app1', 1253, '', '2015-03-30 18:02:16'),
(936, 'app0', 'app1', 1513, '', '2015-03-30 18:21:15'),
(937, 'app0', 'app1', 1256, '', '2015-03-30 18:21:27'),
(938, 'app1', 'app0', 1253, '', '2015-03-30 18:22:42'),
(939, 'app0', 'app1', 1619, '', '2015-03-30 18:25:13'),
(940, 'app0', 'app1', 1618, '', '2015-03-30 18:25:13'),
(941, 'app0', 'app1', 1253, '', '2015-03-30 18:25:13'),
(942, 'app1', 'app3', 1028, '', '2015-03-30 22:30:19'),
(943, 'app1', 'app3', 964, '', '2015-03-30 22:31:24'),
(944, 'app1', 'app3', 1052, '', '2015-03-30 22:31:24'),
(945, 'app1', 'app3', 965, '', '2015-03-30 22:32:08'),
(946, 'app1', 'app3', 966, '', '2015-03-30 22:32:34'),
(947, 'app1', 'app3', 1253, '', '2015-03-30 22:33:48'),
(948, 'app1', 'app3', 1256, '', '2015-03-30 22:33:49'),
(949, 'app0', 'app1', 1045, '', '2015-03-30 22:34:51'),
(950, 'app1', 'app3', 1045, '', '2015-03-30 22:35:22'),
(951, 'app0', 'app1', 1055, '', '2015-03-30 23:03:18'),
(952, 'app1', 'app3', 1055, '', '2015-03-30 23:04:08'),
(953, 'app0', 'app1', 1040, '', '2015-03-30 23:10:25'),
(954, 'app0', 'app1', 1035, '', '2015-03-30 23:10:26'),
(955, 'app1', 'app3', 1035, '', '2015-03-30 23:11:12'),
(956, 'app1', 'app3', 1040, '', '2015-03-30 23:11:12'),
(957, 'app1', 'app3', 112, '', '2015-03-31 07:26:50'),
(958, 'app1', 'app3', 1181, '', '2015-03-31 07:26:50'),
(959, 'app1', 'app3', 1178, '', '2015-03-31 07:26:50'),
(960, 'app1', 'app3', 1172, '', '2015-03-31 07:26:50'),
(961, 'app1', 'app3', 1583, '', '2015-03-31 07:26:50'),
(962, 'app1', 'app3', 111, '', '2015-03-31 07:27:05');
INSERT INTO `timesheetcomment` (`idTemesheetComment`, `previousStatus`, `actualStatus`, `idTimeSheet`, `contentComment`, `commentDate`) VALUES
(963, 'app1', 'app3', 1237, '', '2015-03-31 07:27:05'),
(964, 'app1', 'app3', 1180, '', '2015-03-31 07:27:05'),
(965, 'app1', 'app3', 1177, '', '2015-03-31 07:27:05'),
(966, 'app1', 'app3', 1171, '', '2015-03-31 07:27:05'),
(967, 'app1', 'app3', 110, '', '2015-03-31 07:27:19'),
(968, 'app1', 'app3', 1140, '', '2015-03-31 07:27:19'),
(969, 'app1', 'app3', 1179, '', '2015-03-31 07:27:19'),
(970, 'app1', 'app3', 1176, '', '2015-03-31 07:27:19'),
(971, 'app1', 'app3', 1170, '', '2015-03-31 07:27:19'),
(972, 'app0', 'app1', 1030, '', '2015-03-31 09:44:24'),
(973, 'app0', 'app1', 1165, '', '2015-03-31 10:25:56'),
(974, 'app0', 'app1', 1105, '', '2015-03-31 10:27:28'),
(975, 'app1', 'app3', 1165, '', '2015-03-31 10:28:16'),
(976, 'app1', 'app3', 1030, '', '2015-03-31 10:28:16'),
(977, 'app1', 'app3', 1105, '', '2015-03-31 10:28:16'),
(978, 'app1', 'app3', 551, '', '2015-03-31 14:50:36'),
(979, 'app1', 'app3', 550, '', '2015-03-31 14:50:46'),
(980, 'app1', 'app3', 549, '', '2015-03-31 14:50:54'),
(981, 'app0', 'app1', 256, '', '2015-03-31 14:52:14'),
(982, 'app1', 'app3', 256, '', '2015-03-31 14:52:33'),
(983, 'app3', 'app0', 1106, '', '2015-04-01 16:55:43'),
(984, 'app3', 'app0', 922, '', '2015-04-01 16:55:56'),
(985, 'app0', 'app1', 1106, '', '2015-04-01 16:56:23'),
(986, 'app0', 'app1', 1161, '', '2015-04-01 16:56:23'),
(987, 'app0', 'app1', 922, '', '2015-04-01 16:56:23'),
(988, 'app1', 'app0', 1161, '', '2015-04-01 16:57:19'),
(989, 'app0', 'app1', 1161, '', '2015-04-01 16:57:31'),
(990, 'app1', 'app0', 1106, '', '2015-04-01 16:58:28'),
(991, 'app0', 'app1', 1106, '', '2015-04-01 16:58:48'),
(992, 'app1', 'app3', 922, '', '2015-04-01 16:59:10'),
(993, 'app1', 'app3', 1161, '', '2015-04-01 16:59:10'),
(994, 'app1', 'app0', 1106, '', '2015-04-01 16:59:41'),
(995, 'app0', 'app1', 1106, '', '2015-04-01 17:00:39'),
(996, 'app1', 'app0', 1106, '', '2015-04-01 17:02:19'),
(997, 'app0', 'app1', 1106, '', '2015-04-01 17:05:49'),
(998, 'app1', 'app0', 1106, '', '2015-04-01 17:06:22'),
(999, 'app3', 'app0', 1161, '', '2015-04-01 17:06:40'),
(1000, 'app0', 'app1', 1106, '', '2015-04-01 17:14:30'),
(1001, 'app0', 'app1', 1161, '', '2015-04-01 17:14:30'),
(1002, 'app1', 'app3', 1106, '', '2015-04-01 17:15:03'),
(1003, 'app1', 'app3', 1161, '', '2015-04-01 17:15:03'),
(1004, 'app3', 'app0', 1042, '', '2015-04-01 22:14:57'),
(1005, 'app0', 'app1', 1042, '', '2015-04-01 22:15:51'),
(1006, 'app1', 'app3', 1042, '', '2015-04-01 22:16:35'),
(1007, 'app0', 'app1', 1643, '', '2015-04-02 11:30:00'),
(1008, 'app0', 'app1', 1626, '', '2015-04-02 11:32:42'),
(1009, 'app0', 'app1', 1601, '', '2015-04-02 11:32:50'),
(1010, 'app0', 'app1', 1603, '', '2015-04-02 11:32:51'),
(1011, 'app0', 'app1', 1357, '', '2015-04-02 11:32:58'),
(1012, 'app0', 'app1', 1495, '', '2015-04-02 11:33:00'),
(1013, 'app0', 'app1', 1494, '', '2015-04-02 11:33:02'),
(1014, 'app0', 'app1', 1500, '', '2015-04-02 11:33:04'),
(1015, 'app0', 'app1', 1356, '', '2015-04-02 11:33:09'),
(1016, 'app0', 'app1', 1355, '', '2015-04-02 11:33:13'),
(1017, 'app0', 'app1', 423, '', '2015-04-02 11:54:12'),
(1018, 'app0', 'app1', 1589, '', '2015-04-02 11:54:12'),
(1019, 'app0', 'app1', 1591, '', '2015-04-02 11:54:12'),
(1020, 'app0', 'app1', 1568, '', '2015-04-02 11:54:12'),
(1021, 'app0', 'app1', 422, '', '2015-04-02 11:54:27'),
(1022, 'app1', 'app3', 1589, '', '2015-04-02 11:55:38'),
(1023, 'app1', 'app3', 1591, '', '2015-04-02 11:55:38'),
(1024, 'app1', 'app3', 1134, '', '2015-04-02 11:55:53'),
(1025, 'app1', 'app3', 1125, '', '2015-04-02 11:55:57'),
(1026, 'app0', 'app1', 1610, '', '2015-04-02 14:13:57'),
(1027, 'app0', 'app1', 1628, '', '2015-04-02 15:24:59'),
(1028, 'app0', 'app1', 1556, '', '2015-04-02 15:27:18'),
(1029, 'app0', 'app1', 1078, '', '2015-04-02 15:27:33'),
(1030, 'app1', 'app3', 1078, '', '2015-04-02 15:28:23'),
(1031, 'app0', 'app1', 1648, '', '2015-04-02 15:35:24'),
(1032, 'app0', 'app1', 1656, '', '2015-04-02 15:35:24'),
(1033, 'app0', 'app1', 1617, '', '2015-04-02 15:45:12'),
(1034, 'app1', 'app3', 1643, '', '2015-04-02 17:11:02'),
(1035, 'app1', 'app3', 1628, '', '2015-04-02 17:11:23'),
(1036, 'app0', 'app1', 1661, '', '2015-04-02 17:11:44'),
(1037, 'app1', 'app3', 1661, '', '2015-04-02 17:12:40'),
(1038, 'app3', 'app0', 1165, '', '2015-04-02 17:15:26'),
(1039, 'app1', 'app0', 1656, '', '2015-04-02 17:15:26'),
(1040, 'app1', 'app0', 1648, '', '2015-04-02 17:15:31'),
(1041, 'app0', 'app1', 1648, '', '2015-04-02 17:18:22'),
(1042, 'app0', 'app1', 1165, '', '2015-04-02 17:18:22'),
(1043, 'app0', 'app1', 1656, '', '2015-04-02 17:18:22'),
(1044, 'app1', 'app3', 1165, '', '2015-04-02 17:20:01'),
(1045, 'app1', 'app3', 1656, '', '2015-04-02 17:20:01'),
(1046, 'app1', 'app3', 1648, '', '2015-04-02 17:20:01'),
(1047, 'app1', 'app3', 423, '', '2015-04-02 17:52:02'),
(1048, 'app1', 'app3', 422, '', '2015-04-02 17:52:16'),
(1049, 'app0', 'app1', 1624, '', '2015-04-03 06:57:41'),
(1050, 'app0', 'app1', 1595, '', '2015-04-03 06:57:41'),
(1051, 'app0', 'app1', 60, '', '2015-04-03 06:57:41'),
(1052, 'app1', 'app3', 60, '', '2015-04-03 07:27:31'),
(1053, 'app1', 'app3', 1624, '', '2015-04-03 07:27:32'),
(1054, 'app1', 'app3', 1595, '', '2015-04-03 07:27:32'),
(1055, 'app0', 'app1', 1600, '', '2015-04-03 09:03:56'),
(1056, 'app0', 'app1', 1609, '', '2015-04-03 14:11:12'),
(1057, 'app0', 'app1', 1690, '', '2015-04-03 14:11:41'),
(1058, 'app0', 'app1', 1688, '', '2015-04-03 14:11:41'),
(1059, 'app0', 'app1', 1691, '', '2015-04-03 14:11:41'),
(1060, 'app0', 'app1', 1689, '', '2015-04-03 14:11:41'),
(1061, 'app0', 'app1', 859, '', '2015-04-03 14:11:42'),
(1062, 'app0', 'app1', 1314, 'ATRef INC000003444495', '2015-04-03 14:46:04'),
(1063, 'app0', 'app1', 1315, 'ATRef INC000003444495', '2015-04-03 14:46:58'),
(1064, 'app0', 'app1', 1638, '', '2015-04-03 15:52:31'),
(1065, 'app3', 'app0', 1030, '', '2015-04-03 15:53:35'),
(1066, 'app1', 'app3', 1638, '', '2015-04-03 15:57:10'),
(1067, 'app3', 'app0', 1638, '', '2015-04-03 15:58:30'),
(1068, 'app0', 'app1', 1638, '', '2015-04-03 15:59:19'),
(1069, 'app0', 'app1', 1030, '', '2015-04-03 15:59:19'),
(1070, 'app1', 'app3', 1030, '', '2015-04-03 15:59:54'),
(1071, 'app1', 'app3', 1638, '', '2015-04-03 15:59:54'),
(1072, 'app0', 'app1', 1653, '', '2015-04-03 16:37:30'),
(1073, 'app1', 'app3', 1653, '', '2015-04-03 16:37:58'),
(1074, 'app1', 'app3', 859, '', '2015-04-07 15:00:59'),
(1075, 'app1', 'app3', 1618, '', '2015-04-07 15:00:59'),
(1076, 'app1', 'app3', 1619, '', '2015-04-07 15:00:59'),
(1077, 'app1', 'app3', 1617, '', '2015-04-07 15:00:59'),
(1078, 'app1', 'app3', 1576, '', '2015-04-08 16:52:46'),
(1079, 'app1', 'app3', 1600, '', '2015-04-08 16:53:18'),
(1080, 'app1', 'app3', 1577, '', '2015-04-08 16:53:47'),
(1081, 'app0', 'app1', 1720, '', '2015-04-08 16:54:59'),
(1082, 'app0', 'app1', 1718, '', '2015-04-08 16:56:15'),
(1083, 'app1', 'app3', 1720, '', '2015-04-08 17:28:32'),
(1084, 'app1', 'app3', 1718, '', '2015-04-08 17:28:47'),
(1085, 'app0', 'app1', 1629, '', '2015-04-09 08:53:44'),
(1086, 'app0', 'app1', 1719, '', '2015-04-09 10:14:10'),
(1087, 'app0', 'app1', 1712, '', '2015-04-09 10:14:43'),
(1088, 'app0', 'app1', 553, '', '2015-04-09 10:31:27'),
(1089, 'app0', 'app1', 1622, '', '2015-04-09 10:31:30'),
(1090, 'app0', 'app1', 114, '', '2015-04-09 10:31:34'),
(1091, 'app0', 'app1', 552, '', '2015-04-09 10:31:46'),
(1092, 'app0', 'app1', 1621, '', '2015-04-09 10:31:50'),
(1093, 'app0', 'app1', 113, '', '2015-04-09 10:31:52'),
(1094, 'app0', 'app1', 967, '', '2015-04-09 10:31:54'),
(1095, 'app0', 'app1', 1620, '', '2015-04-09 10:32:14'),
(1096, 'app0', 'app1', 1360, '', '2015-04-09 10:53:43'),
(1097, 'app0', 'app1', 1705, '', '2015-04-09 10:53:45'),
(1098, 'app0', 'app1', 1752, '', '2015-04-09 10:53:47'),
(1099, 'app1', 'app3', 1719, '', '2015-04-09 10:57:11'),
(1100, 'app1', 'app3', 1712, '', '2015-04-09 10:57:22'),
(1101, 'app0', 'app1', 1731, '', '2015-04-09 11:52:46'),
(1102, 'app0', 'app1', 1662, '', '2015-04-09 12:13:02'),
(1103, 'app0', 'app1', 1806, '', '2015-04-09 12:13:06'),
(1104, 'app1', 'app3', 1731, '', '2015-04-09 13:59:44'),
(1105, 'app1', 'app0', 1662, '', '2015-04-09 14:00:05'),
(1106, 'app1', 'app0', 1806, '', '2015-04-09 14:00:18'),
(1107, 'app0', 'app1', 1806, '', '2015-04-09 14:00:44'),
(1108, 'app0', 'app1', 1662, '', '2015-04-09 14:00:50'),
(1109, 'app1', 'app3', 1662, '', '2015-04-09 14:04:20'),
(1110, 'app1', 'app3', 1806, '', '2015-04-09 14:04:25'),
(1111, 'app0', 'app1', 1730, '', '2015-04-09 14:35:01'),
(1112, 'app0', 'app1', 1555, '', '2015-04-09 14:35:05'),
(1113, 'app0', 'app1', 1316, '', '2015-04-09 14:35:31'),
(1114, 'app0', 'app1', 1671, '', '2015-04-09 15:46:45'),
(1115, 'app0', 'app1', 1814, '', '2015-04-09 15:46:45'),
(1116, 'app0', 'app1', 1654, '', '2015-04-09 15:46:45'),
(1117, 'app0', 'app1', 1828, '', '2015-04-09 15:46:45'),
(1118, 'app1', 'app3', 1730, '', '2015-04-09 16:49:40'),
(1119, 'app1', 'app3', 1671, '', '2015-04-09 16:49:51'),
(1120, 'app1', 'app3', 1814, '', '2015-04-09 16:49:56'),
(1121, 'app0', 'app1', 1830, '', '2015-04-09 17:06:57'),
(1122, 'app0', 'app1', 1829, '', '2015-04-09 17:08:36'),
(1123, 'app0', 'app1', 1634, '', '2015-04-09 17:10:56'),
(1124, 'app0', 'app1', 1713, '', '2015-04-09 17:11:30'),
(1125, 'app0', 'app1', 1448, '', '2015-04-09 17:12:05'),
(1126, 'app0', 'app1', 1739, '', '2015-04-09 17:12:06'),
(1127, 'app1', 'app3', 1634, '', '2015-04-09 18:03:08'),
(1128, 'app1', 'app3', 1629, '', '2015-04-09 18:03:20'),
(1129, 'app1', 'app3', 1654, '', '2015-04-09 18:03:30'),
(1130, 'app1', 'app3', 1828, '', '2015-04-09 18:03:30'),
(1131, 'app1', 'app3', 1620, '', '2015-04-10 06:57:04'),
(1132, 'app1', 'app3', 113, '', '2015-04-10 06:57:16'),
(1133, 'app1', 'app3', 1621, '', '2015-04-10 06:57:16'),
(1134, 'app1', 'app3', 1830, '', '2015-04-10 06:57:16'),
(1135, 'app1', 'app3', 114, '', '2015-04-10 06:57:31'),
(1136, 'app1', 'app3', 1622, '', '2015-04-10 06:57:31'),
(1137, 'app1', 'app3', 1829, '', '2015-04-10 06:57:31'),
(1138, 'app0', 'app1', 1625, '', '2015-04-10 06:58:17'),
(1139, 'app0', 'app1', 1738, '', '2015-04-10 06:58:17'),
(1140, 'app0', 'app1', 900, '', '2015-04-10 06:58:17'),
(1141, 'app0', 'app1', 61, '', '2015-04-10 06:58:17'),
(1142, 'app1', 'app3', 61, '', '2015-04-10 06:58:41'),
(1143, 'app1', 'app3', 1625, '', '2015-04-10 06:58:41'),
(1144, 'app1', 'app3', 1738, '', '2015-04-10 06:58:41'),
(1145, 'app0', 'app1', 1615, '', '2015-04-10 09:43:15'),
(1146, 'app0', 'app1', 860, '', '2015-04-10 09:43:23'),
(1147, 'app0', 'app1', 1833, '', '2015-04-10 09:43:25'),
(1148, 'app0', 'app1', 1539, '', '2015-04-10 11:10:12'),
(1149, 'app0', 'app1', 1860, '', '2015-04-10 11:10:12'),
(1150, 'app1', 'app3', 1860, '', '2015-04-10 11:10:45'),
(1151, 'app1', 'app3', 860, '', '2015-04-10 11:10:45'),
(1152, 'app0', 'app1', 1852, '', '2015-04-10 11:39:32'),
(1153, 'app0', 'app1', 1850, '', '2015-04-10 11:39:32'),
(1154, 'app0', 'app1', 1711, '', '2015-04-10 12:00:49'),
(1155, 'app0', 'app1', 1706, '', '2015-04-10 12:00:49'),
(1156, 'app0', 'app1', 1403, '', '2015-04-10 12:00:49'),
(1157, 'app0', 'app1', 1842, '', '2015-04-10 13:36:05'),
(1158, 'app0', 'app1', 1834, '', '2015-04-10 13:36:05'),
(1159, 'app1', 'app3', 1834, '', '2015-04-10 15:02:25'),
(1160, 'app1', 'app3', 1842, '', '2015-04-10 15:02:25'),
(1161, 'app1', 'app3', 1850, '', '2015-04-10 15:02:25'),
(1162, 'app1', 'app3', 1852, '', '2015-04-10 15:02:25'),
(1163, 'app0', 'app1', 1981, '', '2015-04-10 16:41:28'),
(1164, 'app0', 'app1', 1961, '', '2015-04-10 16:41:56'),
(1165, 'app1', 'app3', 1981, '', '2015-04-10 16:43:37'),
(1166, 'app1', 'app3', 1961, '', '2015-04-10 16:43:37'),
(1167, 'app0', 'app1', 1361, '', '2015-04-14 14:20:19'),
(1168, 'app0', 'app1', 1753, '', '2015-04-14 14:20:21'),
(1169, 'app0', 'app1', 2011, '', '2015-04-14 14:20:42'),
(1170, 'app0', 'app1', 2036, '', '2015-04-14 16:40:34'),
(1171, 'app0', 'app1', 2035, '', '2015-04-14 16:40:34'),
(1172, 'app0', 'app1', 2034, '', '2015-04-14 16:40:34'),
(1173, 'app0', 'app1', 2033, '', '2015-04-14 16:40:34'),
(1174, 'app0', 'app1', 2032, '', '2015-04-14 16:40:34'),
(1175, 'app0', 'app1', 1613, '', '2015-04-14 16:40:34'),
(1176, 'app0', 'app1', 861, '', '2015-04-14 16:40:34'),
(1177, 'app0', 'app1', 493, '', '2015-04-15 12:38:56'),
(1178, 'app0', 'app1', 1137, '', '2015-04-15 12:38:56'),
(1179, 'app0', 'app1', 424, '', '2015-04-15 12:38:56'),
(1180, 'app0', 'app1', 1590, '', '2015-04-15 12:38:56'),
(1181, 'app0', 'app1', 2075, '', '2015-04-15 17:57:18'),
(1182, 'app1', 'app3', 2075, '', '2015-04-15 17:58:25'),
(1183, 'app0', 'app1', 2079, '', '2015-04-16 09:22:07'),
(1184, 'app0', 'app1', 2077, '', '2015-04-16 09:22:12'),
(1185, 'app0', 'app1', 2060, '', '2015-04-16 09:36:23'),
(1186, 'app0', 'app1', 2080, '', '2015-04-16 09:36:25'),
(1187, 'app0', 'app1', 2061, '', '2015-04-16 09:56:44'),
(1188, 'app0', 'app1', 1540, '', '2015-04-16 09:56:50'),
(1189, 'app1', 'app3', 2061, '', '2015-04-16 10:04:49'),
(1190, 'app1', 'app3', 2060, '', '2015-04-16 10:05:07'),
(1191, 'app0', 'app1', 1807, '', '2015-04-16 10:08:57'),
(1192, 'app0', 'app1', 1663, '', '2015-04-16 10:11:26'),
(1193, 'app1', 'app3', 2036, '', '2015-04-16 10:32:38'),
(1194, 'app1', 'app3', 2035, '', '2015-04-16 10:32:38'),
(1195, 'app1', 'app3', 2034, '', '2015-04-16 10:32:38'),
(1196, 'app1', 'app3', 2033, '', '2015-04-16 10:32:38'),
(1197, 'app1', 'app3', 2032, '', '2015-04-16 10:32:38'),
(1198, 'app0', 'app1', 1630, '', '2015-04-16 10:36:54'),
(1199, 'app0', 'app1', 1962, '', '2015-04-16 10:55:23'),
(1200, 'app0', 'app1', 1982, '', '2015-04-16 11:01:08'),
(1201, 'app0', 'app1', 1557, '', '2015-04-16 11:04:38'),
(1202, 'app1', 'app3', 1630, '', '2015-04-16 11:10:01'),
(1203, 'app1', 'app3', 1982, '', '2015-04-16 11:10:01'),
(1204, 'app1', 'app3', 1962, '', '2015-04-16 11:10:01'),
(1205, 'app0', 'app1', 1717, '', '2015-04-16 11:23:44'),
(1206, 'app0', 'app1', 1843, '', '2015-04-16 11:23:44'),
(1207, 'app0', 'app1', 1835, '', '2015-04-16 11:23:44'),
(1208, 'app0', 'app1', 1645, 'Les deux premiers jours ont été effectués sur de la charge Expert technique pour le PMP et une documentation d''aide à la saisie du PMP.', '2015-04-16 12:38:56'),
(1209, 'app0', 'app1', 2086, '', '2015-04-16 14:02:01'),
(1210, 'app1', 'app3', 1663, '', '2015-04-16 14:04:07'),
(1211, 'app3', 'app0', 1663, '', '2015-04-16 14:04:18'),
(1212, 'app1', 'app3', 1807, '', '2015-04-16 14:04:30'),
(1213, 'app0', 'app1', 1663, '', '2015-04-16 14:04:54'),
(1214, 'app1', 'app3', 1663, '', '2015-04-16 14:05:08'),
(1215, 'app0', 'app1', 1317, '', '2015-04-16 14:40:11'),
(1216, 'app0', 'app1', 2052, '', '2015-04-16 15:02:39'),
(1217, 'app0', 'app1', 2054, '', '2015-04-16 15:02:39'),
(1218, 'app0', 'app1', 1765, '', '2015-04-16 15:02:39'),
(1219, 'app0', 'app1', 1517, '', '2015-04-16 16:52:51'),
(1220, 'app0', 'app1', 1853, '', '2015-04-16 17:21:08'),
(1221, 'app0', 'app1', 1851, '', '2015-04-16 17:21:08'),
(1222, 'app0', 'app1', 554, 'SMB sur site', '2015-04-17 09:10:54'),
(1223, 'app0', 'app1', 2028, '', '2015-04-17 09:11:09'),
(1224, 'app0', 'app1', 115, '', '2015-04-17 09:11:12'),
(1225, 'app0', 'app1', 1967, '', '2015-04-17 09:11:17'),
(1226, 'app0', 'app1', 1966, '', '2015-04-17 09:11:40'),
(1227, 'app0', 'app1', 1525, '', '2015-04-17 09:34:37'),
(1228, 'app0', 'app1', 1650, '', '2015-04-17 09:34:37'),
(1229, 'app0', 'app1', 1635, '', '2015-04-17 09:34:37'),
(1230, 'app1', 'app0', 1645, '', '2015-04-17 09:40:05'),
(1231, 'app1', 'app3', 1635, '', '2015-04-17 09:41:19'),
(1232, 'app1', 'app3', 1650, '', '2015-04-17 09:41:46'),
(1233, 'app0', 'app1', 2094, '', '2015-04-17 09:41:58'),
(1234, 'app0', 'app1', 1645, '', '2015-04-17 09:41:58'),
(1235, 'app1', 'app3', 1967, '', '2015-04-17 09:42:06'),
(1236, 'app1', 'app3', 1645, '', '2015-04-17 09:42:29'),
(1237, 'app1', 'app3', 2094, '', '2015-04-17 09:42:29'),
(1238, 'app1', 'app3', 552, '', '2015-04-17 09:57:47'),
(1239, 'app1', 'app3', 424, '', '2015-04-17 09:57:47'),
(1240, 'app1', 'app3', 493, '', '2015-04-17 09:57:47'),
(1241, 'app1', 'app3', 553, '', '2015-04-17 09:57:57'),
(1242, 'app1', 'app3', 554, '', '2015-04-17 09:58:07'),
(1243, 'app1', 'app3', 1137, '', '2015-04-17 10:01:02'),
(1244, 'app1', 'app3', 1590, '', '2015-04-17 10:01:02'),
(1245, 'app0', 'app1', 2029, '', '2015-04-17 11:39:40'),
(1246, 'app0', 'app1', 62, '', '2015-04-17 11:39:40'),
(1247, 'app1', 'app3', 115, '', '2015-04-17 11:40:11'),
(1248, 'app1', 'app3', 2028, '', '2015-04-17 11:40:11'),
(1249, 'app1', 'app3', 62, '', '2015-04-17 11:40:11'),
(1250, 'app1', 'app3', 2029, '', '2015-04-17 11:40:12'),
(1251, 'app1', 'app3', 2086, '', '2015-04-17 11:40:12'),
(1252, 'app0', 'app1', 494, '', '2015-04-17 13:55:55'),
(1253, 'app0', 'app1', 425, '', '2015-04-17 13:55:55'),
(1254, 'app0', 'app1', 426, '', '2015-04-17 13:57:04'),
(1255, 'app0', 'app1', 2059, '', '2015-04-17 13:57:05'),
(1256, 'app0', 'app1', 2063, '', '2015-04-17 14:06:50'),
(1257, 'app0', 'app1', 2026, '', '2015-04-17 14:06:50'),
(1258, 'app1', 'app3', 2063, '', '2015-04-17 14:07:31'),
(1259, 'app0', 'app1', 2050, '', '2015-04-17 14:15:43'),
(1260, 'app0', 'app1', 2048, '', '2015-04-17 14:15:43'),
(1261, 'app0', 'app1', 2045, '', '2015-04-17 14:16:11'),
(1262, 'app1', 'app3', 2045, '', '2015-04-17 14:17:15'),
(1263, 'app1', 'app3', 2050, '', '2015-04-17 14:17:28'),
(1264, 'app1', 'app3', 2048, '', '2015-04-17 14:17:28'),
(1265, 'app1', 'app3', 1525, '', '2015-04-20 08:46:10'),
(1266, 'app1', 'app3', 1557, '', '2015-04-20 08:46:10'),
(1267, 'app1', 'app3', 1517, '', '2015-04-20 08:46:10'),
(1268, 'app1', 'app3', 2059, '', '2015-04-20 08:46:10'),
(1269, 'app1', 'app3', 1540, '', '2015-04-20 08:46:10'),
(1270, 'app1', 'app3', 1613, '', '2015-04-20 08:46:10'),
(1271, 'app1', 'app3', 1717, '', '2015-04-20 08:46:10'),
(1272, 'app1', 'app3', 2026, '', '2015-04-20 08:46:10'),
(1273, 'app1', 'app3', 900, '', '2015-04-20 08:46:24'),
(1274, 'app1', 'app3', 1539, '', '2015-04-20 08:46:24'),
(1275, 'app1', 'app3', 1615, '', '2015-04-20 08:46:24'),
(1276, 'app1', 'app3', 1555, '', '2015-04-20 08:46:24'),
(1277, 'app1', 'app3', 1610, '', '2015-04-20 08:46:35'),
(1278, 'app1', 'app3', 1556, '', '2015-04-20 08:46:35'),
(1279, 'app1', 'app3', 1513, '', '2015-04-20 08:46:35'),
(1280, 'app1', 'app3', 1204, '', '2015-04-20 08:46:47'),
(1281, 'app1', 'app3', 1568, '', '2015-04-20 08:46:47'),
(1282, 'app1', 'app3', 1546, '', '2015-04-20 08:46:47'),
(1283, 'app1', 'app3', 1119, '', '2015-04-20 08:46:47'),
(1284, 'app1', 'app3', 1512, '', '2015-04-20 08:46:47'),
(1285, 'app1', 'app3', 1130, '', '2015-04-20 08:46:57'),
(1286, 'app1', 'app3', 1129, '', '2015-04-20 08:46:57'),
(1287, 'app1', 'app3', 1248, '', '2015-04-20 08:46:57'),
(1288, 'app1', 'app3', 901, '', '2015-04-20 08:47:09'),
(1289, 'app1', 'app3', 1208, '', '2015-04-20 08:47:09'),
(1290, 'app1', 'app3', 1160, '', '2015-04-20 08:47:09'),
(1291, 'app1', 'app3', 1116, '', '2015-04-20 08:47:18'),
(1292, 'app1', 'app3', 1009, '', '2015-04-20 08:47:27'),
(1293, 'app1', 'app3', 749, '', '2015-04-20 08:47:36'),
(1294, 'app1', 'app3', 713, '', '2015-04-20 08:47:50'),
(1295, 'app1', 'app3', 673, '', '2015-04-20 08:47:50'),
(1296, 'app1', 'app3', 664, '', '2015-04-20 08:47:50'),
(1297, 'app1', 'app3', 912, '', '2015-04-20 08:47:50'),
(1298, 'app1', 'app3', 911, '', '2015-04-20 08:47:50'),
(1299, 'app1', 'app3', 155, '', '2015-04-20 08:49:20'),
(1300, 'app1', 'app3', 213, '', '2015-04-20 08:49:29'),
(1301, 'app1', 'app3', 224, '', '2015-04-20 08:49:29'),
(1302, 'app1', 'app3', 212, '', '2015-04-20 08:49:41'),
(1303, 'app1', 'app3', 225, '', '2015-04-20 08:49:41'),
(1304, 'app0', 'app1', 2104, '', '2015-04-20 14:18:01'),
(1305, 'app0', 'app1', 2082, '', '2015-04-20 14:18:01'),
(1306, 'app0', 'app1', 1766, '', '2015-04-20 14:18:01'),
(1307, 'app0', 'app1', 2067, 'Mise en place ligne Orange pour Airbus Helicoptere', '2015-04-20 16:28:41'),
(1308, 'app3', 'app0', 367, '', '2015-04-20 16:33:38'),
(1309, 'app3', 'app0', 548, '', '2015-04-20 16:38:34'),
(1310, 'app3', 'app0', 549, '', '2015-04-20 16:39:23'),
(1311, 'app3', 'app0', 550, '', '2015-04-20 16:39:53'),
(1312, 'app3', 'app0', 551, '', '2015-04-20 16:40:02'),
(1313, 'app3', 'app0', 552, '', '2015-04-20 16:40:13'),
(1314, 'app1', 'app3', 2067, '', '2015-04-20 16:47:20'),
(1315, 'app0', 'app1', 548, '', '2015-04-20 16:54:43'),
(1316, 'app0', 'app1', 549, '', '2015-04-20 16:54:52'),
(1317, 'app0', 'app1', 550, '', '2015-04-20 16:54:57'),
(1318, 'app0', 'app1', 551, '', '2015-04-20 16:55:02'),
(1319, 'app0', 'app1', 552, '', '2015-04-20 16:55:10'),
(1320, 'app1', 'app3', 548, '', '2015-04-20 16:56:23'),
(1321, 'app1', 'app3', 549, '', '2015-04-20 16:56:32'),
(1322, 'app1', 'app3', 550, '', '2015-04-20 16:56:38'),
(1323, 'app1', 'app3', 551, '', '2015-04-20 16:56:43'),
(1324, 'app1', 'app3', 552, '', '2015-04-20 16:57:24'),
(1325, 'app0', 'app1', 367, '', '2015-04-20 17:03:22'),
(1326, 'app0', 'app1', 1126, '', '2015-04-20 17:16:08'),
(1327, 'app0', 'app1', 1246, '', '2015-04-20 17:16:08'),
(1328, 'app0', 'app1', 1247, '', '2015-04-20 17:17:02'),
(1329, 'app1', 'app3', 1126, '', '2015-04-20 17:17:52'),
(1330, 'app1', 'app3', 1247, '', '2015-04-21 08:31:14'),
(1331, 'app1', 'app3', 1246, '', '2015-04-21 08:31:23'),
(1332, 'app0', 'app1', 1362, '', '2015-04-22 13:27:27'),
(1333, 'app0', 'app1', 1754, '', '2015-04-22 13:27:31'),
(1334, 'app0', 'app1', 2159, '', '2015-04-23 09:40:08'),
(1335, 'app0', 'app1', 1664, '', '2015-04-23 10:02:03'),
(1336, 'app0', 'app1', 1808, '', '2015-04-23 10:02:07'),
(1337, 'app0', 'app1', 2126, '', '2015-04-23 10:02:12'),
(1338, 'app1', 'app3', 2159, '', '2015-04-23 10:02:35'),
(1339, 'app1', 'app3', 1664, '', '2015-04-23 10:02:48'),
(1340, 'app1', 'app3', 1808, '', '2015-04-23 10:02:55'),
(1341, 'app1', 'app3', 2126, '', '2015-04-23 10:03:08'),
(1342, 'app0', 'app1', 1631, '', '2015-04-23 11:28:58'),
(1343, 'app0', 'app1', 1732, '', '2015-04-23 12:11:29'),
(1344, 'app0', 'app1', 1694, '', '2015-04-23 12:11:29'),
(1345, 'app0', 'app1', 1692, '', '2015-04-23 12:11:29'),
(1346, 'app1', 'app3', 1688, '', '2015-04-23 12:12:25'),
(1347, 'app1', 'app3', 1691, '', '2015-04-23 12:12:25'),
(1348, 'app1', 'app3', 1689, '', '2015-04-23 12:12:25'),
(1349, 'app1', 'app3', 1694, '', '2015-04-23 12:12:26'),
(1350, 'app1', 'app3', 1692, '', '2015-04-23 12:12:26'),
(1351, 'app0', 'app1', 2160, '', '2015-04-23 15:19:31'),
(1352, 'app0', 'app1', 2161, '', '2015-04-23 15:19:31'),
(1353, 'app0', 'app1', 2162, '', '2015-04-23 15:19:31'),
(1354, 'app1', 'app3', 2160, '', '2015-04-23 15:30:33'),
(1355, 'app1', 'app3', 2161, '', '2015-04-23 15:30:33'),
(1356, 'app1', 'app3', 2162, '', '2015-04-23 15:30:33'),
(1357, 'app0', 'app1', 2165, '', '2015-04-23 15:32:16'),
(1358, 'app0', 'app1', 2163, '', '2015-04-23 15:32:16'),
(1359, 'app0', 'app1', 2166, '', '2015-04-23 15:32:16'),
(1360, 'app0', 'app1', 2167, '', '2015-04-23 15:32:16'),
(1361, 'app1', 'app3', 2163, '', '2015-04-23 15:33:02'),
(1362, 'app1', 'app3', 2166, '', '2015-04-23 15:33:03'),
(1363, 'app1', 'app3', 2167, '', '2015-04-23 15:33:03'),
(1364, 'app0', 'app1', 1646, '', '2015-04-23 16:00:40'),
(1365, 'app3', 'app0', 2061, '', '2015-04-23 17:12:14'),
(1366, 'app0', 'app1', 2061, '', '2015-04-23 17:12:54'),
(1367, 'app0', 'app1', 2030, '', '2015-04-23 17:14:15'),
(1368, 'app0', 'app1', 2027, '', '2015-04-23 17:14:17'),
(1369, 'app0', 'app1', 2178, '', '2015-04-23 17:23:17'),
(1370, 'app0', 'app1', 63, '', '2015-04-23 17:23:17'),
(1371, 'app1', 'app3', 63, '', '2015-04-23 17:25:31'),
(1372, 'app1', 'app3', 2178, '', '2015-04-23 17:25:31'),
(1373, 'app0', 'app1', 1651, '', '2015-04-23 18:00:03'),
(1374, 'app0', 'app1', 1659, '', '2015-04-23 18:00:03'),
(1375, 'app0', 'app1', 1614, '', '2015-04-24 09:21:08'),
(1376, 'app0', 'app1', 2181, '', '2015-04-24 09:21:16'),
(1377, 'app0', 'app1', 2184, '', '2015-04-24 09:21:27'),
(1378, 'app0', 'app1', 2185, '', '2015-04-24 09:31:44'),
(1379, 'app0', 'app1', 2183, '', '2015-04-24 09:31:44'),
(1380, 'app0', 'app1', 2182, '', '2015-04-24 09:31:44'),
(1381, 'app1', 'app3', 1614, '', '2015-04-24 09:51:42'),
(1382, 'app0', 'app1', 2095, '', '2015-04-24 10:36:33'),
(1383, 'app0', 'app1', 2096, '', '2015-04-24 10:36:35'),
(1384, 'app0', 'app1', 1449, '', '2015-04-24 10:36:39'),
(1385, 'app0', 'app1', 1740, '', '2015-04-24 10:36:40'),
(1386, 'app0', 'app1', 2053, '', '2015-04-24 10:37:03'),
(1387, 'app1', 'app3', 426, '', '2015-04-24 10:40:57'),
(1388, 'app1', 'app3', 425, '', '2015-04-24 10:41:04'),
(1389, 'app1', 'app3', 494, '', '2015-04-24 10:41:09'),
(1390, 'app1', 'app3', 1732, '', '2015-04-24 10:41:15'),
(1391, 'app1', 'app3', 367, '', '2015-04-24 10:41:22'),
(1392, 'app1', 'app3', 2165, '', '2015-04-24 10:41:54'),
(1393, 'app0', 'app1', 259, '', '2015-04-24 10:42:32'),
(1394, 'app0', 'app1', 2057, '', '2015-04-24 10:42:35'),
(1395, 'app1', 'app3', 259, '', '2015-04-24 10:43:01'),
(1396, 'app0', 'app1', 496, '', '2015-04-24 10:46:15'),
(1397, 'app0', 'app1', 2044, '', '2015-04-24 10:46:28'),
(1398, 'app0', 'app1', 2190, '', '2015-04-24 10:52:12'),
(1399, 'app0', 'app1', 2164, '', '2015-04-24 10:52:15'),
(1400, 'app0', 'app1', 2203, '', '2015-04-24 10:52:36'),
(1401, 'app0', 'app1', 2202, '', '2015-04-24 10:52:37'),
(1402, 'app1', 'app3', 2203, '', '2015-04-24 10:53:39'),
(1403, 'app1', 'app3', 2202, '', '2015-04-24 10:56:11'),
(1404, 'app0', 'app1', 2124, '', '2015-04-24 11:04:38'),
(1405, 'app0', 'app1', 2121, '', '2015-04-24 11:04:44'),
(1406, 'app0', 'app1', 2158, '', '2015-04-24 11:04:46'),
(1407, 'app0', 'app1', 2106, '', '2015-04-24 11:05:03'),
(1408, 'app0', 'app1', 1844, '', '2015-04-24 11:11:05'),
(1409, 'app0', 'app1', 1836, '', '2015-04-24 11:11:05'),
(1410, 'app1', 'app3', 2027, '', '2015-04-24 11:11:59'),
(1411, 'app1', 'app3', 2030, '', '2015-04-24 11:11:59'),
(1412, 'app1', 'app3', 861, '', '2015-04-24 11:11:59'),
(1413, 'app1', 'app3', 1835, '', '2015-04-24 11:11:59'),
(1414, 'app1', 'app3', 1843, '', '2015-04-24 11:11:59'),
(1415, 'app1', 'app3', 1851, '', '2015-04-24 11:11:59'),
(1416, 'app1', 'app3', 1853, '', '2015-04-24 11:11:59'),
(1417, 'app1', 'app3', 1836, '', '2015-04-24 11:12:08'),
(1418, 'app1', 'app3', 1844, '', '2015-04-24 11:12:08'),
(1419, 'app0', 'app1', 2207, '', '2015-04-24 11:16:27'),
(1420, 'app0', 'app1', 2309, '', '2015-04-24 11:16:27'),
(1421, 'app0', 'app1', 1959, '', '2015-04-24 12:11:36'),
(1422, 'app0', 'app1', 2186, '', '2015-04-24 14:32:37'),
(1423, 'app0', 'app1', 1406, '', '2015-04-24 14:32:37'),
(1424, 'app0', 'app1', 2346, '', '2015-04-24 14:35:08'),
(1425, 'app0', 'app1', 2347, '', '2015-04-24 14:35:10'),
(1426, 'app1', 'app3', 1959, '', '2015-04-24 14:35:24'),
(1427, 'app1', 'app3', 2347, '', '2015-04-24 14:35:37'),
(1428, 'app1', 'app3', 2346, '', '2015-04-24 14:35:37'),
(1429, 'app1', 'app3', 2158, '', '2015-04-24 14:37:51'),
(1430, 'app0', 'app1', 2348, '', '2015-04-24 14:50:46'),
(1431, 'app1', 'app3', 2044, '', '2015-04-24 14:52:38'),
(1432, 'app0', 'app1', 1318, '', '2015-04-24 14:54:27'),
(1433, 'app0', 'app1', 2349, '', '2015-04-24 15:15:09'),
(1434, 'app0', 'app1', 2081, '', '2015-04-24 15:21:14'),
(1435, 'app0', 'app1', 2350, '', '2015-04-24 15:21:26'),
(1436, 'app1', 'app3', 2349, '', '2015-04-24 15:23:32'),
(1437, 'app1', 'app3', 2350, '', '2015-04-24 15:23:36'),
(1438, 'app0', 'app1', 2194, '', '2015-04-24 15:46:32'),
(1439, 'app0', 'app1', 2191, '', '2015-04-24 15:46:32'),
(1440, 'app0', 'app1', 2192, '', '2015-04-24 16:16:32'),
(1441, 'app0', 'app1', 2118, '', '2015-04-27 09:15:02'),
(1442, 'app0', 'app1', 1541, '', '2015-04-27 09:15:04'),
(1443, 'app0', 'app1', 1519, '', '2015-04-27 13:24:21'),
(1444, 'app0', 'app1', 1845, '', '2015-04-27 13:24:21'),
(1445, 'app0', 'app1', 1837, '', '2015-04-27 13:24:21'),
(1446, 'app1', 'app3', 1837, '', '2015-04-27 14:09:45'),
(1447, 'app1', 'app3', 1845, '', '2015-04-27 14:09:45'),
(1448, 'app0', 'app1', 2112, '', '2015-04-27 15:12:12'),
(1449, 'app0', 'app1', 2111, '', '2015-04-27 15:12:17'),
(1450, 'app0', 'app1', 1918, '', '2015-04-27 15:12:20'),
(1451, 'app0', 'app1', 1915, 'Bug Fix ASPIRE', '2015-04-27 15:18:01'),
(1452, 'app0', 'app1', 1865, '', '2015-04-27 15:18:42'),
(1453, 'app0', 'app1', 1960, '', '2015-04-27 15:25:53'),
(1454, 'app0', 'app1', 1956, '', '2015-04-27 15:25:56'),
(1455, 'app1', 'app3', 496, '', '2015-04-27 17:25:54'),
(1456, 'app1', 'app3', 2348, '', '2015-04-27 17:25:54'),
(1457, 'app1', 'app3', 2207, '', '2015-04-27 17:26:14'),
(1458, 'app1', 'app3', 2164, '', '2015-04-27 17:26:14'),
(1459, 'app1', 'app3', 2190, '', '2015-04-27 17:26:14'),
(1460, 'app1', 'app3', 2191, '', '2015-04-27 17:26:14'),
(1461, 'app1', 'app3', 2194, '', '2015-04-27 17:26:14'),
(1462, 'app1', 'app3', 2192, '', '2015-04-27 17:26:14'),
(1463, 'app1', 'app3', 1646, '', '2015-04-28 10:24:39'),
(1464, 'app1', 'app3', 1631, '', '2015-04-28 10:24:43'),
(1465, 'app1', 'app3', 1659, '', '2015-04-28 10:24:48'),
(1466, 'app1', 'app3', 1651, '', '2015-04-28 10:24:55'),
(1467, 'app0', 'app1', 1963, '', '2015-04-28 10:28:50'),
(1468, 'app0', 'app1', 1964, '', '2015-04-28 10:29:54'),
(1469, 'app0', 'app1', 1983, '', '2015-04-28 10:44:42'),
(1470, 'app0', 'app1', 1984, '', '2015-04-28 10:45:02'),
(1471, 'app0', 'app1', 1558, '', '2015-04-28 10:45:50'),
(1472, 'app0', 'app1', 2142, '', '2015-04-28 10:46:51'),
(1473, 'app0', 'app1', 2385, '', '2015-04-28 11:16:58'),
(1474, 'app1', 'app3', 1983, '', '2015-04-28 11:17:22'),
(1475, 'app1', 'app3', 1963, '', '2015-04-28 11:17:22'),
(1476, 'app1', 'app3', 1966, '', '2015-04-28 11:17:33'),
(1477, 'app1', 'app3', 967, '', '2015-04-28 11:17:42'),
(1478, 'app1', 'app3', 2385, '', '2015-04-28 11:18:10'),
(1479, 'app1', 'app3', 1984, '', '2015-04-28 11:18:10'),
(1480, 'app1', 'app3', 1964, '', '2015-04-28 11:18:10'),
(1481, 'app0', 'app1', 2383, '', '2015-04-28 14:23:27'),
(1482, 'app0', 'app1', 1632, '', '2015-04-28 14:32:00'),
(1483, 'app0', 'app1', 1725, '', '2015-04-28 15:48:57'),
(1484, 'app0', 'app1', 1855, '', '2015-04-28 15:49:43'),
(1485, 'app1', 'app3', 1632, '', '2015-04-28 16:13:30'),
(1486, 'app0', 'app1', 2386, '', '2015-04-28 17:38:12'),
(1487, 'app1', 'app3', 2386, '', '2015-04-28 17:39:44'),
(1488, 'app0', 'app1', 1637, '', '2015-04-28 18:02:58'),
(1489, 'app0', 'app1', 2179, '', '2015-04-29 07:18:02'),
(1490, 'app0', 'app1', 2420, '', '2015-04-29 07:18:02'),
(1491, 'app0', 'app1', 64, '', '2015-04-29 07:18:02'),
(1492, 'app1', 'app3', 64, '', '2015-04-29 07:19:37'),
(1493, 'app1', 'app3', 2179, '', '2015-04-29 07:19:37'),
(1494, 'app1', 'app3', 2420, '', '2015-04-29 07:19:37'),
(1495, 'app1', 'app3', 2383, '', '2015-04-29 07:19:37'),
(1496, 'app1', 'app3', 1637, '', '2015-04-29 09:42:21'),
(1497, 'app0', 'app1', 2408, '', '2015-04-29 10:08:48'),
(1498, 'app0', 'app1', 2388, '', '2015-04-29 10:08:54'),
(1499, 'app1', 'app3', 2118, '', '2015-04-29 10:12:36'),
(1500, 'app1', 'app3', 2142, '', '2015-04-29 10:12:50'),
(1501, 'app0', 'app1', 2127, '', '2015-04-29 10:14:18'),
(1502, 'app0', 'app1', 1665, '', '2015-04-29 10:14:22'),
(1503, 'app0', 'app1', 1809, '', '2015-04-29 10:14:24'),
(1504, 'app0', 'app1', 2363, '', '2015-04-29 10:14:27'),
(1505, 'app1', 'app3', 2127, '', '2015-04-29 10:14:53'),
(1506, 'app1', 'app3', 1809, '', '2015-04-29 10:15:01'),
(1507, 'app1', 'app3', 1665, '', '2015-04-29 10:15:09'),
(1508, 'app0', 'app1', 2414, '', '2015-04-29 10:50:07'),
(1509, 'app0', 'app1', 2411, '', '2015-04-29 10:50:07'),
(1510, 'app0', 'app1', 2410, '', '2015-04-29 10:50:07'),
(1511, 'app0', 'app1', 2401, '', '2015-04-29 12:13:57'),
(1512, 'app0', 'app1', 2422, '', '2015-04-29 12:14:00'),
(1513, 'app1', 'app3', 2422, '', '2015-04-29 13:59:31'),
(1514, 'app0', 'app1', 427, '', '2015-04-29 14:08:13'),
(1515, 'app1', 'app3', 2061, '', '2015-04-29 14:11:54'),
(1516, 'app3', 'app0', 2118, '', '2015-04-29 14:12:15'),
(1517, 'app0', 'app1', 2118, '', '2015-04-29 14:13:27'),
(1518, 'app1', 'app3', 2118, '', '2015-04-29 14:14:11'),
(1519, 'app0', 'app1', 2400, '', '2015-04-29 15:21:46'),
(1520, 'app0', 'app1', 2377, '', '2015-04-29 16:09:57'),
(1521, 'app0', 'app1', 2362, '', '2015-04-29 16:10:20'),
(1522, 'app0', 'app1', 2399, '', '2015-04-29 17:35:09'),
(1523, 'app0', 'app1', 2208, '', '2015-04-29 17:35:09'),
(1524, 'app0', 'app1', 2310, '', '2015-04-29 17:35:09'),
(1525, 'app1', 'app3', 2363, '', '2015-04-30 07:17:01'),
(1526, 'app1', 'app3', 2377, '', '2015-04-30 07:17:01'),
(1527, 'app1', 'app0', 2362, '2 jours en formation et 1 journée sur EDF TMO² à imputer', '2015-04-30 07:17:28'),
(1528, 'app0', 'app1', 1969, 'Pas de Total à imputer', '2015-04-30 08:21:29'),
(1529, 'app0', 'app1', 117, '', '2015-04-30 08:21:41'),
(1530, 'app0', 'app1', 2419, '', '2015-04-30 08:21:43'),
(1531, 'app0', 'app1', 2171, '', '2015-04-30 08:21:49'),
(1532, 'app0', 'app1', 556, '', '2015-04-30 08:22:17'),
(1533, 'app0', 'app1', 712, '', '2015-04-30 08:23:25'),
(1534, 'app1', 'app3', 1969, '', '2015-04-30 09:42:37'),
(1535, 'app0', 'app1', 1363, '', '2015-04-30 10:07:53'),
(1536, 'app0', 'app1', 2394, '', '2015-04-30 10:08:01'),
(1537, 'app0', 'app1', 1813, '', '2015-04-30 10:56:51'),
(1538, 'app0', 'app1', 2429, '', '2015-04-30 11:35:12'),
(1539, 'app0', 'app1', 2529, '', '2015-04-30 11:35:12'),
(1540, 'app0', 'app1', 2519, '', '2015-04-30 11:35:12'),
(1541, 'app0', 'app1', 428, '', '2015-04-30 11:35:12'),
(1542, 'app1', 'app3', 2429, '', '2015-04-30 11:38:54'),
(1543, 'app1', 'app3', 2529, '', '2015-04-30 11:38:54'),
(1544, 'app1', 'app3', 2519, '', '2015-04-30 11:38:54'),
(1545, 'app0', 'app1', 2458, '', '2015-04-30 11:52:28'),
(1546, 'app0', 'app1', 2353, '', '2015-04-30 11:52:56'),
(1547, 'app0', 'app1', 2418, '', '2015-04-30 11:53:09');

-- --------------------------------------------------------

--
-- Structure de la table `wbsnode`
--

DROP TABLE IF EXISTS `wbsnode`;
CREATE TABLE IF NOT EXISTS `wbsnode` (
`IdWBSNode` int(11) NOT NULL,
  `idProject` int(11) NOT NULL,
  `Code` varchar(5) DEFAULT NULL,
  `Name` varchar(150) DEFAULT NULL COMMENT 'de 80 à 150',
  `Description` varchar(1500) DEFAULT NULL,
  `IsControlAccount` bit(1) DEFAULT NULL,
  `Budget` double DEFAULT NULL,
  `Parent` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=1587 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `wbsnode`
--

INSERT INTO `wbsnode` (`IdWBSNode`, `idProject`, `Code`, `Name`, `Description`, `IsControlAccount`, `Budget`, `Parent`) VALUES
(13, 7, NULL, 'Management du Centre de Services', NULL, b'0', NULL, NULL),
(14, 7, 'PPR', 'Patrice Prouzat', '', b'1', 0, 13),
(15, 7, 'SPE', 'Stéphan Peccini', '', b'1', 0, 13),
(16, 8, '', 'Congés 2014', '', b'0', NULL, NULL),
(17, 8, 'CP14', 'Congés Payés 2014', '', b'1', 0, 16),
(18, 8, 'RE14', 'RTT employé 2014', '', b'1', 0, 16),
(19, 8, 'AE14', 'Absences exceptionnelles 2014', '', b'1', 0, 16),
(20, 9, '', 'Formations Externes 2015', '', b'0', NULL, NULL),
(22, 10, '', 'Formations Internes 2015', '', b'0', NULL, NULL),
(23, 10, '', 'OpenPPM', '', b'1', 1000, 22),
(27, 13, NULL, 'Interface entre OpenPPM et SmartPlan', NULL, b'1', NULL, NULL),
(33, 14, NULL, 'Formulaire de saisie de congés', NULL, b'1', NULL, NULL),
(35, 16, 'BU', 'Infrastructure du centre de services', '', b'1', 0, NULL),
(37, 18, NULL, 'Évolutions d''OpenPPM', NULL, b'0', NULL, NULL),
(38, 19, NULL, 'E-Sign EIS evolutions', NULL, b'0', NULL, NULL),
(39, 19, '', 'Kick-off (4j)', '', b'1', 2160, 38),
(40, 19, '', 'DEVELOPPEMENT', '', b'0', NULL, 38),
(41, 19, '', 'Suivi (4j)', '', b'1', 2160, 40),
(42, 19, '', 'Sprint 1 (7,5j)', '', b'1', 4050, 40),
(43, 19, '', 'Sprint 2 (7,5j)', '', b'1', 4050, 40),
(44, 19, '', 'Acceptance', '', b'0', NULL, 38),
(45, 19, '', 'MII - Unit test (3j)', '', b'1', 1620, 44),
(46, 19, '', 'Documentation Update (2j)', '', b'1', 1080, 44),
(47, 19, '', 'MIV - Support BAT', '', b'1', 2160, 44),
(48, 19, '', 'MIP', '', b'1', 540, 44),
(49, 20, NULL, 'Airbus Helicopters - TMA S400 - WP1 - recurring activities', NULL, b'1', NULL, NULL),
(50, 21, '', 'Airbus Helicopters - TMA S400 - WP3 - Requests Management', '', b'0', 3333, NULL),
(51, 21, '', 'Unit Data Administration - Modification of an attribute of an information', '', b'1', 0, 50),
(52, 21, '', 'Unit Data Administration - Modification of an attribute of an end-user', '', b'0', NULL, 50),
(53, 21, '', 'Mass Data Administration', '', b'1', 0, 50),
(54, 21, '', 'Mass User Administration', '', b'0', NULL, 50),
(55, 21, '', 'Data export/import from template', '', b'1', 0, 50),
(56, 21, '', 'Database restore/refresh, not under INB responsibility', '', b'1', 0, 50),
(57, 21, '', 'Database restore/refresh, under INB responsibility', '', b'1', 0, 50),
(58, 21, '', 'Report Schedule Creation', '', b'1', 0, 50),
(59, 21, '', 'Report Update Schedule', '', b'1', 0, 50),
(60, 21, '', 'Report Schedule Suppress', '', b'1', 0, 50),
(62, 22, NULL, 'Airbus Helicopters - TMA S400 - Initialisation', NULL, b'1', NULL, NULL),
(63, 23, NULL, 'Airbus Helicopters - TMA S400 - Gouvernance', NULL, b'1', NULL, NULL),
(64, 24, '', 'Airbus Helicopters - TMA S400 - On demand projects', '', b'0', NULL, NULL),
(65, 25, NULL, 'CEA - DAM - Train de maintenance évolutive n° 01', NULL, b'0', NULL, NULL),
(66, 25, '', 'Devis', '', b'1', 0, 65),
(67, 25, '', 'Specs Update', '', b'1', 0, 65),
(68, 25, '', 'Développement (20j)', '', b'1', 12400, 65),
(69, 25, '', 'Recette croisée (3j)', '', b'1', 1860, 65),
(70, 25, '', 'Livraison (1j)', '', b'1', 622, 65),
(71, 26, '', 'Reporting dashboard migration', '', b'0', NULL, NULL),
(72, 27, NULL, 'Congés 2015', NULL, b'0', NULL, NULL),
(73, 27, 'CP15', 'Congés Payés 2015', '', b'1', 0, 72),
(74, 27, 'RE15', 'RTT employé 2015', '', b'1', 0, 72),
(75, 27, 'AE14', 'Absences exceptionnelles 2015', '', b'1', 0, 72),
(76, 28, NULL, 'CEA - DAM - Formations session S1 2015', NULL, b'0', NULL, NULL),
(77, 29, NULL, 'LBP - OPUS - Train de maintenance évolutive n° 15', NULL, b'0', NULL, NULL),
(78, 30, NULL, 'LBP - OPUS - TMA Corrective - Q1 2015', NULL, b'1', NULL, NULL),
(79, 31, '', 'CEA - DAM - TMA - Corrective Q1 2015', '', b'0', NULL, NULL),
(80, 32, 'MGT', 'Management du Centre de Services 2015', '', b'1', 0, NULL),
(81, 33, 'MALAD', 'Jours de maladie - 2015', '', b'1', 0, NULL),
(82, 34, NULL, 'Avant-vente 2015', NULL, b'0', NULL, NULL),
(83, 34, 'RGSO', 'SANOFI DAI : Déploiement PROMISE', '', b'0', NULL, 82),
(84, 34, 'AVV', 'SANOFI DAI : Déploiement PROMISE - Proposition V2', '', b'1', 0, 83),
(85, 34, 'BUIET', 'Total CDS Middle office', '', b'0', NULL, 82),
(86, 34, 'AVV', 'Total CDS Middle office - V1 - Rédaction des UO et chiffrage - partie 1', '', b'1', 0, 85),
(87, 34, 'RGSO', 'Airbus D&S - IT Bundle RFP', '', b'0', NULL, 82),
(88, 34, 'AVV', 'Airbus D&S - IT Bundle RFP - V1 - Contribution à la proposition', '', b'1', 0, 87),
(89, 34, 'RGSO', 'LBP - OPUS V2', '', b'0', NULL, 82),
(90, 34, 'AVV', 'LBP - OPUS V2 - V1 - Contribution à la proposition', '', b'1', 0, 89),
(91, 34, 'BUIET', 'Celine - Bundle Patch Management', '', b'0', NULL, 82),
(92, 34, 'BUIET', 'DSI Courrier La poste Mise en place de Centre de Services', '', b'0', NULL, 82),
(93, 34, 'AVV', 'Celine - Bundle Patch Management - V1 - contribution à la proposition', '', b'1', 0, 91),
(94, 34, 'AVV', 'DSI Courrier La poste MEP de CdS - V1 - contribution à la proposition', '', b'1', 0, 92),
(95, 34, 'RGSO', 'Akérys - TMA', '', b'0', NULL, 82),
(97, 34, 'AVV', 'Akérys - TMA - proposition', '', b'1', 0, 95),
(98, 18, 'BU', 'Gestion des Skills', '', b'1', 0, 37),
(99, 18, 'BU', 'Capacity Planning', '', b'1', 0, 37),
(100, 18, 'BU', 'Gestion des Congés', '', b'1', 0, 37),
(101, 18, 'BU', 'Déclaration des UO', '', b'1', 0, 37),
(102, 18, 'BU', 'Du CRA vers Aramis', '', b'1', 0, 37),
(105, 18, 'BU', 'Génération du SFP', '', b'1', 0, 37),
(106, 18, 'BU', 'Gestion des coûts standards', '', b'1', 0, 37),
(107, 28, '', 'Session DIF / SISR', '', b'1', 0, 76),
(108, 34, 'MSCAP', 'MSC Assurances - Prism Particuliers', '', b'0', NULL, 82),
(109, 34, 'AVV', 'MSC Assurances - Prism Particuliers - Qualification', '', b'1', 0, 87),
(110, 35, NULL, 'Fin du rôle Direction Technique 2014', NULL, b'0', NULL, NULL),
(111, 35, 'MGT', 'Bilan financier et MDB', '', b'1', 0, 110),
(112, 35, 'MGT', 'Transfert de connaissances', '', b'1', 0, 110),
(113, 34, 'RGSE', 'CEGID TMA ITSM', '', b'0', NULL, 82),
(114, 34, 'AVV', 'CEGID TMA ITSM - Contribution à la proposition V1', '', b'1', 0, 113),
(115, 9, 'FR15', 'Sauveteur Secouriste du Travail', '', b'1', 0, 20),
(116, 29, '', 'TM15 - Spécifications (2,4j)', '', b'1', 1308, 77),
(117, 29, '', 'TM15 - Réalisation / Documentation (13,2j)', '', b'1', 7194, 119),
(118, 29, '', 'TM15 - Intégration / Recette croisée (3,6j)', '', b'1', 1962, 119),
(119, 29, '', 'Paramétrage / Intégration', '', b'0', NULL, 77),
(120, 29, '', 'TM15 - VABF', '', b'1', 1308, 119),
(121, 29, '', 'TM15 - Gestion de projet', '', b'1', 1308, 77),
(122, 34, 'AVV', 'MSC Assurances - Prism Particuliers - contribution à la réponse', '', b'1', 0, 108),
(123, 34, 'RGSO', 'Airbus - ARTS v2', '', b'0', NULL, 82),
(124, 34, 'AVV', 'Airbus - ARTS v2 - round 1', '', b'1', 0, 123),
(125, 28, '', 'Session S6 - Valduc - MJE', '', b'1', 0, 76),
(126, 28, '', 'Session S6 - DIF - CSA', '', b'1', 0, 76),
(127, 28, '', 'Session S7 - DIF - CSA', '', b'1', 0, 76),
(128, 28, '', 'Session S8 - DIF - VSA', '', b'1', 0, 76),
(129, 28, '', 'Session S8 - Valduc - MJE', '', b'1', 0, 76),
(130, 28, '', 'Session S8 - Ripault - CSA', '', b'1', 0, 76),
(131, 28, '', 'Session S9 - DIF - CSA', '', b'1', 0, 76),
(132, 28, '', 'Session S9 - Valduc - MJE', '', b'1', 0, 76),
(133, 28, '', 'Session S9 - DIF - VSA', '', b'1', 0, 76),
(134, 28, '', 'Session S10 - Ripault - MJE', '', b'1', 0, 76),
(135, 28, '', 'Session S10 - DIF - CSA', '', b'1', 0, 76),
(136, 28, '', 'Session S11 - Ripault - MJE', '', b'1', 0, 76),
(137, 28, '', 'Session S11 - DIF - VSA', '', b'1', 0, 76),
(138, 28, '', 'Session S12 - DIF - CSA', '', b'1', 0, 76),
(139, 28, '', 'Session S13 - DIF - VSA', '', b'1', 0, 76),
(140, 34, 'AVV', 'Total CDS Middle Office - Soutenance et BAFO', '', b'1', 0, 85),
(141, 36, '', 'Tous les projets BI de moins de 25 jours', '', b'0', 8499.8425, NULL),
(142, 37, NULL, 'MAGIC - Activités autour de l''outil', NULL, b'0', 93899.94479999997, NULL),
(143, 38, '', 'Tout le run BI de moins de 25 jours', '', b'0', 135890.23, NULL),
(145, 39, '', 'AAL V8.6.0', '', b'0', 14972.919999999998, NULL),
(146, 40, '', 'ATREF V1.4.20', '', b'0', NULL, NULL),
(147, 41, NULL, 'ICT', NULL, b'0', NULL, NULL),
(150, 34, 'AVV', 'ARTS v2 - préparation soutenance', '', b'1', 0, 123),
(155, 21, '', 'Mass User Administration - 2015-02-10T10:30:01+00:00', '', b'1', 225, 54),
(156, 21, NULL, 'Unit Data Administration - Modification of an attribute of an end-user - 2015-02-10T10:31:23+00:00', NULL, b'1', 36, 52),
(160, 41, '01889', 'CN-01889 - Suivi ICT Février 2015', '', b'1', 0, 147),
(167, 34, 'RSO', 'Airbus - Bundle Tools', '', b'0', NULL, 82),
(168, 34, 'AVV', 'Airbus - Bundle Tools - pré BOR2', '', b'1', 0, 167),
(169, 43, NULL, 'Airbus Helicopters - Projet S400 - déploiement SSO', NULL, b'1', NULL, NULL),
(175, 34, 'AVV', 'SANOFI DAI : Déploiement PROMISE - Proposition V3', '', b'1', 0, 83),
(176, 18, 'BU', 'Support Fonctionnel', '', b'1', 0, 37),
(177, 44, NULL, 'Total - TMA ITSM - Support ITSM', NULL, b'0', NULL, NULL),
(178, 45, NULL, 'Total - TMA ITSM - Support BO', NULL, b'0', NULL, NULL),
(179, 46, NULL, 'Total - TMA ITSM - Gestion des problèmes', NULL, b'0', NULL, NULL),
(180, 47, NULL, 'Total - TMA ITSM - Chef de Projet technique', NULL, b'0', NULL, NULL),
(181, 48, NULL, 'Total - TMA ITSM - Transfert', NULL, b'0', NULL, NULL),
(182, 49, NULL, 'Total - TMA ITSM - Gouvernance', NULL, b'0', NULL, NULL),
(183, 50, NULL, 'Bundle Tools - ITSM - WP1', NULL, b'1', NULL, NULL),
(184, 51, NULL, 'Incidents - Bundle Tools - BI', NULL, b'1', NULL, NULL),
(185, 52, NULL, 'Incidents - Bundle Tools - NTIC', NULL, b'1', NULL, NULL),
(186, 53, NULL, 'Bundle Tools - ITSM - WP3', NULL, b'1', NULL, NULL),
(187, 54, NULL, 'TOP - Bundle Tools - BI', NULL, b'1', NULL, NULL),
(188, 55, NULL, 'TOP - Bundle Tools - NTIC', NULL, b'1', NULL, NULL),
(189, 56, '', 'CEA - DAM - Train de maintenance évolutive n° 02', '', b'1', 5354.34, NULL),
(195, 34, 'BUIET', 'LVMH - Les Échos - Patch Management', '', b'0', NULL, 82),
(196, 34, 'AVV', 'LVMH - Les Échos - Patch Management - Contribution V1', '', b'1', 0, 195),
(197, 57, NULL, 'AIRBUS - ITSM - ARTS V2', NULL, b'0', NULL, NULL),
(198, 58, NULL, 'Semaphore RUN', NULL, b'1', 4490.81, NULL),
(199, 59, NULL, 'ITSM TOOL RUN', NULL, b'1', NULL, NULL),
(200, 60, NULL, 'Semaphore Projets', NULL, b'1', 17788.09, NULL),
(201, 61, NULL, 'ITSM TOOL Projets', NULL, b'1', 80615.175, NULL),
(202, 44, '', 'Total - TMA ITSM - Support ITSM - 02/2015', '', b'1', 30921, 177),
(203, 44, '', 'Total - TMA ITSM - Support ITSM - 03/2015', '', b'1', 30921, 177),
(204, 46, '', 'Total - TMA ITSM - Gestion des problèmes - 02/2015', '', b'1', 4800, 179),
(205, 46, '', 'Total - TMA ITSM - Gestion des problèmes - 03/2015', '', b'1', 4800, 179),
(206, 45, '', 'Total - TMA ITSM - Support BO - 02/2015', '', b'1', 3758, 178),
(207, 45, '', 'Total - TMA ITSM - Support BO - 03/2015', '', b'1', 3758, 178),
(208, 48, '', 'Total - TMA ITSM - Transfert - Pilotage', '', b'1', 0, 181),
(209, 48, '', 'Total - TMA ITSM - Transfert - RO', '', b'1', 0, 181),
(210, 48, '', 'Total - TMA ITSM - Transfert - MCO', '', b'1', 0, 181),
(211, 34, 'RGSE', 'Orange - PEO', '', b'0', NULL, 82),
(212, 34, 'AVV', 'Orange - PEO - accompagnement amont', '', b'1', 0, 211),
(213, 31, '', 'CEA - DAM - VSR SM9 Q1 2015', '', b'1', 0, 79),
(214, 31, '', 'CEA - DAM - CESTA - TMA - Corrective -SM7 Q1 2015', '', b'1', 0, 79),
(215, 49, '', 'Total - TMA ITSM - Gouvernance - 02/2015', '', b'1', 0, 182),
(216, 49, '', 'Total - TMA ITSM - Gouvernance - 03/2015', '', b'1', 0, 182),
(217, 34, 'DVTBE', 'GDF SUEZ - .Net Centre', '', b'0', NULL, 82),
(218, 34, 'AVV', 'GDF SUEZ - .Net Centre - Faisabilité', '', b'1', 0, 217),
(219, 34, 'AVV', 'SANOFI DAI : Déploiement PROMISE - visite client', '', b'1', 0, 83),
(220, 21, NULL, 'Mass Data Administration - 2015-03-03T18:20:39+00:00', NULL, b'1', 337.5, 53),
(221, 44, '', 'Total - TMA ITSM - Support ITSM - 04/2015', '', b'1', 30921, 177),
(222, 44, '', 'Total - TMA ITSM - Support ITSM - 05/2015', '', b'1', 30921, 177),
(223, 44, '', 'Total - TMA ITSM - Support ITSM - 06/2015', '', b'1', 30921, 177),
(224, 44, '', 'Total - TMA ITSM - Support ITSM - 07/2015', '', b'1', 30921, 177),
(225, 44, '', 'Total - TMA ITSM - Support ITSM - 08/2015', '', b'1', 30921, 177),
(226, 44, '', 'Total - TMA ITSM - Support ITSM - 09/2015', '', b'1', 30921, 177),
(227, 44, '', 'Total - TMA ITSM - Support ITSM - 10/2015', '', b'1', 30921, 177),
(228, 44, '', 'Total - TMA ITSM - Support ITSM - 11/2015', '', b'1', 30921, 177),
(229, 44, '', 'Total - TMA ITSM - Support ITSM - 12/2015', '', b'1', 30921, 177),
(230, 45, '', 'Total - TMA ITSM - Support BO - 04/2015', '', b'1', 3758, 178),
(231, 45, '', 'Total - TMA ITSM - Support BO - 05/2015', '', b'1', 3758, 178),
(232, 45, '', 'Total - TMA ITSM - Support BO - 06/2015', '', b'1', 3758, 178),
(233, 47, '', 'Total - TMA ITSM - CdP Technique - 02/2015', '', b'1', 2592, 180),
(234, 47, '', 'Total - TMA ITSM - CdP Technique - 03/2015', '', b'1', 2592, 180),
(235, 47, '', 'Total - TMA ITSM - CdP Technique - 04/2015', '', b'1', 2592, 180),
(236, 47, '', 'Total - TMA ITSM - CdP Technique - 05/2015', '', b'1', 2592, 180),
(237, 47, '', 'Total - TMA ITSM - CdP Technique - 06/2015', '', b'1', 2592, 180),
(238, 47, '', 'Total - TMA ITSM - CdP Technique - 07/2015', '', b'1', 2592, 180),
(239, 47, '', 'Total - TMA ITSM - CdP Technique - 08/2015', '', b'1', 2592, 180),
(240, 47, '', 'Total - TMA ITSM - CdP Technique - 09/2015', '', b'1', 2592, 180),
(241, 47, '', 'Total - TMA ITSM - CdP Technique - 10/2015', '', b'1', 2592, 180),
(242, 47, '', 'Total - TMA ITSM - CdP Technique - 11/2015', '', b'1', 2592, 180),
(243, 47, '', 'Total - TMA ITSM - CdP Technique - 12/2015', '', b'1', 2592, 180),
(507, 26, NULL, 'CN-01070 (40j)', 'BI - CN Evolution', b'0', NULL, 71),
(508, 26, '', '_CN-01070 - Analyse (16j)', 'CN Analyse phase', b'1', 8525.6, 507),
(509, 26, '', '_CN-01070 - Dev (16j)', 'CN Dev phase', b'1', 8525.6, 507),
(510, 26, '', '_CN-01070 - Test (8j)', 'CN Test phase', b'1', 4262.8, 507),
(563, 62, NULL, 'CN-01930 (1.6j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(564, 62, NULL, '_CN-01930 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 563),
(565, 62, NULL, '_CN-01930 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 563),
(566, 62, NULL, '_CN-01930 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 563),
(567, 62, NULL, '_CN-01930 - ARA (0.3j)', 'CN ARA', b'1', 159, 563),
(572, 65, NULL, 'CN-01917 (5.6j)', 'I4U - CN Evolution', b'0', NULL, 900),
(573, 65, NULL, '_CN-01917 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 572),
(574, 65, NULL, '_CN-01917 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 572),
(575, 65, NULL, '_CN-01917 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 572),
(576, 65, NULL, 'CN-01916 (2.8j)', 'I4U - CN Evolution', b'0', NULL, 900),
(577, 65, NULL, '_CN-01916 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 576),
(578, 65, NULL, '_CN-01916 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 576),
(579, 65, NULL, '_CN-01916 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 576),
(580, 62, NULL, 'CN-01899 (0.8j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(581, 62, NULL, '_CN-01899 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 580),
(582, 62, NULL, '_CN-01899 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 580),
(583, 62, NULL, '_CN-01899 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 580),
(584, 62, NULL, '_CN-01899 - ARA (0.15j)', 'CN ARA', b'1', 79.5, 580),
(585, 62, NULL, 'CN-01897 (28j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(586, 62, NULL, '_CN-01897 - Analyse (11.2j)', 'CN Analyse phase', b'1', 4932.2, 585),
(587, 62, NULL, '_CN-01897 - Dev (11.2j)', 'CN Dev phase', b'1', 4932.2, 585),
(588, 62, NULL, '_CN-01897 - Test (5.6j)', 'CN Test phase', b'1', 2466.24, 585),
(589, 62, NULL, '_CN-01897 - ARA (5.25j)', 'CN ARA', b'1', 2782.5, 585),
(590, 39, NULL, 'CN-01892 (0.8j)', 'AAL - CN Evolution', b'0', NULL, 145),
(591, 39, NULL, '_CN-01892 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 590),
(592, 39, NULL, '_CN-01892 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 590),
(593, 39, NULL, '_CN-01892 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 590),
(594, 40, NULL, 'CN-01891 (0j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(595, 40, NULL, '_CN-01891 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 594),
(596, 40, NULL, '_CN-01891 - Dev (0j)', 'CN Dev phase', b'1', NULL, 594),
(597, 40, NULL, '_CN-01891 - Test (0j)', 'CN Test phase', b'1', NULL, 594),
(598, 62, NULL, 'CN-01888 (0.8j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(599, 62, NULL, '_CN-01888 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 598),
(600, 62, NULL, '_CN-01888 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 598),
(601, 62, NULL, '_CN-01888 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 598),
(602, 62, NULL, '_CN-01888 - ARA (0.15j)', 'CN ARA', b'1', 79.5, 598),
(603, 62, NULL, 'CN-01887 (2.4j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(604, 62, NULL, '_CN-01887 - Analyse (0.96j)', 'CN Analyse phase', b'1', 422.76, 603),
(605, 62, NULL, '_CN-01887 - Dev (0.96j)', 'CN Dev phase', b'1', 422.76, 603),
(606, 62, NULL, '_CN-01887 - Test (0.48j)', 'CN Test phase', b'1', 211.392, 603),
(607, 62, NULL, '_CN-01887 - ARA (0.45j)', 'CN ARA', b'1', 238.5, 603),
(608, 62, NULL, 'CN-01886 (1.6j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(609, 62, NULL, '_CN-01886 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 608),
(610, 62, NULL, '_CN-01886 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 608),
(611, 62, NULL, '_CN-01886 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 608),
(612, 62, NULL, '_CN-01886 - ARA (0.3j)', 'CN ARA', b'1', 159, 608),
(613, 62, NULL, 'CN-01885 (2j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(614, 62, NULL, '_CN-01885 - Analyse (0.8j)', 'CN Analyse phase', b'1', 352.3, 613),
(615, 62, NULL, '_CN-01885 - Dev (0.8j)', 'CN Dev phase', b'1', 352.3, 613),
(616, 62, NULL, '_CN-01885 - Test (0.4j)', 'CN Test phase', b'1', 176.16, 613),
(617, 62, NULL, '_CN-01885 - ARA (0.375j)', 'CN ARA', b'1', 198.75, 613),
(618, 61, NULL, 'CN-01881 (11j)', 'REMEDY_SAD - CN Study ', b'1', 9147.6, 201),
(619, 40, NULL, 'CN-01880 (1.6j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(620, 40, NULL, '_CN-01880 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 619),
(621, 40, NULL, '_CN-01880 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 619),
(622, 40, NULL, '_CN-01880 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 619),
(623, 40, NULL, 'CN-01879 (5.6j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(624, 40, NULL, '_CN-01879 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 623),
(625, 40, NULL, '_CN-01879 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 623),
(626, 40, NULL, '_CN-01879 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 623),
(627, 0, NULL, 'CN-01871 (7.2j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(628, 0, NULL, '_CN-01871 - Analyse (2.88j)', 'CN Analyse phase', b'1', 1268.28, 627),
(629, 0, NULL, '_CN-01871 - Dev (2.88j)', 'CN Dev phase', b'1', 1268.28, 627),
(630, 0, NULL, '_CN-01871 - Test (1.44j)', 'CN Test phase', b'1', 634.176, 627),
(631, 40, NULL, 'CN-01869 (8.8j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(632, 40, NULL, '_CN-01869 - Analyse (3.52j)', 'CN Analyse phase', b'1', 1550.12, 631),
(633, 40, NULL, '_CN-01869 - Dev (3.52j)', 'CN Dev phase', b'1', 1550.12, 631),
(634, 40, NULL, '_CN-01869 - Test (1.76j)', 'CN Test phase', b'1', 775.104, 631),
(635, 40, NULL, 'CN-01868 (5.6j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(636, 40, NULL, '_CN-01868 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 635),
(637, 40, NULL, '_CN-01868 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 635),
(638, 40, NULL, '_CN-01868 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 635),
(639, 68, NULL, 'CN-01866 (14.4j)', 'MASTERPLAN - CN Evolution', b'0', NULL, 946),
(640, 68, NULL, '_CN-01866 - Analyse (5.76j)', 'CN Analyse phase', b'1', 2536.56, 639),
(641, 68, NULL, '_CN-01866 - Dev (5.76j)', 'CN Dev phase', b'1', 2536.56, 639),
(642, 68, NULL, '_CN-01866 - Test (2.88j)', 'CN Test phase', b'1', 1268.352, 639),
(653, 38, '', 'CN-01856 (8j)', 'ETICKET - CN Study', b'1', 4262, 143),
(664, 39, NULL, 'CN-01852 (1.6j)', 'AAL - CN Evolution', b'0', NULL, 145),
(665, 39, NULL, '_CN-01852 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 664),
(666, 39, NULL, '_CN-01852 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 664),
(667, 39, NULL, '_CN-01852 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 664),
(668, 37, NULL, 'CN-01849 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(669, 37, NULL, '_CN-01849 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 668),
(670, 37, NULL, '_CN-01849 - Dev (1.54j)', 'CN Dev phase', b'1', 676.416, 668),
(671, 37, NULL, '_CN-01849 - Test (0.77j)', 'CN Test phase', b'1', 338.2272, 668),
(672, 37, NULL, '_CN-01849 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 668),
(673, 40, NULL, 'CN-01848 (5.6j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(674, 40, NULL, '_CN-01848 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 673),
(675, 40, NULL, '_CN-01848 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 673),
(676, 40, NULL, '_CN-01848 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 673),
(677, 39, NULL, 'CN-01845 (1.2j)', 'AAL - CN Evolution', b'0', NULL, 145),
(678, 39, NULL, '_CN-01845 - Analyse (0.48j)', 'CN Analyse phase', b'1', 211.38, 677),
(679, 39, NULL, '_CN-01845 - Dev (0.48j)', 'CN Dev phase', b'1', 211.38, 677),
(680, 39, NULL, '_CN-01845 - Test (0.24j)', 'CN Test phase', b'1', 105.696, 677),
(681, 0, NULL, 'CN-01837 (2j)', 'PWINIT - CN Study ', b'1', 1080, NULL),
(682, 39, NULL, 'CN-01828 (1.6j)', 'AAL - CN Evolution', b'0', NULL, 145),
(683, 39, NULL, '_CN-01828 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 682),
(684, 39, NULL, '_CN-01828 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 682),
(685, 39, NULL, '_CN-01828 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 682),
(694, 0, NULL, 'CN-01821 (15j)', 'AFROM - CN Study ', b'1', 8100, NULL),
(695, 61, NULL, 'CN-01812 (22.4j)', 'REMEDY_SAD - CN Evolution', b'0', NULL, 201),
(696, 61, NULL, '_CN-01812 - Analyse (8.96j)', 'CN Analyse phase', b'1', 4774.336, 695),
(697, 61, NULL, '_CN-01812 - Dev (8.96j)', 'CN Dev phase', b'1', 4774.336, 695),
(698, 61, NULL, '_CN-01812 - Test (4.48j)', 'CN Test phase', b'1', 2387.168, 695),
(699, 0, NULL, 'CN-01811 (72.5j)', 'AML - CN Study ', b'1', 39150, NULL),
(700, 37, NULL, 'CN-01809 (21j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(701, 37, NULL, '_CN-01809 - Analyse (8.4j)', 'CN Analyse phase', b'1', 3699.15, 700),
(702, 37, NULL, '_CN-01809 - Dev (8.4j)', 'CN Dev phase', b'1', 3699.15, 700),
(703, 37, NULL, '_CN-01809 - Test (4.2j)', 'CN Test phase', b'1', 1849.68, 700),
(704, 37, NULL, '_CN-01809 - ARA (3.9375j)', 'CN ARA', b'1', 2086.875, 700),
(705, 39, NULL, 'CN-01801 (8.4j)', 'AAL - CN Evolution', b'0', NULL, 145),
(706, 39, NULL, '_CN-01801 - Analyse (3.36j)', 'CN Analyse phase', b'1', 1479.66, 705),
(707, 39, NULL, '_CN-01801 - Dev (3.36j)', 'CN Dev phase', b'1', 1479.66, 705),
(708, 39, NULL, '_CN-01801 - Test (1.68j)', 'CN Test phase', b'1', 739.872, 705),
(709, 0, NULL, 'CN-01800 (2j)', 'ETICKET - CN Study ', b'1', 1080, NULL),
(710, 0, NULL, 'CN-01794 (0j)', 'ICT CATALOGS - CN Study ', b'1', NULL, NULL),
(711, 0, NULL, 'CN-01787 (50.5j)', 'AML - CN Evolution', b'0', NULL, NULL),
(712, 0, NULL, '_CN-01787 - Analyse (20.2j)', 'CN Analyse phase', b'1', 8895.575, 711),
(713, 0, NULL, '_CN-01787 - Dev (20.2j)', 'CN Dev phase', b'1', 8895.575, 711),
(714, 0, NULL, '_CN-01787 - Test (10.1j)', 'CN Test phase', b'1', 4448.04, 711),
(715, 63, NULL, 'CN-01780 (22.8j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(716, 63, NULL, '_CN-01780 - Analyse (9.12j)', 'CN Analyse phase', b'1', 4016.22, 715),
(717, 63, NULL, '_CN-01780 - Dev (9.12j)', 'CN Dev phase', b'1', 4016.22, 715),
(718, 63, NULL, '_CN-01780 - Test (4.56j)', 'CN Test phase', b'1', 2008.224, 715),
(719, 63, NULL, '_CN-01780 - ARA (4.275j)', 'CN ARA', b'1', 2265.75, 715),
(720, 0, NULL, 'CN-01779 (33.6j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(721, 0, NULL, '_CN-01779 - Analyse (13.44j)', 'CN Analyse phase', b'1', 5918.64, 720),
(722, 0, NULL, '_CN-01779 - Dev (13.44j)', 'CN Dev phase', b'1', 5918.64, 720),
(723, 0, NULL, '_CN-01779 - Test (6.72j)', 'CN Test phase', b'1', 2959.488, 720),
(724, 0, NULL, '_CN-01779 - ARA (6.3j)', 'CN ARA', b'1', 3339, 720),
(725, 0, NULL, 'CN-01770 (3.2j)', 'ICT CATALOGS - CN Study ', b'1', 1728, NULL),
(726, 0, NULL, 'CN-01765 (14.8j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(727, 0, NULL, '_CN-01765 - Analyse (5.92j)', 'CN Analyse phase', b'1', 2607.02, 726),
(728, 0, NULL, '_CN-01765 - Dev (5.92j)', 'CN Dev phase', b'1', 2607.02, 726),
(729, 0, NULL, '_CN-01765 - Test (2.96j)', 'CN Test phase', b'1', 1303.584, 726),
(730, 0, NULL, '_CN-01765 - ARA (2.775j)', 'CN ARA', b'1', 1470.75, 726),
(731, 68, NULL, 'CN-01764 (32j)', 'MASTERPLAN - CN Evolution', b'0', NULL, 946),
(732, 68, NULL, '_CN-01764 - Analyse (12.8j)', 'CN Analyse phase', b'1', 5636.8, 731),
(733, 68, NULL, '_CN-01764 - Dev (12.8j)', 'CN Dev phase', b'1', 5636.8, 731),
(734, 68, NULL, '_CN-01764 - Test (6.4j)', 'CN Test phase', b'1', 2818.56, 731),
(735, 0, NULL, 'CN-01758 (4j)', 'ICT CATALOGS - CN Study ', b'1', 2160, NULL),
(736, 0, NULL, 'CN-01750 (12.9j)', 'ICT CATALOGS - CN Study ', b'1', 6966, NULL),
(737, 0, NULL, 'CN-01746 (12j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(738, 0, NULL, '_CN-01746 - Analyse (4.8j)', 'CN Analyse phase', b'1', 2113.8, 737),
(739, 0, NULL, '_CN-01746 - Dev (4.8j)', 'CN Dev phase', b'1', 2113.8, 737),
(740, 0, NULL, '_CN-01746 - Test (2.4j)', 'CN Test phase', b'1', 1056.96, 737),
(741, 0, NULL, '_CN-01746 - ARA (2.25j)', 'CN ARA', b'1', 1192.5, 737),
(742, 0, NULL, 'CN-01736 (11.6j)', 'ICT CATALOGS - CN Study ', b'1', 6264, NULL),
(743, 0, NULL, 'CN-01735 (7.2j)', 'ICT CATALOGS - CN Study ', b'1', 3888, NULL),
(744, 0, NULL, 'CN-01710 (5j)', 'ETICKET - CN Study ', b'1', 2700, NULL),
(745, 38, NULL, 'CN-01703 (6.4j)', 'PWINIT - CN Evolution', b'0', NULL, 143),
(746, 38, '', '_CN-01703 - Analyse (2.56j)', 'CN Analyse phase', b'1', 1364, 745),
(747, 38, '', '_CN-01703 - Dev (2.56j)', 'CN Dev phase', b'1', 1364, 745),
(748, 38, '', '_CN-01703 - Test (1.28j)', 'CN Test phase', b'1', 682, 745),
(749, 0, NULL, 'CN-01700 (20.8j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(750, 0, NULL, '_CN-01700 - Analyse (8.32j)', 'CN Analyse phase', b'1', 3663.92, 749),
(751, 0, NULL, '_CN-01700 - Dev (8.32j)', 'CN Dev phase', b'1', 3663.92, 749),
(752, 0, NULL, '_CN-01700 - Test (4.16j)', 'CN Test phase', b'1', 1832.064, 749),
(753, 0, NULL, 'CN-01699 (2.5j)', 'MASTERPLAN - CN Study ', b'1', 1350, NULL),
(754, 0, NULL, 'CN-01696 (4j)', 'ATREF - CN Study ', b'1', 2160, NULL),
(755, 0, NULL, 'CN-01688 (60j)', 'AML - CN Study ', b'1', 32400, NULL),
(756, 61, NULL, 'CN-01659 (50.9j)', 'REMEDY_SAD - CN Evolution', b'0', NULL, 201),
(757, 61, NULL, '_CN-01659 - Analyse (20.36j)', 'CN Analyse phase', b'1', 10848.826, 756),
(758, 61, NULL, '_CN-01659 - Dev (20.36j)', 'CN Dev phase', b'1', 10848.826, 756),
(759, 61, NULL, '_CN-01659 - Test (10.18j)', 'CN Test phase', b'1', 5424.413, 756),
(760, 0, NULL, 'CN-01622 (12.4j)', 'ICT CATALOGS - CN Study ', b'1', 6696, NULL),
(761, 0, NULL, 'CN-01620 (0j)', 'ICT CATALOGS - CN Study ', b'1', NULL, NULL),
(762, 37, NULL, 'CN-01618 (87j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(763, 37, NULL, '_CN-01618 - Analyse (34.8j)', 'CN Analyse phase', b'1', 15325.05, 762),
(764, 37, NULL, '_CN-01618 - Dev (34.8j)', 'CN Dev phase', b'1', 15325.05, 762),
(765, 37, NULL, '_CN-01618 - Test (17.4j)', 'CN Test phase', b'1', 7662.96, 762),
(766, 37, NULL, '_CN-01618 - ARA (16.3125j)', 'CN ARA', b'1', 8645.625, 762),
(767, 0, NULL, 'CN-01592 (2.5j)', 'ETICKET - CN Study ', b'1', 1350, NULL),
(768, 0, NULL, 'CN-01590 (2.5j)', 'ETICKET - CN Study ', b'1', 1350, NULL),
(769, 0, NULL, 'CN-01589 (4.8j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(770, 0, NULL, '_CN-01589 - Analyse (1.92j)', 'CN Analyse phase', b'1', 845.52, 769),
(771, 0, NULL, '_CN-01589 - Dev (1.92j)', 'CN Dev phase', b'1', 845.52, 769),
(772, 0, NULL, '_CN-01589 - Test (0.96j)', 'CN Test phase', b'1', 422.784, 769),
(773, 0, NULL, 'CN-01583 (5.5j)', 'AML - CN Evolution', b'0', NULL, NULL),
(774, 0, NULL, '_CN-01583 - Analyse (2.2j)', 'CN Analyse phase', b'1', 968.825, 773),
(775, 0, NULL, '_CN-01583 - Dev (2.2j)', 'CN Dev phase', b'1', 968.825, 773),
(776, 0, NULL, '_CN-01583 - Test (1.1j)', 'CN Test phase', b'1', 484.44, 773),
(777, 0, NULL, 'CN-01559 (5j)', 'ETICKET - CN Study ', b'1', 2700, NULL),
(778, 0, NULL, 'CN-01555 (144.4j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(779, 0, NULL, '_CN-01555 - Analyse (57.76j)', 'CN Analyse phase', b'1', 25436.06, 778),
(780, 0, NULL, '_CN-01555 - Dev (57.76j)', 'CN Dev phase', b'1', 25436.06, 778),
(781, 0, NULL, '_CN-01555 - Test (28.88j)', 'CN Test phase', b'1', 12718.752, 778),
(782, 0, NULL, 'CN-01544 (12.75j)', 'PC BACKUP - CN Evolution', b'0', NULL, NULL),
(783, 0, NULL, '_CN-01544 - Analyse (5.1j)', 'CN Analyse phase', b'1', 2245.9125, 782),
(784, 0, NULL, '_CN-01544 - Dev (5.1j)', 'CN Dev phase', b'1', 2245.9125, 782),
(785, 0, NULL, '_CN-01544 - Test (2.55j)', 'CN Test phase', b'1', 1123.02, 782),
(786, 0, NULL, 'CN-01535 (26.125j)', 'AML - CN Evolution', b'0', NULL, NULL),
(787, 0, NULL, '_CN-01535 - Analyse (10.45j)', 'CN Analyse phase', b'1', 4601.91875, 786),
(788, 0, NULL, '_CN-01535 - Dev (10.45j)', 'CN Dev phase', b'1', 4601.91875, 786),
(789, 0, NULL, '_CN-01535 - Test (5.23j)', 'CN Test phase', b'1', 2301.09, 786),
(790, 0, NULL, 'CN-01170 (4j)', 'PWINIT - CN Study ', b'1', 2160, NULL),
(791, 0, NULL, 'CN-00737 (0.75j)', 'DROP - CN Evolution', b'0', NULL, NULL),
(792, 0, NULL, '_CN-00737 - Analyse (0.3j)', 'CN Analyse phase', b'1', 132.1125, 791),
(793, 0, NULL, '_CN-00737 - Dev (0.3j)', 'CN Dev phase', b'1', 132.1125, 791),
(794, 0, NULL, '_CN-00737 - Test (0.15j)', 'CN Test phase', b'1', 66.06, 791),
(795, 36, '', 'CN-01088 (2.5j)', 'BI - CN Study', b'1', 2079, 141),
(796, 38, NULL, 'CN-01086 (67.2j)', 'BI - CN Evolution', b'0', NULL, 143),
(797, 38, NULL, '_CN-01086 - Analyse (26.88j)', 'CN Analyse phase', b'1', 14323.008, 796),
(798, 38, NULL, '_CN-01086 - Dev (26.88j)', 'CN Dev phase', b'1', 14323.008, 796),
(799, 38, NULL, '_CN-01086 - Test (13.44j)', 'CN Test phase', b'1', 7161.504, 796),
(800, 36, NULL, 'CN-01082 (11.25j)', 'BI - CN Evolution', b'0', NULL, 141),
(801, 36, NULL, '_CN-01082 - Analyse (4.5j)', 'CN Analyse phase', b'1', 2397.825, 800),
(802, 36, NULL, '_CN-01082 - Dev (4.5j)', 'CN Dev phase', b'1', 2397.825, 800),
(803, 36, NULL, '_CN-01082 - Test (2.25j)', 'CN Test phase', b'1', 1198.9125, 800),
(804, 60, NULL, 'CN-01081 (29j)', 'SEMAPHORE - CN Study ', b'1', 24116.4, 200),
(805, 38, NULL, 'CN-01080 (19.2j)', 'BI - CN Evolution', b'0', NULL, 143),
(806, 38, NULL, '_CN-01080 - Analyse (7.68j)', 'CN Analyse phase', b'1', 4092.288, 805),
(807, 38, NULL, '_CN-01080 - Dev (7.68j)', 'CN Dev phase', b'1', 4092.288, 805),
(808, 38, NULL, '_CN-01080 - Test (3.84j)', 'CN Test phase', b'1', 2046.144, 805),
(809, 38, NULL, 'CN-01078 (4.8j)', 'BI - CN Evolution', b'0', NULL, 143),
(810, 38, NULL, '_CN-01078 - Analyse (1.92j)', 'CN Analyse phase', b'1', 1023.072, 809),
(811, 38, NULL, '_CN-01078 - Dev (1.92j)', 'CN Dev phase', b'1', 1023.072, 809),
(812, 38, NULL, '_CN-01078 - Test (0.96j)', 'CN Test phase', b'1', 511.536, 809),
(817, 38, NULL, 'CN-01072 (29.625j)', 'BI - CN Evolution', b'0', NULL, 143),
(818, 38, NULL, '_CN-01072 - Analyse (11.85j)', 'CN Analyse phase', b'1', 6314.2725, 817),
(819, 38, NULL, '_CN-01072 - Dev (11.85j)', 'CN Dev phase', b'1', 6314.2725, 817),
(820, 38, NULL, '_CN-01072 - Test (5.93j)', 'CN Test phase', b'1', 3157.13625, 817),
(821, 60, NULL, 'CN-01069 (30j)', 'SEMAPHORE - CN Study ', b'1', 24948, 200),
(822, 60, NULL, 'CN-01068 (25j)', 'SEMAPHORE - CN Study ', b'1', 20790, 200),
(823, 58, NULL, 'CN-01067 (12.8j)', 'SEMAPHORE - CN Evolution', b'0', NULL, 198),
(824, 58, NULL, '_CN-01067 - Analyse (5.12j)', 'CN Analyse phase', b'1', 2728.192, 823),
(825, 58, NULL, '_CN-01067 - Dev (5.12j)', 'CN Dev phase', b'1', 2728.192, 823),
(826, 58, NULL, '_CN-01067 - Test (2.56j)', 'CN Test phase', b'1', 1364.096, 823),
(831, 58, NULL, 'CN-01063 (35j)', 'SEMAPHORE - CN Study ', b'1', 29106, 198),
(832, 38, NULL, 'CN-01062 (16j)', 'BI - CN Evolution', b'0', NULL, 143),
(833, 38, NULL, '_CN-01062 - Analyse (6.4j)', 'CN Analyse phase', b'1', 3410.24, 832),
(834, 38, NULL, '_CN-01062 - Dev (6.4j)', 'CN Dev phase', b'1', 3410.24, 832),
(835, 38, NULL, '_CN-01062 - Test (3.2j)', 'CN Test phase', b'1', 1705.12, 832),
(836, 60, NULL, 'CN-01061 (24j)', 'SEMAPHORE - CN Study ', b'1', 19958.4, 200),
(841, 38, NULL, 'CN-01058 (24j)', 'BI - CN Evolution', b'0', NULL, 143),
(842, 38, NULL, '_CN-01058 - Analyse (9.6j)', 'CN Analyse phase', b'1', 5115.36, 841),
(843, 38, NULL, '_CN-01058 - Dev (9.6j)', 'CN Dev phase', b'1', 5115.36, 841),
(844, 38, NULL, '_CN-01058 - Test (4.8j)', 'CN Test phase', b'1', 2557.68, 841),
(845, 60, NULL, 'CN-01054 (3.2j)', 'SEMAPHORE - CN Evolution', b'0', NULL, 200),
(846, 60, NULL, '_CN-01054 - Analyse (1.28j)', 'CN Analyse phase', b'1', 682.048, 845),
(847, 60, NULL, '_CN-01054 - Dev (1.28j)', 'CN Dev phase', b'1', 682.048, 845),
(848, 60, NULL, '_CN-01054 - Test (0.64j)', 'CN Test phase', b'1', 341.024, 845),
(849, 60, NULL, 'CN-01051 (11.2j)', 'SEMAPHORE - CN Evolution', b'0', NULL, 200),
(850, 60, NULL, '_CN-01051 - Analyse (4.48j)', 'CN Analyse phase', b'1', 2387.168, 849),
(851, 60, NULL, '_CN-01051 - Dev (4.48j)', 'CN Dev phase', b'1', 2387.168, 849),
(852, 60, NULL, '_CN-01051 - Test (2.24j)', 'CN Test phase', b'1', 1193.584, 849),
(872, 18, 'BU', 'Management', '', b'1', 0, 37),
(873, 64, NULL, 'CN-01918 (12.75j)', 'AML - CN Evolution', b'0', NULL, 899),
(874, 64, NULL, '_CN-01918 - Analyse (5.1j)', 'CN Analyse phase', b'1', 2245.9125, 873),
(875, 64, NULL, '_CN-01918 - Dev (5.1j)', 'CN Dev phase', b'1', 2245.9125, 873),
(876, 64, NULL, '_CN-01918 - Test (2.55j)', 'CN Test phase', b'1', 1123.02, 873),
(877, 0, NULL, 'CN-01914 (0.375j)', 'PC BACKUP - CN Evolution', b'0', NULL, NULL),
(878, 0, NULL, '_CN-01914 - Analyse (0.15j)', 'CN Analyse phase', b'1', 66.05625, 877),
(879, 0, NULL, '_CN-01914 - Dev (0.15j)', 'CN Dev phase', b'1', 66.05625, 877),
(880, 0, NULL, '_CN-01914 - Test (0.08j)', 'CN Test phase', b'1', 33.03, 877),
(881, 39, NULL, 'CN-01858 (4j)', 'AAL - CN Evolution', b'0', NULL, 145),
(882, 39, NULL, '_CN-01858 - Analyse (1.6j)', 'CN Analyse phase', b'1', 704.6, 881),
(883, 39, NULL, '_CN-01858 - Dev (1.6j)', 'CN Dev phase', b'1', 704.6, 881),
(884, 39, NULL, '_CN-01858 - Test (0.8j)', 'CN Test phase', b'1', 352.32, 881),
(885, 81, NULL, 'CN-01827 (36.4j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(886, 81, NULL, '_CN-01827 - Analyse (14.56j)', 'CN Analyse phase', b'1', 6411.86, 885),
(887, 81, NULL, '_CN-01827 - Dev (14.56j)', 'CN Dev phase', b'1', 6411.86, 885),
(888, 81, NULL, '_CN-01827 - Test (7.28j)', 'CN Test phase', b'1', 3206.112, 885),
(889, 81, NULL, 'CN-01825 (14j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(890, 81, NULL, '_CN-01825 - Analyse (5.6j)', 'CN Analyse phase', b'1', 2466.1, 889),
(891, 81, NULL, '_CN-01825 - Dev (5.6j)', 'CN Dev phase', b'1', 2466.1, 889),
(892, 81, NULL, '_CN-01825 - Test (2.8j)', 'CN Test phase', b'1', 1233.12, 889),
(893, 39, NULL, 'CN-01807 (11.2j)', 'AAL - CN Evolution', b'0', NULL, 145),
(894, 39, NULL, '_CN-01807 - Analyse (4.48j)', 'CN Analyse phase', b'1', 1972.88, 893),
(895, 39, NULL, '_CN-01807 - Dev (4.48j)', 'CN Dev phase', b'1', 1972.88, 893),
(896, 39, NULL, '_CN-01807 - Test (2.24j)', 'CN Test phase', b'1', 986.496, 893),
(897, 62, '', 'ASPIRE V1.14', '', b'0', 20078.885999999988, NULL),
(898, 63, '', 'ASPIRE V1.15', '', b'0', 41884.98799999998, NULL),
(899, 64, NULL, 'AML V2.4.9', NULL, b'1', 11064.547499999999, NULL),
(900, 65, NULL, 'I4U V1.2', NULL, b'1', 3699.192, NULL),
(901, 66, NULL, 'MASTER PLAN 2.1', NULL, b'1', 8455.296, NULL),
(902, 34, 'RGSO', 'Airbus - Bundle Tools - INUY', '', b'0', NULL, 82),
(903, 34, 'AVV', 'Airbus - Bundle Tools - INUY - Frame', '', b'1', 0, 902),
(904, 34, 'AVV', 'Airbus - Bundle Tools - INUY - CMS V3', '', b'1', 0, 902),
(905, 34, 'AVV', 'Airbus - Bundle Tools - INUY - Lean Ticketing', '', b'1', 0, 902),
(906, 57, '', 'Project Initialization', '', b'0', NULL, 197),
(907, 57, '', 'KickOff Meeting', '', b'1', 0, 906),
(908, 67, NULL, 'CN-01936 (15.6j)', 'ETICKET - CN Evolution', b'0', NULL, 945),
(909, 67, NULL, '_CN-01936 - Analyse (6.24j)', 'CN Analyse phase', b'1', 2747.94, 908),
(910, 67, NULL, '_CN-01936 - Dev (6.24j)', 'CN Dev phase', b'1', 2747.94, 908),
(911, 67, NULL, '_CN-01936 - Test (3.12j)', 'CN Test phase', b'1', 1374.048, 908),
(916, 81, NULL, 'CN-01825 (13.6j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(917, 81, NULL, '_CN-01825 - Analyse (5.44j)', 'CN Analyse phase', b'1', 2395.64, 916),
(918, 81, NULL, '_CN-01825 - Dev (5.44j)', 'CN Dev phase', b'1', 2395.64, 916),
(919, 81, NULL, '_CN-01825 - Test (2.72j)', 'CN Test phase', b'1', 1197.888, 916),
(920, 34, 'BUIET', 'MINEFI - TMA OGPS', '', b'0', NULL, 82),
(921, 34, 'AVV', 'MINEFI - TMA OGPS - Volet 3', '', b'1', 0, 920),
(922, 37, NULL, 'CN-01955 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(923, 37, NULL, '_CN-01955 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 922),
(924, 37, NULL, '_CN-01955 - Dev (1.54j)', 'CN Dev phase', b'1', 676.416, 922),
(925, 37, NULL, '_CN-01955 - Test (0.77j)', 'CN Test phase', b'1', 338.2272, 922),
(926, 37, NULL, '_CN-01955 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 922),
(927, 37, NULL, 'CN-01954 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(928, 37, NULL, '_CN-01954 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 927),
(929, 37, NULL, '_CN-01954 - Dev (1.54j)', 'CN Dev phase', b'1', 676.416, 927),
(930, 37, NULL, '_CN-01954 - Test (0.77j)', 'CN Test phase', b'1', 338.2272, 927),
(931, 37, NULL, '_CN-01954 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 927),
(932, 37, NULL, 'CN-01953 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(933, 37, NULL, '_CN-01953 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 932),
(934, 37, NULL, '_CN-01953 - Dev (1.54j)', 'CN Dev phase', b'1', 676.416, 932),
(935, 37, NULL, '_CN-01953 - Test (0.77j)', 'CN Test phase', b'1', 338.2272, 932),
(936, 37, NULL, '_CN-01953 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 932),
(937, 67, NULL, 'CN-01937 (2.8j)', 'ETICKET - CN Evolution', b'0', NULL, 945),
(938, 67, NULL, '_CN-01937 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 937),
(939, 67, NULL, '_CN-01937 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 937),
(940, 67, NULL, '_CN-01937 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 937),
(941, 40, NULL, 'CN-01870 (7.2j)', 'ATREF - CN Evolution', b'0', NULL, 146),
(942, 40, NULL, '_CN-01870 - Analyse (2.88j)', 'CN Analyse phase', b'1', 1268.28, 941),
(943, 40, NULL, '_CN-01870 - Dev (2.88j)', 'CN Dev phase', b'1', 1268.28, 941),
(944, 40, NULL, '_CN-01870 - Test (1.44j)', 'CN Test phase', b'1', 634.176, 941),
(945, 67, NULL, 'ETICKET V3.0', NULL, b'1', 13916.008, NULL),
(946, 68, '', 'MASTER PLAN 2.0', '', b'0', NULL, NULL),
(947, 37, NULL, 'CN-01920 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(948, 37, NULL, '_CN-01920 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 947),
(949, 37, NULL, '_CN-01920 - Dev (1.54j)', 'CN Dev phase', b'1', 676.416, 947),
(950, 37, NULL, '_CN-01920 - Test (0.77j)', 'CN Test phase', b'1', 338.2272, 947),
(951, 37, NULL, '_CN-01920 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 947),
(952, 37, NULL, 'CN-01919 (1.6j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(953, 37, NULL, '_CN-01919 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 952),
(954, 37, NULL, '_CN-01919 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 952),
(955, 37, NULL, '_CN-01919 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 952),
(956, 37, NULL, '_CN-01919 - ARA (0.3j)', 'CN ARA', b'1', 159, 952),
(957, 0, NULL, 'CN-01836 (2j)', 'ETICKET - CN Study ', b'1', 1080, NULL),
(958, 0, NULL, 'CN-01694 (39.2j)', 'AFROM - CN Evolution', b'0', NULL, NULL),
(959, 0, NULL, '_CN-01694 - Analyse (15.68j)', 'CN Analyse phase', b'1', 6905.08, 958),
(960, 0, NULL, '_CN-01694 - Dev (15.68j)', 'CN Dev phase', b'1', 6905.08, 958),
(961, 0, NULL, '_CN-01694 - Test (7.84j)', 'CN Test phase', b'1', 3452.736, 958),
(962, 0, NULL, 'CN-01633 (5j)', 'AFROM - CN Study ', b'1', 2700, NULL),
(963, 0, NULL, 'CN-01591 (1.2j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(964, 0, NULL, '_CN-01591 - Analyse (0.48j)', 'CN Analyse phase', b'1', 211.38, 963),
(965, 0, NULL, '_CN-01591 - Dev (0.48j)', 'CN Dev phase', b'1', 211.38, 963),
(966, 0, NULL, '_CN-01591 - Test (0.24j)', 'CN Test phase', b'1', 105.696, 963),
(967, 0, NULL, 'CN-01357 (2j)', 'AML - CN Study ', b'1', 1080, NULL),
(973, 0, NULL, 'CN-01935 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(974, 0, NULL, '_CN-01935 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 973),
(975, 0, NULL, '_CN-01935 - Dev (0j)', 'CN Dev phase', b'1', NULL, 973),
(976, 0, NULL, '_CN-01935 - Test (0j)', 'CN Test phase', b'1', NULL, 973),
(977, 0, NULL, '_CN-01935 - ARA (0j)', 'CN ARA', b'1', NULL, 973),
(978, 66, NULL, 'CN-01921 (19.2j)', 'MASTERPLAN - CN Evolution', b'0', NULL, 901),
(979, 66, NULL, '_CN-01921 - Analyse (7.68j)', 'CN Analyse phase', b'1', 3382.08, 978),
(980, 66, NULL, '_CN-01921 - Dev (7.68j)', 'CN Dev phase', b'1', 3382.08, 978),
(981, 66, NULL, '_CN-01921 - Test (3.84j)', 'CN Test phase', b'1', 1691.136, 978),
(982, 0, NULL, 'CN-01902 (8.4j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(983, 0, NULL, '_CN-01902 - Analyse (3.36j)', 'CN Analyse phase', b'1', 1479.66, 982),
(984, 0, NULL, '_CN-01902 - Dev (3.36j)', 'CN Dev phase', b'1', 1479.66, 982),
(985, 0, NULL, '_CN-01902 - Test (1.68j)', 'CN Test phase', b'1', 739.872, 982),
(986, 0, NULL, '_CN-01902 - ARA (1.575j)', 'CN ARA', b'1', 834.75, 982),
(987, 73, NULL, 'CN-01719 (8j)', 'PWINIT - CN Study ', b'1', 4320, 1067),
(988, 34, 'AVV', 'Celine - Bundle Patch Management - V2 - contribution à la proposition', '', b'1', 0, 91),
(989, 73, NULL, 'CN-01943 (2j)', 'PWINIT - CN Evolution', b'0', NULL, 1067),
(990, 73, NULL, '_CN-01943 - Analyse (0.8j)', 'CN Analyse phase', b'1', 352.3, 989),
(991, 73, NULL, '_CN-01943 - Dev (0.8j)', 'CN Dev phase', b'1', 352.3, 989),
(992, 73, NULL, '_CN-01943 - Test (0.4j)', 'CN Test phase', b'1', 176.16, 989),
(993, 63, NULL, 'CN-01913 (5.6j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(994, 63, NULL, '_CN-01913 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 993),
(995, 63, NULL, '_CN-01913 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 993),
(996, 63, NULL, '_CN-01913 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 993),
(997, 63, NULL, '_CN-01913 - ARA (1.05j)', 'CN ARA', b'1', 556.5, 993),
(998, 64, NULL, 'CN-01847 (11.125j)', 'AML - CN Evolution', b'0', NULL, 899),
(999, 64, NULL, '_CN-01847 - Analyse (4.45j)', 'CN Analyse phase', b'1', 1959.66875, 998),
(1000, 64, NULL, '_CN-01847 - Dev (4.45j)', 'CN Dev phase', b'1', 1959.66875, 998),
(1001, 64, NULL, '_CN-01847 - Test (2.23j)', 'CN Test phase', b'1', 979.89, 998),
(1002, 63, NULL, 'CN-01819 (20j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1003, 63, NULL, '_CN-01819 - Analyse (8j)', 'CN Analyse phase', b'1', 3523, 1002),
(1004, 63, NULL, '_CN-01819 - Dev (8j)', 'CN Dev phase', b'1', 3523, 1002),
(1005, 63, NULL, '_CN-01819 - Test (4j)', 'CN Test phase', b'1', 1761.6, 1002),
(1006, 63, NULL, '_CN-01819 - ARA (3.75j)', 'CN ARA', b'1', 1987.5, 1002),
(1007, 69, NULL, 'SANOFI - Déploiement Promise - RUN', NULL, b'1', NULL, NULL),
(1008, 0, NULL, 'CN-01939 (0.8j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1009, 0, NULL, '_CN-01939 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 1008),
(1010, 0, NULL, '_CN-01939 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 1008),
(1011, 0, NULL, '_CN-01939 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 1008),
(1012, 60, NULL, 'CN-01087 (2.5j)', 'SEMAPHORE - CN Study ', b'1', 2079, 200),
(1013, 60, NULL, 'CN-01085 (2j)', 'SEMAPHORE - CN Study ', b'1', 1663.2, 200),
(1014, 60, NULL, 'CN-01084 (2j)', 'SEMAPHORE - CN Study ', b'1', 1663.2, 200),
(1029, 81, NULL, 'CN-01876 (4.4j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1030, 81, NULL, '_CN-01876 - Analyse (1.76j)', 'CN Analyse phase', b'1', 775.06, 1029),
(1031, 81, NULL, '_CN-01876 - Dev (1.76j)', 'CN Dev phase', b'1', 775.06, 1029),
(1032, 81, NULL, '_CN-01876 - Test (0.88j)', 'CN Test phase', b'1', 387.552, 1029),
(1033, 65, NULL, 'CN-01861 (0j)', 'I4U - CN Evolution', b'0', NULL, 900),
(1034, 65, NULL, '_CN-01861 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1033),
(1035, 65, NULL, '_CN-01861 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1033),
(1036, 65, NULL, '_CN-01861 - Test (0j)', 'CN Test phase', b'1', NULL, 1033),
(1037, 85, NULL, 'CN-01831 (2.8j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, 1368),
(1038, 85, NULL, '_CN-01831 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 1037),
(1039, 85, NULL, '_CN-01831 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 1037),
(1040, 85, NULL, '_CN-01831 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 1037),
(1041, 60, NULL, 'CN-01089 (11j)', 'SEMAPHORE - CN Study ', b'1', 9147.6, 200),
(1042, 37, NULL, 'CN-01966 (1.6j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1043, 37, NULL, '_CN-01966 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1042),
(1044, 37, NULL, '_CN-01966 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 1042),
(1045, 37, NULL, '_CN-01966 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1042),
(1046, 37, NULL, '_CN-01966 - ARA (0.3j)', 'CN ARA', b'1', 159, 1042),
(1063, 70, '', 'Gestion des activités - V1', '', b'0', NULL, NULL),
(1064, 71, NULL, 'Gestion des demandes', NULL, b'1', NULL, NULL),
(1065, 34, 'AVV', 'Orange - PEO - réponse V1', '', b'1', 0, 211),
(1066, 72, NULL, 'MASTER PLAN 2.2', NULL, b'1', 27832.016000000003, NULL),
(1067, 73, '', 'PWINIT v3.6', '', b'0', NULL, NULL),
(1069, 72, NULL, 'CN-01963 (24.8j)', 'MASTERPLAN - CN Evolution', b'0', NULL, 1066),
(1070, 72, NULL, '_CN-01963 - Analyse (9.92j)', 'CN Analyse phase', b'1', 4368.52, 1069),
(1071, 72, NULL, '_CN-01963 - Dev (9.92j)', 'CN Dev phase', b'1', 4368.52, 1069),
(1072, 72, NULL, '_CN-01963 - Test (4.96j)', 'CN Test phase', b'1', 2184.384, 1069),
(1073, 0, NULL, 'CN-01940 (1.6j)', 'AAL - CN Evolution', b'0', NULL, NULL),
(1074, 0, NULL, '_CN-01940 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1073),
(1075, 0, NULL, '_CN-01940 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 1073),
(1076, 0, NULL, '_CN-01940 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1073),
(1081, 39, NULL, 'CN-01927 (1.6j)', 'AAL - CN Evolution', b'0', NULL, 145),
(1082, 39, NULL, '_CN-01927 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1081),
(1083, 39, NULL, '_CN-01927 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 1081),
(1084, 39, NULL, '_CN-01927 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1081),
(1086, 0, NULL, 'CN-01908 (2j)', 'AAL - CN Study ', b'1', 1080, NULL),
(1087, 0, NULL, 'CN-01846 (0.25j)', 'AML - CN Study ', b'1', 135, NULL),
(1088, 88, NULL, 'CN-01568 (5j)', 'PWINIT - CN Study ', b'1', 2700, 1386),
(1093, 37, NULL, 'CN-01991 (1.6j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1094, 37, NULL, '_CN-01991 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1093),
(1095, 37, NULL, '_CN-01991 - Dev (0.64j)', 'CN Dev phase', b'1', 352.304, 1093),
(1096, 37, NULL, '_CN-01991 - Test (0.32j)', 'CN Test phase', b'1', 70.464, 1093),
(1097, 37, NULL, '_CN-01991 - ARA (0.3j)', 'CN ARA', b'1', 159, 1093),
(1099, 61, NULL, 'CN-01802 (35j)', 'REMEDY_SAD - CN Study ', b'1', 29106, 201),
(1100, 34, '', 'Transverse', '', b'0', NULL, 82),
(1101, 34, 'BU', 'Transverse - Catalogue de Services', '', b'1', 0, 123),
(1102, 37, '', 'CN-01985 (6j)', 'MAGIC - CN Study', b'1', 3240, 142),
(1103, 61, NULL, 'CN-01813 (2j)', 'REMEDY_SAD - CN Evolution', b'0', NULL, 201),
(1104, 61, NULL, '_CN-01813 - Analyse (0.8j)', 'CN Analyse phase', b'1', 426.28, 1103),
(1105, 61, NULL, '_CN-01813 - Dev (0.8j)', 'CN Dev phase', b'1', 426.28, 1103),
(1106, 61, NULL, '_CN-01813 - Test (0.4j)', 'CN Test phase', b'1', 213.14, 1103),
(1107, 0, NULL, 'CN-01567 (5j)', 'PWINIT - CN Study ', b'1', 2700, NULL),
(1108, 74, NULL, 'CEGID TMA Phase de transition', NULL, b'1', NULL, NULL),
(1109, 75, NULL, 'CEGID TMA Corrective', NULL, b'1', NULL, NULL),
(1110, 76, NULL, 'CEGID TMA Evolutive', NULL, b'1', NULL, NULL),
(1111, 77, NULL, 'CEGID TMA Préventive', NULL, b'1', NULL, NULL),
(1113, 70, '', 'Realisation des interviews', '', b'1', 0, 1063),
(1123, 21, NULL, 'Mass Data Administration - 2015-03-23T17:15:22+00:00', NULL, b'1', 337.5, 53),
(1124, 21, NULL, 'Mass Data Administration - 2015-03-23T17:16:54+00:00', NULL, b'1', 337.5, 53),
(1125, 37, NULL, 'CN-01996 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1126, 37, NULL, '_CN-01996 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 1125),
(1127, 37, NULL, '_CN-01996 - Dev (1.54j)', 'CN Dev phase', b'1', 845.5296, 1125),
(1128, 37, NULL, '_CN-01996 - Test (0.77j)', 'CN Test phase', b'1', 169.1136, 1125),
(1129, 37, NULL, '_CN-01996 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 1125),
(1130, 62, NULL, 'CN-01987 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(1131, 62, NULL, '_CN-01987 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1130),
(1132, 62, NULL, '_CN-01987 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1130),
(1133, 62, NULL, '_CN-01987 - Test (0j)', 'CN Test phase', b'1', NULL, 1130),
(1134, 62, NULL, '_CN-01987 - ARA (0j)', 'CN ARA', b'1', NULL, 1130),
(1135, 62, NULL, 'CN-01986 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(1136, 62, NULL, '_CN-01986 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1135),
(1137, 62, NULL, '_CN-01986 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1135),
(1138, 62, NULL, '_CN-01986 - Test (0j)', 'CN Test phase', b'1', NULL, 1135),
(1139, 62, NULL, '_CN-01986 - ARA (0j)', 'CN ARA', b'1', NULL, 1135),
(1140, 37, NULL, 'CN-01985 (6j)', 'MAGIC - CN Study ', b'1', 3240, 142),
(1141, 62, NULL, 'CN-01984 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(1142, 62, NULL, '_CN-01984 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1141),
(1143, 62, NULL, '_CN-01984 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1141),
(1144, 62, NULL, '_CN-01984 - Test (0j)', 'CN Test phase', b'1', NULL, 1141),
(1145, 62, NULL, '_CN-01984 - ARA (0j)', 'CN ARA', b'1', NULL, 1141),
(1146, 62, NULL, 'CN-01982 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(1147, 62, NULL, '_CN-01982 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1146),
(1148, 62, NULL, '_CN-01982 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1146),
(1149, 62, NULL, '_CN-01982 - Test (0j)', 'CN Test phase', b'1', NULL, 1146),
(1150, 62, NULL, '_CN-01982 - ARA (0j)', 'CN ARA', b'1', NULL, 1146),
(1151, 63, NULL, 'CN-01981 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 898);
INSERT INTO `wbsnode` (`IdWBSNode`, `idProject`, `Code`, `Name`, `Description`, `IsControlAccount`, `Budget`, `Parent`) VALUES
(1152, 63, NULL, '_CN-01981 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1151),
(1153, 63, NULL, '_CN-01981 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1151),
(1154, 63, NULL, '_CN-01981 - Test (0j)', 'CN Test phase', b'1', NULL, 1151),
(1155, 63, NULL, '_CN-01981 - ARA (0j)', 'CN ARA', b'1', NULL, 1151),
(1156, 0, NULL, 'CN-01969 (5.6j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1157, 0, NULL, '_CN-01969 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 1156),
(1158, 0, NULL, '_CN-01969 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 1156),
(1159, 0, NULL, '_CN-01969 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 1156),
(1160, 0, NULL, 'CN-01968 (5.6j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1161, 0, NULL, '_CN-01968 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 1160),
(1162, 0, NULL, '_CN-01968 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 1160),
(1163, 0, NULL, '_CN-01968 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 1160),
(1164, 87, NULL, 'CN-01965 (29.6j)', 'I4U - CN Evolution', b'0', NULL, 1385),
(1165, 87, NULL, '_CN-01965 - Analyse (11.84j)', 'CN Analyse phase', b'1', 5214.04, 1164),
(1166, 87, NULL, '_CN-01965 - Dev (11.84j)', 'CN Dev phase', b'1', 5214.04, 1164),
(1167, 87, NULL, '_CN-01965 - Test (5.92j)', 'CN Test phase', b'1', 2607.168, 1164),
(1168, 37, NULL, 'CN-01958 (6.4j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1169, 37, NULL, '_CN-01958 - Analyse (2.56j)', 'CN Analyse phase', b'1', 1127.36, 1168),
(1170, 37, NULL, '_CN-01958 - Dev (2.56j)', 'CN Dev phase', b'1', 1409.216, 1168),
(1171, 37, NULL, '_CN-01958 - Test (1.28j)', 'CN Test phase', b'1', 281.856, 1168),
(1172, 37, NULL, '_CN-01958 - ARA (1.2j)', 'CN ARA', b'1', 636, 1168),
(1173, 0, NULL, 'CN-01956 (4j)', 'AML - CN Study ', b'1', 2160, NULL),
(1174, 0, NULL, 'CN-01952 (4.4j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1175, 0, NULL, '_CN-01952 - Analyse (1.76j)', 'CN Analyse phase', b'1', 775.06, 1174),
(1176, 0, NULL, '_CN-01952 - Dev (1.76j)', 'CN Dev phase', b'1', 775.06, 1174),
(1177, 0, NULL, '_CN-01952 - Test (0.88j)', 'CN Test phase', b'1', 387.552, 1174),
(1178, 0, NULL, 'CN-01949 (8.4j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1179, 0, NULL, '_CN-01949 - Analyse (3.36j)', 'CN Analyse phase', b'1', 1479.66, 1178),
(1180, 0, NULL, '_CN-01949 - Dev (3.36j)', 'CN Dev phase', b'1', 1479.66, 1178),
(1181, 0, NULL, '_CN-01949 - Test (1.68j)', 'CN Test phase', b'1', 739.872, 1178),
(1182, 0, NULL, 'CN-01946 (2j)', 'AAL - CN Evolution', b'0', NULL, NULL),
(1183, 0, NULL, '_CN-01946 - Analyse (0.8j)', 'CN Analyse phase', b'1', 352.3, 1182),
(1184, 0, NULL, '_CN-01946 - Dev (0.8j)', 'CN Dev phase', b'1', 352.3, 1182),
(1185, 0, NULL, '_CN-01946 - Test (0.4j)', 'CN Test phase', b'1', 176.16, 1182),
(1186, 0, NULL, 'CN-01944 (2j)', 'AAL - CN Evolution', b'0', NULL, NULL),
(1187, 0, NULL, '_CN-01944 - Analyse (0.8j)', 'CN Analyse phase', b'1', 352.3, 1186),
(1188, 0, NULL, '_CN-01944 - Dev (0.8j)', 'CN Dev phase', b'1', 352.3, 1186),
(1189, 0, NULL, '_CN-01944 - Test (0.4j)', 'CN Test phase', b'1', 176.16, 1186),
(1190, 0, NULL, 'CN-01943 (2.8j)', 'PWINIT - CN Evolution', b'0', NULL, NULL),
(1191, 0, NULL, '_CN-01943 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 1190),
(1192, 0, NULL, '_CN-01943 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 1190),
(1193, 0, NULL, '_CN-01943 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 1190),
(1194, 72, NULL, 'CN-01933 (0j)', 'MASTERPLAN - CN Evolution', b'0', NULL, 1066),
(1195, 72, NULL, '_CN-01933 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1194),
(1196, 72, NULL, '_CN-01933 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1194),
(1197, 72, NULL, '_CN-01933 - Test (0j)', 'CN Test phase', b'1', NULL, 1194),
(1198, 0, NULL, 'CN-01909 (2j)', 'ATREF - CN Study ', b'1', 1080, NULL),
(1199, 0, NULL, 'CN-01843 (4j)', 'AFROM - CN Study ', b'1', 2160, NULL),
(1200, 0, NULL, 'CN-01832 (0j)', 'ICT CATALOGS - CN Study ', b'1', NULL, NULL),
(1201, 0, NULL, 'CN-01831 (5.6j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, NULL),
(1202, 0, NULL, '_CN-01831 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 1201),
(1203, 0, NULL, '_CN-01831 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 1201),
(1204, 0, NULL, '_CN-01831 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 1201),
(1205, 70, '', 'Quotation des users stories et implémentation dans icescrum', '', b'1', 0, 1063),
(1206, 37, NULL, 'CN-02006 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1207, 37, NULL, '_CN-02006 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 1206),
(1208, 37, NULL, '_CN-02006 - Dev (1.54j)', 'CN Dev phase', b'1', 845.5296, 1206),
(1209, 37, NULL, '_CN-02006 - Test (0.77j)', 'CN Test phase', b'1', 169.1136, 1206),
(1210, 37, NULL, '_CN-02006 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 1206),
(1211, 62, NULL, 'CN-01983 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 897),
(1212, 62, NULL, '_CN-01983 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1211),
(1213, 62, NULL, '_CN-01983 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1211),
(1214, 62, NULL, '_CN-01983 - Test (0j)', 'CN Test phase', b'1', NULL, 1211),
(1215, 62, NULL, '_CN-01983 - ARA (0j)', 'CN ARA', b'1', NULL, 1211),
(1216, 0, NULL, 'CN-01894 (2.8j)', 'AIFU - CN Evolution', b'0', NULL, NULL),
(1217, 0, NULL, '_CN-01894 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 1216),
(1218, 0, NULL, '_CN-01894 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 1216),
(1219, 0, NULL, '_CN-01894 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 1216),
(1221, 78, '', 'CEA - DAM - Train de maintenance évolutive n° 03', '', b'1', 6859.47, NULL),
(1222, 79, '', 'Reporting Bundle Tools Activity (19j)', '', b'1', 10124, NULL),
(1223, 49, '', 'Total - TMA ITSM - Gouvernance - 04/2015', '', b'1', 0, 182),
(1224, 46, '', 'Total - TMA ITSM - Gestion des problèmes - 04/2015', '', b'1', 4800, 179),
(1225, 46, '', 'Total - TMA ITSM - Gestion des problèmes - 05/2015', '', b'1', 4800, 179),
(1226, 46, '', 'Total - TMA ITSM - Gestion des problèmes - 06/2015', '', b'1', 4800, 179),
(1227, 31, '', 'CEA - DAM -VSR SM9', '', b'1', 0, 79),
(1228, 34, 'RGSO', 'CEA Civil', '', b'0', NULL, 82),
(1229, 34, 'AVV', 'CEA Civil - participation', '', b'1', 0, 123),
(1230, 37, NULL, 'CN-02014 (1.6j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1231, 37, NULL, '_CN-02014 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1230),
(1232, 37, NULL, '_CN-02014 - Dev (0.8j)', 'CN Dev phase', b'1', 352.304, 1230),
(1233, 37, NULL, '_CN-02014 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 1230),
(1234, 37, NULL, '_CN-02014 - ARA (0.3j)', 'CN ARA', b'1', 159, 1230),
(1235, 37, NULL, 'CN-02011 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1236, 37, NULL, '_CN-02011 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 1235),
(1237, 37, NULL, '_CN-02011 - Dev (1.92j)', 'CN Dev phase', b'1', 845.5296, 1235),
(1238, 37, NULL, '_CN-02011 - Test (0.38j)', 'CN Test phase', b'1', 169.1136, 1235),
(1239, 37, NULL, '_CN-02011 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 1235),
(1240, 37, NULL, 'CN-02010 (3.84j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1241, 37, NULL, '_CN-02010 - Analyse (1.54j)', 'CN Analyse phase', b'1', 676.416, 1240),
(1242, 37, NULL, '_CN-02010 - Dev (1.92j)', 'CN Dev phase', b'1', 845.5296, 1240),
(1243, 37, NULL, '_CN-02010 - Test (0.38j)', 'CN Test phase', b'1', 169.1136, 1240),
(1244, 37, NULL, '_CN-02010 - ARA (0.72j)', 'CN ARA', b'1', 381.6, 1240),
(1245, 61, NULL, 'CN-01972 (1.2j)', 'REMEDY_SAD - CN Evolution', b'0', NULL, 201),
(1246, 61, NULL, '_CN-01972 - Analyse (0.48j)', 'CN Analyse phase', b'1', 255.768, 1245),
(1247, 61, NULL, '_CN-01972 - Dev (0.48j)', 'CN Dev phase', b'1', 255.768, 1245),
(1248, 61, NULL, '_CN-01972 - Test (0.24j)', 'CN Test phase', b'1', 127.884, 1245),
(1249, 0, NULL, 'CN-01971 (1.6j)', 'AAL - CN Evolution', b'0', NULL, NULL),
(1250, 0, NULL, '_CN-01971 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1249),
(1251, 0, NULL, '_CN-01971 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 1249),
(1252, 0, NULL, '_CN-01971 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1249),
(1253, 38, NULL, 'CN-01932 (16.75j)', 'AML - CN Evolution', b'0', NULL, 143),
(1254, 38, NULL, '_CN-01932 - Analyse (6.7j)', 'CN Analyse phase', b'1', 2950.5125, 1253),
(1255, 38, NULL, '_CN-01932 - Dev (6.7j)', 'CN Dev phase', b'1', 2950.5125, 1253),
(1256, 38, NULL, '_CN-01932 - Test (3.35j)', 'CN Test phase', b'1', 1475.34, 1253),
(1257, 81, NULL, 'CN-01878 (7.2j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1258, 81, NULL, '_CN-01878 - Analyse (2.88j)', 'CN Analyse phase', b'1', 1268.28, 1257),
(1259, 81, NULL, '_CN-01878 - Dev (2.88j)', 'CN Dev phase', b'1', 1268.28, 1257),
(1260, 81, NULL, '_CN-01878 - Test (1.44j)', 'CN Test phase', b'1', 634.176, 1257),
(1261, 0, NULL, 'CN-01840 (10.4j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1262, 0, NULL, '_CN-01840 - Analyse (4.16j)', 'CN Analyse phase', b'1', 1831.96, 1261),
(1263, 0, NULL, '_CN-01840 - Dev (4.16j)', 'CN Dev phase', b'1', 1831.96, 1261),
(1264, 0, NULL, '_CN-01840 - Test (2.08j)', 'CN Test phase', b'1', 916.032, 1261),
(1265, 38, NULL, 'CN-01091 (23.625j)', 'BI - CN Evolution', b'0', NULL, 143),
(1266, 38, NULL, '_CN-01091 - Analyse (9.45j)', 'CN Analyse phase', b'1', 5035.4325, 1265),
(1267, 38, NULL, '_CN-01091 - Dev (9.45j)', 'CN Dev phase', b'1', 5035.4325, 1265),
(1268, 38, NULL, '_CN-01091 - Test (4.73j)', 'CN Test phase', b'1', 2517.71625, 1265),
(1271, 70, '', 'Gestion des activites', '', b'1', 0, 1063),
(1272, 70, '', 'Sprint 1', '', b'1', 0, 1271),
(1273, 39, NULL, 'CN-01995 (0j)', 'AAL - CN Evolution', b'0', NULL, 145),
(1274, 39, NULL, '_CN-01995 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1273),
(1275, 39, NULL, '_CN-01995 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1273),
(1276, 39, NULL, '_CN-01995 - Test (0j)', 'CN Test phase', b'1', NULL, 1273),
(1277, 72, NULL, 'CN-01980 (38.4j)', 'MASTERPLAN - CN Evolution', b'0', NULL, 1066),
(1278, 72, NULL, '_CN-01980 - Analyse (15.36j)', 'CN Analyse phase', b'1', 6764.16, 1277),
(1279, 72, NULL, '_CN-01980 - Dev (15.36j)', 'CN Dev phase', b'1', 6764.16, 1277),
(1280, 72, NULL, '_CN-01980 - Test (7.68j)', 'CN Test phase', b'1', 3382.272, 1277),
(1281, 63, NULL, 'CN-01979 (1.5j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1282, 63, NULL, '_CN-01979 - Analyse (0.6j)', 'CN Analyse phase', b'1', 264.225, 1281),
(1283, 63, NULL, '_CN-01979 - Dev (0.6j)', 'CN Dev phase', b'1', 264.225, 1281),
(1284, 63, NULL, '_CN-01979 - Test (0.3j)', 'CN Test phase', b'1', 132.12, 1281),
(1285, 63, NULL, '_CN-01979 - ARA (0.28125j)', 'CN ARA', b'1', 149.0625, 1281),
(1286, 63, NULL, 'CN-01978 (1.5j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1287, 63, NULL, '_CN-01978 - Analyse (0.6j)', 'CN Analyse phase', b'1', 264.225, 1286),
(1288, 63, NULL, '_CN-01978 - Dev (0.6j)', 'CN Dev phase', b'1', 264.225, 1286),
(1289, 63, NULL, '_CN-01978 - Test (0.3j)', 'CN Test phase', b'1', 132.12, 1286),
(1290, 63, NULL, '_CN-01978 - ARA (0.28125j)', 'CN ARA', b'1', 149.0625, 1286),
(1291, 63, NULL, 'CN-01977 (5.6j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1292, 63, NULL, '_CN-01977 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 1291),
(1293, 63, NULL, '_CN-01977 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 1291),
(1294, 63, NULL, '_CN-01977 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 1291),
(1295, 63, NULL, '_CN-01977 - ARA (1.05j)', 'CN ARA', b'1', 556.5, 1291),
(1296, 63, NULL, 'CN-01973 (4.1j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1297, 63, NULL, '_CN-01973 - Analyse (1.64j)', 'CN Analyse phase', b'1', 722.215, 1296),
(1298, 63, NULL, '_CN-01973 - Dev (1.64j)', 'CN Dev phase', b'1', 722.215, 1296),
(1299, 63, NULL, '_CN-01973 - Test (0.82j)', 'CN Test phase', b'1', 361.128, 1296),
(1300, 63, NULL, '_CN-01973 - ARA (0.76875j)', 'CN ARA', b'1', 407.4375, 1296),
(1301, 0, NULL, 'CN-01942 (0.77j)', 'ICT CATALOGS - CN Study ', b'1', 415.8, NULL),
(1302, 81, NULL, 'CN-01877 (2.8j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1303, 81, NULL, '_CN-01877 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 1302),
(1304, 81, NULL, '_CN-01877 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 1302),
(1305, 81, NULL, '_CN-01877 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 1302),
(1306, 0, NULL, 'CN-01875 (12j)', 'ATREF - CN Evolution', b'0', NULL, NULL),
(1307, 0, NULL, '_CN-01875 - Analyse (4.8j)', 'CN Analyse phase', b'1', 2113.8, 1306),
(1308, 0, NULL, '_CN-01875 - Dev (4.8j)', 'CN Dev phase', b'1', 2113.8, 1306),
(1309, 0, NULL, '_CN-01875 - Test (2.4j)', 'CN Test phase', b'1', 1056.96, 1306),
(1310, 85, NULL, 'CN-01832 (2.4j)', 'ICT CATALOGS - CN Study ', b'1', 1296, 1368),
(1311, 60, NULL, 'CN-01092 (21.6j)', 'SEMAPHORE - CN Evolution', b'0', NULL, 200),
(1312, 60, NULL, '_CN-01092 - Analyse (8.64j)', 'CN Analyse phase', b'1', 4603.824, 1311),
(1313, 60, NULL, '_CN-01092 - Dev (8.64j)', 'CN Dev phase', b'1', 4603.824, 1311),
(1314, 60, NULL, '_CN-01092 - Test (4.32j)', 'CN Test phase', b'1', 2301.912, 1311),
(1315, 60, NULL, 'CN-01083 (35.2j)', 'SEMAPHORE - CN Evolution', b'0', NULL, 200),
(1316, 60, NULL, '_CN-01083 - Analyse (14.08j)', 'CN Analyse phase', b'1', 7502.528, 1315),
(1317, 60, NULL, '_CN-01083 - Dev (14.08j)', 'CN Dev phase', b'1', 7502.528, 1315),
(1318, 60, NULL, '_CN-01083 - Test (7.04j)', 'CN Test phase', b'1', 3751.264, 1315),
(1319, 80, '', 'AAL V8.7.0', '', b'1', 0, NULL),
(1320, 81, '', 'ATREF V2.1', '', b'0', 42804.93600000001, NULL),
(1321, 82, NULL, 'AIFU', NULL, b'1', NULL, NULL),
(1322, 83, NULL, 'LBP - OPUS - TMA Corrective - 2015', NULL, b'0', NULL, NULL),
(1323, 84, NULL, 'Activités externes au CdS', NULL, b'1', NULL, NULL),
(1324, 83, '', 'LBP - OPUS TMA Corrective - Avril  2015', '', b'1', 0, 1322),
(1329, 67, NULL, 'CN-02002 (8.4j)', 'ETICKET - CN Evolution', b'0', NULL, 945),
(1330, 67, NULL, '_CN-02002 - Analyse (3.36j)', 'CN Analyse phase', b'1', 1479.66, 1329),
(1331, 67, NULL, '_CN-02002 - Dev (3.36j)', 'CN Dev phase', b'1', 1479.66, 1329),
(1332, 67, NULL, '_CN-02002 - Test (1.68j)', 'CN Test phase', b'1', 739.872, 1329),
(1333, 0, NULL, 'CN-01967 (1.6j)', 'AAL - CN Evolution', b'0', NULL, NULL),
(1334, 0, NULL, '_CN-01967 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1333),
(1335, 0, NULL, '_CN-01967 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 1333),
(1336, 0, NULL, '_CN-01967 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1333),
(1337, 0, NULL, 'CN-01961 (0j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, NULL),
(1338, 0, NULL, '_CN-01961 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1337),
(1339, 0, NULL, '_CN-01961 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1337),
(1340, 0, NULL, '_CN-01961 - Test (0j)', 'CN Test phase', b'1', NULL, 1337),
(1341, 63, NULL, 'CN-01929 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1342, 63, NULL, '_CN-01929 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1341),
(1343, 63, NULL, '_CN-01929 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1341),
(1344, 63, NULL, '_CN-01929 - Test (0j)', 'CN Test phase', b'1', NULL, 1341),
(1345, 63, NULL, '_CN-01929 - ARA (0j)', 'CN ARA', b'1', NULL, 1341),
(1346, 81, NULL, 'CN-01875 (13.6j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1347, 81, NULL, '_CN-01875 - Analyse (5.44j)', 'CN Analyse phase', b'1', 2395.64, 1346),
(1348, 81, NULL, '_CN-01875 - Dev (5.44j)', 'CN Dev phase', b'1', 2395.64, 1346),
(1349, 81, NULL, '_CN-01875 - Test (2.72j)', 'CN Test phase', b'1', 1197.888, 1346),
(1350, 0, NULL, 'CN-01831 (9.7j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, NULL),
(1351, 0, NULL, '_CN-01831 - Analyse (3.88j)', 'CN Analyse phase', b'1', 1708.655, 1350),
(1352, 0, NULL, '_CN-01831 - Dev (3.88j)', 'CN Dev phase', b'1', 1708.655, 1350),
(1353, 0, NULL, '_CN-01831 - Test (1.94j)', 'CN Test phase', b'1', 854.376, 1350),
(1354, 63, NULL, 'CN-01975 (2.3j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1355, 63, NULL, '_CN-01975 - Analyse (0.92j)', 'CN Analyse phase', b'1', 405.145, 1354),
(1356, 63, NULL, '_CN-01975 - Dev (0.92j)', 'CN Dev phase', b'1', 405.145, 1354),
(1357, 63, NULL, '_CN-01975 - Test (0.46j)', 'CN Test phase', b'1', 202.584, 1354),
(1358, 63, NULL, '_CN-01975 - ARA (0.43125j)', 'CN ARA', b'1', 228.5625, 1354),
(1359, 63, NULL, 'CN-01974 (1.5j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1360, 63, NULL, '_CN-01974 - Analyse (0.6j)', 'CN Analyse phase', b'1', 264.225, 1359),
(1361, 63, NULL, '_CN-01974 - Dev (0.6j)', 'CN Dev phase', b'1', 264.225, 1359),
(1362, 63, NULL, '_CN-01974 - Test (0.3j)', 'CN Test phase', b'1', 132.12, 1359),
(1363, 63, NULL, '_CN-01974 - ARA (0.28125j)', 'CN ARA', b'1', 149.0625, 1359),
(1364, 39, NULL, 'CN-01938 (2j)', 'AAL - CN Evolution', b'0', NULL, 145),
(1365, 39, NULL, '_CN-01938 - Analyse (0.8j)', 'CN Analyse phase', b'1', 352.3, 1364),
(1366, 39, NULL, '_CN-01938 - Dev (0.8j)', 'CN Dev phase', b'1', 352.3, 1364),
(1367, 39, NULL, '_CN-01938 - Test (0.4j)', 'CN Test phase', b'1', 176.16, 1364),
(1368, 85, NULL, 'ICT Catalogue', NULL, b'1', 2529.0640000000003, NULL),
(1369, 86, NULL, 'Reste à produire 2015', NULL, b'1', NULL, NULL),
(1370, 91, NULL, 'CN-02007 (11.2j)', 'AML - CN Evolution', b'0', NULL, 1504),
(1371, 91, NULL, '_CN-02007 - Analyse (4.48j)', 'CN Analyse phase', b'1', 1972.88, 1370),
(1372, 91, NULL, '_CN-02007 - Dev (4.48j)', 'CN Dev phase', b'1', 1972.88, 1370),
(1373, 91, NULL, '_CN-02007 - Test (2.24j)', 'CN Test phase', b'1', 986.496, 1370),
(1374, 67, NULL, 'CN-01998 (4.8j)', 'ETICKET - CN Evolution', b'0', NULL, 945),
(1375, 67, NULL, '_CN-01998 - Analyse (1.92j)', 'CN Analyse phase', b'1', 845.52, 1374),
(1376, 67, NULL, '_CN-01998 - Dev (1.92j)', 'CN Dev phase', b'1', 845.52, 1374),
(1377, 67, NULL, '_CN-01998 - Test (0.96j)', 'CN Test phase', b'1', 422.784, 1374),
(1378, 0, NULL, 'CN-01928 (2j)', 'AAL - CN Study ', b'1', 1080, NULL),
(1379, 63, NULL, 'CN-01049 (11.2j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1380, 63, NULL, '_CN-01049 - Analyse (4.48j)', 'CN Analyse phase', b'1', 1972.88, 1379),
(1381, 63, NULL, '_CN-01049 - Dev (4.48j)', 'CN Dev phase', b'1', 1972.88, 1379),
(1382, 63, NULL, '_CN-01049 - Test (2.24j)', 'CN Test phase', b'1', 986.496, 1379),
(1383, 63, NULL, '_CN-01049 - ARA (2.1j)', 'CN ARA', b'1', 1113, 1379),
(1384, 21, NULL, 'Mass Data Administration - 2015-04-15T09:56:43+00:00', NULL, b'1', 337.5, 53),
(1385, 87, NULL, 'I4U 1.3', NULL, b'1', 13035.248, NULL),
(1386, 88, '', 'PWINIT Out of Release', '', b'0', NULL, NULL),
(1387, 70, '', 'Sprint 2', '', b'1', 0, 1271),
(1388, 89, NULL, 'CEA - DAM - Reprise de Données Centre Gramat', NULL, b'0', NULL, NULL),
(1389, 0, NULL, 'CN-02015 (2j)', 'PWINIT - CN Study ', b'1', 1080, NULL),
(1390, 92, NULL, 'CN-02000 (4.8j)', 'ETICKET - CN Evolution', b'0', NULL, 1505),
(1391, 92, NULL, '_CN-02000 - Analyse (1.92j)', 'CN Analyse phase', b'1', 845.52, 1390),
(1392, 92, NULL, '_CN-02000 - Dev (1.92j)', 'CN Dev phase', b'1', 845.52, 1390),
(1393, 92, NULL, '_CN-02000 - Test (0.96j)', 'CN Test phase', b'1', 422.784, 1390),
(1394, 63, NULL, 'CN-01993 (1.5j)', 'ASPIRE - CN Evolution', b'0', NULL, 898),
(1395, 63, NULL, '_CN-01993 - Analyse (0.6j)', 'CN Analyse phase', b'1', 264.225, 1394),
(1396, 63, NULL, '_CN-01993 - Dev (0.6j)', 'CN Dev phase', b'1', 264.225, 1394),
(1397, 63, NULL, '_CN-01993 - Test (0.3j)', 'CN Test phase', b'1', 132.12, 1394),
(1398, 63, NULL, '_CN-01993 - ARA (0.28125j)', 'CN ARA', b'1', 149.0625, 1394),
(1399, 81, NULL, 'CN-01992 (0j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1400, 81, NULL, '_CN-01992 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1399),
(1401, 81, NULL, '_CN-01992 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1399),
(1402, 81, NULL, '_CN-01992 - Test (0j)', 'CN Test phase', b'1', NULL, 1399),
(1403, 0, NULL, 'CN-01989 (1.6j)', 'AAL - CN Evolution', b'0', NULL, NULL),
(1404, 0, NULL, '_CN-01989 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1403),
(1405, 0, NULL, '_CN-01989 - Dev (0.64j)', 'CN Dev phase', b'1', 281.84, 1403),
(1406, 0, NULL, '_CN-01989 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1403),
(1407, 0, NULL, 'CN-01988 (0j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(1408, 0, NULL, '_CN-01988 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1407),
(1409, 0, NULL, '_CN-01988 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1407),
(1410, 0, NULL, '_CN-01988 - Test (0j)', 'CN Test phase', b'1', NULL, 1407),
(1411, 0, NULL, '_CN-01988 - ARA (0j)', 'CN ARA', b'1', NULL, 1407),
(1412, 81, NULL, 'CN-01876 (5.2j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1413, 81, NULL, '_CN-01876 - Analyse (2.08j)', 'CN Analyse phase', b'1', 915.98, 1412),
(1414, 81, NULL, '_CN-01876 - Dev (2.08j)', 'CN Dev phase', b'1', 915.98, 1412),
(1415, 81, NULL, '_CN-01876 - Test (1.04j)', 'CN Test phase', b'1', 458.016, 1412),
(1416, 0, NULL, 'CN-01794 (1.6j)', 'ICT CATALOGS - CN Study ', b'1', 864, NULL),
(1417, 0, NULL, 'CN-01620 (19.9j)', 'ICT CATALOGS - CN Study ', b'1', 10746, NULL),
(1418, 0, NULL, 'CN-02017 (4.1j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(1419, 0, NULL, '_CN-02017 - Analyse (1.64j)', 'CN Analyse phase', b'1', 722.215, 1418),
(1420, 0, NULL, '_CN-02017 - Dev (1.64j)', 'CN Dev phase', b'1', 722.215, 1418),
(1421, 0, NULL, '_CN-02017 - Test (0.82j)', 'CN Test phase', b'1', 361.128, 1418),
(1422, 0, NULL, '_CN-02017 - ARA (0.76875j)', 'CN ARA', b'1', 407.4375, 1418),
(1423, 0, NULL, 'CN-02016 (0.8j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(1424, 0, NULL, '_CN-02016 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 1423),
(1425, 0, NULL, '_CN-02016 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 1423),
(1426, 0, NULL, '_CN-02016 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 1423),
(1427, 0, NULL, '_CN-02016 - ARA (0.15j)', 'CN ARA', b'1', 79.5, 1423),
(1428, 0, NULL, 'CN-02009 (0.8j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(1429, 0, NULL, '_CN-02009 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 1428),
(1430, 0, NULL, '_CN-02009 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 1428),
(1431, 0, NULL, '_CN-02009 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 1428),
(1432, 0, NULL, '_CN-02009 - ARA (0.15j)', 'CN ARA', b'1', 79.5, 1428),
(1433, 92, NULL, 'CN-01997 (4.8j)', 'ETICKET - CN Evolution', b'0', NULL, 1505),
(1434, 92, NULL, '_CN-01997 - Analyse (1.92j)', 'CN Analyse phase', b'1', 845.52, 1433),
(1435, 92, NULL, '_CN-01997 - Dev (1.92j)', 'CN Dev phase', b'1', 845.52, 1433),
(1436, 92, NULL, '_CN-01997 - Test (0.96j)', 'CN Test phase', b'1', 422.784, 1433),
(1437, 0, NULL, 'CN-01994 (4.1j)', 'ASPIRE - CN Evolution', b'0', NULL, NULL),
(1438, 0, NULL, '_CN-01994 - Analyse (1.64j)', 'CN Analyse phase', b'1', 722.215, 1437),
(1439, 0, NULL, '_CN-01994 - Dev (1.64j)', 'CN Dev phase', b'1', 722.215, 1437),
(1440, 0, NULL, '_CN-01994 - Test (0.82j)', 'CN Test phase', b'1', 361.128, 1437),
(1441, 0, NULL, '_CN-01994 - ARA (0.76875j)', 'CN ARA', b'1', 407.4375, 1437),
(1442, 0, NULL, 'CN-01970 (0j)', 'ATREF - CN Evolution', b'0', NULL, NULL),
(1443, 0, NULL, '_CN-01970 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1442),
(1444, 0, NULL, '_CN-01970 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1442),
(1445, 0, NULL, '_CN-01970 - Test (0j)', 'CN Test phase', b'1', NULL, 1442),
(1446, 0, NULL, 'CN-01959 (4j)', 'ICT CATALOGS - CN Study ', b'1', 2160, NULL),
(1447, 0, NULL, 'CN-01911 (0j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, NULL),
(1448, 0, NULL, '_CN-01911 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1447),
(1449, 0, NULL, '_CN-01911 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1447),
(1450, 0, NULL, '_CN-01911 - Test (0j)', 'CN Test phase', b'1', NULL, 1447),
(1451, 0, NULL, 'CN-01620 (39.8j)', 'ICT CATALOGS - CN Study ', b'1', 21492, NULL),
(1452, 89, '', 'Spécification(s)-Atelier(s)', '', b'1', 0, 1388),
(1453, 0, NULL, 'CN-02001 (0.8j)', 'ETICKET - CN Evolution', b'0', NULL, NULL),
(1454, 0, NULL, '_CN-02001 - Analyse (0.32j)', 'CN Analyse phase', b'1', 140.92, 1453),
(1455, 0, NULL, '_CN-02001 - Dev (0.32j)', 'CN Dev phase', b'1', 140.92, 1453),
(1456, 0, NULL, '_CN-02001 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 1453),
(1457, 92, NULL, 'CN-01999 (1.41j)', 'ETICKET - CN Evolution', b'0', NULL, 1505),
(1458, 92, NULL, '_CN-01999 - Analyse (0.56j)', 'CN Analyse phase', b'1', 248.3715, 1457),
(1459, 92, NULL, '_CN-01999 - Dev (0.56j)', 'CN Dev phase', b'1', 248.3715, 1457),
(1460, 92, NULL, '_CN-01999 - Test (0.28j)', 'CN Test phase', b'1', 124.1928, 1457),
(1502, 90, '', 'PWINIT 3.7', '', b'0', NULL, NULL),
(1503, 37, NULL, 'CN-02038 (5j)', 'MAGIC - CN Study ', b'1', 2700, 142),
(1504, 91, NULL, 'AML V2.4.9.1', NULL, b'1', 4932.256, NULL),
(1505, 92, NULL, 'Eticket V3.1', NULL, b'1', 7314.711800000001, NULL),
(1506, 0, NULL, 'CN-02033 (2.8j)', 'PWINIT - CN Evolution', b'0', NULL, NULL),
(1507, 0, NULL, '_CN-02033 - Analyse (1.12j)', 'CN Analyse phase', b'1', 493.22, 1506),
(1508, 0, NULL, '_CN-02033 - Dev (1.12j)', 'CN Dev phase', b'1', 493.22, 1506),
(1509, 0, NULL, '_CN-02033 - Test (0.56j)', 'CN Test phase', b'1', 246.624, 1506),
(1510, 0, NULL, 'CN-02032 (5.6j)', 'PWINIT - CN Evolution', b'0', NULL, NULL),
(1511, 0, NULL, '_CN-02032 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 1510),
(1512, 0, NULL, '_CN-02032 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 1510),
(1513, 0, NULL, '_CN-02032 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 1510),
(1514, 0, NULL, 'CN-02027 (0j)', 'ATREF - CN Evolution', b'0', NULL, NULL),
(1515, 0, NULL, '_CN-02027 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1514),
(1516, 0, NULL, '_CN-02027 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1514),
(1517, 0, NULL, '_CN-02027 - Test (0j)', 'CN Test phase', b'1', NULL, 1514),
(1518, 92, NULL, 'CN-02025 (5.6j)', 'ETICKET - CN Evolution', b'0', NULL, 1505),
(1519, 92, NULL, '_CN-02025 - Analyse (2.24j)', 'CN Analyse phase', b'1', 986.44, 1518),
(1520, 92, NULL, '_CN-02025 - Dev (2.24j)', 'CN Dev phase', b'1', 986.44, 1518),
(1521, 92, NULL, '_CN-02025 - Test (1.12j)', 'CN Test phase', b'1', 493.248, 1518),
(1522, 0, NULL, 'CN-02015 (3j)', 'PWINIT - CN Study ', b'1', 1620, NULL),
(1523, 0, NULL, 'CN-01846 (2j)', 'AML - CN Study ', b'1', 1080, NULL),
(1524, 34, 'AVV', 'Airbus - Bundle Tools - STADS - round 1', '', b'1', 0, 167),
(1525, 24, '', 'CN-005_Enable Audit Asset_EMA(1.2j)', 'Analyse + Other EMA', b'1', 0, 64),
(1526, 0, NULL, 'CN-01962 (0j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, NULL),
(1527, 0, NULL, '_CN-01962 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1526),
(1528, 0, NULL, '_CN-01962 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1526),
(1529, 0, NULL, '_CN-01962 - Test (0j)', 'CN Test phase', b'1', NULL, 1526),
(1530, 0, NULL, 'CN-01961 (1.2j)', 'ICT CATALOGS - CN Evolution', b'0', NULL, NULL),
(1531, 0, NULL, '_CN-01961 - Analyse (0.48j)', 'CN Analyse phase', b'1', 211.38, 1530),
(1532, 0, NULL, '_CN-01961 - Dev (0.48j)', 'CN Dev phase', b'1', 211.38, 1530),
(1533, 0, NULL, '_CN-01961 - Test (0.24j)', 'CN Test phase', b'1', 105.696, 1530),
(1534, 81, NULL, 'CN-01903 (0j)', 'ATREF - CN Evolution', b'0', NULL, 1320),
(1535, 81, NULL, '_CN-01903 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1534),
(1536, 81, NULL, '_CN-01903 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1534),
(1537, 81, NULL, '_CN-01903 - Test (0j)', 'CN Test phase', b'1', NULL, 1534),
(1538, 37, NULL, 'CN-02040 (1.6j)', 'MAGIC - CN Evolution', b'0', NULL, 142),
(1539, 37, NULL, '_CN-02040 - Analyse (0.64j)', 'CN Analyse phase', b'1', 281.84, 1538),
(1540, 37, NULL, '_CN-02040 - Dev (0.8j)', 'CN Dev phase', b'1', 352.304, 1538),
(1541, 37, NULL, '_CN-02040 - Test (0.16j)', 'CN Test phase', b'1', 70.464, 1538),
(1542, 37, NULL, '_CN-02040 - ARA (0.3j)', 'CN ARA', b'1', 159, 1538),
(1543, 61, NULL, 'CN-01893 (3j)', 'REMEDY_SAD - CN Evolution', b'0', NULL, 201),
(1544, 61, NULL, '_CN-01893 - Analyse (1.2j)', 'CN Analyse phase', b'1', 639.42, 1543),
(1545, 61, NULL, '_CN-01893 - Dev (1.2j)', 'CN Dev phase', b'1', 639.42, 1543),
(1546, 61, NULL, '_CN-01893 - Test (0.6j)', 'CN Test phase', b'1', 319.71, 1543),
(1547, 93, NULL, 'Intermission', NULL, b'0', NULL, NULL),
(1548, 93, 'BU', 'Intégration', '', b'1', 0, 1547),
(1549, 10, 'FR15', 'Formation reçue - HP SM9 pour EDF TMO²', '', b'1', 0, 22),
(1550, 10, 'FD15', 'Formation donnée - HP SM9 pour EDF TMO²', '', b'1', 0, 22),
(1551, 94, NULL, 'EDF TMO²', NULL, b'1', NULL, NULL),
(1552, 49, '', 'Total - TMA ITSM - Gouvernance - 05/2015', '', b'1', 0, 182),
(1553, 49, '', 'Total - TMA ITSM - Gouvernance - 06/2015', '', b'1', 0, 182),
(1558, 24, '', 'CN-002_EvolutionInterfaceAssetPC', '', b'0', NULL, 64),
(1559, 24, '', 'CN-002_EvolutionInterfaceAssetPC_EMA_(9j)', '', b'1', 0, 1558),
(1560, 9, 'FR15', 'Risques Psycho Sociaux', '', b'1', 0, 20),
(1561, 0, NULL, 'CN-02012 (3.2j)', 'MAGIC - CN Evolution', b'0', NULL, NULL),
(1562, 0, NULL, '_CN-02012 - Analyse (1.28j)', 'CN Analyse phase', b'1', 563.68, 1561),
(1563, 0, NULL, '_CN-02012 - Dev (1.6j)', 'CN Dev phase', b'1', 704.608, 1561),
(1564, 0, NULL, '_CN-02012 - Test (0.32j)', 'CN Test phase', b'1', 140.928, 1561),
(1565, 0, NULL, '_CN-02012 - ARA (0.6j)', 'CN ARA', b'1', 318, 1561),
(1566, 0, NULL, 'CN-01873 (8j)', 'ATREF - CN Evolution', b'0', NULL, NULL),
(1567, 0, NULL, '_CN-01873 - Analyse (3.2j)', 'CN Analyse phase', b'1', 1409.2, 1566),
(1568, 0, NULL, '_CN-01873 - Dev (3.2j)', 'CN Dev phase', b'1', 1409.2, 1566),
(1569, 0, NULL, '_CN-01873 - Test (1.6j)', 'CN Test phase', b'1', 704.64, 1566),
(1570, 0, NULL, 'CN-01090 (4.8j)', 'SEMAPHORE - CN Evolution', b'0', NULL, NULL),
(1571, 0, NULL, '_CN-01090 - Analyse (1.92j)', 'CN Analyse phase', b'1', 1023.072, 1570),
(1572, 0, NULL, '_CN-01090 - Dev (1.92j)', 'CN Dev phase', b'1', 1023.072, 1570),
(1573, 0, NULL, '_CN-01090 - Test (0.96j)', 'CN Test phase', b'1', 511.536, 1570),
(1574, 0, NULL, 'CN-00926 (0j)', 'SEMAPHORE - CN Evolution', b'0', NULL, NULL),
(1575, 0, NULL, '_CN-00926 - Analyse (0j)', 'CN Analyse phase', b'1', NULL, 1574),
(1576, 0, NULL, '_CN-00926 - Dev (0j)', 'CN Dev phase', b'1', NULL, 1574),
(1577, 0, NULL, '_CN-00926 - Test (0j)', 'CN Test phase', b'1', NULL, 1574),
(1578, 24, '', 'CN-002_EvolutionInterfaceAssetPC_EvoImple', 'Technical specifications writting Development in "Development environment" Deployment in Integration, Acceptance and Production environments Technical unit test dossier creation Tests realization and Tests results Move in production (EIS and communication leaflet) Update technical referential documentation Packaging', b'1', 0, 64),
(1579, 24, '', 'CN-005_Enable Audit Asset_EvolImple(2j)', 'Technical specifications writting Development in "Development environment" Deployment in Integration, Acceptance and Production environments Technical unit test dossier creation Tests realization and Tests results Move in production (EIS and communication leaflet) Update technical referential documentation Packaging', b'1', 0, 64),
(1580, 36, NULL, 'CN-01094 (0.8j)', 'BI - CN Evolution', b'0', NULL, 141),
(1581, 36, NULL, '_CN-01094 - Analyse (0.32j)', 'CN Analyse phase', b'1', 170.512, 1580),
(1582, 36, NULL, '_CN-01094 - Dev (0.32j)', 'CN Dev phase', b'1', 170.512, 1580),
(1583, 36, NULL, '_CN-01094 - Test (0.16j)', 'CN Test phase', b'1', 85.256, 1580),
(1584, 24, '', 'CN-003_AutomaticClosurePendingGroups_EMA', '', b'1', 0, 64),
(1585, 24, '', 'CN-003_AutomaticClosurePendingGroups_EvoImple', '', b'1', 0, 64),
(1586, 24, '', 'CN-004_ProtectionDuplicatePCname_EMA', '', b'1', 0, 64);

-- --------------------------------------------------------

--
-- Structure de la table `workingcosts`
--

DROP TABLE IF EXISTS `workingcosts`;
CREATE TABLE IF NOT EXISTS `workingcosts` (
`idWorkingCosts` int(10) unsigned NOT NULL,
  `resourceName` varchar(50) DEFAULT NULL,
  `resourceDepartment` varchar(50) DEFAULT NULL,
  `effort` int(10) unsigned DEFAULT NULL,
  `rate` double DEFAULT NULL,
  `workCost` double DEFAULT NULL,
  `idProject` int(11) NOT NULL,
  `q1` int(10) unsigned DEFAULT NULL,
  `q2` int(10) unsigned DEFAULT NULL,
  `q3` int(10) unsigned DEFAULT NULL,
  `q4` int(10) unsigned DEFAULT NULL,
  `realEffort` int(10) unsigned DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=76 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `workingcosts`
--

INSERT INTO `workingcosts` (`idWorkingCosts`, `resourceName`, `resourceDepartment`, `effort`, `rate`, `workCost`, `idProject`, `q1`, `q2`, `q3`, `q4`, `realEffort`) VALUES
(7, 'Expert DB', 'CdS Toulouse', 10, 300, 3000, 13, NULL, NULL, NULL, NULL, 0),
(8, 'Développeur PHP + MySQL', 'CdS Toulouse', 1, 300, 300, 14, NULL, NULL, NULL, NULL, 0),
(10, 'Architecte et administrateur infra', 'CdS Toulouse', 10, 300, 3000, 16, NULL, NULL, NULL, NULL, 0),
(12, 'Équipe de développement', 'CdS Toulouse', 50, 300, 15000, 18, NULL, NULL, NULL, NULL, 0),
(13, 'N2', 'CdS Toulouse', 15, 540, 8100, 19, NULL, NULL, NULL, NULL, 0),
(14, 'N3', 'CdS Toulouse', 18, 540, 9720, 19, NULL, NULL, NULL, NULL, 0),
(15, 'Chef de projet', 'CdS Toulouse', 26, 300, 7800, 23, NULL, NULL, NULL, NULL, 0),
(16, 'Expert', 'CdS Toulouse', 72, 300, 21600, 24, NULL, NULL, NULL, NULL, 0),
(17, 'Chef de projet', 'CdS Toulouse', 28, 350, 9800, 24, NULL, NULL, NULL, NULL, 0),
(18, 'Développeur Talend', 'CdS Toulouse', 10, 300, 3000, 25, NULL, NULL, NULL, NULL, 0),
(19, 'Développeur BO', 'CdS Toulouse', 5, 300, 1500, 25, NULL, NULL, NULL, NULL, 0),
(20, 'Chef de projet', 'CdS Toulouse', 3, 350, 1050, 25, NULL, NULL, NULL, NULL, 0),
(21, 'Développeur HP SM9', 'CdS Toulouse', 10, 300, 3000, 25, NULL, NULL, NULL, NULL, 0),
(22, 'Chef de projet', 'CdS Toulouse', 8, 350, 2800, 26, NULL, NULL, NULL, NULL, 0),
(23, 'Développeur', 'CdS Toulouse', 25, 300, 7500, 26, NULL, NULL, NULL, NULL, 0),
(24, 'Testeur', 'CdS Toulouse', 7, 300, 2100, 26, NULL, NULL, NULL, NULL, 0),
(25, 'Développeur', 'CdS Toulouse', 20, 280, 5600, 29, NULL, NULL, NULL, NULL, 0),
(26, 'Concepteur', 'CdS Toulouse', 4, 350, 1400, 29, NULL, NULL, NULL, NULL, 0),
(27, 'Recette croisée', 'CdS Toulouse', 4, 280, 1120, 29, NULL, NULL, NULL, NULL, 0),
(28, 'Intégration - documentation', 'CdS Toulouse', 4, 300, 1200, 29, NULL, NULL, NULL, NULL, 0),
(29, 'Recette client', 'CdS Toulouse', 4, 300, 1200, 29, NULL, NULL, NULL, NULL, 0),
(30, 'Pilotage', 'CdS Toulouse', 4, 350, 1400, 29, NULL, NULL, NULL, NULL, 0),
(31, 'Directeur CdS', 'CdS Toulouse', 218, 493, 107474, 32, NULL, NULL, NULL, NULL, 0),
(32, 'Directeur opérationnel', 'CdS Toulouse', 109, 443, 48287, 32, NULL, NULL, NULL, NULL, 0),
(33, 'Avant-vendeur', 'CdS Toulouse', 100, 350, 35000, 34, NULL, NULL, NULL, NULL, 0),
(34, 'Expert', 'CdS Toulouse', 25, 300, 7500, 22, NULL, NULL, NULL, NULL, 0),
(35, 'SPE', 'CdS Toulouse', 5, 479, 2395, 35, NULL, NULL, NULL, NULL, 0),
(36, 'MCO ITSM N1/N2/N3', 'CdS Toulouse', 462, 304, 140448, 44, NULL, NULL, NULL, NULL, 0),
(37, 'MCO BO', 'CdS Toulouse', 36, 304, 10944, 45, NULL, NULL, NULL, NULL, 0),
(38, 'Expert ITSM', 'CdS Toulouse', 36, 385, 13860, 46, NULL, NULL, NULL, NULL, 0),
(39, 'Project Manager Senior Consultant', 'CdS Toulouse', 40, 386, 15440, 47, NULL, NULL, NULL, NULL, 0),
(40, 'Pilotage transfert', 'CdS Toulouse', 8, 324, 2592, 48, NULL, NULL, NULL, NULL, 0),
(41, 'CdP MCO', 'CdS Toulouse', 80, 421, 33680, 48, NULL, NULL, NULL, NULL, 0),
(42, 'CdP opérationnel', 'CdS Toulouse', 8, 421, 3368, 48, NULL, NULL, NULL, NULL, 0),
(43, 'Sol-PM-ExDir', 'CdS Toulouse', 8, 825, 6600, 49, NULL, NULL, NULL, NULL, 0),
(44, 'CdsTls-PM-PrCslt', 'CdS Toulouse', 11, 443, 4873, 49, NULL, NULL, NULL, NULL, 0),
(45, 'CdsTls-PM-Cslt', 'CdS Toulouse', 119, 334, 39746, 49, NULL, NULL, NULL, NULL, 0),
(46, 'Init RUN - CdP', 'CdS Toulouse', 20, 413, 8260, 69, NULL, NULL, NULL, NULL, 0),
(47, 'Init RUN - AL Cslt', 'CdS Toulouse', 32, 264, 8448, 69, NULL, NULL, NULL, NULL, 0),
(48, 'Init RUN - OST Cslt', 'CdS Toulouse', 32, 186, 5952, 69, NULL, NULL, NULL, NULL, 0),
(49, 'RUN Y1 - CdP', 'CdS Toulouse', 47, 413, 19411, 69, NULL, NULL, NULL, NULL, 0),
(50, 'RUN Y1 - AL Cslt', 'CdS Toulouse', 142, 264, 37488, 69, NULL, NULL, NULL, NULL, 0),
(51, 'RUN Y1 - OST Cslt', 'CdS Toulouse', 142, 186, 26412, 69, NULL, NULL, NULL, NULL, 0),
(52, 'RUN Y2 - CdP', 'CdS Toulouse', 35, 413, 14455, 69, NULL, NULL, NULL, NULL, 0),
(53, 'RUN Y2 - AL Cslt', 'CdS Toulouse', 105, 264, 27720, 69, NULL, NULL, NULL, NULL, 0),
(54, 'RUN Y2 - OST Cslt', 'CdS Toulouse', 105, 186, 19530, 69, NULL, NULL, NULL, NULL, 0),
(55, 'RUN Y1 - AL Senior', 'Autre', 26, 295, 7670, 69, NULL, NULL, NULL, NULL, 0),
(56, 'RUN Y2 - AL Senior', 'Autre', 27, 295, 7965, 69, NULL, NULL, NULL, NULL, 0),
(57, 'RUN Y3 - CdP', 'CdS Toulouse', 40, 413, 16520, 69, NULL, NULL, NULL, NULL, 0),
(58, 'RUN Y3 - AL Cslt', 'CdS Toulouse', 119, 264, 31416, 69, NULL, NULL, NULL, NULL, 0),
(59, 'RUN Y3 - OST Cslt', 'CdS Toulouse', 119, 186, 22134, 69, NULL, NULL, NULL, NULL, 0),
(60, 'RUN Y3 - AL Senior', 'Autre', 28, 295, 8260, 69, NULL, NULL, NULL, NULL, 0),
(65, 'Mixed profile', 'CdS Toulouse', 20, 294.8, 5896, 75, NULL, NULL, NULL, NULL, 0),
(66, 'Mixed profile', 'CdS Toulouse', 20, 310.85, 6217, 74, NULL, NULL, NULL, NULL, 0),
(67, 'Mixed profile', 'CdS Toulouse', 24, 301.2, 7228.799999999999, 76, NULL, NULL, NULL, NULL, 0),
(68, 'Mixed profile', 'CdS Toulouse', 13, 319.92, 4158.96, 77, NULL, NULL, NULL, NULL, 0),
(69, 'Cedric', 'CdS Toulouse', 63, 68, 4284, 70, NULL, NULL, NULL, NULL, 0),
(70, 'Xavier', 'CdS Toulouse', 30, 386, 11580, 70, NULL, NULL, NULL, NULL, 0),
(71, 'Alexandre', 'CdS Toulouse', 24, 375, 9000, 70, NULL, NULL, NULL, NULL, 0),
(72, 'Olivier', 'CdS Toulouse', 5, 334, 1670, 70, NULL, NULL, NULL, NULL, 0),
(73, 'Romain', 'CdS Toulouse', 2, 305, 610, 70, NULL, NULL, NULL, NULL, 0),
(74, 'TBD', 'CdS Toulouse', 60, 300, 18000, 70, NULL, NULL, NULL, NULL, 0),
(75, 'Jean-Christophe Bourion', 'CdS Toulouse', 5, 386, 1930, 70, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Structure de la table `__Application_Change_`
--

DROP TABLE IF EXISTS `__Application_Change_`;
CREATE TABLE IF NOT EXISTS `__Application_Change_` (
`idApplicationChange` int(11) NOT NULL,
  `Name` text NOT NULL,
  `idProgram` int(11) NOT NULL,
  `idComplexity` int(11) NOT NULL,
  `UseDefaultCost` tinyint(1) NOT NULL DEFAULT '1',
  `AnalyseSpecific` decimal(10,4) NOT NULL,
  `DevSpecific` decimal(10,4) NOT NULL,
  `TestSpecific` decimal(10,4) NOT NULL,
  `Specific` varchar(20) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Application_Change_`
--

INSERT INTO `__Application_Change_` (`idApplicationChange`, `Name`, `idProgram`, `idComplexity`, `UseDefaultCost`, `AnalyseSpecific`, `DevSpecific`, `TestSpecific`, `Specific`) VALUES
(1, 'ASPIRE', 5, 2, 1, 0.0000, 0.0000, 0.0000, 'ARA'),
(2, 'ATREF', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(3, 'MAGIC', 3, 2, 0, 0.4000, 0.5000, 0.1000, 'ARA'),
(4, 'AIFU', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(5, 'REMEDY_SAD', 3, 1, 1, 0.0000, 0.0000, 0.0000, ''),
(6, 'AAL', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(7, 'ICT CATALOGS', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(8, 'ETICKET', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(9, 'MASTERPLAN', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(10, 'I4U', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(11, 'AML', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(12, 'AFROM', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(13, 'PWINIT', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(14, 'PC BACKUP', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(15, 'DROP', 5, 2, 1, 0.0000, 0.0000, 0.0000, ''),
(16, 'GDX', 5, 1, 1, 0.0000, 0.0000, 0.0000, ''),
(17, 'BI', 6, 1, 1, 0.0000, 0.0000, 0.0000, ''),
(18, 'SMARTER', 6, 1, 1, 0.8000, 0.0000, 0.1000, ''),
(19, 'SEMAPHORE', 3, 1, 1, 0.0000, 0.0000, 0.0000, ''),
(20, 'CSC', 5, 2, 1, 0.0000, 0.0000, 0.0000, '');

-- --------------------------------------------------------

--
-- Structure de la table `__CapacityPlanning`
--

DROP TABLE IF EXISTS `__CapacityPlanning`;
CREATE TABLE IF NOT EXISTS `__CapacityPlanning` (
`idCapacityPlanning` int(11) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idTeamMember` int(11) NOT NULL,
  `statut` enum('en cours','non démarrée','terminée') DEFAULT 'en cours',
  `realisation` enum('nominal','excédent','dépassement') DEFAULT 'nominal',
  `decalage` int(11) DEFAULT '0',
  `delai` enum('nominal','en retard','en avance') DEFAULT 'nominal',
  `raf` enum('inchangé','diminué','augmenté') DEFAULT 'inchangé',
  `raf_valeur` int(11) DEFAULT '0',
  `replanification` date DEFAULT NULL,
  `dateInitiale` date DEFAULT NULL,
  `editable` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__CapacityPlanning`
--

INSERT INTO `__CapacityPlanning` (`idCapacityPlanning`, `timestamp`, `idTeamMember`, `statut`, `realisation`, `decalage`, `delai`, `raf`, `raf_valeur`, `replanification`, `dateInitiale`, `editable`) VALUES
(44, '2014-12-17 09:32:40', 19, 'en cours', 'excédent', 1, 'nominal', 'diminué', 1, NULL, NULL, 0),
(45, '2014-12-17 09:32:40', 24, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 0),
(46, '2014-12-17 09:32:40', 20, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 0),
(47, '2014-12-17 09:32:40', 16, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 0),
(48, '2014-12-31 14:19:33', 28, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(49, '2014-12-31 14:19:33', 93, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(50, '2014-12-31 14:19:33', 95, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(51, '2014-12-31 14:19:33', 94, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(52, '2014-12-31 14:19:33', 92, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(53, '2014-12-31 14:19:33', 90, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(54, '2014-12-31 14:19:33', 89, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(55, '2014-12-30 14:45:27', 97, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(56, '2014-12-30 14:45:27', 98, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(57, '2014-12-30 14:45:27', 104, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(58, '2014-12-30 14:45:27', 103, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(59, '2014-12-30 14:45:27', 102, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(60, '2014-12-30 14:45:27', 99, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(61, '2014-12-30 14:45:27', 100, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, NULL, NULL, 1),
(62, '2014-12-31 14:19:33', 96, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, '2015-01-16', '2015-01-16', 1),
(63, '2014-12-31 14:19:33', 106, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, '2015-01-09', '2015-01-09', 1),
(64, '2014-12-31 14:19:33', 105, 'en cours', 'nominal', 0, 'nominal', 'inchangé', 0, '2015-01-09', '2015-01-09', 1),
(65, '2015-02-05 13:33:47', 166, 'en cours', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(66, '2015-02-05 13:33:47', 114, 'en cours', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(67, '2015-02-06 14:54:11', 147, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(68, '2015-02-06 14:54:18', 147, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(69, '2015-02-12 09:34:12', 147, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(70, '2015-02-19 11:04:18', 234, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(71, '2015-02-19 11:06:09', 234, 'en cours', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(72, '2015-02-19 11:06:11', 234, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(73, '2015-02-19 11:06:11', 234, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(74, '2015-02-25 14:13:21', 264, 'en cours', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(75, '2015-02-25 14:13:21', 147, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(76, '2015-04-20 14:23:43', 688, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1),
(77, '2015-04-20 14:23:55', 688, 'terminée', 'nominal', 2, 'nominal', NULL, NULL, NULL, NULL, 1),
(78, '2015-04-20 14:23:59', 688, 'terminée', 'nominal', 0, 'nominal', NULL, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Structure de la table `__Codes_SFP__`
--

DROP TABLE IF EXISTS `__Codes_SFP__`;
CREATE TABLE IF NOT EXISTS `__Codes_SFP__` (
`idCodesSFP` int(11) NOT NULL,
  `Aramis` varchar(50) NOT NULL,
  `Client` varchar(100) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Actif` enum('oui','non') NOT NULL DEFAULT 'oui'
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

--
-- Contenu de la table `__Codes_SFP__`
--

INSERT INTO `__Codes_SFP__` (`idCodesSFP`, `Aramis`, `Client`, `Name`, `Actif`) VALUES
(1, 'FR0114-FNLNOZ', 'Airbus Helicopters', 'TMA S400', 'oui'),
(2, 'FR01010433161', 'La Banque Postale', 'TMA Classique', 'oui'),
(3, 'FR0113-8EY6RU', 'CEA', 'TMA Nautiles', 'oui'),
(4, 'FR0113-BDZ9S6', 'Airbus', 'Bundle BAC', 'oui'),
(5, 'FR0113-BKZXIX', 'Airbus', 'Bundle Tools', 'non'),
(6, 'FR0114-DZ2VKM', 'Total', 'TMA ITSM', 'oui'),
(7, 'FR0114-F5D4MY', 'Airbus', 'Bundle Tools', 'oui'),
(8, 'FR0115-IRMDX4', 'Airbus', 'Bundle Tools', 'oui'),
(9, 'FR0115-ISOEYV', 'Airbus', 'ARTS V2', 'oui'),
(10, 'FR0115-IRMDX5', 'Total', 'TMA ITSM', 'oui');

-- --------------------------------------------------------

--
-- Structure de la table `__Complexity_`
--

DROP TABLE IF EXISTS `__Complexity_`;
CREATE TABLE IF NOT EXISTS `__Complexity_` (
`idComplexity` int(11) NOT NULL,
  `TypeComplexity` varchar(15) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Complexity_`
--

INSERT INTO `__Complexity_` (`idComplexity`, `TypeComplexity`) VALUES
(1, 'Complex'),
(2, 'Standard');

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `__CostApplication__`
--
DROP VIEW IF EXISTS `__CostApplication__`;
CREATE TABLE IF NOT EXISTS `__CostApplication__` (
`Application` text
,`ProgramName` varchar(50)
,`Cost` decimal(10,4)
,`typeComplexity` varchar(15)
,`Task` varchar(30)
,`Analyse` decimal(15,2)
,`PartAnalyse` decimal(10,4)
,`Dev` decimal(15,2)
,`PartDev` decimal(10,4)
,`Test` decimal(15,2)
,`PartTest` decimal(10,4)
,`Specificity` varchar(20)
,`SpecificCost` decimal(20,8)
,`FullCostSpec` decimal(10,4)
,`idProgram` int(11)
);
-- --------------------------------------------------------

--
-- Structure de la table `__Eagle_Entities__`
--

DROP TABLE IF EXISTS `__Eagle_Entities__`;
CREATE TABLE IF NOT EXISTS `__Eagle_Entities__` (
`idEntities` int(11) NOT NULL,
  `Name` varchar(100) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Eagle_Entities__`
--

INSERT INTO `__Eagle_Entities__` (`idEntities`, `Name`) VALUES
(1, 'Centre de Services Toulouse'),
(2, 'Devoteam Expertise Régions'),
(3, 'Koncept'),
(4, 'FPT Software'),
(5, 'Innovans'),
(6, 'Devoteam Solution'),
(7, 'Centre de Services Madrid');

-- --------------------------------------------------------

--
-- Structure de la table `__Eagle_Metiers__`
--

DROP TABLE IF EXISTS `__Eagle_Metiers__`;
CREATE TABLE IF NOT EXISTS `__Eagle_Metiers__` (
`idMetier` int(11) NOT NULL,
  `Name` enum('Project Management','Information System Organization Management','Application Lifecycle','Infrastructures Design Build Run','Methods Quality Security','On Site technician') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Eagle_Metiers__`
--

INSERT INTO `__Eagle_Metiers__` (`idMetier`, `Name`) VALUES
(1, 'Project Management'),
(2, 'Information System Organization Management'),
(3, 'Application Lifecycle'),
(4, 'Infrastructures Design Build Run'),
(5, 'Methods Quality Security'),
(6, 'On Site technician');

-- --------------------------------------------------------

--
-- Structure de la table `__Eagle_Seniorites__`
--

DROP TABLE IF EXISTS `__Eagle_Seniorites__`;
CREATE TABLE IF NOT EXISTS `__Eagle_Seniorites__` (
`idSeniorite` int(11) NOT NULL,
  `Name` enum('Consultant','Senior Consultant','Principal Consultant','Expert Director') NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Eagle_Seniorites__`
--

INSERT INTO `__Eagle_Seniorites__` (`idSeniorite`, `Name`) VALUES
(1, 'Consultant'),
(2, 'Senior Consultant'),
(3, 'Principal Consultant'),
(4, 'Expert Director');

-- --------------------------------------------------------

--
-- Structure de la table `__Eagle_Standard_Costs__`
--

DROP TABLE IF EXISTS `__Eagle_Standard_Costs__`;
CREATE TABLE IF NOT EXISTS `__Eagle_Standard_Costs__` (
`idStandardCosts` int(11) NOT NULL,
  `idEntite` int(11) NOT NULL,
  `idMetier` int(11) NOT NULL,
  `idSeniorite` int(11) NOT NULL,
  `Cost` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Eagle_Standard_Costs__`
--

INSERT INTO `__Eagle_Standard_Costs__` (`idStandardCosts`, `idEntite`, `idMetier`, `idSeniorite`, `Cost`) VALUES
(1, 1, 1, 1, 334),
(2, 1, 1, 2, 386),
(3, 1, 1, 3, 443),
(4, 1, 1, 4, 493),
(5, 1, 2, 1, 299),
(6, 1, 2, 2, 334),
(7, 1, 2, 3, 413),
(8, 1, 2, 4, 507),
(9, 1, 3, 1, 264),
(10, 1, 3, 2, 304),
(11, 1, 3, 3, 418),
(12, 1, 3, 4, 477),
(13, 1, 4, 1, 284),
(14, 1, 4, 2, 305),
(15, 1, 4, 3, 381),
(16, 1, 4, 4, 460),
(17, 1, 5, 1, 303),
(18, 1, 5, 2, 358),
(19, 1, 5, 3, 388),
(20, 1, 5, 4, 528),
(21, 1, 6, 1, 186),
(22, 1, 6, 2, 208),
(23, 2, 1, 1, 324),
(24, 2, 1, 2, 375),
(25, 2, 1, 3, 430),
(26, 2, 1, 4, 479),
(27, 2, 2, 1, 290),
(28, 2, 2, 2, 324),
(29, 2, 2, 3, 401),
(30, 2, 2, 4, 492),
(31, 2, 3, 1, 256),
(32, 2, 3, 2, 295),
(33, 2, 3, 3, 406),
(34, 2, 3, 4, 463),
(35, 2, 4, 1, 276),
(36, 2, 4, 2, 296),
(37, 2, 4, 3, 370),
(38, 2, 4, 4, 447),
(39, 2, 5, 1, 294),
(40, 2, 5, 2, 348),
(41, 2, 5, 3, 377),
(42, 2, 5, 4, 513),
(43, 2, 6, 1, 181),
(44, 2, 6, 2, 202),
(45, 3, 3, 2, 280),
(46, 4, 3, 2, 110),
(47, 5, 3, 2, 300),
(48, 6, 1, 1, 381),
(49, 6, 1, 2, 421),
(50, 6, 1, 3, 579),
(51, 6, 1, 4, 825),
(52, 6, 2, 1, 321),
(53, 6, 2, 2, 426),
(54, 6, 2, 3, 651),
(55, 6, 2, 4, 944),
(56, 6, 3, 1, 325),
(57, 6, 3, 2, 385),
(58, 6, 3, 3, 599),
(59, 6, 3, 4, 1020),
(60, 6, 4, 1, 333),
(61, 6, 4, 2, 404),
(62, 6, 4, 3, 577),
(63, 6, 4, 4, 923),
(64, 6, 5, 1, 342),
(65, 6, 5, 2, 400),
(66, 6, 5, 3, 646),
(67, 6, 5, 4, 1149),
(68, 7, 1, 1, 0),
(69, 7, 1, 2, 0),
(70, 7, 1, 3, 0),
(71, 7, 1, 4, 0),
(72, 7, 2, 1, 0),
(73, 7, 2, 2, 0),
(74, 7, 2, 3, 0),
(75, 7, 2, 4, 0),
(76, 7, 3, 1, 190),
(77, 7, 3, 2, 234),
(78, 7, 3, 3, 0),
(79, 7, 3, 4, 0),
(80, 7, 4, 1, 0),
(81, 7, 4, 2, 0),
(82, 7, 4, 3, 0),
(83, 7, 4, 4, 0),
(84, 7, 5, 1, 0),
(85, 7, 5, 2, 0),
(86, 7, 5, 3, 0),
(87, 7, 5, 4, 0),
(88, 7, 6, 1, 0),
(89, 7, 6, 2, 0);

-- --------------------------------------------------------

--
-- Structure de la table `__Employee_Eagle_profile__`
--

DROP TABLE IF EXISTS `__Employee_Eagle_profile__`;
CREATE TABLE IF NOT EXISTS `__Employee_Eagle_profile__` (
`idEmployeeEagleProfile` int(11) NOT NULL,
  `idEntities` int(11) NOT NULL,
  `idEmployee` int(11) NOT NULL,
  `idMetier` int(11) NOT NULL,
  `idSeniorite` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__Employee_Eagle_profile__`
--

INSERT INTO `__Employee_Eagle_profile__` (`idEmployeeEagleProfile`, `idEntities`, `idEmployee`, `idMetier`, `idSeniorite`) VALUES
(1, 1, 35, 4, 1),
(2, 1, 46, 1, 3),
(3, 1, 24, 1, 4),
(4, 1, 72, 3, 2),
(5, 1, 69, 3, 1),
(6, 1, 64, 3, 1),
(7, 1, 102, 1, 2),
(8, 1, 79, 3, 1),
(9, 1, 103, 2, 3),
(10, 1, 67, 4, 1),
(11, 4, 96, 3, 2),
(12, 4, 97, 3, 2),
(13, 1, 80, 3, 2),
(14, 1, 81, 3, 1),
(15, 1, 17, 3, 1),
(16, 3, 82, 3, 2),
(17, 1, 53, 1, 2),
(18, 1, 68, 3, 2),
(19, 1, 66, 1, 1),
(20, 1, 78, 3, 2),
(21, 5, 83, 3, 2),
(22, 1, 65, 2, 2),
(23, 1, 73, 6, 1),
(24, 1, 77, 3, 2),
(25, 1, 101, 2, 3),
(26, 1, 71, 3, 2),
(27, 1, 75, 4, 2),
(28, 1, 37, 3, 2),
(29, 1, 84, 3, 1),
(30, 1, 70, 3, 2),
(31, 1, 63, 5, 2),
(32, 1, 39, 3, 1),
(33, 1, 76, 3, 1),
(34, 1, 74, 1, 2),
(35, 1, 86, 6, 1),
(36, 2, 106, 5, 2),
(37, 1, 85, 3, 3),
(38, 1, 109, 1, 1),
(39, 2, 55, 1, 2),
(40, 2, 48, 1, 4),
(41, 2, 58, 1, 4),
(42, 1, 117, 4, 3),
(43, 2, 112, 3, 2),
(44, 6, 123, 3, 2),
(45, 1, 124, 1, 2),
(46, 1, 127, 1, 2),
(47, 2, 129, 2, 2),
(48, 2, 131, 2, 2),
(49, 3, 137, 3, 2),
(50, 3, 138, 3, 2),
(51, 1, 139, 3, 1),
(52, 7, 140, 3, 2),
(53, 2, 142, 1, 3),
(54, 7, 149, 3, 1),
(55, 1, 146, 3, 2),
(56, 7, 150, 3, 1),
(57, 1, 151, 3, 1);

-- --------------------------------------------------------

--
-- Structure de la table `__scenarioscapacityplanning`
--

DROP TABLE IF EXISTS `__scenarioscapacityplanning`;
CREATE TABLE IF NOT EXISTS `__scenarioscapacityplanning` (
  `idScenario` int(11) NOT NULL,
  `seuil` int(11) NOT NULL,
  `Semaine_0` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_1` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_2` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_3` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_4` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_5` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_6` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_7` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_8` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_9` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_10` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_11` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_12` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_13` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_14` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_15` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_16` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_17` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_18` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_19` enum('vert','jaune','rouge') NOT NULL,
  `Semaine_20` enum('vert','jaune','rouge') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__scenarioscapacityplanning`
--

INSERT INTO `__scenarioscapacityplanning` (`idScenario`, `seuil`, `Semaine_0`, `Semaine_1`, `Semaine_2`, `Semaine_3`, `Semaine_4`, `Semaine_5`, `Semaine_6`, `Semaine_7`, `Semaine_8`, `Semaine_9`, `Semaine_10`, `Semaine_11`, `Semaine_12`, `Semaine_13`, `Semaine_14`, `Semaine_15`, `Semaine_16`, `Semaine_17`, `Semaine_18`, `Semaine_19`, `Semaine_20`) VALUES
(0, 120, 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge'),
(1, 110, 'jaune', 'jaune', 'jaune', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge'),
(2, 95, 'vert', 'vert', 'jaune', 'jaune', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge', 'rouge'),
(3, 80, 'rouge', 'jaune', 'jaune', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert'),
(4, 50, 'rouge', 'rouge', 'jaune', 'jaune', 'jaune', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert'),
(5, -1, 'rouge', 'rouge', 'rouge', 'rouge', 'jaune', 'jaune', 'jaune', 'jaune', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert', 'vert');

-- --------------------------------------------------------

--
-- Structure de la table `__task_cost_`
--

DROP TABLE IF EXISTS `__task_cost_`;
CREATE TABLE IF NOT EXISTS `__task_cost_` (
`idTaskCost` int(11) NOT NULL,
  `Task` varchar(30) NOT NULL,
  `idComplexity` int(11) NOT NULL,
  `Cost` decimal(10,4) NOT NULL,
  `PartAnalyse` decimal(10,4) NOT NULL DEFAULT '0.4000',
  `PartDev` decimal(10,4) NOT NULL DEFAULT '0.4000',
  `PartTest` decimal(10,4) NOT NULL DEFAULT '0.2000',
  `PartEMA` decimal(10,4) NOT NULL DEFAULT '0.6000',
  `PartOther` decimal(10,4) NOT NULL DEFAULT '0.5000'
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

--
-- Contenu de la table `__task_cost_`
--

INSERT INTO `__task_cost_` (`idTaskCost`, `Task`, `idComplexity`, `Cost`, `PartAnalyse`, `PartDev`, `PartTest`, `PartEMA`, `PartOther`) VALUES
(1, 'Evolution', 1, 532.8600, 0.4000, 0.4000, 0.2000, 0.0000, 0.0000),
(2, 'Evolution', 2, 440.3800, 0.4000, 0.4000, 0.2000, 0.0000, 0.0000),
(3, 'Study', 1, 831.6000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000),
(4, 'Study', 2, 540.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000),
(5, 'ARA', 1, 689.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.1875),
(6, 'ARA', 2, 530.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.1875);

-- --------------------------------------------------------

--
-- Doublure de structure pour la vue `__Users_`
--
DROP VIEW IF EXISTS `__Users_`;
CREATE TABLE IF NOT EXISTS `__Users_` (
`FullName` varchar(50)
,`IdContact` int(11)
,`idEmployee` int(11)
,`idProfile` int(11)
,`ProfileName` varchar(50)
);
-- --------------------------------------------------------

--
-- Structure de la vue `__CostApplication__`
--
DROP TABLE IF EXISTS `__CostApplication__`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `__CostApplication__` AS select `a`.`Name` AS `Application`,`p`.`ProgramName` AS `ProgramName`,`t`.`Cost` AS `Cost`,`c`.`TypeComplexity` AS `typeComplexity`,`t`.`Task` AS `Task`,(case when ((`t`.`Task` = 'Study') or (`a`.`UseDefaultCost` <> 0)) then round((`t`.`Cost` * `t`.`PartAnalyse`),2) else round((`t`.`Cost` * `a`.`AnalyseSpecific`),2) end) AS `Analyse`,(case when ((`t`.`Task` = 'Study') or (`a`.`UseDefaultCost` <> 0)) then `t`.`PartAnalyse` else `a`.`AnalyseSpecific` end) AS `PartAnalyse`,(case when ((`t`.`Task` = 'Study') or (`a`.`UseDefaultCost` <> 0)) then round((`t`.`Cost` * `t`.`PartDev`),2) else round((`t`.`Cost` * `a`.`DevSpecific`),2) end) AS `Dev`,(case when ((`t`.`Task` = 'Study') or (`a`.`UseDefaultCost` <> 0)) then `t`.`PartDev` else `a`.`DevSpecific` end) AS `PartDev`,(case when ((`t`.`Task` = 'Study') or (`a`.`UseDefaultCost` <> 0)) then round((`t`.`Cost` * `t`.`PartTest`),2) else round((`t`.`Cost` * `a`.`TestSpecific`),2) end) AS `Test`,(case when ((`t`.`Task` = 'Study') or (`a`.`UseDefaultCost` <> 0)) then `t`.`PartTest` else `a`.`TestSpecific` end) AS `PartTest`,`a`.`Specific` AS `Specificity`,(case when (`a`.`Specific` <> '') then (`tspec`.`Cost` * `tspec`.`PartOther`) else 0 end) AS `SpecificCost`,(case when (`a`.`Specific` <> '') then `tspec`.`Cost` else 0 end) AS `FullCostSpec`,`p`.`IdProgram` AS `idProgram` from ((((`__Application_Change_` `a` join `__Complexity_` `c`) join `__task_cost_` `t` on((`t`.`Task` in ('Evolution','Study')))) join `__task_cost_` `tspec` on((`tspec`.`idComplexity` = `a`.`idComplexity`))) join `program` `p`) where ((`t`.`idComplexity` = `a`.`idComplexity`) and (`t`.`idComplexity` = `c`.`idComplexity`) and (`a`.`idProgram` = `p`.`IdProgram`) and (`tspec`.`Task` not in ('Evolution','Study'))) order by `p`.`IdProgram`,`a`.`Name`,`t`.`Task`;

-- --------------------------------------------------------

--
-- Structure de la vue `__Users_`
--
DROP TABLE IF EXISTS `__Users_`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `__Users_` AS select `contact`.`FullName` AS `FullName`,`contact`.`IdContact` AS `IdContact`,`employee`.`idEmployee` AS `idEmployee`,`employee`.`idProfile` AS `idProfile`,`resourceprofiles`.`ProfileName` AS `ProfileName` from ((`contact` join `employee`) join `resourceprofiles`) where ((`contact`.`IdContact` = `employee`.`idContact`) and (`employee`.`idProfile` = `resourceprofiles`.`IdProfile`)) order by `contact`.`IdContact`,`contact`.`FullName`;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `activityseller`
--
ALTER TABLE `activityseller`
 ADD PRIMARY KEY (`idActivitySeller`), ADD KEY `ACTIVITYSELLER_ACTIVITY_FK` (`idActivity`), ADD KEY `ACTIVITYSELLER_SELLER_FK` (`idSeller`);

--
-- Index pour la table `assumptionreassessmentlog`
--
ALTER TABLE `assumptionreassessmentlog`
 ADD PRIMARY KEY (`IdLog`), ADD KEY `ASSREALOG_ASSREG_FK` (`IdAssumption`);

--
-- Index pour la table `assumptionregister`
--
ALTER TABLE `assumptionregister`
 ADD PRIMARY KEY (`IdAssumption`), ADD KEY `ASSUMPTIONREGISTER_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `bscdimension`
--
ALTER TABLE `bscdimension`
 ADD PRIMARY KEY (`idBscDimension`), ADD KEY `BSCDIM_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `budgetaccounts`
--
ALTER TABLE `budgetaccounts`
 ADD PRIMARY KEY (`IdBudgetAccount`), ADD KEY `BUDGETACCOUNTS_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `calendarbase`
--
ALTER TABLE `calendarbase`
 ADD PRIMARY KEY (`idCalendarBase`), ADD KEY `CALENDARBASE_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `calendarbaseexceptions`
--
ALTER TABLE `calendarbaseexceptions`
 ADD PRIMARY KEY (`IdCalendarBaseException`), ADD KEY `CALBASEEXCEP_CALBASE_FK` (`IdCalendarBase`);

--
-- Index pour la table `category`
--
ALTER TABLE `category`
 ADD PRIMARY KEY (`IdCategory`), ADD KEY `CATEGORY_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `changecontrol`
--
ALTER TABLE `changecontrol`
 ADD PRIMARY KEY (`IdChange`), ADD KEY `CHANGECONTROL_CHANGETYPE_FK` (`IdChangeType`), ADD KEY `CHANGECONTROL_WBSNODE_FK` (`IdWBSNode`), ADD KEY `CHANGECONTROL_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `changetype`
--
ALTER TABLE `changetype`
 ADD PRIMARY KEY (`idChangeType`) USING BTREE, ADD KEY `CHANGETYPE_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `chargescosts`
--
ALTER TABLE `chargescosts`
 ADD PRIMARY KEY (`idChargesCosts`), ADD KEY `CHARGESCOSTS_PROJECT_FK` (`idProject`);

--
-- Index pour la table `checklist`
--
ALTER TABLE `checklist`
 ADD PRIMARY KEY (`idChecklist`), ADD KEY `CHECKLIST_WBSNODE_FK` (`idWbsnode`);

--
-- Index pour la table `company`
--
ALTER TABLE `company`
 ADD PRIMARY KEY (`IdCompany`);

--
-- Index pour la table `contact`
--
ALTER TABLE `contact`
 ADD PRIMARY KEY (`IdContact`), ADD KEY `CONTACT_COMPANY_FK` (`IdCompany`);

--
-- Index pour la table `contentfile`
--
ALTER TABLE `contentfile`
 ADD PRIMARY KEY (`idContentFile`) USING BTREE;

--
-- Index pour la table `contracttype`
--
ALTER TABLE `contracttype`
 ADD PRIMARY KEY (`IdContractType`), ADD KEY `CONTRACTTYPE_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `customer`
--
ALTER TABLE `customer`
 ADD PRIMARY KEY (`IdCustomer`), ADD KEY `CUSTOMER_COMPANY_FK` (`IdCompany`), ADD KEY `CUSTOMER_CUSTOMERTYPE_FK` (`idCustomerType`);

--
-- Index pour la table `customertype`
--
ALTER TABLE `customertype`
 ADD PRIMARY KEY (`idCustomerType`), ADD KEY `CUSTOMERTYPE_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `directcosts`
--
ALTER TABLE `directcosts`
 ADD PRIMARY KEY (`IdDirectCosts`), ADD KEY `DIRECTCOSTS_BUDGETACCOUNTS_FK` (`IdBudgetAccount`), ADD KEY `DIRECTCOSTS_PROJECTCOSTS_FK` (`IdProjectCosts`);

--
-- Index pour la table `documentation`
--
ALTER TABLE `documentation`
 ADD PRIMARY KEY (`idDocumentation`), ADD KEY `DOCUMENTATION_CONTENTFILE_FK` (`idContentFile`), ADD KEY `DOCUMENTATION_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `documentproject`
--
ALTER TABLE `documentproject`
 ADD PRIMARY KEY (`idDocumentProject`), ADD KEY `DOCUMENTPROJECT_PROJECT_FK` (`idProject`);

--
-- Index pour la table `employee`
--
ALTER TABLE `employee`
 ADD PRIMARY KEY (`idEmployee`) USING BTREE, ADD KEY `EMPLOYEE_RSMANAGER_FK` (`idResourceManager`), ADD KEY `EMPLOYEE_CALENDARBASE_FK` (`idCalendarBase`), ADD KEY `EMPLOYEE_CONTACT_FK` (`idContact`), ADD KEY `EMPLOYEE_PERFORG_FK` (`idPerfOrg`), ADD KEY `EMPLOYEE_RESPROFILES_FK` (`idProfile`);

--
-- Index pour la table `expenseaccounts`
--
ALTER TABLE `expenseaccounts`
 ADD PRIMARY KEY (`IdExpenseAccount`), ADD KEY `EXPENSEACCOUNTS_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `expenses`
--
ALTER TABLE `expenses`
 ADD PRIMARY KEY (`IdExpense`), ADD KEY `EXPENSES_BUDGETACCOUNTS_FK` (`IdBudgetAccount`), ADD KEY `EXPENSES_PROJECTCOSTS_FK` (`IdProjectCosts`);

--
-- Index pour la table `expensesheet`
--
ALTER TABLE `expensesheet`
 ADD PRIMARY KEY (`idExpenseSheet`), ADD KEY `EXPENSESHEET_EXPENSE_FK` (`idExpense`), ADD KEY `EXPENSESHEET_OPERATION_FK` (`idOperation`), ADD KEY `EXPENSESHEET_EMPLOYEE_FK` (`idEmployee`), ADD KEY `EXPENSESHEET_EXPACCOUNTS_FK` (`idExpenseAccount`), ADD KEY `EXPENSESHEET_PROJECT_FK` (`idProject`);

--
-- Index pour la table `expensesheetcomment`
--
ALTER TABLE `expensesheetcomment`
 ADD PRIMARY KEY (`idExpenseSheetComment`), ADD KEY `EXPSHEETCOMMENT_EXPSHEET_FK` (`idExpenseSheet`);

--
-- Index pour la table `fundingsource`
--
ALTER TABLE `fundingsource`
 ADD PRIMARY KEY (`idFundingSource`), ADD KEY `FUNDINGSOURCE_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `geography`
--
ALTER TABLE `geography`
 ADD PRIMARY KEY (`idGeography`) USING BTREE, ADD KEY `GEOGRAPHY_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `incomes`
--
ALTER TABLE `incomes`
 ADD PRIMARY KEY (`idIncome`) USING BTREE, ADD KEY `INCOMES_PROJECT_FK` (`idProject`);

--
-- Index pour la table `issuelog`
--
ALTER TABLE `issuelog`
 ADD PRIMARY KEY (`IdIssue`), ADD KEY `ISSUELOG_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `iwo`
--
ALTER TABLE `iwo`
 ADD PRIMARY KEY (`IdIWO`), ADD KEY `IWO_PROJECTCOSTS_FK` (`IdProjectCosts`);

--
-- Index pour la table `logprojectstatus`
--
ALTER TABLE `logprojectstatus`
 ADD PRIMARY KEY (`idLogProjectStatus`), ADD KEY `LOGPROJECTSTATUS_EMPLOYEE_FK` (`idEmployee`), ADD KEY `LOGPROJECTSTATUS_PROJECT_FK` (`idProject`);

--
-- Index pour la table `metrickpi`
--
ALTER TABLE `metrickpi`
 ADD PRIMARY KEY (`idMetricKpi`) USING BTREE, ADD KEY `METRICKPI_BSCDIMENSION_FK` (`idBscDimension`), ADD KEY `METRICKPI_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `milestones`
--
ALTER TABLE `milestones`
 ADD PRIMARY KEY (`IdMilestone`), ADD KEY `MILESTONE_ACTIVITY_FK` (`IdActivity`), ADD KEY `MILESTONE_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `operation`
--
ALTER TABLE `operation`
 ADD PRIMARY KEY (`IdOperation`), ADD KEY `OPERATION_OPERATIONACCOUNT_FK` (`IdOpAccount`);

--
-- Index pour la table `operationaccount`
--
ALTER TABLE `operationaccount`
 ADD PRIMARY KEY (`IdOpAccount`), ADD KEY `OPERATIONACCOUNT_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `performingorg`
--
ALTER TABLE `performingorg`
 ADD PRIMARY KEY (`IdPerfOrg`), ADD KEY `PERFORMINGORG_EMPLOYEE_FK` (`Manager`), ADD KEY `PERFORMINGORG_COMPANY_FK` (`IdCompany`);

--
-- Index pour la table `plugin`
--
ALTER TABLE `plugin`
 ADD PRIMARY KEY (`idPlugin`), ADD KEY `PLUGIN_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `procurementpayments`
--
ALTER TABLE `procurementpayments`
 ADD PRIMARY KEY (`idProcurementPayment`), ADD KEY `PROCPAYMENTS_PROJECT_FK` (`idProject`), ADD KEY `PROCPAYMENTS_SELLER_FK` (`idSeller`);

--
-- Index pour la table `program`
--
ALTER TABLE `program`
 ADD PRIMARY KEY (`IdProgram`), ADD KEY `PROGRAM_PERFORMINGORG_FK` (`idPerfOrg`), ADD KEY `PROGRAM_PMEMPLOYEE_FK` (`ProgramManager`);

--
-- Index pour la table `project`
--
ALTER TABLE `project`
 ADD PRIMARY KEY (`idProject`), ADD KEY `PROJECT_FMEMPLOYEE_FK` (`functionalManager`), ADD KEY `PROJECT_PMEMPLOYEE_FK` (`projectManager`), ADD KEY `PROJECT_SPEMPLOYEE_FK` (`sponsor`), ADD KEY `PROJECT_IMEMPLOYEE_FK` (`investmentManager`), ADD KEY `PROJECT_CATEGORY_FK` (`idCategory`), ADD KEY `PROJECT_CUSTOMER_FK` (`idCustomer`), ADD KEY `PROJECT_CONTRACTTYPE_FK` (`IdContractType`), ADD KEY `PROJECT_FUNDINGSOURCE_FK` (`idFundingSource`), ADD KEY `PROJECT_PROGRAM_FK` (`idProgram`), ADD KEY `PROJECT_GEOGRAPHY_FK` (`idGeography`), ADD KEY `PROJECT_PERFORMINGORG_FK` (`idPerfOrg`), ADD KEY `PROJECT_PROJECTCALENDAR_FK` (`idProjectCalendar`);

--
-- Index pour la table `projectactivity`
--
ALTER TABLE `projectactivity`
 ADD PRIMARY KEY (`IdActivity`), ADD KEY `PROJECTACTIVITY_PROJECT_FK` (`idProject`), ADD KEY `PROJECTACTIVITY_WBSNODE_FK` (`WorkPackage`);

--
-- Index pour la table `projectassociation`
--
ALTER TABLE `projectassociation`
 ADD PRIMARY KEY (`idProjectAssociation`), ADD KEY `PROJSSOCIATION_LEADPROJECT_FK` (`lead`), ADD KEY `PROJSSOCIATION_DEPPROJECT_FK` (`dependent`);

--
-- Index pour la table `projectcalendar`
--
ALTER TABLE `projectcalendar`
 ADD PRIMARY KEY (`IdProjectCalendar`), ADD KEY `PROJCALENDAR_CALENDARBASE_FK` (`idCalendarBase`);

--
-- Index pour la table `projectcalendarexceptions`
--
ALTER TABLE `projectcalendarexceptions`
 ADD PRIMARY KEY (`IdProjectCalendarException`), ADD KEY `PROJCALEXCEPTIONS_PROJCAL_FK` (`IdProjectCalendar`);

--
-- Index pour la table `projectcharter`
--
ALTER TABLE `projectcharter`
 ADD PRIMARY KEY (`IdProjectCharter`), ADD KEY `PROJECTCHARTER_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `projectclosure`
--
ALTER TABLE `projectclosure`
 ADD PRIMARY KEY (`idProjectClouse`), ADD KEY `PROJECTCLOSURE_PROJECT_FK` (`idProject`);

--
-- Index pour la table `projectcosts`
--
ALTER TABLE `projectcosts`
 ADD PRIMARY KEY (`IdProjectCosts`), ADD KEY `PROJECTCOSTS_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `projectfollowup`
--
ALTER TABLE `projectfollowup`
 ADD PRIMARY KEY (`IdProjectFollowup`), ADD KEY `PROJECTFOLLOWUP_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `projectkpi`
--
ALTER TABLE `projectkpi`
 ADD PRIMARY KEY (`IdProjectKPI`), ADD KEY `PROJECTKPI_PROJECT_FK` (`IdProject`), ADD KEY `PROJECTKPI_METRICKPI_FK` (`idMetricKpi`);

--
-- Index pour la table `resourceprofiles`
--
ALTER TABLE `resourceprofiles`
 ADD PRIMARY KEY (`IdProfile`);

--
-- Index pour la table `riskcategories`
--
ALTER TABLE `riskcategories`
 ADD PRIMARY KEY (`IdRiskCategory`);

--
-- Index pour la table `riskreassessmentlog`
--
ALTER TABLE `riskreassessmentlog`
 ADD PRIMARY KEY (`IdLog`), ADD KEY `RISKREASSLOG_RISKREGISTER_FK` (`IdRisk`);

--
-- Index pour la table `riskregister`
--
ALTER TABLE `riskregister`
 ADD PRIMARY KEY (`IdRisk`), ADD KEY `RISKREGISTER_PROJECT_FK` (`IdProject`), ADD KEY `RISKREGISTER_RISKCATEGORIES_FK` (`IdRiskCategory`);

--
-- Index pour la table `security`
--
ALTER TABLE `security`
 ADD PRIMARY KEY (`IdSec`), ADD KEY `SECURITY_CONTACT_FK` (`idContact`);

--
-- Index pour la table `seller`
--
ALTER TABLE `seller`
 ADD PRIMARY KEY (`idSeller`), ADD KEY `SELLER_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `setting`
--
ALTER TABLE `setting`
 ADD PRIMARY KEY (`idSetting`), ADD KEY `SETTING_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `skill`
--
ALTER TABLE `skill`
 ADD PRIMARY KEY (`idSkill`) USING BTREE, ADD KEY `SKILL_COMPANY_FK` (`idCompany`);

--
-- Index pour la table `skillsemployee`
--
ALTER TABLE `skillsemployee`
 ADD PRIMARY KEY (`idSkillsEmployee`) USING BTREE, ADD KEY `SKILLSEMPLOYEE_EMPLOYEE_FK` (`idEmployee`), ADD KEY `SKILLSEMPLOYEE_SKILL_FK` (`idSkill`);

--
-- Index pour la table `stakeholder`
--
ALTER TABLE `stakeholder`
 ADD PRIMARY KEY (`IdStakeholder`), ADD KEY `STAKEHOLDER_PROJECT_FK` (`IdProject`);

--
-- Index pour la table `teammember`
--
ALTER TABLE `teammember`
 ADD PRIMARY KEY (`idTeamMember`) USING BTREE, ADD KEY `TEAMMEMBER_ACTIVITY_FK` (`idActivity`), ADD KEY `TEAMMEMBER_EMPLOYEE_FK` (`idEmployee`), ADD KEY `TEAMMEMBER_SKILL_FK` (`idSkill`);

--
-- Index pour la table `timesheet`
--
ALTER TABLE `timesheet`
 ADD PRIMARY KEY (`idTimeSheet`), ADD KEY `TIMESHEET_OPERATION_FK` (`idOperation`), ADD KEY `TIMESHEET_EMPLOYEE_FK` (`idEmployee`), ADD KEY `TIMESHEET_ACTIVITY_FK` (`idActivity`);

--
-- Index pour la table `timesheetcomment`
--
ALTER TABLE `timesheetcomment`
 ADD PRIMARY KEY (`idTemesheetComment`), ADD KEY `TIMESHEETCOMMENT_TIMESHEET_FK` (`idTimeSheet`);

--
-- Index pour la table `wbsnode`
--
ALTER TABLE `wbsnode`
 ADD PRIMARY KEY (`IdWBSNode`), ADD KEY `WBSNODE_PROJECT_FK` (`idProject`), ADD KEY `WBSNODE_PARENT_FK` (`Parent`);

--
-- Index pour la table `workingcosts`
--
ALTER TABLE `workingcosts`
 ADD PRIMARY KEY (`idWorkingCosts`), ADD KEY `WORKINGCOSTS_PROJECT_FK` (`idProject`);

--
-- Index pour la table `__Application_Change_`
--
ALTER TABLE `__Application_Change_`
 ADD PRIMARY KEY (`idApplicationChange`), ADD KEY `idProgram` (`idProgram`), ADD KEY `idComplexity` (`idComplexity`);

--
-- Index pour la table `__CapacityPlanning`
--
ALTER TABLE `__CapacityPlanning`
 ADD PRIMARY KEY (`idCapacityPlanning`);

--
-- Index pour la table `__Codes_SFP__`
--
ALTER TABLE `__Codes_SFP__`
 ADD PRIMARY KEY (`idCodesSFP`);

--
-- Index pour la table `__Complexity_`
--
ALTER TABLE `__Complexity_`
 ADD PRIMARY KEY (`idComplexity`), ADD UNIQUE KEY `TypeComplexity` (`TypeComplexity`);

--
-- Index pour la table `__Eagle_Entities__`
--
ALTER TABLE `__Eagle_Entities__`
 ADD PRIMARY KEY (`idEntities`), ADD KEY `idMetier` (`idEntities`);

--
-- Index pour la table `__Eagle_Metiers__`
--
ALTER TABLE `__Eagle_Metiers__`
 ADD PRIMARY KEY (`idMetier`), ADD KEY `idMetier` (`idMetier`);

--
-- Index pour la table `__Eagle_Seniorites__`
--
ALTER TABLE `__Eagle_Seniorites__`
 ADD PRIMARY KEY (`idSeniorite`);

--
-- Index pour la table `__Eagle_Standard_Costs__`
--
ALTER TABLE `__Eagle_Standard_Costs__`
 ADD PRIMARY KEY (`idStandardCosts`), ADD KEY `idEntite` (`idEntite`), ADD KEY `idStandardCosts` (`idStandardCosts`), ADD KEY `idMetier` (`idMetier`), ADD KEY `idSeniorite` (`idSeniorite`);

--
-- Index pour la table `__Employee_Eagle_profile__`
--
ALTER TABLE `__Employee_Eagle_profile__`
 ADD PRIMARY KEY (`idEmployeeEagleProfile`), ADD KEY `idEmployeeEagleProfile` (`idEmployeeEagleProfile`), ADD KEY `idEmployee` (`idEmployee`), ADD KEY `idMetier` (`idMetier`), ADD KEY `idSeniorite` (`idSeniorite`), ADD KEY `idEntities` (`idEntities`);

--
-- Index pour la table `__scenarioscapacityplanning`
--
ALTER TABLE `__scenarioscapacityplanning`
 ADD PRIMARY KEY (`idScenario`), ADD KEY `idScenario` (`idScenario`);

--
-- Index pour la table `__task_cost_`
--
ALTER TABLE `__task_cost_`
 ADD PRIMARY KEY (`idTaskCost`), ADD KEY `idComplexity` (`idComplexity`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `activityseller`
--
ALTER TABLE `activityseller`
MODIFY `idActivitySeller` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `assumptionreassessmentlog`
--
ALTER TABLE `assumptionreassessmentlog`
MODIFY `IdLog` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `assumptionregister`
--
ALTER TABLE `assumptionregister`
MODIFY `IdAssumption` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `bscdimension`
--
ALTER TABLE `bscdimension`
MODIFY `idBscDimension` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `budgetaccounts`
--
ALTER TABLE `budgetaccounts`
MODIFY `IdBudgetAccount` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `calendarbase`
--
ALTER TABLE `calendarbase`
MODIFY `idCalendarBase` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `calendarbaseexceptions`
--
ALTER TABLE `calendarbaseexceptions`
MODIFY `IdCalendarBaseException` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=91;
--
-- AUTO_INCREMENT pour la table `category`
--
ALTER TABLE `category`
MODIFY `IdCategory` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `changecontrol`
--
ALTER TABLE `changecontrol`
MODIFY `IdChange` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `changetype`
--
ALTER TABLE `changetype`
MODIFY `idChangeType` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `chargescosts`
--
ALTER TABLE `chargescosts`
MODIFY `idChargesCosts` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `checklist`
--
ALTER TABLE `checklist`
MODIFY `idChecklist` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=28;
--
-- AUTO_INCREMENT pour la table `company`
--
ALTER TABLE `company`
MODIFY `IdCompany` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `contact`
--
ALTER TABLE `contact`
MODIFY `IdContact` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT pour la table `contentfile`
--
ALTER TABLE `contentfile`
MODIFY `idContentFile` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `contracttype`
--
ALTER TABLE `contracttype`
MODIFY `IdContractType` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `customer`
--
ALTER TABLE `customer`
MODIFY `IdCustomer` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT pour la table `customertype`
--
ALTER TABLE `customertype`
MODIFY `idCustomerType` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `directcosts`
--
ALTER TABLE `directcosts`
MODIFY `IdDirectCosts` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT pour la table `documentation`
--
ALTER TABLE `documentation`
MODIFY `idDocumentation` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `documentproject`
--
ALTER TABLE `documentproject`
MODIFY `idDocumentProject` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `employee`
--
ALTER TABLE `employee`
MODIFY `idEmployee` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=152;
--
-- AUTO_INCREMENT pour la table `expenseaccounts`
--
ALTER TABLE `expenseaccounts`
MODIFY `IdExpenseAccount` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `expenses`
--
ALTER TABLE `expenses`
MODIFY `IdExpense` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `expensesheet`
--
ALTER TABLE `expensesheet`
MODIFY `idExpenseSheet` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `expensesheetcomment`
--
ALTER TABLE `expensesheetcomment`
MODIFY `idExpenseSheetComment` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `fundingsource`
--
ALTER TABLE `fundingsource`
MODIFY `idFundingSource` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT pour la table `geography`
--
ALTER TABLE `geography`
MODIFY `idGeography` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=10;
--
-- AUTO_INCREMENT pour la table `incomes`
--
ALTER TABLE `incomes`
MODIFY `idIncome` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `issuelog`
--
ALTER TABLE `issuelog`
MODIFY `IdIssue` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `iwo`
--
ALTER TABLE `iwo`
MODIFY `IdIWO` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `logprojectstatus`
--
ALTER TABLE `logprojectstatus`
MODIFY `idLogProjectStatus` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=269;
--
-- AUTO_INCREMENT pour la table `metrickpi`
--
ALTER TABLE `metrickpi`
MODIFY `idMetricKpi` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `milestones`
--
ALTER TABLE `milestones`
MODIFY `IdMilestone` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `operation`
--
ALTER TABLE `operation`
MODIFY `IdOperation` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `operationaccount`
--
ALTER TABLE `operationaccount`
MODIFY `IdOpAccount` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `performingorg`
--
ALTER TABLE `performingorg`
MODIFY `IdPerfOrg` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT pour la table `plugin`
--
ALTER TABLE `plugin`
MODIFY `idPlugin` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `procurementpayments`
--
ALTER TABLE `procurementpayments`
MODIFY `idProcurementPayment` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT pour la table `program`
--
ALTER TABLE `program`
MODIFY `IdProgram` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=23;
--
-- AUTO_INCREMENT pour la table `project`
--
ALTER TABLE `project`
MODIFY `idProject` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT pour la table `projectactivity`
--
ALTER TABLE `projectactivity`
MODIFY `IdActivity` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=967;
--
-- AUTO_INCREMENT pour la table `projectassociation`
--
ALTER TABLE `projectassociation`
MODIFY `idProjectAssociation` int(10) unsigned NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `projectcalendar`
--
ALTER TABLE `projectcalendar`
MODIFY `IdProjectCalendar` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=52;
--
-- AUTO_INCREMENT pour la table `projectcalendarexceptions`
--
ALTER TABLE `projectcalendarexceptions`
MODIFY `IdProjectCalendarException` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `projectcharter`
--
ALTER TABLE `projectcharter`
MODIFY `IdProjectCharter` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT pour la table `projectclosure`
--
ALTER TABLE `projectclosure`
MODIFY `idProjectClouse` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `projectcosts`
--
ALTER TABLE `projectcosts`
MODIFY `IdProjectCosts` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=95;
--
-- AUTO_INCREMENT pour la table `projectfollowup`
--
ALTER TABLE `projectfollowup`
MODIFY `IdProjectFollowup` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=234;
--
-- AUTO_INCREMENT pour la table `projectkpi`
--
ALTER TABLE `projectkpi`
MODIFY `IdProjectKPI` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `riskreassessmentlog`
--
ALTER TABLE `riskreassessmentlog`
MODIFY `IdLog` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `riskregister`
--
ALTER TABLE `riskregister`
MODIFY `IdRisk` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `security`
--
ALTER TABLE `security`
MODIFY `IdSec` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT pour la table `seller`
--
ALTER TABLE `seller`
MODIFY `idSeller` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `setting`
--
ALTER TABLE `setting`
MODIFY `idSetting` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT pour la table `skill`
--
ALTER TABLE `skill`
MODIFY `idSkill` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=328;
--
-- AUTO_INCREMENT pour la table `skillsemployee`
--
ALTER TABLE `skillsemployee`
MODIFY `idSkillsEmployee` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=843;
--
-- AUTO_INCREMENT pour la table `stakeholder`
--
ALTER TABLE `stakeholder`
MODIFY `IdStakeholder` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `teammember`
--
ALTER TABLE `teammember`
MODIFY `idTeamMember` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=936;
--
-- AUTO_INCREMENT pour la table `timesheet`
--
ALTER TABLE `timesheet`
MODIFY `idTimeSheet` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2570;
--
-- AUTO_INCREMENT pour la table `timesheetcomment`
--
ALTER TABLE `timesheetcomment`
MODIFY `idTemesheetComment` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1548;
--
-- AUTO_INCREMENT pour la table `wbsnode`
--
ALTER TABLE `wbsnode`
MODIFY `IdWBSNode` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=1587;
--
-- AUTO_INCREMENT pour la table `workingcosts`
--
ALTER TABLE `workingcosts`
MODIFY `idWorkingCosts` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=76;
--
-- AUTO_INCREMENT pour la table `__Application_Change_`
--
ALTER TABLE `__Application_Change_`
MODIFY `idApplicationChange` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=21;
--
-- AUTO_INCREMENT pour la table `__CapacityPlanning`
--
ALTER TABLE `__CapacityPlanning`
MODIFY `idCapacityPlanning` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=79;
--
-- AUTO_INCREMENT pour la table `__Codes_SFP__`
--
ALTER TABLE `__Codes_SFP__`
MODIFY `idCodesSFP` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=11;
--
-- AUTO_INCREMENT pour la table `__Complexity_`
--
ALTER TABLE `__Complexity_`
MODIFY `idComplexity` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT pour la table `__Eagle_Entities__`
--
ALTER TABLE `__Eagle_Entities__`
MODIFY `idEntities` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT pour la table `__Eagle_Metiers__`
--
ALTER TABLE `__Eagle_Metiers__`
MODIFY `idMetier` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- AUTO_INCREMENT pour la table `__Eagle_Seniorites__`
--
ALTER TABLE `__Eagle_Seniorites__`
MODIFY `idSeniorite` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT pour la table `__Eagle_Standard_Costs__`
--
ALTER TABLE `__Eagle_Standard_Costs__`
MODIFY `idStandardCosts` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=90;
--
-- AUTO_INCREMENT pour la table `__Employee_Eagle_profile__`
--
ALTER TABLE `__Employee_Eagle_profile__`
MODIFY `idEmployeeEagleProfile` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=58;
--
-- AUTO_INCREMENT pour la table `__task_cost_`
--
ALTER TABLE `__task_cost_`
MODIFY `idTaskCost` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=7;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `activityseller`
--
ALTER TABLE `activityseller`
ADD CONSTRAINT `ACTIVITYSELLER_ACTIVITY_FK` FOREIGN KEY (`idActivity`) REFERENCES `projectactivity` (`IdActivity`),
ADD CONSTRAINT `ACTIVITYSELLER_SELLER_FK` FOREIGN KEY (`idSeller`) REFERENCES `seller` (`idSeller`) ON DELETE CASCADE;

--
-- Contraintes pour la table `assumptionreassessmentlog`
--
ALTER TABLE `assumptionreassessmentlog`
ADD CONSTRAINT `ASSREALOG_ASSREG_FK` FOREIGN KEY (`IdAssumption`) REFERENCES `assumptionregister` (`IdAssumption`) ON DELETE CASCADE;

--
-- Contraintes pour la table `assumptionregister`
--
ALTER TABLE `assumptionregister`
ADD CONSTRAINT `ASSUMPTIONREGISTER_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `bscdimension`
--
ALTER TABLE `bscdimension`
ADD CONSTRAINT `BSCDIM_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `budgetaccounts`
--
ALTER TABLE `budgetaccounts`
ADD CONSTRAINT `BUDGETACCOUNTS_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `calendarbase`
--
ALTER TABLE `calendarbase`
ADD CONSTRAINT `CALENDARBASE_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `calendarbaseexceptions`
--
ALTER TABLE `calendarbaseexceptions`
ADD CONSTRAINT `CALBASEEXCEP_CALBASE_FK` FOREIGN KEY (`IdCalendarBase`) REFERENCES `calendarbase` (`idCalendarBase`) ON DELETE CASCADE;

--
-- Contraintes pour la table `category`
--
ALTER TABLE `category`
ADD CONSTRAINT `CATEGORY_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `changecontrol`
--
ALTER TABLE `changecontrol`
ADD CONSTRAINT `CHANGECONTROL_CHANGETYPE_FK` FOREIGN KEY (`IdChangeType`) REFERENCES `changetype` (`idChangeType`) ON DELETE SET NULL,
ADD CONSTRAINT `CHANGECONTROL_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE,
ADD CONSTRAINT `CHANGECONTROL_WBSNODE_FK` FOREIGN KEY (`IdWBSNode`) REFERENCES `wbsnode` (`IdWBSNode`) ON DELETE SET NULL;

--
-- Contraintes pour la table `changetype`
--
ALTER TABLE `changetype`
ADD CONSTRAINT `CHANGETYPE_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `chargescosts`
--
ALTER TABLE `chargescosts`
ADD CONSTRAINT `CHARGESCOSTS_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `checklist`
--
ALTER TABLE `checklist`
ADD CONSTRAINT `CHECKLIST_WBSNODE_FK` FOREIGN KEY (`idWbsnode`) REFERENCES `wbsnode` (`IdWBSNode`) ON DELETE CASCADE;

--
-- Contraintes pour la table `contact`
--
ALTER TABLE `contact`
ADD CONSTRAINT `CONTACT_COMPANY_FK` FOREIGN KEY (`IdCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `contracttype`
--
ALTER TABLE `contracttype`
ADD CONSTRAINT `CONTRACTTYPE_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `customer`
--
ALTER TABLE `customer`
ADD CONSTRAINT `CUSTOMER_COMPANY_FK` FOREIGN KEY (`IdCompany`) REFERENCES `company` (`IdCompany`),
ADD CONSTRAINT `CUSTOMER_CUSTOMERTYPE_FK` FOREIGN KEY (`idCustomerType`) REFERENCES `customertype` (`idCustomerType`) ON DELETE SET NULL;

--
-- Contraintes pour la table `customertype`
--
ALTER TABLE `customertype`
ADD CONSTRAINT `CUSTOMERTYPE_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `directcosts`
--
ALTER TABLE `directcosts`
ADD CONSTRAINT `DIRECTCOSTS_BUDGETACCOUNTS_FK` FOREIGN KEY (`IdBudgetAccount`) REFERENCES `budgetaccounts` (`IdBudgetAccount`) ON DELETE SET NULL,
ADD CONSTRAINT `DIRECTCOSTS_PROJECTCOSTS_FK` FOREIGN KEY (`IdProjectCosts`) REFERENCES `projectcosts` (`IdProjectCosts`) ON DELETE CASCADE;

--
-- Contraintes pour la table `documentation`
--
ALTER TABLE `documentation`
ADD CONSTRAINT `DOCUMENTATION_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`),
ADD CONSTRAINT `DOCUMENTATION_CONTENTFILE_FK` FOREIGN KEY (`idContentFile`) REFERENCES `contentfile` (`idContentFile`) ON DELETE SET NULL;

--
-- Contraintes pour la table `documentproject`
--
ALTER TABLE `documentproject`
ADD CONSTRAINT `DOCUMENTPROJECT_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `employee`
--
ALTER TABLE `employee`
ADD CONSTRAINT `EMPLOYEE_CALENDARBASE_FK` FOREIGN KEY (`idCalendarBase`) REFERENCES `calendarbase` (`idCalendarBase`) ON DELETE SET NULL,
ADD CONSTRAINT `EMPLOYEE_CONTACT_FK` FOREIGN KEY (`idContact`) REFERENCES `contact` (`IdContact`),
ADD CONSTRAINT `EMPLOYEE_PERFORG_FK` FOREIGN KEY (`idPerfOrg`) REFERENCES `performingorg` (`IdPerfOrg`) ON DELETE SET NULL,
ADD CONSTRAINT `EMPLOYEE_RESPROFILES_FK` FOREIGN KEY (`idProfile`) REFERENCES `resourceprofiles` (`IdProfile`) ON DELETE SET NULL,
ADD CONSTRAINT `EMPLOYEE_RSMANAGER_FK` FOREIGN KEY (`idResourceManager`) REFERENCES `employee` (`idEmployee`);

--
-- Contraintes pour la table `expenseaccounts`
--
ALTER TABLE `expenseaccounts`
ADD CONSTRAINT `EXPENSEACCOUNTS_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `expenses`
--
ALTER TABLE `expenses`
ADD CONSTRAINT `EXPENSES_BUDGETACCOUNTS_FK` FOREIGN KEY (`IdBudgetAccount`) REFERENCES `budgetaccounts` (`IdBudgetAccount`) ON DELETE SET NULL,
ADD CONSTRAINT `EXPENSES_PROJECTCOSTS_FK` FOREIGN KEY (`IdProjectCosts`) REFERENCES `projectcosts` (`IdProjectCosts`) ON DELETE CASCADE;

--
-- Contraintes pour la table `expensesheet`
--
ALTER TABLE `expensesheet`
ADD CONSTRAINT `EXPENSESHEET_EMPLOYEE_FK` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`idEmployee`) ON DELETE CASCADE,
ADD CONSTRAINT `EXPENSESHEET_EXPACCOUNTS_FK` FOREIGN KEY (`idExpenseAccount`) REFERENCES `expenseaccounts` (`IdExpenseAccount`) ON DELETE SET NULL,
ADD CONSTRAINT `EXPENSESHEET_EXPENSE_FK` FOREIGN KEY (`idExpense`) REFERENCES `expenses` (`IdExpense`) ON DELETE SET NULL,
ADD CONSTRAINT `EXPENSESHEET_OPERATION_FK` FOREIGN KEY (`idOperation`) REFERENCES `operation` (`IdOperation`) ON DELETE SET NULL,
ADD CONSTRAINT `EXPENSESHEET_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `expensesheetcomment`
--
ALTER TABLE `expensesheetcomment`
ADD CONSTRAINT `EXPSHEETCOMMENT_EXPSHEET_FK` FOREIGN KEY (`idExpenseSheet`) REFERENCES `expensesheet` (`idExpenseSheet`) ON DELETE CASCADE;

--
-- Contraintes pour la table `fundingsource`
--
ALTER TABLE `fundingsource`
ADD CONSTRAINT `FUNDINGSOURCE_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `geography`
--
ALTER TABLE `geography`
ADD CONSTRAINT `GEOGRAPHY_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `incomes`
--
ALTER TABLE `incomes`
ADD CONSTRAINT `INCOMES_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `issuelog`
--
ALTER TABLE `issuelog`
ADD CONSTRAINT `ISSUELOG_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `iwo`
--
ALTER TABLE `iwo`
ADD CONSTRAINT `IWO_PROJECTCOSTS_FK` FOREIGN KEY (`IdProjectCosts`) REFERENCES `projectcosts` (`IdProjectCosts`) ON DELETE CASCADE;

--
-- Contraintes pour la table `logprojectstatus`
--
ALTER TABLE `logprojectstatus`
ADD CONSTRAINT `LOGPROJECTSTATUS_EMPLOYEE_FK` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`idEmployee`) ON DELETE CASCADE,
ADD CONSTRAINT `LOGPROJECTSTATUS_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `metrickpi`
--
ALTER TABLE `metrickpi`
ADD CONSTRAINT `METRICKPI_BSCDIMENSION_FK` FOREIGN KEY (`idBscDimension`) REFERENCES `bscdimension` (`idBscDimension`),
ADD CONSTRAINT `METRICKPI_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `milestones`
--
ALTER TABLE `milestones`
ADD CONSTRAINT `MILESTONE_ACTIVITY_FK` FOREIGN KEY (`IdActivity`) REFERENCES `projectactivity` (`IdActivity`) ON DELETE SET NULL,
ADD CONSTRAINT `MILESTONE_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `operation`
--
ALTER TABLE `operation`
ADD CONSTRAINT `OPERATION_OPERATIONACCOUNT_FK` FOREIGN KEY (`IdOpAccount`) REFERENCES `operationaccount` (`IdOpAccount`);

--
-- Contraintes pour la table `operationaccount`
--
ALTER TABLE `operationaccount`
ADD CONSTRAINT `OPERATIONACCOUNT_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `performingorg`
--
ALTER TABLE `performingorg`
ADD CONSTRAINT `PERFORMINGORG_COMPANY_FK` FOREIGN KEY (`IdCompany`) REFERENCES `company` (`IdCompany`),
ADD CONSTRAINT `PERFORMINGORG_EMPLOYEE_FK` FOREIGN KEY (`Manager`) REFERENCES `employee` (`idEmployee`) ON DELETE SET NULL;

--
-- Contraintes pour la table `plugin`
--
ALTER TABLE `plugin`
ADD CONSTRAINT `PLUGIN_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `procurementpayments`
--
ALTER TABLE `procurementpayments`
ADD CONSTRAINT `PROCPAYMENTS_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE,
ADD CONSTRAINT `PROCPAYMENTS_SELLER_FK` FOREIGN KEY (`idSeller`) REFERENCES `seller` (`idSeller`) ON DELETE CASCADE;

--
-- Contraintes pour la table `program`
--
ALTER TABLE `program`
ADD CONSTRAINT `PROGRAM_PERFORMINGORG_FK` FOREIGN KEY (`idPerfOrg`) REFERENCES `performingorg` (`IdPerfOrg`),
ADD CONSTRAINT `PROGRAM_PMEMPLOYEE_FK` FOREIGN KEY (`ProgramManager`) REFERENCES `employee` (`idEmployee`) ON DELETE SET NULL;

--
-- Contraintes pour la table `project`
--
ALTER TABLE `project`
ADD CONSTRAINT `PROJECT_CATEGORY_FK` FOREIGN KEY (`idCategory`) REFERENCES `category` (`IdCategory`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_CONTRACTTYPE_FK` FOREIGN KEY (`IdContractType`) REFERENCES `contracttype` (`IdContractType`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_CUSTOMER_FK` FOREIGN KEY (`idCustomer`) REFERENCES `customer` (`IdCustomer`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_FMEMPLOYEE_FK` FOREIGN KEY (`functionalManager`) REFERENCES `employee` (`idEmployee`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_FUNDINGSOURCE_FK` FOREIGN KEY (`idFundingSource`) REFERENCES `fundingsource` (`idFundingSource`),
ADD CONSTRAINT `PROJECT_GEOGRAPHY_FK` FOREIGN KEY (`idGeography`) REFERENCES `geography` (`idGeography`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_IMEMPLOYEE_FK` FOREIGN KEY (`investmentManager`) REFERENCES `employee` (`idEmployee`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_PERFORMINGORG_FK` FOREIGN KEY (`idPerfOrg`) REFERENCES `performingorg` (`IdPerfOrg`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_PMEMPLOYEE_FK` FOREIGN KEY (`projectManager`) REFERENCES `employee` (`idEmployee`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_PROGRAM_FK` FOREIGN KEY (`idProgram`) REFERENCES `program` (`IdProgram`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_PROJECTCALENDAR_FK` FOREIGN KEY (`idProjectCalendar`) REFERENCES `projectcalendar` (`IdProjectCalendar`) ON DELETE SET NULL,
ADD CONSTRAINT `PROJECT_SPEMPLOYEE_FK` FOREIGN KEY (`sponsor`) REFERENCES `employee` (`idEmployee`) ON DELETE SET NULL;

--
-- Contraintes pour la table `projectactivity`
--
ALTER TABLE `projectactivity`
ADD CONSTRAINT `PROJECTACTIVITY_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE,
ADD CONSTRAINT `PROJECTACTIVITY_WBSNODE_FK` FOREIGN KEY (`WorkPackage`) REFERENCES `wbsnode` (`IdWBSNode`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectassociation`
--
ALTER TABLE `projectassociation`
ADD CONSTRAINT `PROJSSOCIATION_DEPPROJECT_FK` FOREIGN KEY (`dependent`) REFERENCES `project` (`idProject`) ON DELETE CASCADE,
ADD CONSTRAINT `PROJSSOCIATION_LEADPROJECT_FK` FOREIGN KEY (`lead`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectcalendar`
--
ALTER TABLE `projectcalendar`
ADD CONSTRAINT `PROJCALENDAR_CALENDARBASE_FK` FOREIGN KEY (`idCalendarBase`) REFERENCES `calendarbase` (`idCalendarBase`) ON DELETE SET NULL;

--
-- Contraintes pour la table `projectcalendarexceptions`
--
ALTER TABLE `projectcalendarexceptions`
ADD CONSTRAINT `PROJCALEXCEPTIONS_PROJCAL_FK` FOREIGN KEY (`IdProjectCalendar`) REFERENCES `projectcalendar` (`IdProjectCalendar`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectcharter`
--
ALTER TABLE `projectcharter`
ADD CONSTRAINT `PROJECTCHARTER_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectclosure`
--
ALTER TABLE `projectclosure`
ADD CONSTRAINT `PROJECTCLOSURE_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectcosts`
--
ALTER TABLE `projectcosts`
ADD CONSTRAINT `PROJECTCOSTS_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectfollowup`
--
ALTER TABLE `projectfollowup`
ADD CONSTRAINT `PROJECTFOLLOWUP_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `projectkpi`
--
ALTER TABLE `projectkpi`
ADD CONSTRAINT `PROJECTKPI_METRICKPI_FK` FOREIGN KEY (`idMetricKpi`) REFERENCES `metrickpi` (`idMetricKpi`),
ADD CONSTRAINT `PROJECTKPI_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `riskreassessmentlog`
--
ALTER TABLE `riskreassessmentlog`
ADD CONSTRAINT `RISKREASSLOG_RISKREGISTER_FK` FOREIGN KEY (`IdRisk`) REFERENCES `riskregister` (`IdRisk`) ON DELETE CASCADE;

--
-- Contraintes pour la table `riskregister`
--
ALTER TABLE `riskregister`
ADD CONSTRAINT `RISKREGISTER_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE,
ADD CONSTRAINT `RISKREGISTER_RISKCATEGORIES_FK` FOREIGN KEY (`IdRiskCategory`) REFERENCES `riskcategories` (`IdRiskCategory`) ON DELETE SET NULL;

--
-- Contraintes pour la table `security`
--
ALTER TABLE `security`
ADD CONSTRAINT `SECURITY_CONTACT_FK` FOREIGN KEY (`idContact`) REFERENCES `contact` (`IdContact`) ON DELETE CASCADE;

--
-- Contraintes pour la table `seller`
--
ALTER TABLE `seller`
ADD CONSTRAINT `SELLER_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `setting`
--
ALTER TABLE `setting`
ADD CONSTRAINT `SETTING_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`) ON DELETE CASCADE;

--
-- Contraintes pour la table `skill`
--
ALTER TABLE `skill`
ADD CONSTRAINT `SKILL_COMPANY_FK` FOREIGN KEY (`idCompany`) REFERENCES `company` (`IdCompany`);

--
-- Contraintes pour la table `skillsemployee`
--
ALTER TABLE `skillsemployee`
ADD CONSTRAINT `SKILLSEMPLOYEE_EMPLOYEE_FK` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`idEmployee`),
ADD CONSTRAINT `SKILLSEMPLOYEE_SKILL_FK` FOREIGN KEY (`idSkill`) REFERENCES `skill` (`idSkill`);

--
-- Contraintes pour la table `stakeholder`
--
ALTER TABLE `stakeholder`
ADD CONSTRAINT `STAKEHOLDER_PROJECT_FK` FOREIGN KEY (`IdProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `teammember`
--
ALTER TABLE `teammember`
ADD CONSTRAINT `TEAMMEMBER_ACTIVITY_FK` FOREIGN KEY (`idActivity`) REFERENCES `projectactivity` (`IdActivity`) ON DELETE CASCADE,
ADD CONSTRAINT `TEAMMEMBER_EMPLOYEE_FK` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`idEmployee`) ON DELETE CASCADE,
ADD CONSTRAINT `TEAMMEMBER_SKILL_FK` FOREIGN KEY (`idSkill`) REFERENCES `skill` (`idSkill`) ON DELETE SET NULL;

--
-- Contraintes pour la table `timesheet`
--
ALTER TABLE `timesheet`
ADD CONSTRAINT `TIMESHEET_ACTIVITY_FK` FOREIGN KEY (`idActivity`) REFERENCES `projectactivity` (`IdActivity`) ON DELETE CASCADE,
ADD CONSTRAINT `TIMESHEET_EMPLOYEE_FK` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`idEmployee`) ON DELETE CASCADE,
ADD CONSTRAINT `TIMESHEET_OPERATION_FK` FOREIGN KEY (`idOperation`) REFERENCES `operation` (`IdOperation`) ON DELETE CASCADE;

--
-- Contraintes pour la table `timesheetcomment`
--
ALTER TABLE `timesheetcomment`
ADD CONSTRAINT `TIMESHEETCOMMENT_TIMESHEET_FK` FOREIGN KEY (`idTimeSheet`) REFERENCES `timesheet` (`idTimeSheet`) ON DELETE CASCADE;

--
-- Contraintes pour la table `wbsnode`
--
ALTER TABLE `wbsnode`
ADD CONSTRAINT `WBSNODE_PARENT_FK` FOREIGN KEY (`Parent`) REFERENCES `wbsnode` (`IdWBSNode`) ON DELETE CASCADE,
ADD CONSTRAINT `WBSNODE_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `workingcosts`
--
ALTER TABLE `workingcosts`
ADD CONSTRAINT `WORKINGCOSTS_PROJECT_FK` FOREIGN KEY (`idProject`) REFERENCES `project` (`idProject`) ON DELETE CASCADE;

--
-- Contraintes pour la table `__Application_Change_`
--
ALTER TABLE `__Application_Change_`
ADD CONSTRAINT `__Application_Complexity_2` FOREIGN KEY (`idComplexity`) REFERENCES `__Complexity_` (`idComplexity`) ON DELETE CASCADE,
ADD CONSTRAINT `__Application_Program` FOREIGN KEY (`idProgram`) REFERENCES `program` (`IdProgram`) ON DELETE CASCADE;

--
-- Contraintes pour la table `__Eagle_Standard_Costs__`
--
ALTER TABLE `__Eagle_Standard_Costs__`
ADD CONSTRAINT `__Eagle_Standard_Costs___ibfk_1` FOREIGN KEY (`idMetier`) REFERENCES `__Eagle_Metiers__` (`idMetier`),
ADD CONSTRAINT `__Eagle_Standard_Costs___ibfk_2` FOREIGN KEY (`idSeniorite`) REFERENCES `__Eagle_Seniorites__` (`idSeniorite`),
ADD CONSTRAINT `__Eagle_Standard_Costs___ibfk_3` FOREIGN KEY (`idEntite`) REFERENCES `__Eagle_Entities__` (`idEntities`);

--
-- Contraintes pour la table `__Employee_Eagle_profile__`
--
ALTER TABLE `__Employee_Eagle_profile__`
ADD CONSTRAINT `__Employee_Eagle_profile___ibfk_1` FOREIGN KEY (`idEntities`) REFERENCES `__Eagle_Entities__` (`idEntities`),
ADD CONSTRAINT `__Employee_Eagle_profile___ibfk_2` FOREIGN KEY (`idEmployee`) REFERENCES `employee` (`idEmployee`),
ADD CONSTRAINT `__Employee_Eagle_profile___ibfk_3` FOREIGN KEY (`idMetier`) REFERENCES `__Eagle_Metiers__` (`idMetier`),
ADD CONSTRAINT `__Employee_Eagle_profile___ibfk_4` FOREIGN KEY (`idSeniorite`) REFERENCES `__Eagle_Seniorites__` (`idSeniorite`);

--
-- Contraintes pour la table `__task_cost_`
--
ALTER TABLE `__task_cost_`
ADD CONSTRAINT `__task_cost__ibfk_1` FOREIGN KEY (`idComplexity`) REFERENCES `__Complexity_` (`idComplexity`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
