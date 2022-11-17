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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`persona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`persona` (
  `dni` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(20) NOT NULL,
  `domicilio` VARCHAR(45) NOT NULL,
  `edad` TINYINT(3) NULL,
  `fecha_nac` DATE NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`dni`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`domicilio` (
  `iddomicilio` INT NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `altura` SMALLINT(6) NOT NULL,
  `pais` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `ciudad` VARCHAR(45) NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`iddomicilio`, `persona_dni`),
  INDEX `fk_domicilio_persona_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_domicilio_persona`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `mydb`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`educacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`educacion` (
  `ideducacion` INT NOT NULL,
  `nombre_estab` VARCHAR(45) NOT NULL,
  `nivel_educ` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egre` DATE NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`ideducacion`, `persona_dni`),
  INDEX `fk_educacion_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_educacion_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `mydb`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`experiencia_laboral`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`experiencia_laboral` (
  `idlaboral` INT NOT NULL,
  `empresa` VARCHAR(45) NOT NULL,
  `cargo` VARCHAR(45) NOT NULL,
  `fecha_ing` DATE NOT NULL,
  `fecha_egre` DATE NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`idlaboral`, `persona_dni`),
  INDEX `fk_experiencia_laboral_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_experiencia_laboral_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `mydb`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `idusuario` INT NOT NULL,
  `usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`idusuario`, `persona_dni`),
  INDEX `fk_usuarios_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `mydb`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`softskill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`softskill` (
  `idskill` INT NOT NULL,
  `habilidades` VARCHAR(45) NOT NULL,
  `porcentaje` VARCHAR(45) NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`idskill`, `persona_dni`),
  INDEX `fk_softskill_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_softskill_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `mydb`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`proyectos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`proyectos` (
  `idproyectos` INT NOT NULL,
  `nombre_proyecto` VARCHAR(45) NOT NULL,
  `fecha` DATE NOT NULL,
  `descripcion` LONGTEXT NOT NULL,
  `persona_dni` INT NOT NULL,
  PRIMARY KEY (`idproyectos`, `persona_dni`),
  INDEX `fk_proyectos_persona1_idx` (`persona_dni` ASC) VISIBLE,
  CONSTRAINT `fk_proyectos_persona1`
    FOREIGN KEY (`persona_dni`)
    REFERENCES `mydb`.`persona` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `idrol` INT NOT NULL,
  `rolcol` VARCHAR(45) NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rol_has_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol_has_usuarios` (
  `rol_idrol` INT NOT NULL,
  `usuarios_idusuario` INT NOT NULL,
  `usuarios_persona_dni` INT NOT NULL,
  PRIMARY KEY (`rol_idrol`, `usuarios_idusuario`, `usuarios_persona_dni`),
  INDEX `fk_rol_has_usuarios_usuarios1_idx` (`usuarios_idusuario` ASC, `usuarios_persona_dni` ASC) VISIBLE,
  INDEX `fk_rol_has_usuarios_rol1_idx` (`rol_idrol` ASC) VISIBLE,
  CONSTRAINT `fk_rol_has_usuarios_rol1`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `mydb`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rol_has_usuarios_usuarios1`
    FOREIGN KEY (`usuarios_idusuario` , `usuarios_persona_dni`)
    REFERENCES `mydb`.`usuarios` (`idusuario` , `persona_dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
