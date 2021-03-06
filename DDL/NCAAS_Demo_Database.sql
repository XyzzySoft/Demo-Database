-- MySQL Script generated by MySQL Workbench
-- Thu 27 Jan 2022 11:07:44 PM EST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
SHOW WARNINGS;
-- -----------------------------------------------------
-- Schema ncaaf_Demo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ncaaf_Demo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ncaaf_Demo` ;
SHOW WARNINGS;
USE `ncaaf_Demo` ;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`Teams`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`Teams` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`Teams` (
  `idTeams` INT NOT NULL AUTO_INCREMENT,
  `TeamName` VARCHAR(45) NULL,
  `University` VARCHAR(45) NULL,
  `Abbreviation` VARCHAR(45) NULL,
  PRIMARY KEY (`idTeams`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `idTeams_UNIQUE` ON `ncaaf_Demo`.`Teams` (`idTeams` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`Players`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`Players` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`Players` (
  `idPlayers` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`idPlayers`))
ENGINE = InnoDB
COMMENT = 'Basic Player Information - in first draft this will be three comma delimited key:value pairs for offense,defense,special teams.\nWill need to link them to many to one universities, positions, etc.  most of this can be in the future though\nIn future we will also more carefully specific data values by defined row\n\nAlso note the PlayerGames table, where we will specifically defiine player playing time and position contributions per quarter per game\n\nAssociations of players to teams will be defined by joins per year because of transfers.  This means team rosters will be a view joining Teams with Players per year.\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`Seasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`Seasons` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`Seasons` (
  `idSeasons` INT NOT NULL,
  `year` VARCHAR(45) NULL,
  PRIMARY KEY (`idSeasons`))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`Games`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`Games` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`Games` (
  `idGame` INT NOT NULL AUTO_INCREMENT,
  `idSeasons` INT NOT NULL,
  `idHomeTeam` INT NOT NULL,
  `idVisitingTeam` INT NOT NULL,
  `NeutralLocation` INT NULL,
  `Date` VARCHAR(45) NULL,
  `Gamescol` VARCHAR(45) NULL,
  PRIMARY KEY (`idGame`),
  CONSTRAINT `fk_Games_Seasons`
    FOREIGN KEY (`idSeasons`)
    REFERENCES `ncaaf_Demo`.`Seasons` (`idSeasons`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Games_HomeTeam`
    FOREIGN KEY (`idHomeTeam`)
    REFERENCES `ncaaf_Demo`.`Teams` (`idTeams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Games_VisitingTeam`
    FOREIGN KEY (`idVisitingTeam`)
    REFERENCES `ncaaf_Demo`.`Teams` (`idTeams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `idGame_UNIQUE` ON `ncaaf_Demo`.`Games` (`idGame` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_Games_Seasons_idx` ON `ncaaf_Demo`.`Games` (`idSeasons` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_Games_HomeTeam_idx` ON `ncaaf_Demo`.`Games` (`idHomeTeam` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_Games_VisitingTeam_idx` ON `ncaaf_Demo`.`Games` (`idVisitingTeam` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`StudentClass`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`StudentClass` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`StudentClass` (
  `idplayersClass` INT NOT NULL,
  `class` VARCHAR(45) NULL,
  PRIMARY KEY (`idplayersClass`))
ENGINE = InnoDB
COMMENT = 'Freshmen, redshirt, graduate etc.';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`PlayerData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`PlayerData` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`PlayerData` (
  `idPlayerData` INT NOT NULL,
  `idPlayers` INT NOT NULL,
  `idTeams` INT NOT NULL,
  `idSeasons` INT NOT NULL,
  `idPlayersClass` INT NOT NULL,
  `jerseyNumber` INT NULL,
  `offense_raw` VARCHAR(250) NULL,
  `defense_raw` VARCHAR(250) NULL,
  `special_raw` VARCHAR(250) NULL,
  PRIMARY KEY (`idPlayerData`),
  CONSTRAINT `fk_PlayerData_Players`
    FOREIGN KEY ()
    REFERENCES `ncaaf_Demo`.`Players` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerData_Team`
    FOREIGN KEY (`idTeams`)
    REFERENCES `ncaaf_Demo`.`Teams` (`idTeams`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerData_Seasons`
    FOREIGN KEY ()
    REFERENCES `ncaaf_Demo`.`Seasons` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlayerData_StudentClass`
    FOREIGN KEY (`idPlayersClass`)
    REFERENCES `ncaaf_Demo`.`StudentClass` (`idplayersClass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Summary Data, per season, per player.\nNote, need a restriction to ensure that idTems and idSeasons year exists.\nNeed a many to one for positons mediated via a multiple join.';

SHOW WARNINGS;
CREATE INDEX `fk_PlayerData_Team_idx` ON `ncaaf_Demo`.`PlayerData` (`idTeams` ASC);

SHOW WARNINGS;
CREATE INDEX `fk_PlayerData_StudentClass_idx` ON `ncaaf_Demo`.`PlayerData` (`idPlayersClass` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`PositionType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`PositionType` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`PositionType` (
  `idPositionType` INT NOT NULL,
  `PositionType` VARCHAR(1) NOT NULL,
  `PositionTypecDesc` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPositionType`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `PositionType_UNIQUE` ON `ncaaf_Demo`.`PositionType` (`PositionType` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `PositionTypecDesc_UNIQUE` ON `ncaaf_Demo`.`PositionType` (`PositionTypecDesc` ASC);

SHOW WARNINGS;
CREATE UNIQUE INDEX `idPositionType_UNIQUE` ON `ncaaf_Demo`.`PositionType` (`idPositionType` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`Positions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`Positions` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`Positions` (
  `idPositions` INT NOT NULL,
  `Position` VARCHAR(45) NOT NULL,
  `PositionType` INT NOT NULL COMMENT 'O, D, K, R for offense, defense, kick return or kickiing',
  PRIMARY KEY (`idPositions`),
  CONSTRAINT `fk_PositionType`
    FOREIGN KEY (`PositionType`)
    REFERENCES `ncaaf_Demo`.`PositionType` (`idPositionType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'List of positions players can hold.';

SHOW WARNINGS;
CREATE INDEX `fk_PositionType_idx` ON `ncaaf_Demo`.`Positions` (`PositionType` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`joinPlayersPositionsSeasons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`joinPlayersPositionsSeasons` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`joinPlayersPositionsSeasons` (
  `idPlayersData` INT NOT NULL,
  `idPositions` INT NOT NULL,
  PRIMARY KEY (`idPlayersData`, `idPositions`),
  CONSTRAINT `fk_joinPlayerData`
    FOREIGN KEY (`idPlayersData`)
    REFERENCES `ncaaf_Demo`.`PlayerData` (`idPlayerData`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JoinPosition`
    FOREIGN KEY (`idPositions`)
    REFERENCES `ncaaf_Demo`.`Positions` (`idPositions`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'need to be able to associate player with different positions by year played.';

SHOW WARNINGS;
CREATE INDEX `fk_JoinPosition_idx` ON `ncaaf_Demo`.`joinPlayersPositionsSeasons` (`idPositions` ASC);

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `ncaaf_Demo`.`Scores`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ncaaf_Demo`.`Scores` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`Scores` (
  `idScores` INT NOT NULL,
  `idGames` INT NOT NULL,
  `HomeScore` INT NOT NULL,
  `AwayScore` INT NOT NULL,
  `HomeForfit` BIT NULL,
  `AwayForfit` BIT NULL,
  PRIMARY KEY (`idScores`),
  CONSTRAINT `fk_Scores_Games`
    FOREIGN KEY (`idGames`)
    REFERENCES `ncaaf_Demo`.`Games` (`idGame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Scores_Games_idx` ON `ncaaf_Demo`.`Scores` (`idGames` ASC);

SHOW WARNINGS;
USE `ncaaf_Demo` ;

-- -----------------------------------------------------
-- Placeholder table for view `ncaaf_Demo`.`TeamSchedules`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`TeamSchedules` (`year` INT, `idTeams` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `ncaaf_Demo`.`TeamRosters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`TeamRosters` (`year` INT, `Name` INT, `jerseyNumber` INT, `idTeams` INT, `TeamName` INT, `Abbreviation` INT, `University` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `ncaaf_Demo`.`TeamRecords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`TeamRecords` (`year` INT, `idTeams` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `ncaaf_Demo`.`PlayerRecords`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`PlayerRecords` (`year` INT, `idTeams` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- Placeholder table for view `ncaaf_Demo`.`TeamSchedule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ncaaf_Demo`.`TeamSchedule` (`year` INT, `idTeams` INT);
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ncaaf_Demo`.`TeamSchedules`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ncaaf_Demo`.`TeamSchedules` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `ncaaf_Demo`.`TeamSchedules`;
SHOW WARNINGS;
USE `ncaaf_Demo`;
CREATE  OR REPLACE VIEW `TeamSchedules` AS
SELECT DISTINCT(Schedules.year), Teams.idTeams
FROM Schedules,Teams
WHERE Teams.idTeams = Schedules.idTeams;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ncaaf_Demo`.`TeamRosters`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ncaaf_Demo`.`TeamRosters` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `ncaaf_Demo`.`TeamRosters`;
SHOW WARNINGS;
USE `ncaaf_Demo`;
CREATE  OR REPLACE VIEW `TeamRosters` AS
SELECT distinct(s.year), p.Name, d.jerseyNumber, s.idTeams, t.TeamName, t.Abbreviation, t.University
FROM Players p, Teams t, Schedules s, PlayerData d, Seasons sn
WHERE p.idPlayers = d.idPlayers and d.idTeams = t.idTeams and d.idTeams = s.idTeams and sn.idSeasons = s.idSeasons and d.idSeasons = sn.idSeasons and sn.idTeams = d.idTeams;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ncaaf_Demo`.`TeamRecords`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ncaaf_Demo`.`TeamRecords` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `ncaaf_Demo`.`TeamRecords`;
SHOW WARNINGS;
USE `ncaaf_Demo`;
CREATE  OR REPLACE VIEW `TeamRecords` AS
SELECT DISTINCT(Schedules.year), Teams.idTeams
FROM Schedules,Teams
WHERE Teams.idTeams = Schedules.idTeams;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ncaaf_Demo`.`PlayerRecords`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ncaaf_Demo`.`PlayerRecords` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `ncaaf_Demo`.`PlayerRecords`;
SHOW WARNINGS;
USE `ncaaf_Demo`;
CREATE  OR REPLACE VIEW `PlayerRecords` AS
SELECT DISTINCT(Schedules.year), Teams.idTeams
FROM Schedules,Teams
WHERE Teams.idTeams = Schedules.idTeams;
SHOW WARNINGS;

-- -----------------------------------------------------
-- View `ncaaf_Demo`.`TeamSchedule`
-- -----------------------------------------------------
DROP VIEW IF EXISTS `ncaaf_Demo`.`TeamSchedule` ;
SHOW WARNINGS;
DROP TABLE IF EXISTS `ncaaf_Demo`.`TeamSchedule`;
SHOW WARNINGS;
USE `ncaaf_Demo`;
CREATE  OR REPLACE VIEW `TeamSchedule` AS
SELECT DISTINCT(Schedules.year), Teams.idTeams
FROM Schedules,Teams
WHERE Teams.idTeams = Schedules.idTeams;
SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `ncaaf_Demo`.`Teams`
-- -----------------------------------------------------
START TRANSACTION;
USE `ncaaf_Demo`;
INSERT INTO `ncaaf_Demo`.`Teams` (`idTeams`, `TeamName`, `University`, `Abbreviation`) VALUES (1, 'Bulldogs', 'University of Georgia', 'UGA');
INSERT INTO `ncaaf_Demo`.`Teams` (`idTeams`, `TeamName`, `University`, `Abbreviation`) VALUES (2, 'Tigers', 'Clemson University', 'CLM');
INSERT INTO `ncaaf_Demo`.`Teams` (`idTeams`, `TeamName`, `University`, `Abbreviation`) VALUES (3, 'Gators', 'University of Florida', 'FLA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `ncaaf_Demo`.`PositionType`
-- -----------------------------------------------------
START TRANSACTION;
USE `ncaaf_Demo`;
INSERT INTO `ncaaf_Demo`.`PositionType` (`idPositionType`, `PositionType`, `PositionTypecDesc`) VALUES (1, 'O', 'Offense');
INSERT INTO `ncaaf_Demo`.`PositionType` (`idPositionType`, `PositionType`, `PositionTypecDesc`) VALUES (2, 'D', 'Defense');
INSERT INTO `ncaaf_Demo`.`PositionType` (`idPositionType`, `PositionType`, `PositionTypecDesc`) VALUES (3, 'K', 'Kicking');
INSERT INTO `ncaaf_Demo`.`PositionType` (`idPositionType`, `PositionType`, `PositionTypecDesc`) VALUES (4, 'R', 'Returning');

COMMIT;

