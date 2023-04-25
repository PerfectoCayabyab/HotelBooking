ALTER TABLE `#__vikbooking_prices` ADD COLUMN `meal_plans` varchar(128) DEFAULT NULL;

ALTER TABLE `#__vikbooking_ordersrooms` ADD COLUMN `pets` tinyint(2) NOT NULL DEFAULT 0 AFTER `children`;

ALTER TABLE `#__vikbooking_ordersrooms` ADD COLUMN `meals` varchar(128) DEFAULT NULL;

ALTER TABLE `#__vikbooking_orders` CHANGE `ota_type_data` `ota_type_data` varchar(512) DEFAULT NULL;