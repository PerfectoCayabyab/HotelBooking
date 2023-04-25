CREATE TABLE IF NOT EXISTS `#__vikbooking_einvoicing_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `driver` varchar(32) NOT NULL,
  `params` text,
  `automatic` tinyint(1) NOT NULL DEFAULT 0,
  `progcount` int(6) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_einvoicing_data` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `driverid` int(10) NOT NULL DEFAULT 0,
  `created_on` datetime DEFAULT NULL,
  `for_date` date DEFAULT NULL,
  `filename` varchar(64) NOT NULL,
  `number` varchar(16) NOT NULL,
  `idorder` int(10) NOT NULL,
  `idcustomer` int(10) NOT NULL DEFAULT 0,
  `country` char(3) DEFAULT NULL,
  `recipientcode` varchar(64) NOT NULL,
  `xml` text,
  `transmitted` tinyint(1) NOT NULL DEFAULT 0,
  `obliterated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_operators` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `code` varchar(16) NOT NULL,
  `ujid` int(5) NOT NULL DEFAULT 0,
  `fingpt` varchar(32) DEFAULT NULL,
  `perms` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_trackings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` datetime DEFAULT NULL,
  `lastdt` datetime DEFAULT NULL,
  `fingerprint` varchar(64) DEFAULT NULL,
  `ip` varchar(64) DEFAULT NULL,
  `geo` varchar(256) DEFAULT NULL,
  `country` char(3) DEFAULT NULL,
  `idcustomer` int(10) NOT NULL DEFAULT 0,
  `published` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_tracking_infos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idtracking` int(10) NOT NULL,
  `identifier` int(10) NOT NULL,
  `trackingdt` datetime DEFAULT NULL,
  `device` char(1) DEFAULT NULL,
  `trkdata` varchar(512) DEFAULT NULL,
  `checkin` datetime DEFAULT NULL,
  `checkout` datetime DEFAULT NULL,
  `idorder` int(10) NOT NULL DEFAULT 0,
  `referrer` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `#__vikbooking_customers` ADD COLUMN `fisccode` varchar(32) DEFAULT NULL;
ALTER TABLE `#__vikbooking_customers` ADD COLUMN `pec` varchar(128) DEFAULT NULL;
ALTER TABLE `#__vikbooking_customers` ADD COLUMN `recipcode` varchar(64) DEFAULT NULL;

ALTER TABLE `#__vikbooking_optionals` ADD COLUMN `alwaysav` varchar(32) DEFAULT NULL;
ALTER TABLE `#__vikbooking_optionals` ADD COLUMN `pcentroom` tinyint(1) NOT NULL DEFAULT 0;

ALTER TABLE `#__vikbooking_seasons` ADD COLUMN `promolastmin` int(10) NOT NULL DEFAULT 0;

INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('trkenabled','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('trkcookierfrdur','3');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('trkcampaigns','');