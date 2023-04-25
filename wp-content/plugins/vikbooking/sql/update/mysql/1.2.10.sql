ALTER TABLE `#__vikbooking_customers`
ADD COLUMN `docsfolder` varchar(256) DEFAULT NULL COMMENT 'a unique folder name that will be used for keeping the customer documents' AFTER `docimg`;