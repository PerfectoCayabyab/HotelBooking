-- WP SHORTCODES --

CREATE TABLE IF NOT EXISTS `#__vikbooking_wpshortcodes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `createdon` DATETIME NOT NULL,
  `createdby` int(10) NOT NULL,
  `json` text NOT NULL,
  `type` varchar(48) NOT NULL,
  `title` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `lang` varchar(16) DEFAULT '*',
  `shortcode` varchar(512) NOT NULL,
  `post_id` int(10) unsigned DEFAULT 0,
  `tmp_post_id` int(10) unsigned DEFAULT 0,
  `parent_id` int(10) unsigned DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- END WP SHORTCODES --

CREATE TABLE IF NOT EXISTS `#__vikbooking_adultsdiff` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idroom` int(10) NOT NULL,
  `chdisc` tinyint(1) NOT NULL DEFAULT 1,
  `valpcent` tinyint(1) NOT NULL DEFAULT 1,
  `value` decimal(12,2) DEFAULT NULL,
  `adults` int(10) NOT NULL,
  `pernight` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_busy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idroom` int(10) NOT NULL,
  `checkin` int(11) DEFAULT NULL,
  `checkout` int(11) DEFAULT NULL,
  `realback` int(11) DEFAULT NULL,
  `sharedcal` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_characteristics` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `icon` varchar(128) DEFAULT NULL,
  `textimg` varchar(256) DEFAULT NULL,
  `ordering` int(10) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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

