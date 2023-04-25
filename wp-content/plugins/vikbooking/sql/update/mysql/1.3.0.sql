CREATE TABLE IF NOT EXISTS `#__vikbooking_calendars_xref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mainroom` int(10) NOT NULL,
  `childroom` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_greview_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(256) NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

ALTER TABLE `#__vikbooking_busy` ADD COLUMN `sharedcal` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `#__vikbooking_orders` ADD COLUMN `payable` decimal(12,2) DEFAULT 0.00;