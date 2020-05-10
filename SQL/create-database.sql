# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: shona.ck4hfkyujfxy.eu-west-1.rds.amazonaws.com (MySQL 5.7.26-log)
# Database: Autism
# Generation Time: 2020-05-10 13:53:23 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table activity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `activity`;

CREATE TABLE `activity` (
  `activity_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `activity_type_id` int(11) unsigned NOT NULL,
  `completed` bit(11) NOT NULL,
  PRIMARY KEY (`activity_id`),
  KEY `activity_user` (`user_id`),
  KEY `activity_activity_type` (`activity_type_id`),
  CONSTRAINT `activity_activity_type` FOREIGN KEY (`activity_type_id`) REFERENCES `activity_type` (`activity_type_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `activity_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table activity_type
# ------------------------------------------------------------

DROP TABLE IF EXISTS `activity_type`;

CREATE TABLE `activity_type` (
  `activity_type_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `image_url` varchar(11) NOT NULL DEFAULT '',
  PRIMARY KEY (`activity_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table feeling
# ------------------------------------------------------------

DROP TABLE IF EXISTS `feeling`;

CREATE TABLE `feeling` (
  `feeling_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `image_url` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`feeling_id`),
  KEY `feeling_user` (`user_id`),
  CONSTRAINT `feeling_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL DEFAULT '',
  `username` varchar(250) NOT NULL DEFAULT '',
  `email` varchar(250) NOT NULL DEFAULT '',
  `password` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