CREATE TABLE IF NOT EXISTS `#__vikbooking_critical_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `idroom` int(10) NOT NULL DEFAULT 0,
  `subunit` int(10) NOT NULL DEFAULT 0,
  `info` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `img` varchar(128) DEFAULT NULL,
  `idcat` varchar(128) DEFAULT NULL,
  `idcarat` varchar(128) DEFAULT NULL,
  `idopt` varchar(128) DEFAULT NULL,
  `info` text DEFAULT NULL,
  `avail` tinyint(1) NOT NULL DEFAULT 1,
  `units` int(10) NOT NULL DEFAULT 1,
  `moreimgs` varchar(1024) DEFAULT NULL,
  `fromadult` int(10) NOT NULL DEFAULT 1,
  `toadult` int(10) NOT NULL DEFAULT 1,
  `fromchild` int(10) NOT NULL DEFAULT 1,
  `tochild` int(10) NOT NULL DEFAULT 1,
  `smalldesc` varchar(512) DEFAULT NULL,
  `totpeople` int(10) NOT NULL DEFAULT 1,
  `mintotpeople` int(10) NOT NULL DEFAULT 1,
  `params` text DEFAULT NULL,
  `imgcaptions` varchar(1024) DEFAULT NULL,
  `alias` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_calendars_xref` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mainroom` int(10) NOT NULL,
  `childroom` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'cat',
  `descr` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_config` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `param` varchar(128) NOT NULL,
  `setting` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `country_name` char(64) DEFAULT NULL,
  `country_3_code` char(3) DEFAULT NULL,
  `country_2_code` char(2) DEFAULT NULL,
  `phone_prefix` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_coupons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `percentot` tinyint(1) NOT NULL DEFAULT 1,
  `value` decimal(12,2) DEFAULT NULL,
  `datevalid` varchar(64) DEFAULT NULL,
  `allvehicles` tinyint(1) NOT NULL DEFAULT 1,
  `idrooms` varchar(512) DEFAULT NULL,
  `mintotord` decimal(12,2) DEFAULT NULL,
  `idcustomer` int(10) DEFAULT NULL,
  `excludetaxes` tinyint(1) NOT NULL DEFAULT 1,
  `minlos` tinyint(2) NOT NULL DEFAULT 1,
  `maxtotord` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_custfields` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `type` varchar(64) NOT NULL DEFAULT 'text',
  `choose` text DEFAULT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `ordering` int(10) NOT NULL DEFAULT 1,
  `isemail` tinyint(1) NOT NULL DEFAULT 0,
  `poplink` varchar(256) DEFAULT NULL,
  `isnominative` tinyint(1) NOT NULL DEFAULT 0,
  `isphone` tinyint(1) NOT NULL DEFAULT 0,
  `flag` varchar(64) DEFAULT NULL,
  `defvalue` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_customers` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(64) NOT NULL,
  `last_name` varchar(64) NOT NULL,
  `email` varchar(128) DEFAULT NULL,
  `phone` varchar(64) DEFAULT NULL,
  `country` varchar(32) DEFAULT NULL,
  `cfields` text DEFAULT NULL,
  `pin` int(10) NOT NULL DEFAULT 0,
  `ujid` int(5) NOT NULL DEFAULT 0,
  `address` varchar(256) DEFAULT NULL,
  `city` varchar(64) DEFAULT NULL,
  `zip` varchar(16) DEFAULT NULL,
  `state` varchar(64) DEFAULT NULL,
  `doctype` varchar(64) DEFAULT NULL,
  `docnum` varchar(128) DEFAULT NULL,
  `docimg` varchar(128) DEFAULT NULL,
  `docsfolder` varchar(256) DEFAULT NULL COMMENT 'a unique folder name that will be used for keeping the customer documents',
  `notes` text DEFAULT NULL,
  `ischannel` tinyint(1) NOT NULL DEFAULT 0,
  `chdata` varchar(256) DEFAULT NULL,
  `company` varchar(128) DEFAULT NULL,
  `vat` varchar(64) DEFAULT NULL,
  `gender` char(1) DEFAULT NULL,
  `bdate` varchar(16) DEFAULT NULL,
  `pbirth` varchar(64) DEFAULT NULL,
  `fisccode` varchar(32) DEFAULT NULL,
  `pec` varchar(128) DEFAULT NULL,
  `recipcode` varchar(64) DEFAULT NULL,
  `pic` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_customers_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idcustomer` int(10) NOT NULL,
  `idorder` int(10) NOT NULL,
  `signature` varchar(256) DEFAULT NULL,
  `pax_data` text DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `checkindoc` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_customers_coupons` (
  `idcustomer` int(10) NOT NULL,
  `idcoupon` int(10) NOT NULL,
  `automatic` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE KEY `idx_customer_coupon` (`idcustomer`,`idcoupon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `#__vikbooking_cronjobs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cron_name` varchar(128) NOT NULL,
  `class_file` varchar(128) NOT NULL,
  `params` text DEFAULT NULL,
  `last_exec` int(11) DEFAULT NULL,
  `logs` text DEFAULT NULL,
  `flag_int` int(11) NOT NULL DEFAULT 0,
  `flag_char` text DEFAULT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_dispcost` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idroom` int(10) NOT NULL,
  `days` int(10) NOT NULL,
  `idprice` int(10) NOT NULL,
  `cost` decimal(12,2) DEFAULT NULL,
  `attrdata` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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
  `trans_data` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_fests_dates` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `dt` date DEFAULT NULL,
  `festinfo` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_gpayments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `file` varchar(64) NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT 0,
  `note` text DEFAULT NULL,
  `charge` decimal(12,2) DEFAULT NULL,
  `setconfirmed` tinyint(1) NOT NULL DEFAULT 0,
  `shownotealw` tinyint(1) NOT NULL DEFAULT 0,
  `val_pcent` tinyint(1) NOT NULL DEFAULT 1,
  `ch_disc` tinyint(1) NOT NULL DEFAULT 1,
  `params` varchar(1024) DEFAULT NULL,
  `ordering` int(5) NOT NULL DEFAULT 1,
  `hidenonrefund` tinyint(1) NOT NULL DEFAULT 0,
  `onlynonrefund` tinyint(1) NOT NULL DEFAULT 0,
  `outposition` varchar(16) NOT NULL DEFAULT 'top',
  `logo` varchar(128) DEFAULT NULL,
  `idrooms` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_greview_service` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `service_name` varchar(256) NOT NULL,
  `extra` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_invoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` varchar(16) NOT NULL,
  `file_name` varchar(128) DEFAULT NULL,
  `idorder` int(10) NOT NULL,
  `idcustomer` int(10) NOT NULL,
  `created_on` int(11) DEFAULT NULL,
  `for_date` int(11) DEFAULT NULL,
  `emailed` tinyint(1) NOT NULL DEFAULT 0,
  `emailed_to` varchar(128) DEFAULT NULL,
  `rawcont` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_iva` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `aliq` decimal(12,3) NOT NULL,
  `breakdown` varchar(512) DEFAULT NULL,
  `taxcap` decimal(12,2) DEFAULT NULL,
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
  `perms` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_optionals` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) DEFAULT NULL,
  `descr` text,
  `cost` decimal(12,2) DEFAULT NULL,
  `perday` tinyint(1) NOT NULL DEFAULT 0,
  `hmany` tinyint(1) NOT NULL DEFAULT 1,
  `img` varchar(128) DEFAULT NULL,
  `idiva` int(10) DEFAULT NULL,
  `maxprice` decimal(12,2) DEFAULT NULL,
  `forcesel` tinyint(1) NOT NULL DEFAULT 0,
  `forceval` varchar(32) DEFAULT NULL,
  `perperson` tinyint(1) NOT NULL DEFAULT 0,
  `ifchildren` tinyint(1) NOT NULL DEFAULT 0,
  `maxquant` int(10) DEFAULT NULL,
  `ordering` int(10) NOT NULL DEFAULT 1,
  `ageintervals` varchar(256) DEFAULT NULL,
  `is_citytax` tinyint(1) NOT NULL DEFAULT 0,
  `is_fee` tinyint(1) NOT NULL DEFAULT 0,
  `alwaysav` varchar(32) DEFAULT NULL,
  `pcentroom` tinyint(1) NOT NULL DEFAULT 0,
  `oparams` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_orders` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `custdata` text DEFAULT NULL,
  `ts` int(11) DEFAULT NULL,
  `status` varchar(128) DEFAULT NULL,
  `days` int(10) DEFAULT NULL,
  `checkin` int(10) DEFAULT NULL,
  `checkout` int(10) DEFAULT NULL,
  `custmail` varchar(128) DEFAULT NULL,
  `sid` varchar(128) DEFAULT NULL,
  `totpaid` decimal(12,2) DEFAULT NULL,
  `idpayment` varchar(128) DEFAULT NULL,
  `ujid` int(10) NOT NULL DEFAULT 0,
  `coupon` varchar(128) DEFAULT NULL,
  `roomsnum` int(10) NOT NULL DEFAULT 1,
  `total` decimal(12,2) DEFAULT NULL,
  `confirmnumber` varchar(64) DEFAULT NULL,
  `idorderota` varchar(128) DEFAULT NULL,
  `channel` varchar(64) DEFAULT NULL,
  `chcurrency` varchar(32) DEFAULT NULL,
  `paymentlog` text DEFAULT NULL,
  `paymcount` tinyint(2) NOT NULL DEFAULT 0,
  `adminnotes` text DEFAULT NULL,
  `lang` varchar(16) DEFAULT NULL,
  `country` varchar(5) DEFAULT NULL,
  `tot_taxes` decimal(12,2) DEFAULT NULL,
  `tot_city_taxes` decimal(12,2) DEFAULT NULL,
  `tot_fees` decimal(12,2) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `pkg` int(10) DEFAULT NULL,
  `cmms` decimal(12,2) DEFAULT NULL,
  `inv_notes` varchar(1024) DEFAULT NULL,
  `colortag` varchar(256) DEFAULT NULL,
  `closure` tinyint(1) NOT NULL DEFAULT 0,
  `checked` tinyint(1) NOT NULL DEFAULT 0,
  `payable` decimal(12,2) DEFAULT 0.00,
  `refund` decimal(12,2) DEFAULT 0.00,
  `type` varchar(64) DEFAULT NULL,
  `ota_type_data` varchar(512) DEFAULT NULL,
  `split_stay` tinyint(1) NOT NULL DEFAULT 0,
  `canc_fee` decimal(12,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_ordersbusy` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idorder` int(10) NOT NULL,
  `idbusy` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_ordersrooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idorder` int(10) NOT NULL,
  `idroom` int(10) NOT NULL,
  `adults` int(10) NOT NULL,
  `children` int(10) NOT NULL DEFAULT 0,
  `pets` tinyint(2) NOT NULL DEFAULT 0,
  `idtar` int(10) DEFAULT NULL,
  `optionals` varchar(128) DEFAULT NULL,
  `childrenage` varchar(256) DEFAULT NULL,
  `t_first_name` varchar(64) DEFAULT NULL,
  `t_last_name` varchar(64) DEFAULT NULL,
  `roomindex` int(5) DEFAULT NULL,
  `pkg_id` int(10) DEFAULT NULL,
  `pkg_name` varchar(128) DEFAULT NULL,
  `cust_cost` decimal(12,2) DEFAULT NULL,
  `cust_idiva` int(10) DEFAULT NULL,
  `extracosts` text DEFAULT NULL,
  `room_cost` decimal(12,2) DEFAULT NULL,
  `otarplan` varchar(64) DEFAULT NULL,
  `meals` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_orderhistory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idorder` int(10) NOT NULL,
  `dt` datetime NOT NULL,
  `type` char(2) NOT NULL DEFAULT 'C',
  `descr` text DEFAULT NULL,
  `totpaid` decimal(12,2) DEFAULT NULL,
  `total` decimal(12,2) DEFAULT NULL,
  `data` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_packages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'package',
  `alias` varchar(128) NOT NULL DEFAULT 'package',
  `img` varchar(128) DEFAULT NULL,
  `dfrom` int(11) NOT NULL,
  `dto` int(11) NOT NULL,
  `excldates` varchar(512) NOT NULL DEFAULT '',
  `minlos` tinyint(2) NOT NULL DEFAULT 1,
  `maxlos` tinyint(2) NOT NULL DEFAULT 0,
  `cost` decimal(12,3) NOT NULL,
  `idiva` int(10) DEFAULT NULL,
  `pernight_total` tinyint(1) NOT NULL DEFAULT 1,
  `perperson` tinyint(1) NOT NULL DEFAULT 1,
  `descr` text DEFAULT NULL,
  `shortdescr` varchar(512) DEFAULT NULL,
  `benefits` varchar(512) DEFAULT NULL,
  `conditions` text DEFAULT NULL,
  `showoptions` tinyint(1) NOT NULL DEFAULT 1,
  `startpublishd` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_packages_rooms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idpackage` int(10) NOT NULL,
  `idroom` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_prices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'cost',
  `attr` varchar(128) DEFAULT NULL,
  `idiva` int(10) DEFAULT NULL,
  `breakfast_included` tinyint(1) DEFAULT 0,
  `free_cancellation` tinyint(1) DEFAULT 0,
  `canc_deadline` int(5) DEFAULT 0,
  `closingd` text DEFAULT NULL,
  `canc_policy` text DEFAULT NULL,
  `minlos` tinyint(2) NOT NULL DEFAULT 0,
  `minhadv` int(5) DEFAULT 0,
  `meal_plans` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_receipts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `number` int(10) NOT NULL,
  `idorder` int(10) NOT NULL,
  `created_on` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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

CREATE TABLE IF NOT EXISTS `#__vikbooking_restrictions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT 'restriction',
  `month` tinyint(2) NOT NULL DEFAULT 7,
  `wday` tinyint(1) DEFAULT NULL,
  `minlos` tinyint(2) NOT NULL DEFAULT 1,
  `multiplyminlos` tinyint(1) NOT NULL DEFAULT 0,
  `maxlos` tinyint(2) NOT NULL DEFAULT 0,
  `dfrom` int(10) DEFAULT NULL,
  `dto` int(10) DEFAULT NULL,
  `wdaytwo` tinyint(1) DEFAULT NULL,
  `wdaycombo` varchar(28) DEFAULT NULL,
  `allrooms` tinyint(1) NOT NULL DEFAULT 1,
  `idrooms` varchar(512) DEFAULT NULL,
  `ctad` varchar(28) DEFAULT NULL,
  `ctdd` varchar(28) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_seasons` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(1) NOT NULL DEFAULT 1,
  `from` int(11) DEFAULT NULL,
  `to` int(11) DEFAULT NULL,
  `diffcost` decimal(12,3) DEFAULT NULL,
  `idrooms` varchar(1024) DEFAULT NULL,
  `spname` varchar(64) DEFAULT NULL,
  `wdays` varchar(16) DEFAULT NULL,
  `checkinincl` tinyint(1) NOT NULL DEFAULT 0,
  `val_pcent` tinyint(1) NOT NULL DEFAULT 2,
  `losoverride` varchar(512) DEFAULT NULL,
  `roundmode` varchar(32) DEFAULT NULL,
  `year` int(5) DEFAULT NULL,
  `idprices` varchar(256) DEFAULT NULL,
  `promo` tinyint(1) NOT NULL DEFAULT 0,
  `promotxt` text DEFAULT NULL,
  `promodaysadv` int(5) DEFAULT NULL,
  `promominlos` tinyint(1) NOT NULL DEFAULT 0,
  `occupancy_ovr` text DEFAULT NULL,
  `promolastmin` int(10) NOT NULL DEFAULT 0,
  `promofinalprice` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_states` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_country` int(10) unsigned NOT NULL DEFAULT 0,
  `state_name` varchar(64) NOT NULL,
  `state_2_code` char(2) NOT NULL,
  `state_3_code` char(3) DEFAULT '',
  `published` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_state_2_code` (`id_country`,`state_2_code`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_texts` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `param` varchar(128) NOT NULL,
  `exp` text,
  `setting` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

CREATE TABLE IF NOT EXISTS `#__vikbooking_tmplock` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `idroom` int(10) NOT NULL,
  `checkin` int(11) NOT NULL,
  `checkout` int(11) NOT NULL,
  `until` int(11) NOT NULL,
  `realback` int(11) DEFAULT NULL,
  `idorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

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

CREATE TABLE IF NOT EXISTS `#__vikbooking_translations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table` varchar(64) NOT NULL,
  `lang` varchar(16) NOT NULL,
  `reference_id` int(10) NOT NULL,
  `content` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('showfooter','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('timeopenstore','43200-36000');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('hoursmorebookingback','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('hoursmoreroomavail','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('allowbooking','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('dateformat','%d/%m/%Y');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('showcategories','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('showchildren','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('fronttitletag','h3');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('fronttitletagclass','');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('searchbtnclass','button');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('ivainclusa','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('tokenform','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('ccpaypal','');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('paytotal','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('payaccpercent','50');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('minuteslock','20');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('sendjutility','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('currencyname','EUR');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('currencysymb','&euro;');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('currencycodepp','EUR');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('sitelogo','vikbooking.png');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('backlogo','');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('showpartlyreserved','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('numcalendars','3');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('requirelogin','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('loadjquery','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('calendar','jqueryui');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('enablecoupons','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('theme','default');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('numrooms','5');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('numadults','1-10');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('numchildren','0-4');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('autodefcalnights','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('numberformat','2:.:,');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('mindaysadvance','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('multipay','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('typedeposit','pcent');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('taxsummary','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smartsearch','automatic');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('maxdate','+2y');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('firstwday','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('todaybookings','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('multilang','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('bootstrap','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('enablepin','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('senderemail','');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('autoroomunit','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('closingdates','[]');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smsapi','');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smsautosend','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smssendto','[]');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smsadminphone','');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smsparams','[]');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('cronkey', FLOOR(1000 + (RAND() * 9000)));
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('showcheckinoutonly','0');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('invoiceinum', '0');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('invoicesuffix', '/WEB');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('invcompanyinfo', '');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('depifdaysadv', '0');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('depcustchoice', '0');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('datesep', '/');
INSERT INTO `#__vikbooking_config` (`param`, `setting`) VALUES('vcmautoupd', '1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('smssendwhen','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('minautoremove','0');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('trkenabled','1');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('trkcookierfrdur','3');
INSERT INTO `#__vikbooking_config` (`param`,`setting`) VALUES ('trkcampaigns','');

INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('disabledbookingmsg','Disabled Booking Message','');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('fronttitle','Page Title','VikBooking');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('searchbtnval','Search Button Text','');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('intromain','Main Page Introducing Text','');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('closingmain','Main Page Closing Text','Powered by VikBooking');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('paymentname','Paypal Transaction Name','Rooms Reservation');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('disclaimer','Disclaimer Text','');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('footerordmail','Footer Text Order eMail','');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('smsadmintpl','Administrator SMS Template','A new booking ({booking_id}) for {tot_guests} guests was confirmed by {customer_name} from {customer_country}.\nCheck-in on {checkin_date} for {num_nights} nights.');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('smscustomertpl','Customer SMS Template','Dear {customer_name},\nYour booking for {num_nights} nights and {tot_guests} guests has been confirmed! Your PIN Code is {customer_pin}');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('smsadmintplpend','Administrator SMS Template (Pending)','A prending reservation ({booking_id}) for {tot_guests} guests was created by {customer_name} from {customer_country}.\nCheck-in on {checkin_date} for {num_nights} nights.');
INSERT INTO `#__vikbooking_texts` (`param`,`exp`,`setting`) VALUES ('smscustomertplpend','Customer SMS Template (Pending)','Dear {customer_name},\nYour booking for {num_nights} nights and {tot_guests} guests is waiting for the payment before the confirmation.');

INSERT INTO `#__vikbooking_gpayments` (`name`,`file`,`published`,`note`,`charge`,`setconfirmed`,`shownotealw`,`val_pcent`,`ch_disc`,`ordering`) VALUES ('Bank Transfer','bank_transfer.php','0','<p>Bank Transfer Info...</p>','0.00','1','1','1','1', 1);
INSERT INTO `#__vikbooking_gpayments` (`name`,`file`,`published`,`note`,`charge`,`setconfirmed`,`shownotealw`,`val_pcent`,`ch_disc`,`ordering`) VALUES ('PayPal','paypal.php','0','<p></p>','0.00','0','0','1','1', 2);
INSERT INTO `#__vikbooking_gpayments` (`name`,`file`,`published`,`note`,`charge`,`setconfirmed`,`shownotealw`,`val_pcent`,`ch_disc`,`ordering`) VALUES ('Offline Credit Card','offline_credit_card.php','0','<p></p>','0.00','0','0','1','1', 3);

INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('VBSEPDRIVERD','separator','','0','1','0','', 0, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_NAME','text','','1','2','0','', 1, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_LNAME','text','','1','3','0','', 1, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_EMAIL','text','','1','4','1','', 0, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_PHONE','text','','0','5','0','', 0, 1);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`,`flag`) VALUES ('ORDER_ADDRESS','text','','0','6','0','', 0, 0, 'address');
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`,`flag`) VALUES ('ORDER_ZIP','text','','0','7','0','', 0, 0, 'zip');
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`,`flag`) VALUES ('ORDER_CITY','text','','0','8','0','', 0, 0, 'city');
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_STATE','country','','0','9','0','', 0, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('VBO_STATE_PROVINCE','state','','0','10','0','', 0, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`,`flag`) VALUES ('VBCUSTOMERCOMPANY','text','','0','11','0','', 0, 0, 'company');
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`,`flag`) VALUES ('VBCUSTOMERCOMPANYVAT','text','','0','12','0','', 0, 0, 'vat');
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_SPREQUESTS','textarea','','0','13','0','', 0, 0);
INSERT INTO `#__vikbooking_custfields` (`name`,`type`,`choose`,`required`,`ordering`,`isemail`,`poplink`,`isnominative`,`isphone`) VALUES ('ORDER_TERMSCONDITIONS','checkbox','','1','14','0','', 0, 0);

INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('WiFi', NULL, '<i class="fas fa-wifi vbo-icn-carat vbo-pref-color-text"></i>', 1);
INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('TV', NULL, '<i class="fas fa-tv vbo-icn-carat vbo-pref-color-text"></i>', 2);
INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('Air Conditioning', NULL, '<i class="fas fa-snowflake vbo-icn-carat vbo-pref-color-text"></i>', 3);
INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('Bathroom', NULL, '<i class="fas fa-bath vbo-icn-carat vbo-pref-color-text"></i>', 4);
INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('Mini Bar', NULL, '<i class="fas fa-beer vbo-icn-carat vbo-pref-color-text"></i>', 5);
INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('Pets Allowed', NULL, '<i class="fas fa-paw vbo-icn-carat vbo-pref-color-text"></i>', 6);
INSERT INTO `#__vikbooking_characteristics` (`name`,`icon`,`textimg`,`ordering`) VALUES ('Disabled Facilities', NULL, '<i class="fas fa-wheelchair vbo-icn-carat vbo-pref-color-text"></i>', 7);

INSERT INTO `#__vikbooking_countries` (`country_name`, `country_3_code`, `country_2_code`, `phone_prefix`) VALUES
('Afghanistan', 'AFG', 'AF', '+93'),
('Aland', 'ALA', 'AX', '+358 18'),
('Albania', 'ALB', 'AL', '+355'),
('Algeria', 'DZA', 'DZ', '+213'),
('American Samoa', 'ASM', 'AS', '+1 684'),
('Andorra', 'AND', 'AD', '+376'),
('Angola', 'AGO', 'AO', '+244'),
('Anguilla', 'AIA', 'AI', '+1 264'),
('Antarctica', 'ATA', 'AQ', '+6721'),
('Antigua and Barbuda', 'ATG', 'AG', '+1 268'),
('Argentina', 'ARG', 'AR', '+54'),
('Armenia', 'ARM', 'AM', '+374'),
('Aruba', 'ABW', 'AW', '+297'),
('Ascension Island', 'ASC', 'AC', '+247'),
('Australia', 'AUS', 'AU', '+61'),
('Austria', 'AUT', 'AT', '+43'),
('Azerbaijan', 'AZE', 'AZ', '+994'),
('Bahamas', 'BHS', 'BS', '+1 242'),
('Bahrain', 'BHR', 'BH', '+973'),
('Bangladesh', 'BGD', 'BD', '+880'),
('Barbados', 'BRB', 'BB', '+1 246'),
('Belarus', 'BLR', 'BY', '+375'),
('Belgium', 'BEL', 'BE', '+32'),
('Belize', 'BLZ', 'BZ', '+501'),
('Benin', 'BEN', 'BJ', '+229'),
('Bermuda', 'BMU', 'BM', '+1 441'),
('Bhutan', 'BTN', 'BT', '+975'),
('Bolivia', 'BOL', 'BO', '+591'),
('Bosnia and Herzegovina', 'BIH', 'BA', '+387'),
('Botswana', 'BWA', 'BW', '+267'),
('Bouvet Island', 'BVT', 'BV', '+47'),
('Brazil', 'BRA', 'BR', '+55'),
('British Indian Ocean Territory', 'IOT', 'IO', '+246'),
('British Virgin Islands', 'VGB', 'VG', '+1 284'),
('Brunei', 'BRN', 'BN', '+673'),
('Bulgaria', 'BGR', 'BG', '+359'),
('Burkina Faso', 'BFA', 'BF', '+226'),
('Burundi', 'BDI', 'BI', '+257'),
('Cambodia', 'KHM', 'KH', '+855'),
('Cameroon', 'CMR', 'CM', '+237'),
('Canada', 'CAN', 'CA', '+1'),
('Cape Verde', 'CPV', 'CV', '+238'),
('Cayman Islands', 'CYM', 'KY', '+1 345'),
('Central African Republic', 'CAF', 'CF', '+236'),
('Chad', 'TCD', 'TD', '+235'),
('Chile', 'CHL', 'CL', '+56'),
('China', 'CHN', 'CN', '+86'),
('Christmas Island', 'CXR', 'CX', '+61 8964'),
('Cocos Islands', 'CCK', 'CC', '+61 8962'),
('Colombia', 'COL', 'CO', '+57'),
('Comoros', 'COM', 'KM', '+269'),
('Cook Islands', 'COK', 'CK', '+682'),
('Costa Rica', 'CRI', 'CR', '+506'),
('Cote d Ivoire', 'CIV', 'CI', '+225'),
('Croatia', 'HRV', 'HR', '+385'),
('Cuba', 'CUB', 'CU', '+53'),
('Cyprus', 'CYP', 'CY', '+357'),
('Czech Republic', 'CZE', 'CZ', '+420'),
('Democratic Republic of the Congo', 'COD', 'CD', '+243'),
('Denmark', 'DNK', 'DK', '+45'),
('Djibouti', 'DJI', 'DJ', '+253'),
('Dominica', 'DMA', 'DM', '+1 767'),
('Dominican Republic', 'DOM', 'DO', '+1 809'),
('East Timor', 'TLS', 'TL', '+670'),
('Ecuador', 'ECU', 'EC', '+593'),
('Egypt', 'EGY', 'EG', '+20'),
('El Salvador', 'SLV', 'SV', '+503'),
('Equatorial Guinea', 'GNQ', 'GQ', '+240'),
('Eritrea', 'ERI', 'ER', '+291'),
('Estonia', 'EST', 'EE', '+372'),
('Ethiopia', 'ETH', 'ET', '+251'),
('Falkland Islands', 'FLK', 'FK', '+500'),
('Faroe Islands', 'FRO', 'FO', '+298'),
('Fiji', 'FJI', 'FJ', '+679'),
('Finland', 'FIN', 'FI', '+358'),
('France', 'FRA', 'FR', '+33'),
('French Austral and Antarctic Territories', 'ATF', 'TF', '+33'),
('French Guiana', 'GUF', 'GF', '+594'),
('French Polynesia', 'PYF', 'PF', '+689'),
('Gabon', 'GAB', 'GA', '+241'),
('Gambia', 'GMB', 'GM', '+220'),
('Georgia', 'GEO', 'GE', '+995'),
('Germany', 'DEU', 'DE', '+49'),
('Ghana', 'GHA', 'GH', '+233'),
('Gibraltar', 'GIB', 'GI', '+350'),
('Greece', 'GRC', 'GR', '+30'),
('Greenland', 'GRL', 'GL', '+299'),
('Grenada', 'GRD', 'GD', '+1 473'),
('Guadeloupe', 'GLP', 'GP', '+590'),
('Guam', 'GUM', 'GU', '+1 671'),
('Guatemala', 'GTM', 'GT', '+502'),
('Guernsey', 'GGY', 'GG', '+44 1481'),
('Guinea', 'GIN', 'GN', '+224'),
('Guinea-Bissau', 'GNB', 'GW', '+245'),
('Guyana', 'GUY', 'GY', '+592'),
('Haiti', 'HTI', 'HT', '+509'),
('Heard and McDonald Islands', 'HMD', 'HM', '+61'),
('Honduras', 'HND', 'HN', '+504'),
('Hong Kong', 'HKG', 'HK', '+852'),
('Hungary', 'HUN', 'HU', '+36'),
('Iceland', 'ISL', 'IS', '+354'),
('India', 'IND', 'IN', '+91'),
('Indonesia', 'IDN', 'ID', '+62'),
('Iran', 'IRN', 'IR', '+98'),
('Iraq', 'IRQ', 'IQ', '+964'),
('Ireland', 'IRL', 'IE', '+353'),
('Isle of Man', 'IMN', 'IM', '+44 1624'),
('Israel', 'ISR', 'IL', '+972'),
('Italy', 'ITA', 'IT', '+39'),
('Jamaica', 'JAM', 'JM', '+1 876'),
('Japan', 'JPN', 'JP', '+81'),
('Jersey', 'JEY', 'JE', '+44 1534'),
('Jordan', 'JOR', 'JO', '+962'),
('Kazakhstan', 'KAZ', 'KZ', '+7'),
('Kenya', 'KEN', 'KE', '+254'),
('Kiribati', 'KIR', 'KI', '+686'),
('Kosovo', 'KV', 'KV', '+381'),
('Kuwait', 'KWT', 'KW', '+965'),
('Kyrgyzstan', 'KGZ', 'KG', '+996'),
('Laos', 'LAO', 'LA', '+856'),
('Latvia', 'LVA', 'LV', '+371'),
('Lebanon', 'LBN', 'LB', '+961'),
('Lesotho', 'LSO', 'LS', '+266'),
('Liberia', 'LBR', 'LR', '+231'),
('Libya', 'LBY', 'LY', '+218'),
('Liechtenstein', 'LIE', 'LI', '+423'),
('Lithuania', 'LTU', 'LT', '+370'),
('Luxembourg', 'LUX', 'LU', '+352'),
('Macau', 'MAC', 'MO', '+853'),
('Macedonia', 'MKD', 'MK', '+389'),
('Madagascar', 'MDG', 'MG', '+261'),
('Malawi', 'MWI', 'MW', '+265'),
('Malaysia', 'MYS', 'MY', '+60'),
('Maldives', 'MDV', 'MV', '+960'),
('Mali', 'MLI', 'ML', '+223'),
('Malta', 'MLT', 'MT', '+356'),
('Marshall Islands', 'MHL', 'MH', '+692'),
('Martinique', 'MTQ', 'MQ', '+596'),
('Mauritania', 'MRT', 'MR', '+222'),
('Mauritius', 'MUS', 'MU', '+230'),
('Mayotte', 'MYT', 'YT', '+262'),
('Mexico', 'MEX', 'MX', '+52'),
('Micronesia', 'FSM', 'FM', '+691'),
('Moldova', 'MDA', 'MD', '+373'),
('Monaco', 'MCO', 'MC', '+377'),
('Mongolia', 'MNG', 'MN', '+976'),
('Montenegro', 'MNE', 'ME', '+382'),
('Montserrat', 'MSR', 'MS', '+1 664'),
('Morocco', 'MAR', 'MA', '+212'),
('Mozambique', 'MOZ', 'MZ', '+258'),
('Myanmar', 'MMR', 'MM', '+95'),
('Namibia', 'NAM', 'NA', '+264'),
('Nauru', 'NRU', 'NR', '+674'),
('Nepal', 'NPL', 'NP', '+977'),
('Netherlands', 'NLD', 'NL', '+31'),
('Netherlands Antilles', 'ANT', 'AN', '+599'),
('New Caledonia', 'NCL', 'NC', '+687'),
('New Zealand', 'NZL', 'NZ', '+64'),
('Nicaragua', 'NIC', 'NI', '+505'),
('Niger', 'NER', 'NE', '+227'),
('Nigeria', 'NGA', 'NG', '+234'),
('Niue', 'NIU', 'NU', '+683'),
('Norfolk Island', 'NFK', 'NF', '+6723'),
('North Korea', 'PRK', 'KP', '+850'),
('Northern Mariana Islands', 'MNP', 'MP', '+1 670'),
('Norway', 'NOR', 'NO', '+47'),
('Oman', 'OMN', 'OM', '+968'),
('Pakistan', 'PAK', 'PK', '+92'),
('Palau', 'PLW', 'PW', '+680'),
('Palestine', 'PSE', 'PS', '+970'),
('Panama', 'PAN', 'PA', '+507'),
('Papua New Guinea', 'PNG', 'PG', '+675'),
('Paraguay', 'PRY', 'PY', '+595'),
('Peru', 'PER', 'PE', '+51'),
('Philippines', 'PHL', 'PH', '+63'),
('Pitcairn Islands', 'PCN', 'PN', '+649'),
('Poland', 'POL', 'PL', '+48'),
('Portugal', 'PRT', 'PT', '+351'),
('Puerto Rico', 'PRI', 'PR', '+1 787'),
('Qatar', 'QAT', 'QA', '+974'),
('Republic of the Congo', 'COG', 'CG', '+242'),
('Reunion', 'REU', 'RE', '+262'),
('Romania', 'ROU', 'RO', '+40'),
('Russia', 'RUS', 'RU', '+7'),
('Rwanda', 'RWA', 'RW', '+250'),
('Saint Helena', 'SHN', 'SH', '+290'),
('Saint Kitts and Nevis', 'KNA', 'KN', '+1 869'),
('Saint Lucia', 'LCA', 'LC', '+1 758'),
('Saint Pierre and Miquelon', 'SPM', 'PM', '+508'),
('Saint Vincent and the Grenadines', 'VCT', 'VC', '+1 784'),
('Samoa', 'WSM', 'WS', '+685'),
('San Marino', 'SMR', 'SM', '+378'),
('Sao Tome and Principe', 'STP', 'ST', '+239'),
('Saudi Arabia', 'SAU', 'SA', '+966'),
('Senegal', 'SEN', 'SN', '+221'),
('Serbia', 'SRB', 'RS', '+381'),
('Seychelles', 'SYC', 'SC', '+248'),
('Sierra Leone', 'SLE', 'SL', '+232'),
('Singapore', 'SGP', 'SG', '+65'),
('Sint Maarten', 'SXM', 'SX', '+1 721'),
('Slovakia', 'SVK', 'SK', '+421'),
('Slovenia', 'SVN', 'SI', '+386'),
('Solomon Islands', 'SLB', 'SB', '+677'),
('Somalia', 'SOM', 'SO', '+252'),
('South Africa', 'ZAF', 'ZA', '+27'),
('South Georgia and the South Sandwich Islands', 'SGS', 'GS', '+44'),
('South Korea', 'KOR', 'KR', '+82'),
('South Sudan', 'SSD', 'SS', '+211'),
('Spain', 'ESP', 'ES', '+34'),
('Sri Lanka', 'LKA', 'LK', '+94'),
('Sudan', 'SDN', 'SD', '+249'),
('Suriname', 'SUR', 'SR', '+597'),
('Svalbard and Jan Mayen Islands', 'SJM', 'SJ', '+47'),
('Swaziland', 'SWZ', 'SZ', '+268'),
('Sweden', 'SWE', 'SE', '+46'),
('Switzerland', 'CHE', 'CH', '+41'),
('Syria', 'SYR', 'SY', '+963'),
('Taiwan', 'TWN', 'TW', '+886'),
('Tajikistan', 'TJK', 'TJ', '+992'),
('Tanzania', 'TZA', 'TZ', '+255'),
('Thailand', 'THA', 'TH', '+66'),
('Togo', 'TGO', 'TG', '+228'),
('Tokelau', 'TKL', 'TK', '+690'),
('Tonga', 'TON', 'TO', '+676'),
('Trinidad and Tobago', 'TTO', 'TT', '+1 868'),
('Tunisia', 'TUN', 'TN', '+216'),
('Turkey', 'TUR', 'TR', '+90'),
('Turkmenistan', 'TKM', 'TM', '+993'),
('Turks and Caicos Islands', 'TCA', 'TC', '+1 649'),
('Tuvalu', 'TUV', 'TV', '+688'),
('U.S. Virgin Islands', 'VIR', 'VI', '+1 340'),
('Uganda', 'UGA', 'UG', '+256'),
('Ukraine', 'UKR', 'UA', '+380'),
('United Arab Emirates', 'ARE', 'AE', '+971'),
('United Kingdom', 'GBR', 'GB', '+44'),
('United States', 'USA', 'US', '+1'),
('Uruguay', 'URY', 'UY', '+598'),
('Uzbekistan', 'UZB', 'UZ', '+998'),
('Vanuatu', 'VUT', 'VU', '+678'),
('Vatican City', 'VAT', 'VA', '+379'),
('Venezuela', 'VEN', 'VE', '+58'),
('Vietnam', 'VNM', 'VN', '+84'),
('Wallis and Futuna', 'WLF', 'WF', '+681'),
('Western Sahara', 'ESH', 'EH', '+212 28'),
('Yemen', 'YEM', 'YE', '+967'),
('Zambia', 'ZMB', 'ZM', '+260'),
('Zimbabwe', 'ZWE', 'ZW', '+263');

--
-- Dumping data for table `#__vikbooking_states`
--

-- Armenia

INSERT INTO `#__vikbooking_states`
(`id_country`,  `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(          12,  'Aragatsotn',           'AG',          'ARG',           1),
(          12,      'Ararat',           'AR',          'ARR',           1),
(          12,     'Armavir',           'AV',          'ARM',           1),
(          12, 'Gegharkunik',           'GR',          'GEG',           1),
(          12,      'Kotayk',           'KT',          'KOT',           1),
(          12,        'Lori',           'LO',          'LOR',           1),
(          12,      'Shirak',           'SH',          'SHI',           1),
(          12,      'Syunik',           'SU',          'SYU',           1),
(          12,      'Tavush',           'TV',          'TAV',           1),
(          12, 'Vayots-Dzor',           'VD',          'VAD',           1),
(          12,     'Yerevan',           'ER',          'YER',           1);

-- Argentina

INSERT INTO `#__vikbooking_states`
(`id_country`,                      `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(          11,                    'Buenos Aires',           'BA',          'BAS',           1),
(          11, 'Ciudad Autonoma De Buenos Aires',           'CB',          'CBA',           1),
(          11,                       'Catamarca',           'CA',          'CAT',           1),
(          11,                           'Chaco',           'CH',          'CHO',           1),
(          11,                          'Chubut',           'CT',          'CTT',           1),
(          11,                         'Cordoba',           'CO',          'COD',           1),
(          11,                      'Corrientes',           'CR',          'CRI',           1),
(          11,                      'Entre Rios',           'ER',          'ERS',           1),
(          11,                         'Formosa',           'FR',          'FRM',           1),
(          11,                           'Jujuy',           'JU',          'JUJ',           1),
(          11,                        'La Pampa',           'LP',          'LPM',           1),
(          11,                        'La Rioja',           'LR',          'LRI',           1),
(          11,                         'Mendoza',           'ME',          'MED',           1),
(          11,                        'Misiones',           'MI',          'MIS',           1),
(          11,                         'Neuquen',           'NQ',          'NQU',           1),
(          11,                       'Rio Negro',           'RN',          'RNG',           1),
(          11,                           'Salta',           'SA',          'SAL',           1),
(          11,                        'San Juan',           'SJ',          'SJN',           1),
(          11,                        'San Luis',           'SL',          'SLU',           1),
(          11,                      'Santa Cruz',           'SC',          'SCZ',           1),
(          11,                        'Santa Fe',           'SF',          'SFE',           1),
(          11,             'Santiago Del Estero',           'SE',          'SEN',           1),
(          11,                'Tierra Del Fuego',           'TF',          'TFE',           1),
(          11,                         'Tucuman',           'TU',          'TUC',           1);

-- Australia

INSERT INTO `#__vikbooking_states`
(`id_country`,                   `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(          15, 'Australian Capital Territory',           'AC',          'ACT',           1),
(          15,              'New South Wales',           'NS',          'NSW',           1),
(          15,           'Northern Territory',           'NT',          'NOT',           1),
(          15,                   'Queensland',           'QL',          'QLD',           1),
(          15,              'South Australia',           'SA',          'SOA',           1),
(          15,                     'Tasmania',           'TS',          'TAS',           1),
(          15,                     'Victoria',           'VI',          'VIC',           1),
(          15,            'Western Australia',           'WA',          'WEA',           1);

-- Brazil

INSERT INTO `#__vikbooking_states`
(`id_country`,          `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(          32,                'Acre',           'AC',          'ACR',           1),
(          32,             'Alagoas',           'AL',          'ALG',           1),
(          32,                'Amap',           'AP',          'AMP',           1),
(          32,            'Amazonas',           'AM',          'AMZ',           1),
(          32,                 'Bah',           'BA',          'BAH',           1),
(          32,                'Cear',           'CE',          'CEA',           1),
(          32,    'Distrito Federal',           'DF',          'DFB',           1),
(          32,      'Espirito Santo',           'ES',          'ESS',           1),
(          32,                 'Goi',           'GO',          'GOI',           1),
(          32,              'Maranh',           'MA',          'MAR',           1),
(          32,         'Mato Grosso',           'MT',          'MAT',           1),
(          32,  'Mato Grosso do Sul',           'MS',          'MGS',           1),
(          32,          'Minas Gera',           'MG',          'MIG',           1),
(          32,               'Paran',           'PR',          'PAR',           1),
(          32,                'Para',           'PB',          'PRB',           1),
(          32,                 'Par',           'PA',          'PAB',           1),
(          32,          'Pernambuco',           'PE',          'PER',           1),
(          32,                'Piau',           'PI',          'PIA',           1),
(          32, 'Rio Grande do Norte',           'RN',          'RGN',           1),
(          32,   'Rio Grande do Sul',           'RS',          'RGS',           1),
(          32,      'Rio de Janeiro',           'RJ',          'RDJ',           1),
(          32,                'Rond',           'RO',          'RON',           1),
(          32,             'Roraima',           'RR',          'ROR',           1),
(          32,      'Santa Catarina',           'SC',          'SAC',           1),
(          32,             'Sergipe',           'SE',          'SER',           1),
(          32,                   'S',           'SP',          'SAP',           1),
(          32,           'Tocantins',           'TO',          'TOC',           1);

-- Canada

INSERT INTO `#__vikbooking_states`
(`id_country`,                `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(          41,                   'Alberta',           'AB',          'ALB',           1),
(          41,          'British Columbia',           'BC',          'BRC',           1),
(          41,                  'Manitoba',           'MB',          'MAB',           1),
(          41,             'New Brunswick',           'NB',          'NEB',           1),
(          41, 'Newfoundland and Labrador',           'NL',          'NFL',           1),
(          41,     'Northwest Territories',           'NT',          'NWT',           1),
(          41,               'Nova Scotia',           'NS',          'NOS',           1),
(          41,                   'Nunavut',           'NU',          'NUT',           1),
(          41,                   'Ontario',           'ON',          'ONT',           1),
(          41,      'Prince Edward Island',           'PE',          'PEI',           1),
(          41,                    'Quebec',           'QC',          'QEC',           1),
(          41,              'Saskatchewan',           'SK',          'SAK',           1),
(          41,                     'Yukon',           'YT',          'YUT',           1);

-- China

INSERT INTO `#__vikbooking_states`
(`id_country`,     `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(          47,          'Anhui',           '34',          'ANH',           1),
(          47,        'Beijing',           '11',          'BEI',           1),
(          47,      'Chongqing',           '50',          'CHO',           1),
(          47,         'Fujian',           '35',          'FUJ',           1),
(          47,          'Gansu',           '62',          'GAN',           1),
(          47,      'Guangdong',           '44',          'GUA',           1),
(          47, 'Guangxi Zhuang',           '45',          'GUZ',           1),
(          47,        'Guizhou',           '52',          'GUI',           1),
(          47,         'Hainan',           '46',          'HAI',           1),
(          47,          'Hebei',           '13',          'HEB',           1),
(          47,   'Heilongjiang',           '23',          'HEI',           1),
(          47,          'Henan',           '41',          'HEN',           1),
(          47,          'Hubei',           '42',          'HUB',           1),
(          47,          'Hunan',           '43',          'HUN',           1),
(          47,        'Jiangsu',           '32',          'JIA',           1),
(          47,        'Jiangxi',           '36',          'JIX',           1),
(          47,          'Jilin',           '22',          'JIL',           1),
(          47,       'Liaoning',           '21',          'LIA',           1),
(          47,     'Nei Mongol',           '15',          'NML',           1),
(          47,    'Ningxia Hui',           '64',          'NIH',           1),
(          47,        'Qinghai',           '63',          'QIN',           1),
(          47,       'Shandong',           '37',          'SNG',           1),
(          47,       'Shanghai',           '31',          'SHH',           1),
(          47,        'Shaanxi',           '61',          'SHX',           1),
(          47,        'Sichuan',           '51',          'SIC',           1),
(          47,        'Tianjin',           '12',          'TIA',           1),
(          47, 'Xinjiang Uygur',           '65',          'XIU',           1),
(          47,         'Xizang',           '54',          'XIZ',           1),
(          47,         'Yunnan',           '53',          'YUN',           1),
(          47,       'Zhejiang',           '33',          'ZHE',           1);

-- Greece

INSERT INTO `#__vikbooking_states`
(`id_country`, `state_2_code`, `state_3_code`, `published`,       `state_name`) VALUES
(          86,           'ΛΕ',          'ΛΕΥ',           1,         'ΛΕΥΚΑΔΑΣ'),
(          86,           'ΛΡ',          'ΛΑΡ',           1,          'ΛΑΡΙΣΑΣ'),
(          86,           'ΑΚ',          'ΑΡΚ',           1,         'ΑΡΚΑΔΙΑΣ'),
(          86,           'ΑΡ',          'ΑΡΓ',           1,        'ΑΡΓΟΛΙΔΑΣ'),
(          86,           'ΛΑ',          'ΛΑΣ',           1,         'ΛΑΣΙΘΙΟΥ'),
(          86,           'ΛΣ',          'ΛΕΣ',           1,           'ΛΕΣΒΟΥ'),
(          86,           'ΚΥ',          'ΚΥΚ',           1,         'ΚΥΚΛΑΔΩΝ'),
(          86,           'ΑΙ',          'ΑΙΤ',           1, 'ΑΙΤΩΛΟΑΚΑΡΝΑΝΙΑΣ'),
(          86,           'ΚΟ',          'ΚΟΡ',           1,        'ΚΟΡΙΝΘΙΑΣ'),
(          86,           'ΛK',          'ΛΑΚ',           1,         'ΛΑΚΩΝΙΑΣ'),
(          86,           'ΗΜ',          'ΗΜΑ',           1,          'ΗΜΑΘΙΑΣ'),
(          86,           'ΗΡ',          'ΗΡΑ',           1,        'ΗΡΑΚΛΕΙΟΥ'),
(          86,           'ΘΠ',          'ΘΕΠ',           1,       'ΘΕΣΠΡΩΤΙΑΣ'),
(          86,           'ΘΕ',          'ΘΕΣ',           1,     'ΘΕΣΣΑΛΟΝΙΚΗΣ'),
(          86,           'ΙΩ',          'ΙΩΑ',          1,        'ΙΩΑΝΝΙΝΩΝ'),
(          86,           'ΚΒ',          'ΚΑΒ',           1,          'ΚΑΒΑΛΑΣ'),
(          86,           'ΚΡ',          'ΚΑΡ',           1,        'ΚΑΡΔΙΤΣΑΣ'),
(          86,           'ΚΣ',          'ΚΑΣ',           1,        'ΚΑΣΤΟΡΙΑΣ'),
(          86,           'ΚΕ',          'ΚΕΡ',           1,         'ΚΕΡΚΥΡΑΣ'),
(          86,           'ΚΦ',          'ΚΕΦ',           1,      'ΚΕΦΑΛΛΗΝΙΑΣ'),
(          86,           'ΚΙ',          'ΚΙΛ',           1,           'ΚΙΛΚΙΣ'),
(          86,           'ΚZ',          'ΚΟΖ',           1,          'ΚΟΖΑΝΗΣ'),
(          86,           'ΑΧ',          'ΑΧΑ',           1,           'ΑΧΑΪΑΣ'),
(          86,           'ΒΟ',          'ΒΟΙ',           1,         'ΒΟΙΩΤΙΑΣ'),
(          86,           'ΓΡ',          'ΓΡΕ',           1,         'ΓΡΕΒΕΝΩΝ'),
(          86,           'ΔΡ',          'ΔΡΑ',           1,           'ΔΡΑΜΑΣ'),
(          86,           'ΔΩ',          'ΔΩΔ',          1,      'ΔΩΔΕΚΑΝΗΣΟΥ'),
(          86,           'ΕΒ',          'ΕΒΡ',           1,            'ΕΒΡΟΥ'),
(          86,           'ΕΥ',          'ΕΥΒ',           1,          'ΕΥΒΟΙΑΣ'),
(          86,           'ΕΡ',          'ΕΥΡ',           1,       'ΕΥΡΥΤΑΝΙΑΣ'),
(          86,           'ΖΑ',          'ΖΑΚ',           1,         'ΖΑΚΥΝΘΟΥ'),
(          86,           'ΗΛ',          'ΗΛΕ',           1,           'ΗΛΕΙΑΣ'),
(          86,           'ΑΑ',          'ΑΡΤ',           1,            'ΑΡΤΑΣ'),
(          86,           'ΑΤ',          'ΑΤΤ',           1,          'ΑΤΤΙΚΗΣ'),
(          86,           'ΜΑ',          'ΜΑΓ',           1,        'ΜΑΓΝΗΣΙΑΣ'),
(          86,           'ΜΕ',          'ΜΕΣ',           1,        'ΜΕΣΣΗΝΙΑΣ'),
(          86,           'ΞΑ',          'ΞΑΝ',           1,           'ΞΑΝΘΗΣ'),
(          86,           'ΠΕ',          'ΠΕΛ',           1,           'ΠΕΛΛΗΣ'),
(          86,           'ΠΙ',          'ΠΙΕ',           1,          'ΠΙΕΡΙΑΣ'),
(          86,           'ΠΡ',          'ΠΡΕ',           1,         'ΠΡΕΒΕΖΑΣ'),
(          86,           'ΡΕ',          'ΡΕΘ',           1,         'ΡΕΘΥΜΝΗΣ'),
(          86,           'ΡΟ',          'ΡΟΔ',           1,          'ΡΟΔΟΠΗΣ'),
(          86,           'ΣΑ',          'ΣΑΜ',           1,            'ΣΑΜΟΥ'),
(          86,           'ΣΕ',          'ΣΕΡ',           1,           'ΣΕΡΡΩΝ'),
(          86,           'ΤΡ',          'ΤΡΙ',           1,         'ΤΡΙΚΑΛΩΝ'),
(          86,           'ΦΘ',          'ΦΘΙ',           1,        'ΦΘΙΩΤΙΔΑΣ'),
(          86,           'ΦΛ',          'ΦΛΩ',           1,        'ΦΛΩΡΙΝΑΣ'),
(          86,           'ΦΩ',         'ΦΩΚ',           1,          'ΦΩΚΙΔΑΣ'),
(          86,           'ΧΑ',          'ΧΑΛ',           1,       'ΧΑΛΚΙΔΙΚΗΣ'),
(          86,           'ΧΝ',          'ΧΑΝ',           1,          'ΧΑΝΙΩΝ'),
(          86,           'ΧΙ',          'ΧΙΟ',           1,             'ΧΙΟΥ');

-- India

INSERT INTO `#__vikbooking_states`
(`id_country`,                `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         102, 'Andaman & Nicobar Islands',           'AI',          'ANI',           1),
(         102,            'Andhra Pradesh',           'AN',          'AND',           1),
(         102,         'Arunachal Pradesh',           'AR',          'ARU',           1),
(         102,                     'Assam',           'AS',          'ASS',           1),
(         102,                     'Bihar',           'BI',          'BIH',           1),
(         102,                'Chandigarh',           'CA',          'CHA',           1),
(         102,               'Chhatisgarh',           'CH',          'CHH',           1),
(         102,      'Dadra & Nagar Haveli',           'DD',          'DAD',           1),
(         102,               'Daman & Diu',           'DA',          'DAM',           1),
(         102,                     'Delhi',           'DE',          'DEL',           1),
(         102,                       'Goa',           'GO',          'GOA',           1),
(         102,                   'Gujarat',           'GU',          'GUJ',           1),
(         102,                   'Haryana',           'HA',          'HAR',           1),
(         102,          'Himachal Pradesh',           'HI',          'HIM',           1),
(         102,           'Jammu & Kashmir',           'JA',          'JAM',           1),
(         102,                 'Jharkhand',           'JH',          'JHA',           1),
(         102,                 'Karnataka',           'KA',          'KAR',           1),
(         102,                    'Kerala',           'KE',          'KER',           1),
(         102,               'Lakshadweep',           'LA',          'LAK',           1),
(         102,            'Madhya Pradesh',           'MD',          'MAD',           1),
(         102,               'Maharashtra',           'MH',          'MAH',           1),
(         102,                   'Manipur',           'MN',          'MAN',           1),
(         102,                 'Meghalaya',           'ME',          'MEG',           1),
(         102,                   'Mizoram',           'MI',          'MIZ',           1),
(         102,                  'Nagaland',           'NA',          'NAG',           1),
(         102,                    'Orissa',           'OR',          'ORI',           1),
(         102,               'Pondicherry',           'PO',          'PON',           1),
(         102,                    'Punjab',           'PU',          'PUN',           1),
(         102,                 'Rajasthan',           'RA',          'RAJ',           1),
(         102,                    'Sikkim',           'SI',          'SIK',           1),
(         102,                'Tamil Nadu',           'TA',          'TAM',           1),
(         102,                   'Tripura',           'TR',          'TRI',           1),
(         102,               'Uttaranchal',           'UA',          'UAR',           1),
(         102,             'Uttar Pradesh',           'UT',          'UTT',           1),
(         102,               'West Bengal',           'WE',          'WES',           1);

-- Iran

INSERT INTO `#__vikbooking_states`
(`id_country`,               `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         104,     'Ahmadi va Kohkiluyeh',           'BO',          'BOK',           1),
(         104,                  'Ardabil',           'AR',          'ARD',           1),
(         104,      'Azarbayjan-e Gharbi',           'AG',          'AZG',           1),
(         104,      'Azarbayjan-e Sharqi',           'AS',          'AZS',           1),
(         104,                  'Bushehr',           'BU',          'BUS',           1),
(         104, 'Chaharmahal va Bakhtiari',           'CM',          'CMB',           1),
(         104,                  'Esfahan',           'ES',          'ESF',           1),
(         104,                     'Fars',           'FA',          'FAR',           1),
(         104,                    'Gilan',           'GI',          'GIL',           1),
(         104,                   'Gorgan',           'GO',          'GOR',           1),
(         104,                  'Hamadan',           'HA',          'HAM',           1),
(         104,                'Hormozgan',           'HO',          'HOR',           1),
(         104,                     'Ilam',           'IL',          'ILA',           1),
(         104,                   'Kerman',           'KE',          'KER',           1),
(         104,               'Kermanshah',           'BA',          'BAK',           1),
(         104,       'Khorasan-e Junoubi',           'KJ',          'KHJ',           1),
(         104,        'Khorasan-e Razavi',           'KR',          'KHR',           1),
(         104,       'Khorasan-e Shomali',           'KS',          'KHS',           1),
(         104,                'Khuzestan',           'KH',          'KHU',           1),
(         104,                'Kordestan',           'KO',          'KOR',           1),
(         104,                 'Lorestan',           'LO',          'LOR',           1),
(         104,                  'Markazi',           'MR',          'MAR',           1),
(         104,               'Mazandaran',           'MZ',          'MAZ',           1),
(         104,                   'Qazvin',           'QA',          'QAS',           1),
(         104,                      'Qom',           'QO',          'QOM',           1),
(         104,                   'Semnan',           'SE',          'SEM',           1),
(         104,    'Sistan va Baluchestan',           'SB',          'SBA',           1),
(         104,                   'Tehran',           'TE',          'TEH',           1),
(         104,                     'Yazd',           'YA',          'YAZ',           1),
(         104,                   'Zanjan',           'ZA',          'ZAN',           1);

-- Israel

INSERT INTO `#__vikbooking_states`
(`id_country`, `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         108,     'Israel',           'IL',          'ISL',           1),
(         108, 'Gaza Strip',           'GZ',          'GZS',           1),
(         108,  'West Bank',           'WB',          'WBK',           1);

-- Italy

INSERT INTO `#__vikbooking_states`
(`id_country`,           `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         109,            'Agrigento',           'AG',          'AGR',           1),
(         109,          'Alessandria',           'AL',          'ALE',           1),
(         109,               'Ancona',           'AN',          'ANC',           1),
(         109,                'Aosta',           'AO',          'AOS',           1),
(         109,               'Arezzo',           'AR',          'ARE',           1),
(         109,        'Ascoli Piceno',           'AP',          'API',           1),
(         109,                 'Asti',           'AT',          'AST',           1),
(         109,             'Avellino',           'AV',          'AVE',           1),
(         109,                 'Bari',           'BA',          'BAR',           1),
(         109,              'Belluno',           'BL',          'BEL',           1),
(         109,            'Benevento',           'BN',          'BEN',           1),
(         109,              'Bergamo',           'BG',          'BEG',           1),
(         109,               'Biella',           'BI',          'BIE',           1),
(         109,              'Bologna',           'BO',          'BOL',           1),
(         109,              'Bolzano',           'BZ',          'BOZ',           1),
(         109,              'Brescia',           'BS',          'BRE',           1),
(         109,             'Brindisi',           'BR',          'BRI',           1),
(         109,             'Cagliari',           'CA',          'CAG',           1),
(         109,        'Caltanissetta',           'CL',          'CAL',           1),
(         109,           'Campobasso',           'CB',          'CBO',           1),
(         109,    'Carbonia-Iglesias',           'CI',          'CAR',           1),
(         109,              'Caserta',           'CE',          'CAS',           1),
(         109,              'Catania',           'CT',          'CAT',           1),
(         109,            'Catanzaro',           'CZ',          'CTZ',           1),
(         109,               'Chieti',           'CH',          'CHI',           1),
(         109,                 'Como',           'CO',          'COM',           1),
(         109,              'Cosenza',           'CS',          'COS',           1),
(         109,              'Cremona',           'CR',          'CRE',           1),
(         109,              'Crotone',           'KR',          'CRO',           1),
(         109,                'Cuneo',           'CN',          'CUN',           1),
(         109,                 'Enna',           'EN',          'ENN',           1),
(         109,              'Ferrara',           'FE',          'FER',           1),
(         109,              'Firenze',           'FI',          'FIR',           1),
(         109,               'Foggia',           'FG',          'FOG',           1),
(         109,         'Forli-Cesena',           'FC',          'FOC',           1),
(         109,            'Frosinone',           'FR',          'FRO',           1),
(         109,               'Genova',           'GE',          'GEN',           1),
(         109,              'Gorizia',           'GO',          'GOR',           1),
(         109,             'Grosseto',           'GR',          'GRO',           1),
(         109,              'Imperia',           'IM',          'IMP',           1),
(         109,              'Isernia',           'IS',          'ISE',           1),
(         109,            'L\'Aquila',           'AQ',          'AQU',           1),
(         109,            'La Spezia',           'SP',          'LAS',           1),
(         109,               'Latina',           'LT',          'LAT',           1),
(         109,                'Lecce',           'LE',          'LEC',           1),
(         109,                'Lecco',           'LC',          'LCC',           1),
(         109,              'Livorno',           'LI',          'LIV',           1),
(         109,                 'Lodi',           'LO',          'LOD',           1),
(         109,                'Lucca',           'LU',          'LUC',           1),
(         109,             'Macerata',           'MC',          'MAC',           1),
(         109,              'Mantova',           'MN',          'MAN',           1),
(         109,        'Massa-Carrara',           'MS',          'MAS',           1),
(         109,               'Matera',           'MT',          'MAA',           1),
(         109,      'Medio Campidano',           'VS',          'MED',           1),
(         109,              'Messina',           'ME',          'MES',           1),
(         109,               'Milano',           'MI',          'MIL',           1),
(         109,               'Modena',           'MO',          'MOD',           1),
(         109,               'Napoli',           'NA',          'NAP',           1),
(         109,               'Novara',           'NO',          'NOV',           1),
(         109,                'Nuoro',           'NU',          'NUR',           1),
(         109,            'Ogliastra',           'OG',          'OGL',           1),
(         109,         'Olbia-Tempio',           'OT',          'OLB',           1),
(         109,             'Oristano',           'OR',          'ORI',           1),
(         109,               'Padova',           'PD',          'PDA',           1),
(         109,              'Palermo',           'PA',          'PAL',           1),
(         109,                'Parma',           'PR',          'PAA',           1),
(         109,                'Pavia',           'PV',          'PAV',           1),
(         109,              'Perugia',           'PG',          'PER',           1),
(         109,      'Pesaro e Urbino',           'PU',          'PES',           1),
(         109,              'Pescara',           'PE',          'PSC',           1),
(         109,             'Piacenza',           'PC',          'PIA',           1),
(         109,                 'Pisa',           'PI',          'PIS',           1),
(         109,              'Pistoia',           'PT',          'PIT',           1),
(         109,            'Pordenone',           'PN',          'POR',           1),
(         109,              'Potenza',           'PZ',          'PTZ',           1),
(         109,                'Prato',           'PO',          'PRA',           1),
(         109,               'Ragusa',           'RG',          'RAG',           1),
(         109,              'Ravenna',           'RA',          'RAV',           1),
(         109,      'Reggio Calabria',           'RC',          'REG',           1),
(         109,        'Reggio Emilia',           'RE',          'REE',           1),
(         109,                'Rieti',           'RI',          'RIE',           1),
(         109,               'Rimini',           'RN',          'RIM',           1),
(         109,                 'Roma',           'RM',          'ROM',           1),
(         109,               'Rovigo',           'RO',          'ROV',           1),
(         109,              'Salerno',           'SA',          'SAL',           1),
(         109,              'Sassari',           'SS',          'SAS',           1),
(         109,               'Savona',           'SV',          'SAV',           1),
(         109,                'Siena',           'SI',          'SIE',           1),
(         109,             'Siracusa',           'SR',          'SIR',           1),
(         109,              'Sondrio',           'SO',          'SOO',           1),
(         109,              'Taranto',           'TA',          'TAR',           1),
(         109,               'Teramo',           'TE',          'TER',           1),
(         109,                'Terni',           'TR',          'TRN',           1),
(         109,               'Torino',           'TO',          'TOR',           1),
(         109,              'Trapani',           'TP',          'TRA',           1),
(         109,               'Trento',           'TN',          'TRE',           1),
(         109,              'Treviso',           'TV',          'TRV',           1),
(         109,              'Trieste',           'TS',          'TRI',           1),
(         109,                'Udine',           'UD',          'UDI',           1),
(         109,               'Varese',           'VA',          'VAR',           1),
(         109,              'Venezia',           'VE',          'VEN',           1),
(         109, 'Verbano Cusio Ossola',           'VB',          'VCO',           1),
(         109,             'Vercelli',           'VC',          'VER',           1),
(         109,               'Verona',           'VR',          'VRN',           1),
(         109,        'Vibo Valenzia',           'VV',          'VIV',           1),
(         109,              'Vicenza',           'VI',          'VII',           1),
(         109,              'Viterbo',           'VT',          'VIT',           1);

-- Mexico

INSERT INTO `#__vikbooking_states`
(`id_country`,            `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         142,        'Aguascalientes',           'AG',          'AGS',           1),
(         142, 'Baja California Norte',           'BN',          'BCN',           1),
(         142,   'Baja California Sur',           'BS',          'BCS',           1),
(         142,              'Campeche',           'CA',          'CAM',           1),
(         142,               'Chiapas',           'CS',          'CHI',           1),
(         142,             'Chihuahua',           'CH',          'CHA',           1),
(         142,              'Coahuila',           'CO',          'COA',           1),
(         142,                'Colima',           'CM',          'COL',           1),
(         142,      'Distrito Federal',           'DF',          'DFM',           1),
(         142,               'Durango',           'DO',          'DGO',           1),
(         142,            'Guanajuato',           'GO',          'GTO',           1),
(         142,              'Guerrero',           'GU',          'GRO',           1),
(         142,               'Hidalgo',           'HI',          'HGO',           1),
(         142,               'Jalisco',           'JA',          'JAL',           1),
(         142,                     'M',           'EM',          'EDM',           1),
(         142,               'Michoac',           'MI',          'MCN',           1),
(         142,               'Morelos',           'MO',          'MOR',           1),
(         142,               'Nayarit',           'NY',          'NAY',           1),
(         142,              'Nuevo Le',           'NL',          'NUL',           1),
(         142,                'Oaxaca',           'OA',          'OAX',           1),
(         142,                'Puebla',           'PU',          'PUE',           1),
(         142,                  'Quer',           'QU',          'QRO',           1),
(         142,          'Quintana Roo',           'QR',          'QUR',           1),
(         142,        'San Luis Potos',           'SP',          'SLP',           1),
(         142,               'Sinaloa',           'SI',          'SIN',           1),
(         142,                'Sonora',           'SO',          'SON',           1),
(         142,               'Tabasco',           'TA',          'TAB',           1),
(         142,            'Tamaulipas',           'TM',          'TAM',           1),
(         142,              'Tlaxcala',           'TX',          'TLX',           1),
(         142,              'Veracruz',           'VZ',          'VER',           1),
(         142,                 'Yucat',           'YU',          'YUC',           1),
(         142,             'Zacatecas',           'ZA',          'ZAC',           1);

-- Netherlands Antilles

INSERT INTO `#__vikbooking_states`
(`id_country`,  `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         156, 'St. Maarten',           'SM',          'STM',           1),
(         156,     'Bonaire',           'BN',          'BNR',           1),
(         156,     'Curacao',           'CR',          'CUR',           1);

-- Romania

INSERT INTO `#__vikbooking_states`
(`id_country`,      `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         183,            'Alba',           'AB',          'ABA',           1),
(         183,            'Arad',           'AR',          'ARD',           1),
(         183,           'Arges',           'AG',          'ARG',           1),
(         183,           'Bacau',           'BC',          'BAC',           1),
(         183,           'Bihor',           'BH',          'BIH',           1),
(         183, 'Bistrita-Nasaud',           'BN',          'BIS',           1),
(         183,        'Botosani',           'BT',          'BOT',           1),
(         183,          'Braila',           'BR',          'BRL',           1),
(         183,          'Brasov',           'BV',          'BRA',           1),
(         183,       'Bucuresti',            'B',          'BUC',           1),
(         183,           'Buzau',           'BZ',          'BUZ',           1),
(         183,        'Calarasi',           'CL',          'CAL',           1),
(         183,   'Caras Severin',           'CS',          'CRS',           1),
(         183,            'Cluj',           'CJ',          'CLJ',           1),
(         183,       'Constanta',           'CT',          'CST',           1),
(         183,         'Covasna',           'CV',          'COV',           1),
(         183,       'Dambovita',           'DB',          'DAM',           1),
(         183,            'Dolj',           'DJ',          'DLJ',           1),
(         183,          'Galati',           'GL',          'GAL',           1),
(         183,         'Giurgiu',           'GR',          'GIU',           1),
(         183,            'Gorj',           'GJ',          'GOR',           1),
(         183,         'Hargita',           'HR',          'HRG',           1),
(         183,       'Hunedoara',           'HD',          'HUN',           1),
(         183,        'Ialomita',           'IL',          'IAL',           1),
(         183,            'Iasi',           'IS',          'IAS',           1),
(         183,           'Ilfov',           'IF',          'ILF',           1),
(         183,       'Maramures',           'MM',          'MAR',           1),
(         183,       'Mehedinti',           'MH',          'MEH',           1),
(         183,           'Mures',           'MS',          'MUR',           1),
(         183,           'Neamt',           'NT',          'NEM',           1),
(         183,             'Olt',           'OT',          'OLT',           1),
(         183,         'Prahova',           'PH',          'PRA',           1),
(         183,           'Salaj',           'SJ',          'SAL',           1),
(         183,       'Satu Mare',           'SM',          'SAT',           1),
(         183,           'Sibiu',           'SB',          'SIB',           1),
(         183,         'Suceava',           'SV',          'SUC',           1),
(         183,       'Teleorman',           'TR',          'TEL',           1),
(         183,           'Timis',           'TM',          'TIM',           1),
(         183,          'Tulcea',           'TL',          'TUL',           1),
(         183,          'Valcea',           'VL',          'VAL',           1),
(         183,          'Vaslui',           'VS',          'VAS',           1),
(         183,         'Vrancea',           'VN',          'VRA',           1);

-- Spain

INSERT INTO `#__vikbooking_states`
(`id_country`,             `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         209,                 'A Coru',           '15',          'ACO',           1),
(         209,                  'Alava',           '01',          'ALA',           1),
(         209,               'Albacete',           '02',          'ALB',           1),
(         209,               'Alicante',           '03',          'ALI',           1),
(         209,                'Almeria',           '04',          'ALM',           1),
(         209,               'Asturias',           '33',          'AST',           1),
(         209,                  'Avila',           '05',          'AVI',           1),
(         209,                'Badajoz',           '06',          'BAD',           1),
(         209,               'Baleares',           '07',          'BAL',           1),
(         209,              'Barcelona',           '08',          'BAR',           1),
(         209,                 'Burgos',           '09',          'BUR',           1),
(         209,                'Caceres',           '10',          'CAC',           1),
(         209,                  'Cadiz',           '11',          'CAD',           1),
(         209,              'Cantabria',           '39',          'CAN',           1),
(         209,              'Castellon',           '12',          'CAS',           1),
(         209,                  'Ceuta',           '51',          'CEU',           1),
(         209,            'Ciudad Real',           '13',          'CIU',           1),
(         209,                'Cordoba',           '14',          'COR',           1),
(         209,                 'Cuenca',           '16',          'CUE',           1),
(         209,                 'Girona',           '17',          'GIR',           1),
(         209,                'Granada',           '18',          'GRA',           1),
(         209,            'Guadalajara',           '19',          'GUA',           1),
(         209,              'Guipuzcoa',           '20',          'GUI',           1),
(         209,                 'Huelva',           '21',          'HUL',           1),
(         209,                 'Huesca',           '22',          'HUS',           1),
(         209,                   'Jaen',           '23',          'JAE',           1),
(         209,               'La Rioja',           '26',          'LRI',           1),
(         209,             'Las Palmas',           '35',          'LPA',           1),
(         209,                   'Leon',           '24',          'LEO',           1),
(         209,                 'Lleida',           '25',          'LLE',           1),
(         209,                   'Lugo',           '27',          'LUG',           1),
(         209,                 'Madrid',           '28',          'MAD',           1),
(         209,                 'Malaga',           '29',          'MAL',           1),
(         209,                'Melilla',           '52',          'MEL',           1),
(         209,                 'Murcia',           '30',          'MUR',           1),
(         209,                'Navarra',           '31',          'NAV',           1),
(         209,                'Ourense',           '32',          'OUR',           1),
(         209,               'Palencia',           '34',          'PAL',           1),
(         209,             'Pontevedra',           '36',          'PON',           1),
(         209,              'Salamanca',           '37',          'SAL',           1),
(         209, 'Santa Cruz de Tenerife',           '38',          'SCT',           1),
(         209,                'Segovia',           '40',          'SEG',           1),
(         209,                'Sevilla',           '41',          'SEV',           1),
(         209,                  'Soria',           '42',          'SOR',           1),
(         209,              'Tarragona',           '43',          'TAR',           1),
(         209,                 'Teruel',           '44',          'TER',           1),
(         209,                 'Toledo',           '45',          'TOL',           1),
(         209,               'Valencia',           '46',          'VAL',           1),
(         209,             'Valladolid',           '47',          'VLL',           1),
(         209,                'Vizcaya',           '48',          'VIZ',           1),
(         209,                 'Zamora',           '49',          'ZAM',           1),
(         209,               'Zaragoza',           '50',          'ZAR',           1);

-- United Kingdom

INSERT INTO `#__vikbooking_states`
(`id_country`,       `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         235,          'England',           'EN',          'ENG',           1),
(         235, 'Northern Ireland',           'NI',          'NOI',           1),
(         235,         'Scotland',           'SD',          'SCO',           1),
(         235,            'Wales',           'WS',          'WLS',           1);

-- United States

INSERT INTO `#__vikbooking_states`
(`id_country`,           `state_name`, `state_2_code`, `state_3_code`, `published`) VALUES
(         236,              'Alabama',           'AL',          'ALA',           1),
(         236,               'Alaska',           'AK',          'ALK',           1),
(         236,              'Arizona',           'AZ',          'ARZ',           1),
(         236,             'Arkansas',           'AR',          'ARK',           1),
(         236,           'California',           'CA',          'CAL',           1),
(         236,             'Colorado',           'CO',          'COL',           1),
(         236,          'Connecticut',           'CT',          'CCT',           1),
(         236,             'Delaware',           'DE',          'DEL',           1),
(         236, 'District Of Columbia',           'DC',          'DOC',           1),
(         236,              'Florida',           'FL',          'FLO',           1),
(         236,              'Georgia',           'GA',          'GEA',           1),
(         236,               'Hawaii',           'HI',          'HWI',           1),
(         236,                'Idaho',           'ID',          'IDA',           1),
(         236,             'Illinois',           'IL',          'ILL',           1),
(         236,              'Indiana',           'IN',          'IND',           1),
(         236,                 'Iowa',           'IA',          'IOA',           1),
(         236,               'Kansas',           'KS',          'KAS',           1),
(         236,             'Kentucky',           'KY',          'KTY',           1),
(         236,            'Louisiana',           'LA',          'LOA',           1),
(         236,                'Maine',           'ME',          'MAI',           1),
(         236,             'Maryland',           'MD',          'MLD',           1),
(         236,        'Massachusetts',           'MA',          'MSA',           1),
(         236,             'Michigan',           'MI',          'MIC',           1),
(         236,            'Minnesota',           'MN',          'MIN',           1),
(         236,          'Mississippi',           'MS',          'MIS',           1),
(         236,             'Missouri',           'MO',          'MIO',           1),
(         236,              'Montana',           'MT',          'MOT',           1),
(         236,             'Nebraska',           'NE',          'NEB',           1),
(         236,               'Nevada',           'NV',          'NEV',           1),
(         236,        'New Hampshire',           'NH',          'NEH',           1),
(         236,           'New Jersey',           'NJ',          'NEJ',           1),
(         236,           'New Mexico',           'NM',          'NEM',           1),
(         236,             'New York',           'NY',          'NEY',           1),
(         236,       'North Carolina',           'NC',          'NOC',           1),
(         236,         'North Dakota',           'ND',          'NOD',           1),
(         236,                 'Ohio',           'OH',          'OHI',           1),
(         236,             'Oklahoma',           'OK',          'OKL',           1),
(         236,               'Oregon',           'OR',          'ORN',           1),
(         236,         'Pennsylvania',           'PA',          'PEA',           1),
(         236,         'Rhode Island',           'RI',          'RHI',           1),
(         236,       'South Carolina',           'SC',          'SOC',           1),
(         236,         'South Dakota',           'SD',          'SOD',           1),
(         236,            'Tennessee',           'TN',          'TEN',           1),
(         236,                'Texas',           'TX',          'TXS',           1),
(         236,                 'Utah',           'UT',          'UTA',           1),
(         236,              'Vermont',           'VT',          'VMT',           1),
(         236,             'Virginia',           'VA',          'VIA',           1),
(         236,           'Washington',           'WA',          'WAS',           1),
(         236,        'West Virginia',           'WV',          'WEV',           1),
(         236,            'Wisconsin',           'WI',          'WIS',           1),
(         236,              'Wyoming',           'WY',          'WYO',           1);