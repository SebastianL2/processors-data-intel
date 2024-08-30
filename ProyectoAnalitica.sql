-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema processors
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`processors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`processors` (
  `processor_id` INT NOT NULL AUTO_INCREMENT,
  `processor_name` VARCHAR(255) NULL,
  `processor_code` VARCHAR(255) NULL,
  `processor_release_date` DATE NULL,
  `cores` VARCHAR(45) NULL,
  `threads` VARCHAR(45) NULL,
  `max_turbo_freq` VARCHAR(45) NULL,
  `base_freq` VARCHAR(45) NULL,
  `integrated_graphics_flag` TINYINT NULL,
  `processor_amount` DOUBLE NULL,
  `processor_status` VARCHAR(45) NULL,
  PRIMARY KEY (`processor_id`),
  UNIQUE INDEX `code_UNIQUE` (`processor_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`materials` (
  `material_id` INT NOT NULL AUTO_INCREMENT,
  `material_name` VARCHAR(255) NULL,
  `material_amount` DOUBLE NULL,
  PRIMARY KEY (`material_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`suppliers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`suppliers` (
  `supplier_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_name` VARCHAR(255) NULL,
  `country_name` VARCHAR(150) NULL,
  `purity_percent` FLOAT NULL,
  PRIMARY KEY (`supplier_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`factories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factories` (
  `factory_id` INT NOT NULL AUTO_INCREMENT,
  `factory_name` VARCHAR(255) NULL,
  PRIMARY KEY (`factory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`factory_has_materials`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factory_has_materials` (
  `processors_materials_id` INT NOT NULL,
  `factory_material_id` INT NOT NULL,
  `factory_id` INT NOT NULL,
  PRIMARY KEY (`processors_materials_id`),
  INDEX `fk_processors_materials_materials1_idx` (`factory_material_id` ASC) VISIBLE,
  INDEX `fk_processor_has_materials_factories1_idx` (`factory_id` ASC) VISIBLE,
  CONSTRAINT `fk_processors_materials_materials1`
    FOREIGN KEY (`factory_material_id`)
    REFERENCES `mydb`.`materials` (`material_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_processor_has_materials_factories1`
    FOREIGN KEY (`factory_id`)
    REFERENCES `mydb`.`factories` (`factory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`countries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`countries` (
  `country_id` INT NOT NULL,
  `country_code` VARCHAR(150) NULL,
  `country_name` VARCHAR(255) NULL,
  PRIMARY KEY (`country_id`),
  UNIQUE INDEX `code_UNIQUE` (`country_code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`countrie_has_factories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`countrie_has_factories` (
  `countries_factories_id` INT NOT NULL AUTO_INCREMENT,
  `countrie_id` INT NOT NULL,
  `factory_id` INT NOT NULL,
  PRIMARY KEY (`countries_factories_id`),
  INDEX `fk_countries_factories_countries1_idx` (`countrie_id` ASC) VISIBLE,
  INDEX `fk_countries_factories_factories1_idx` (`factory_id` ASC) VISIBLE,
  CONSTRAINT `fk_countries_factories_countries1`
    FOREIGN KEY (`countrie_id`)
    REFERENCES `mydb`.`countries` (`country_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_countries_factories_factories1`
    FOREIGN KEY (`factory_id`)
    REFERENCES `mydb`.`factories` (`factory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `supplier_id` INT NOT NULL,
  `order_date` DATE NULL,
  `order_amount` DOUBLE NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_orders_suppliers1_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `mydb`.`suppliers` (`supplier_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_has_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_has_details` (
  `order_detail_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `material_id` INT NOT NULL,
  `order_number` INT NULL,
  PRIMARY KEY (`order_detail_id`),
  INDEX `fk_orders_details_materials1_idx` (`material_id` ASC) VISIBLE,
  INDEX `fk_orders_details_orders1_idx` (`order_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_details_materials1`
    FOREIGN KEY (`material_id`)
    REFERENCES `mydb`.`materials` (`material_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_details_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`orders` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`factory_has_processors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`factory_has_processors` (
  `factory_processors_id` INT NOT NULL AUTO_INCREMENT,
  `processor_id` INT NOT NULL,
  `factory_id` INT NOT NULL,
  `factory_has_processorscol` VARCHAR(45) NULL,
  PRIMARY KEY (`factory_processors_id`),
  INDEX `fk_factory_has_processors_processors1_idx` (`processor_id` ASC) VISIBLE,
  INDEX `fk_factory_has_processors_factories1_idx` (`factory_id` ASC) VISIBLE,
  CONSTRAINT `fk_factory_has_processors_processors1`
    FOREIGN KEY (`processor_id`)
    REFERENCES `mydb`.`processors` (`processor_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factory_has_processors_factories1`
    FOREIGN KEY (`factory_id`)
    REFERENCES `mydb`.`factories` (`factory_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
