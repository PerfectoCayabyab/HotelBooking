CREATE TABLE IF NOT EXISTS `#__vikbooking_critical_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `idroom` int(10) NOT NULL DEFAULT 0,
  `subunit` int(10) NOT NULL DEFAULT 0,
  `info` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `#__vikbooking_optionals` ADD COLUMN `oparams` varchar(1024) DEFAULT NULL;
ALTER TABLE `#__vikbooking_characteristics` ADD COLUMN `ordering` int(10) NOT NULL DEFAULT 1;
ALTER TABLE `#__vikbooking_seasons` ADD COLUMN `promofinalprice` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `#__vikbooking_coupons` ADD COLUMN `excludetaxes` tinyint(1) NOT NULL DEFAULT 1;