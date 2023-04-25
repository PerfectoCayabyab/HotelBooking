CREATE TABLE IF NOT EXISTS `#__vikbooking_fests_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `festinfo` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `#__vikbooking_orderhistory` ADD COLUMN `data` varchar(1024) DEFAULT NULL;
ALTER TABLE `#__vikbooking_iva` ADD COLUMN `taxcap` decimal(12,2) DEFAULT NULL;
ALTER TABLE `#__vikbooking_gpayments` ADD COLUMN `onlynonrefund` tinyint(1) NOT NULL DEFAULT 0;