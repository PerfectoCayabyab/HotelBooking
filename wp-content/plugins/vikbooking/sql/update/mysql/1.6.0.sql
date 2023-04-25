ALTER TABLE `#__vikbooking_gpayments` CHANGE `params` `params` varchar(1024) DEFAULT NULL;

ALTER TABLE `#__vikbooking_orders` ADD COLUMN `split_stay` tinyint(1) NOT NULL DEFAULT 0;
ALTER TABLE `#__vikbooking_orders` ADD COLUMN `canc_fee` decimal(12,2) DEFAULT NULL;

ALTER TABLE `#__vikbooking_orders` CHANGE `inv_notes` `inv_notes` VARCHAR(1024) DEFAULT NULL;

ALTER TABLE `#__vikbooking_ordersrooms` CHANGE `extracosts` `extracosts` text DEFAULT NULL;

ALTER TABLE `#__vikbooking_customers` ADD COLUMN `state` varchar(64) DEFAULT NULL AFTER `zip`;

ALTER TABLE `#__vikbooking_gpayments` ADD COLUMN `idrooms` varchar(1024) DEFAULT NULL;

ALTER TABLE `#__vikbooking_coupons` ADD COLUMN `maxtotord` decimal(12,2) DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `#__vikbooking_customers_coupons` (
  `idcustomer` int(10) NOT NULL,
  `idcoupon` int(10) NOT NULL,
  `automatic` tinyint(1) NOT NULL DEFAULT 0,
  UNIQUE KEY `idx_customer_coupon` (`idcustomer`,`idcoupon`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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