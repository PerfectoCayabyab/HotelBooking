CREATE TABLE IF NOT EXISTS `#__vikbooking_condtexts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `token` varchar(64) DEFAULT NULL,
  `rules` text DEFAULT NULL,
  `msg` text DEFAULT NULL,
  `lastupd` datetime DEFAULT NULL,
  `debug` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

UPDATE `#__vikbooking_config` SET `setting`='300' WHERE `param`='thumbsize';

ALTER TABLE `#__vikbooking_gpayments` ADD COLUMN `outposition` varchar(16) NOT NULL DEFAULT 'top';
ALTER TABLE `#__vikbooking_gpayments` ADD COLUMN `logo` varchar(128) DEFAULT NULL;
ALTER TABLE `#__vikbooking_orders` ADD COLUMN `refund` decimal(12,2) DEFAULT 0.00;
ALTER TABLE `#__vikbooking_orders` ADD COLUMN `type` varchar(64) DEFAULT NULL;
ALTER TABLE `#__vikbooking_orders` ADD COLUMN `ota_type_data` varchar(256) DEFAULT NULL;