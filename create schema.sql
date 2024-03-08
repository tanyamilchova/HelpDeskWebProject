-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ServiceHelpDeskDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ServiceHelpDeskDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ServiceHelpDeskDB` DEFAULT CHARACTER SET utf8 ;
USE `ServiceHelpDeskDB` ;

-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`employees` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`projects` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  `team_lead_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_projects_employees1_idx` (`team_lead_id` ASC) VISIBLE,
  CONSTRAINT `fk_projects_employees`
    FOREIGN KEY (`team_lead_id`)
    REFERENCES `ServiceHelpDeskDB`.`employees` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`project_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`project_branch` (
  `id` BIGINT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `project_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `project_id`),
  INDEX `fk_project_branch_projects1_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_branch_projects`
    FOREIGN KEY (`project_id`)
    REFERENCES `ServiceHelpDeskDB`.`projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`employees` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `role` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`projects` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  `team_lead_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_projects_employees1_idx` (`team_lead_id` ASC) VISIBLE,
  CONSTRAINT `fk_projects_employees`
    FOREIGN KEY (`team_lead_id`)
    REFERENCES `ServiceHelpDeskDB`.`employees` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`actions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`actions` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(1000) NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `project_id` BIGINT NOT NULL,
  `employee_id` BIGINT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_actions_projects1_idx` (`project_id` ASC) VISIBLE,
  INDEX `fk_actions_employees1_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `fk_actions_employees`
    FOREIGN KEY (`employee_id`)
    REFERENCES `ServiceHelpDeskDB`.`employees` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_actions_projects`
    FOREIGN KEY (`project_id`)
    REFERENCES `ServiceHelpDeskDB`.`projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`admins` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`project_branches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`project_branches` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `description` VARCHAR(1000) NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `project_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `project_id`),
  INDEX `fk_project_branch_projects1_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_project_branch_projects`
    FOREIGN KEY (`project_id`)
    REFERENCES `ServiceHelpDeskDB`.`projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `ServiceHelpDeskDB`.`requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ServiceHelpDeskDB`.`requests` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(1000) NOT NULL,
  `status` VARCHAR(100) NOT NULL,
  `date_submitted` DATETIME NOT NULL,
  `employee_id` BIGINT NOT NULL,
  `project_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`, `project_id`),
  INDEX `fk_requests_employees1_idx` (`employee_id` ASC) VISIBLE,
  INDEX `fk_requests_projects1_idx` (`project_id` ASC) VISIBLE,
  CONSTRAINT `fk_requests_employees`
    FOREIGN KEY (`employee_id`)
    REFERENCES `ServiceHelpDeskDB`.`employees` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_requests_projects`
    FOREIGN KEY (`project_id`)
    REFERENCES `ServiceHelpDeskDB`.`projects` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
