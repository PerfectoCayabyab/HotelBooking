ALTER TABLE `#__vikbooking_cronjobs` CHANGE `flag_char` `flag_char` text DEFAULT NULL;

ALTER TABLE `#__vikbooking_orders` CHANGE `idorderota` `idorderota` varchar(128) DEFAULT NULL;