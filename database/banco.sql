-- MySQL Script generated by MySQL Workbench
-- sáb 25 set 2021 21:25:57
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema desafio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema desafio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `desafio` ;
USE `desafio` ;

-- -----------------------------------------------------
-- Table `desafio`.`estados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`estados` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sigla` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafio`.`cidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`cidades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `estados_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidades_estados_idx` (`estados_id` ASC),
  CONSTRAINT `fk_cidades_estados`
    FOREIGN KEY (`estados_id`)
    REFERENCES `desafio`.`estados` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafio`.`bairros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`bairros` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `cidades_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_bairros_cidades1_idx` (`cidades_id` ASC),
  CONSTRAINT `fk_bairros_cidades1`
    FOREIGN KEY (`cidades_id`)
    REFERENCES `desafio`.`cidades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafio`.`enderecos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`enderecos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `rua` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(45) NULL,
  `complemento` TEXT NULL,
  `bairros_id` INT NOT NULL,
  `cep` VARCHAR(9) NOT NULL,
  `criado_em` DATETIME NOT NULL,
  `editado_em` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_enderecos_bairros1_idx` (`bairros_id` ASC),
  CONSTRAINT `fk_enderecos_bairros1`
    FOREIGN KEY (`bairros_id`)
    REFERENCES `desafio`.`bairros` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafio`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(400) NOT NULL,
  `criado_em` DATETIME NOT NULL,
  `editado_em` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafio`.`inscricoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`inscricoes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `data_nascimento` DATE NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `foto` VARCHAR(500) NOT NULL,
  `enderecos_id` INT NOT NULL,
  `criado_em` DATETIME NOT NULL,
  `editado_em` DATETIME NOT NULL,
  `landingpage` TINYINT NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC),
  INDEX `fk_inscricoes_enderecos1_idx` (`enderecos_id` ASC),
  CONSTRAINT `fk_inscricoes_enderecos1`
    FOREIGN KEY (`enderecos_id`)
    REFERENCES `desafio`.`enderecos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `desafio`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `desafio`.`admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuarios_id` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `criado_em` DATETIME NOT NULL,
  `editado_em` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_admin_usuarios1_idx` (`usuarios_id` ASC),
  CONSTRAINT `fk_admin_usuarios1`
    FOREIGN KEY (`usuarios_id`)
    REFERENCES `desafio`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;