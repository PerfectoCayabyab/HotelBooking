CREATE TABLE IF NOT EXISTS `#__vikbooking_reminders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL DEFAULT '',
  `descr` varchar(2048) NOT NULL DEFAULT '',
  `duedate` datetime DEFAULT NULL,
  `usetime` tinyint(1) DEFAULT 0,
  `idorder` int(10) DEFAULT 0,
  `payload` varchar(1024) DEFAULT NULL,
  `completed` tinyint(1) DEFAULT 0,
  `created_on` timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `#__vikbooking_wpshortcodes` ADD COLUMN `parent_id` int(10) unsigned DEFAULT 0;

ALTER TABLE `#__vikbooking_wpshortcodes` CHANGE `lang` `lang` varchar(16);

ALTER TABLE `#__vikbooking_orders` CHANGE `lang` `lang` varchar(16);

ALTER TABLE `#__vikbooking_customers` CHANGE `pin` `pin` int(10) NOT NULL DEFAULT 0;

ALTER TABLE `#__vikbooking_custfields` ADD COLUMN `defvalue` varchar(64) DEFAULT NULL;

ALTER TABLE `#__vikbooking_operators` CHANGE `perms` `perms` varchar(1024) DEFAULT NULL;

ALTER TABLE `#__vikbooking_einvoicing_data` ADD COLUMN `trans_data` varchar(1024) DEFAULT NULL;

ALTER TABLE `#__vikbooking_coupons` ADD COLUMN `minlos` tinyint(2) NOT NULL DEFAULT 1;