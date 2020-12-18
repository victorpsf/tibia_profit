CREATE DATABASE  IF NOT EXISTS `tibia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tibia`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

DROP TABLE IF EXISTS `login`;
CREATE TABLE `login` (
	`id` BIGINT AUTO_INCREMENT,
  `nick` LONGTEXT,
  `email` LONGTEXT NOT NULL,
  `senha` LONGTEXT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `forgotem`;
CREATE TABLE `forgotem` (
	`id` BIGINT AUTO_INCREMENT,
  `login_id` BIGINT NOT NULL,
  `code` LONGTEXT NOT NULL,
  `usaged_at` DATETIME,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`login_id`) REFERENCES `login`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `entrycode`;
CREATE TABLE `entrycode` (
	`id` BIGINT AUTO_INCREMENT,
  `login_id` BIGINT NOT NULL,
  `code` LONGTEXT NOT NULL,
  `usaged_at` DATETIME,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`login_id`) REFERENCES `login`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `file`;
CREATE TABLE `file` (
	`id` BIGINT AUTO_INCREMENT,
  `name` LONGTEXT NOT NULL,
  `mimetype` LONGTEXT NOT NULL,
  `size` BIGINT NOT NULL,
  `binary` LONGBLOB NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	`id` BIGINT AUTO_INCREMENT,
  `cpf` LONGTEXT NOT NULL,
  `login_id` BIGINT NOT NULL,
  `profile_id` BIGINT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`login_id`) REFERENCES `login`(`id`),
  FOREIGN KEY(`profile_id`) REFERENCES `file`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `server`;
CREATE TABLE `server` (
	`id` BIGINT AUTO_INCREMENT,
  `name` VARCHAR(220) NOT NULL,
  `color` VARCHAR(220) NOT NULL,
  `pvp` VARCHAR(220) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `person`;
CREATE TABLE `person` (
	`id` BIGINT AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL,
  `server_id` BIGINT NOT NULL,
  `name` VARCHAR(220) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`user_id`) REFERENCES `user`(`id`),
  FOREIGN KEY(`server_id`) REFERENCES `server`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
	`id` BIGINT AUTO_INCREMENT,
  `person_id` BIGINT NOT NULL,
  `experience` BIGINT NOT NULL,
  `time` BIGINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  `deleted_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`person_id`) REFERENCES `person`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
	`id` BIGINT AUTO_INCREMENT,
  `name` VARCHAR(220) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `npc`;
CREATE TABLE `npc` (
	`id` BIGINT AUTO_INCREMENT,
  `profile_id` BIGINT NOT NULL,
  `location_id` BIGINT NOT NULL,
  `name` VARCHAR(220) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`profile_id`) REFERENCES `file`(`id`),
  FOREIGN KEY(`location_id`) REFERENCES `location`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
	`id` BIGINT AUTO_INCREMENT,
  `image_id` BIGINT NOT NULL,
  `name` VARCHAR(220) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`image_id`) REFERENCES `file`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `npc_buy`;
CREATE TABLE `npc_buy` (
	`id` BIGINT AUTO_INCREMENT,
  `npc_id` BIGINT NOT NULL,
  `item_id` BIGINT NOT NULL,
  `value` DECIMAL(12,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`npc_id`) REFERENCES `npc`(`id`),
  FOREIGN KEY(`item_id`) REFERENCES `item`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `npc_sell`;
CREATE TABLE `npc_sell` (
	`id` BIGINT AUTO_INCREMENT,
  `npc_id` BIGINT NOT NULL,
  `item_id` BIGINT NOT NULL,
  `value` DECIMAL(12,2) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`npc_id`) REFERENCES `npc`(`id`),
  FOREIGN KEY(`item_id`) REFERENCES `item`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `section_item`;
CREATE TABLE `section_item` (
	`id` BIGINT AUTO_INCREMENT,
  `section_id` BIGINT NOT NULL,
  `item_id` BIGINT NOT NULL,
  `status` TINYINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  `deleted_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`section_id`) REFERENCES `section`(`id`),
  FOREIGN KEY(`item_id`) REFERENCES `item`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `access`;
CREATE TABLE `access` (
  `id` BIGINT AUTO_INCREMENT,
  `name` VARCHAR(220) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `npc_access`;
CREATE TABLE `npc_access` (
  `id` BIGINT AUTO_INCREMENT,
  `npc_id` BIGINT NOT NULL,
  `access_id` BIGINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`npc_id`) REFERENCES `npc`(`id`),
  FOREIGN KEY(`access_id`) REFERENCES `access`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `person_access`;
CREATE TABLE `person_access` (
  `id` BIGINT AUTO_INCREMENT,
  `person_id` BIGINT NOT NULL,
  `access_id` BIGINT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME,
  PRIMARY KEY(`id`),
  FOREIGN KEY(`person_id`) REFERENCES `person`(`id`),
  FOREIGN KEY(`access_id`) REFERENCES `access`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO `login` 
	(`email`, `senha`, `created_at`) VALUES 
  ('af6b3f25f3775ec9c9b057c35de45b45b420d6afa0efd894c072751d6246922b', 'f603e12ed5c239702e03df708b290029497655a2b83a26d081dce185bbaebb13', '2020-12-15 00:43:00');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;