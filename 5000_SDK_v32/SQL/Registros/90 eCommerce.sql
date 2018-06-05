SET DATEFIRST 7
SET ANSI_NULLS OFF
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SET LOCK_TIMEOUT -1
SET QUOTED_IDENTIFIER OFF
GO 

/*
IF Exists(SELECT * FROM WebPais WHERE Nombre = 'Mexico')
  UPDATE WebPais SET Nombre = 'México' WHERE Nombre = 'Mexico'
*/  
GO

IF NOT EXISTS(SELECT * FROM WebPais)
BEGIN
 INSERT WebPais (Nombre, Clave2, Clave3)
 SELECT 'Mexico', 'MX', 'MX'
 /*
  SELECT 'Afghanistan', 'AF', 'AF' UNION ALL
  SELECT 'Albania', 'AL', 'AL' UNION ALL
  SELECT 'Algeria', 'DZ', 'DZ' UNION ALL
  SELECT 'American Samoa', 'AS', 'AS' UNION ALL
  SELECT 'Andorra', 'AD', 'AD' UNION ALL
  SELECT 'An la', 'AO', 'AO' UNION ALL
  SELECT 'Anguilla', 'AI', 'AI' UNION ALL
  SELECT 'Antarctica', 'AQ', 'AQ' UNION ALL
  SELECT 'Antigua and Barbuda', 'AG', 'AG' UNION ALL
  SELECT 'Argentina', 'AR', 'AR' UNION ALL
  SELECT 'Armenia', 'AM', 'AM' UNION ALL
  SELECT 'Aruba', 'AW', 'AW' UNION ALL
  SELECT 'Australia', 'AU', 'AU' UNION ALL
  SELECT 'Austria', 'AT', 'AT' UNION ALL
  SELECT 'Azerbaijan', 'AZ', 'AZ' UNION ALL
  SELECT 'Bahamas', 'BS', 'BS' UNION ALL
  SELECT 'Bahrain', 'BH', 'BH' UNION ALL
  SELECT 'Bangladesh', 'BD', 'BD' UNION ALL
  SELECT 'Barbados', 'BB', 'BB' UNION ALL
  SELECT 'Belarus', 'BY', 'BY' UNION ALL
  SELECT 'Belgium', 'BE', 'BE' UNION ALL
  SELECT 'Belize', 'BZ', 'BZ' UNION ALL
  SELECT 'Benin', 'BJ', 'BJ' UNION ALL
  SELECT 'Bermuda', 'BM', 'BM' UNION ALL
  SELECT 'Bhutan', 'BT', 'BT' UNION ALL
  SELECT 'Bolivia', 'BO', 'BO' UNION ALL
  SELECT 'Bosnia and Herze vina', 'BA', 'BA' UNION ALL
  SELECT 'Botswana', 'BW', 'BW' UNION ALL
  SELECT 'Bouvet Island', 'BV', 'BV' UNION ALL
  SELECT 'Brazil', 'BR', 'BR' UNION ALL
  SELECT 'British Indian Ocean Territory', 'IO', 'IO' UNION ALL
  SELECT 'Brunei Darussalam', 'BN', 'BN' UNION ALL
  SELECT 'Bulgaria', 'BG', 'BG' UNION ALL
  SELECT 'Burkina Faso', 'BF', 'BF' UNION ALL
  SELECT 'Burundi', 'BI', 'BI' UNION ALL
  SELECT 'Cambodia', 'KH', 'KH' UNION ALL
  SELECT 'Cameroon', 'CM', 'CM' UNION ALL
  SELECT 'Canada', 'CA', 'CA' UNION ALL
  SELECT 'Cape Verde', 'CV', 'CV' UNION ALL
  SELECT 'Cayman Islands', 'KY', 'KY' UNION ALL
  SELECT 'Central African Republic', 'CF', 'CF' UNION ALL
  SELECT 'Chad', 'TD', 'TD' UNION ALL
  SELECT 'Chile', 'CL', 'CL' UNION ALL
  SELECT 'China', 'CN', 'CN' UNION ALL
  SELECT 'Christmas Island', 'CX', 'CX' UNION ALL
  SELECT 'Cocos (Keeling) Islands', 'CC', 'CC' UNION ALL
  SELECT 'Colombia', 'CO', 'CO' UNION ALL
  SELECT 'Comoros', 'KM', 'KM' UNION ALL
  SELECT 'Con', 'CG', 'CG' UNION ALL
  SELECT 'Con , the Democratic Republic of the', 'CD', 'CD' UNION ALL
  SELECT 'Cook Islands', 'CK', 'CK' UNION ALL
  SELECT 'Costa Rica', 'CR', 'CR' UNION ALL
  SELECT 'Croatia', 'HR', 'HR' UNION ALL
  SELECT 'Cuba', 'CU', 'CU' UNION ALL
  SELECT 'Cyprus', 'CY', 'CY' UNION ALL
  SELECT 'Czech Republic', 'CZ', 'CZ' UNION ALL
  SELECT 'Denmark', 'DK', 'DK' UNION ALL
  SELECT 'Djibouti', 'DJ', 'DJ' UNION ALL
  SELECT 'Dominica', 'DM', 'DM' UNION ALL
  SELECT 'Dominican Republic', 'DO', 'DO' UNION ALL
  SELECT 'Ecuador', 'EC', 'EC' UNION ALL
  SELECT 'Egypt', 'EG', 'EG' UNION ALL
  SELECT 'El Salvador', 'SV', 'SV' UNION ALL
  SELECT 'Equatorial Guinea', 'GQ', 'GQ' UNION ALL
  SELECT 'Eritrea', 'ER', 'ER' UNION ALL
  SELECT 'Estonia', 'EE', 'EE' UNION ALL
  SELECT 'Ethiopia', 'ET', 'ET' UNION ALL
  SELECT 'Falkland Islands (Malvinas)', 'FK', 'FK' UNION ALL
  SELECT 'Faroe Islands', 'FO', 'FO' UNION ALL
  SELECT 'Fiji', 'FJ', 'FJ' UNION ALL
  SELECT 'Finland', 'FI', 'FI' UNION ALL
  SELECT 'France', 'FR', 'FR' UNION ALL
  SELECT 'French Guiana', 'GF', 'GF' UNION ALL
  SELECT 'French Polynesia', 'PF', 'PF' UNION ALL
  SELECT 'French Southern Territories', 'TF', 'TF' UNION ALL
  SELECT 'Gabon', 'GA', 'GA' UNION ALL
  SELECT 'Gambia', 'GM', 'GM' UNION ALL
  SELECT 'Georgia', 'GE', 'GE' UNION ALL
  SELECT 'Germany', 'DE', 'DE' UNION ALL
  SELECT 'Ghana', 'GH', 'GH' UNION ALL
  SELECT 'Gibraltar', 'GI', 'GI' UNION ALL
  SELECT 'Greece', 'GR', 'GR' UNION ALL
  SELECT 'Greenland', 'GL', 'GL' UNION ALL
  SELECT 'Grenada', 'GD', 'GD' UNION ALL
  SELECT 'Guadeloupe', 'GP', 'GP' UNION ALL
  SELECT 'Guam', 'GU', 'GU' UNION ALL
  SELECT 'Guatemala', 'GT', 'GT' UNION ALL
  SELECT 'Guinea', 'GN', 'GN' UNION ALL
  SELECT 'Guinea-Bissau', 'GW', 'GW' UNION ALL
  SELECT 'Guyana', 'GY', 'GY' UNION ALL
  SELECT 'Haiti', 'HT', 'HT' UNION ALL
  SELECT 'Heard Island and Mcdonald Islands', 'HM', 'HM' UNION ALL
  SELECT 'Holy See (Vatican City State)', 'VA', 'VA' UNION ALL
  SELECT 'Honduras', 'HN', 'HN' UNION ALL
  SELECT 'Hong Kong', 'HK', 'HK' UNION ALL
  SELECT 'Hungary', 'HU', 'HU' UNION ALL
  SELECT 'Iceland', 'IS', 'IS' UNION ALL
  SELECT 'India', 'IN', 'IN' UNION ALL
  SELECT 'Indonesia', 'ID', 'ID' UNION ALL
  SELECT 'Iran, Islamic Republic of', 'IR', 'IR' UNION ALL
  SELECT 'Iraq', 'IQ', 'IQ' UNION ALL
  SELECT 'Ireland', 'IE', 'IE' UNION ALL
  SELECT 'Israel', 'IL', 'IL' UNION ALL
  SELECT 'Italy', 'IT', 'IT' UNION ALL
  SELECT 'Jamaica', 'JM', 'JM' UNION ALL
  SELECT 'Japan', 'JP', 'JP' UNION ALL
  SELECT 'Jordan', 'JO', 'JO' UNION ALL
  SELECT 'Kazakhstan', 'KZ', 'KZ' UNION ALL
  SELECT 'Kenya', 'KE', 'KE' UNION ALL
  SELECT 'Kiribati', 'KI', 'KI' UNION ALL
  SELECT 'Korea, Republic of', 'KR', 'KR' UNION ALL
  SELECT 'Kuwait', 'KW', 'KW' UNION ALL
  SELECT 'Kyrgyzstan', 'KG', 'KG' UNION ALL
  SELECT 'Latvia', 'LV', 'LV' UNION ALL
  SELECT 'Lebanon', 'LB', 'LB' UNION ALL
  SELECT 'Lesotho', 'LS', 'LS' UNION ALL
  SELECT 'Liberia', 'LR', 'LR' UNION ALL
  SELECT 'Libyan Arab Jamahiriya', 'LY', 'LY' UNION ALL
  SELECT 'Liechtenstein', 'LI', 'LI' UNION ALL
  SELECT 'Lithuania', 'LT', 'LT' UNION ALL
  SELECT 'Luxembourg', 'LU', 'LU' UNION ALL
  SELECT 'Macao', 'MO', 'MO' UNION ALL
  SELECT 'Macedonia, the Former Yu slav Republic of', 'MK', 'MK' UNION ALL
  SELECT 'Madagascar', 'MG', 'MG' UNION ALL
  SELECT 'Malawi', 'MW', 'MW' UNION ALL
  SELECT 'Malaysia', 'MY', 'MY' UNION ALL
  SELECT 'Maldives', 'MV', 'MV' UNION ALL
  SELECT 'Mali', 'ML', 'ML' UNION ALL
  SELECT 'Malta', 'MT', 'MT' UNION ALL
  SELECT 'Marshall Islands', 'MH', 'MH' UNION ALL
  SELECT 'Martinique', 'MQ', 'MQ' UNION ALL
  SELECT 'Mauritania', 'MR', 'MR' UNION ALL
  SELECT 'Mauritius', 'MU', 'MU' UNION ALL
  SELECT 'Mayotte', 'YT', 'YT' UNION ALL
  SELECT 'México', 'MX', 'MX' UNION ALL
  SELECT 'Micronesia, Federated States of', 'FM', 'FM' UNION ALL
  SELECT 'Moldova, Republic of', 'MD', 'MD' UNION ALL
  SELECT 'Monaco', 'MC', 'MC' UNION ALL
  SELECT 'Mon lia', 'MN', 'MN' UNION ALL
  SELECT 'Montserrat', 'MS', 'MS' UNION ALL
  SELECT 'Morocco', 'MA', 'MA' UNION ALL
  SELECT 'Mozambique', 'MZ', 'MZ' UNION ALL
  SELECT 'Myanmar', 'MM', 'MM' UNION ALL
  SELECT 'Namibia', 'NA', 'NA' UNION ALL
  SELECT 'Nauru', 'NR', 'NR' UNION ALL
  SELECT 'Nepal', 'NP', 'NP' UNION ALL
  SELECT 'Netherlands', 'NL', 'NL' UNION ALL
  SELECT 'Netherlands Antilles', 'AN', 'AN' UNION ALL
  SELECT 'New Caledonia', 'NC', 'NC' UNION ALL
  SELECT 'New Zealand', 'NZ', 'NZ' UNION ALL
  SELECT 'Nicaragua', 'NI', 'NI' UNION ALL
  SELECT 'Niger', 'NE', 'NE' UNION ALL
  SELECT 'Nigeria', 'NG', 'NG' UNION ALL
  SELECT 'Niue', 'NU', 'NU' UNION ALL
  SELECT 'Norfolk Island', 'NF', 'NF' UNION ALL
  SELECT 'Northern Mariana Islands', 'MP', 'MP' UNION ALL
  SELECT 'Norway', 'NO', 'NO' UNION ALL
  SELECT 'Oman', 'OM', 'OM' UNION ALL
  SELECT 'Pakistan', 'PK', 'PK' UNION ALL
  SELECT 'Palau', 'PW', 'PW' UNION ALL
  SELECT 'Palestinian Territory, Occupied', 'PS', 'PS' UNION ALL
  SELECT 'Panama', 'PA', 'PA' UNION ALL
  SELECT 'Papua New Guinea', 'PG', 'PG' UNION ALL
  SELECT 'Paraguay', 'PY', 'PY' UNION ALL
  SELECT 'Peru', 'PE', 'PE' UNION ALL
  SELECT 'Philippines', 'PH', 'PH' UNION ALL
  SELECT 'Pitcairn', 'PN', 'PN' UNION ALL
  SELECT 'Poland', 'PL', 'PL' UNION ALL
  SELECT 'Portugal', 'PT', 'PT' UNION ALL
  SELECT 'Puerto Rico', 'PR', 'PR' UNION ALL
  SELECT 'Qatar', 'QA', 'QA' UNION ALL
  SELECT 'Reunion', 'RE', 'RE' UNION ALL
  SELECT 'Romania', 'RO', 'RO' UNION ALL
  SELECT 'Russian Federation', 'RU', 'RU' UNION ALL
  SELECT 'Rwanda', 'RW', 'RW' UNION ALL
  SELECT 'Saint Helena', 'SH', 'SH' UNION ALL
  SELECT 'Saint Kitts and Nevis', 'KN', 'KN' UNION ALL
  SELECT 'Saint Lucia', 'LC', 'LC' UNION ALL
  SELECT 'Saint Pierre and Miquelon', 'PM', 'PM' UNION ALL
  SELECT 'Saint Vincent and the Grenadines', 'VC', 'VC' UNION ALL
  SELECT 'Samoa', 'WS', 'WS' UNION ALL
  SELECT 'San Marino', 'SM', 'SM' UNION ALL
  SELECT 'Sao Tome and Principe', 'ST', 'ST' UNION ALL
  SELECT 'Saudi Arabia', 'SA', 'SA' UNION ALL
  SELECT 'Senegal', 'SN', 'SN' UNION ALL
  SELECT 'Serbia', 'RS', 'RS' UNION ALL
  SELECT 'Seychelles', 'SC', 'SC' UNION ALL
  SELECT 'Sierra Leone', 'SL', 'SL' UNION ALL
  SELECT 'Singapore', 'SG', 'SG' UNION ALL
  SELECT 'Slovakia', 'SK', 'SK' UNION ALL
  SELECT 'Slovenia', 'SI', 'SI' UNION ALL
  SELECT 'Solomon Islands', 'SB', 'SB' UNION ALL
  SELECT 'Somalia', 'SO', 'SO' UNION ALL
  SELECT 'South Africa', 'ZA', 'ZA' UNION ALL
  SELECT 'South Georgia and the South Sandwich Islands', 'GS', 'GS' UNION ALL
  SELECT 'Spain', 'ES', 'ES' UNION ALL
  SELECT 'Sri Lanka', 'LK', 'LK' UNION ALL
  SELECT 'Sudan', 'SD', 'SD' UNION ALL
  SELECT 'Suriname', 'SR', 'SR' UNION ALL
  SELECT 'Svalbard and Jan Mayen', 'SJ', 'SJ' UNION ALL
  SELECT 'Swaziland', 'SZ', 'SZ' UNION ALL
  SELECT 'Sweden', 'SE', 'SE' UNION ALL
  SELECT 'Switzerland', 'CH', 'CH' UNION ALL
  SELECT 'Syrian Arab Republic', 'SY', 'SY' UNION ALL
  SELECT 'Taiwan', 'TW', 'TW' UNION ALL
  SELECT 'Tajikistan', 'TJ', 'TJ' UNION ALL
  SELECT 'Tanzania, United Republic of', 'TZ', 'TZ' UNION ALL
  SELECT 'Thailand', 'TH', 'TH' UNION ALL
  SELECT 'Timor-Leste', 'TL', 'TL' UNION ALL
  SELECT 'To', 'TG', 'TG' UNION ALL
  SELECT 'Tokelau', 'TK', 'TK' UNION ALL
  SELECT 'Tonga', 'TO', 'TO' UNION ALL
  SELECT 'Trinidad and Toba', 'TT', 'TT' UNION ALL
  SELECT 'Tunisia', 'TN', 'TN' UNION ALL
  SELECT 'Turkey', 'TR', 'TR' UNION ALL
  SELECT 'Turkmenistan', 'TM', 'TM' UNION ALL
  SELECT 'Turks and Caicos Islands', 'TC', 'TC' UNION ALL
  SELECT 'Tuvalu', 'TV', 'TV' UNION ALL
  SELECT 'Uganda', 'UG', 'UG' UNION ALL
  SELECT 'Ukraine', 'UA', 'UA' UNION ALL
  SELECT 'United Arab Emirates', 'AE', 'AE' UNION ALL
  SELECT 'United Kingdom', 'GB', 'GB' UNION ALL
  SELECT 'United States', 'US', 'US' UNION ALL
  SELECT 'United States Minor Outlying Islands', 'UM', 'UM' UNION ALL
  SELECT 'Uruguay', 'UY', 'UY' UNION ALL
  SELECT 'Uzbekistan', 'UZ', 'UZ' UNION ALL
  SELECT 'Vanuatu', 'VU', 'VU' UNION ALL
  SELECT 'Venezuela', 'VE', 'VE' UNION ALL
  SELECT 'Viet Nam', 'VN', 'VN' UNION ALL
  SELECT 'Virgin Islands, British', 'VG', 'VG' UNION ALL
  SELECT 'Virgin Islands, U.S.', 'VI', 'VI' UNION ALL
  SELECT 'Wallis and Futuna', 'WF', 'WF' UNION ALL
  SELECT 'Western Sahara', 'EH', 'EH' UNION ALL
  SELECT 'Yemen', 'YE', 'YE' UNION ALL
  SELECT 'Zambia', 'ZM', 'ZM' UNION ALL
  SELECT 'Zimbabwe', 'ZW', 'ZW' UNION ALL
  SELECT 'Isle of Man', 'IM', 'IM' UNION ALL
  SELECT 'Jersey', 'JE', 'JE' UNION ALL
  SELECT 'Guernsey', 'GG', 'GG' UNION ALL
  SELECT 'Lao Peoples Democratic Republic', 'LA', 'LA' UNION ALL
  SELECT 'Korea, Democratic Peoples Republic of', 'KP', 'KP' UNION ALL
  SELECT 'Montenegro', 'ME', 'ME' 
  */
END
IF NOT EXISTS(SELECT * FROM WebPaisEstado)
BEGIN
  INSERT WebPaisEstado (IDPais, Nombre, Clave)
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Aguascalientes','AGS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Baja California Norte','BCN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Baja California Sur','BCS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Campeche','CAM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Chiapas','CHP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Chihuahua','CHI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Coahuila','COA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Colima','COL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Distrito Federal','DF' UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Durango','DUR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Guanajuato','GUA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Guerrero','GUE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Hidalgo','HID'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Jalisco','JAL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Estado de Mexico','MEX'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Michoacan','MIC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Morelos','MOR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Nayarit','NAY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Nuevo Leon','NVL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Oaxaca','OAX'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Puebla','PUE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Queretaro','QUE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Quintana Roo','QUI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'San Luis Potosi','SLP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Sinaloa','SIN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Sonora','SON'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Tabasco','TAB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Tamaulipas','TAM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Tlaxcala','TLA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Veracruz','VER'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Yucatan','YUC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Mexico'),'Zacatecas','ZAC'
  /*
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'Australian Capital Territory','ACT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'New South Wales','NSW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'Northern Territory','NT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'Queensland','QLD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'South Australia','SA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'Tasmania','TAS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'Victoria','VIC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Australia'),'Western Australia','WA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Wien','WIE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Niederasterreich','NO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Oberasterreich','OO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Salzburg','SB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Karnten','KN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Steiermark','ST'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Tirol','TI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Burgenland','BL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Austria'),'Voralberg','VB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Alberta','AB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'British Columbia','BC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Manitoba','MB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Newfoundland','NF'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'New Brunswick','NB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Nova Scotia','NS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Northwest Territories','NT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Nunavut','NU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Ontario','ON'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Prince Edward Island','PE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Quebec','QC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Saskatchewan','SK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Canada'),'Yukon Territory','YT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Niedersachsen','NDS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Baden-Warttemberg','BAW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Bayern','BAY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Berlin','BER'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Brandenburg','BRG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Bremen','BRE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Hamburg','HAM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Hessen','HES'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Mecklenburg-Vorpommern','MEC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Nordrhein-Westfalen','NRW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Rheinland-Pfalz','RHE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Saarland','SAR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Sachsen','SAS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Sachsen-Anhalt','SAC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Schleswig-Holstein','SCN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Germany'),'Tharingen','THE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Bali','BA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Bangka Belitung','BB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Banten','BT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Bengkulu','BE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Daista Aceh','DA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Jakarta','JK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sumatera Utara','SU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sumatera Barat','SB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Riau','SI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Jambi','JA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sumatera Selatan','SS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Lampung','LA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Jawa Barat','JB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Jawa Tengah','JT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Daista Yogyakarta','DY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Jawa Timur','JT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Kalimantan Barat','KB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Kalimantan Tengah','KT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Kalimantan Timur','KI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Kalimantan Selatan','KS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Nusa Tenggara Barat','NB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Nusa Tenggara Timur','NT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sulawesi Selatan','SN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sulawesi Tengah','ST'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sulawesi Utara','SA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Sulawesi Tenggara','SG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Maluku','MA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Maluku Utara','MU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Irian Jaya Timur','IJ'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Irian Jaya Tengah','IT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Irian Jawa Barat','IB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Indonesia'),'Gorontalo','GO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Carlow','CW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Cavan','CN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Clare','CE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Cork','C'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Donegal','DL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Dublin','D'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Galway','G'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Kerry','KY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Kildare','KE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Kilkenny','KK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Laois','LS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Leitrim','LM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Limerick','LK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Longford','LD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Louth','LH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Mayo','MO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Meath','MH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Monaghan','MN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Offaly','OY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Roscommon','RN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Sligo','SO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Tipperary','TA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Waterford','WD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Westmeath','WH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Wexford','WX'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Ireland'),'Wicklow','WW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Johor','JHR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Kedah','KDH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Kelantan','KTN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Melaka','MLK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Negeri Sembilan','NSN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Pahang','PHG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Pulau Pinang','PNG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Perak','PRK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Perlis','PLS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Selangor','SGR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Terengganu','TRG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Sabah','SBH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Sarawak','SRW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Kuala Lumpur','KUL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Labuan','LBN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Malaysia'),'Putrajaya','PJY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Aguascalientes','AGS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Baja California Norte','BCN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Baja California Sur','BCS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Campeche','CAM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Chiapas','CHP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Chihuahua','CHI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Coahuila','COA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Colima','COL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Durango','DUR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Guanajuato','GUA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Guerrero','GUE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Hidalgo','HID'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Jalisco','JAL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Estado de México','MEX'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Michoacán','MIC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Morelos','MOR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Nayarit','NAY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Nuevo León','NVL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Oaxaca','OAX'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Puebla','PUE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Querétaro','QUE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Quintana Roo','QUI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'San Luis Potosí','SLP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Sinaloa','SIN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Sonora','SON'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Tabasco','TAB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Tamaulipas','TAM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Tlaxcala','TLA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Veracruz','VER'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Yucatán','YUC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Zacatecas','ZAC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='México'),'Distrito Federal','DF'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Eastern Cape','EC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Free State','FS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Gauteng','GT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'KwaZulu-Natal','NL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Limpopo','LP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Mpumalanga','MP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Northern Cape','NC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'North-West','NW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='South Africa'),'Western Cape','WC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'A Coruña','ACOR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Alava','ALAV'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Albacete','ALBA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Alicante','ALIC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Almeria','ALME'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Asturias','ASTU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Avila','AVIL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Badajoz','BADA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Baleares','BALE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Barcelona','BARC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Burgos','BURG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Caceres','CACE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Cadiz','CADI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Cantabria','CANT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Castellon','CAST'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Ceuta','CEUT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Ciudad Real','CIUD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Cordoba','CORD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Cuenca','CUEN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Girona','GIRO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Granada','GRAN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Guadalajara','GUAD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Guipuzcoa','GUIP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Huelva','HUEL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Huesca','HUES'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Jaen','JAEN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'La Rioja','LAR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Las Palmas','LAS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Leon','LEON'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Lleida','LLEI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Lugo','LUGO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Madrid','MADR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Malaga','MALA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Melilla','MELI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Murcia','MURC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Navarra','NAVA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Ourense','OURE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Palencia','PALE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Pontevedra','PONT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Salamanca','SALA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Santa Cruz de Tenerife','SANT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Segovia','SEGO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Sevilla','SEVI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Soria','SORI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Tarragona','TARR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Teruel','TERU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Toledo','TOLE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Valencia','VALE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Valladolid','VALL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Vizcaya','VIZC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Zamora','ZAMO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Spain'),'Zaragoza','ZARA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Aargau','AG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Appenzell Innerrhoden','AI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Appenzell Ausserrhoden','APP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Bern','BE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Basel-Landschaft','BLA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Basel-Stadt','BS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Freiburg','FR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Genf','GE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Glarus','GL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Graubanden','JUB'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Jura','JU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Luzern','LU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Neuenburg','NEU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Nidwalden','NW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Obwalden','OW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'St. Gallen','SG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Schaffhausen','SH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Solothurn','SO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Schwyz','SZ'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Thurgau','TG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Tessin','TE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Uri','UR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Waadt','VD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Wallis','VS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Zug','ZG'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='Switzerland'),'Zurich','ZH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Bedfordshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Berkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Buckinghamshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cambridgeshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cheshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cornwall',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cumberland',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cumbria',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Derbyshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Devon',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Dorset',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Durham',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'East Suffolk',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'East Sussex',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Essex',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Gloucestershire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Greater London',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Greater Manchester',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Hampshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Herefordshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Hertfordshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Isle of Wight',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Kent',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Lancashire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Leicestershire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Lincolnshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'London',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Merseyside',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Middlesex',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Norfolk',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Northamptonshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Northumberland',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'North Humberside',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'North Yorkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Nottinghamshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Oxfordshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Rutland',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Shropshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Somerset',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'South Humberside',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'South Yorkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Staffordshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Suffolk',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Surrey',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Sussex',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Tyne and Wear',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Warwickshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'West Midlands',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Westmorland',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'West Suffolk',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'West Sussex',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'West Yorkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Wiltshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Worcestershire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Yorkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Yorkshire, East Riding',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Yorkshire, North Riding',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Yorkshire, West Riding',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Antrim',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Armagh',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'City of Belfast',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Down',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Fermanagh',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Londonderry',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'City of Londonderry',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Tyrone',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'City of Aberdeen',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Aberdeenshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Angus',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Argyll',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Ayrshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Banffshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Berwickshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Bute',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Caithness',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Clackmannanshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cromartyshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Dumfriesshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Dunbartonshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'City of Dundee',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'East Lothian',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'City of Edinburgh',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Fife',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'City of Glasgow',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Inverness-shire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Kincardineshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Kinross-shire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Kirkcudbrightshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Lanarkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Midlothian',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Moray',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Nairnshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Orkney',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Peeblesshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Perthshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Renfrewshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Ross and Cromarty',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Ross-shire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Roxburghshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Selkirkshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Shetland',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Stirlingshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Sutherland',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'West Lothian',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Wigtownshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Anglesey',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Brecknockshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Caernarfonshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Cardiganshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Carmarthenshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Clwyd',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Denbighshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Dyfed',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Flintshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Glamorgan',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Gwent',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Gwynedd',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Merionethshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Mid Glamorgan',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Monmouthshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Montgomeryshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Pembrokeshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Powys',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'Radnorshire',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'South Glamorgan',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United Kingdom'),'West Glamorgan',''  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Alabama','AL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Alaska','AK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'American Samoa','AS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Arizona','AZ'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Arkansas','AR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Armed Forces Africa','AF'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Armed Forces Americas','AA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Armed Forces Canada','AC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Armed Forces Europe','AE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Armed Forces Middle East','AM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Armed Forces Pacific','AP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'California','CA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Colorado','CO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Connecticut','CT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Delaware','DE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'District of Columbia','DC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Federated States Of Micronesia','FM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Florida','FL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Georgia','GA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Guam','GU'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Hawaii','HI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Idaho','ID'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Illinois','IL'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Indiana','IN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Iowa','IA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Kansas','KS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Kentucky','KY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Louisiana','LA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Maine','ME'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Marshall Islands','MH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Maryland','MD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Massachusetts','MA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Michigan','MI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Minnesota','MN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Mississippi','MS'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Missouri','MO'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Montana','MT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Nebraska','NE'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Nevada','NV'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'New Hampshire','NH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'New Jersey','NJ'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'New México','NM'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'New York','NY'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'North Carolina','NC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'North Dakota','ND'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Northern Mariana Islands','MP'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Ohio','OH'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Oklahoma','OK'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Oregon','OR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Palau','PW'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Pennsylvania','PA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Puerto Rico','PR'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Rhode Island','RI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'South Carolina','SC'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'South Dakota','SD'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Tennessee','TN'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Texas','TX'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Utah','UT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Vermont','VT'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Virgin Islands','VI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Virginia','VA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Washington','WA'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'West Virginia','WV'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Wisconsin','WI'  UNION ALL
  SELECT (SELECT ID FROM WebPais WHERE Nombre ='United States'),'Wyoming','WY'  
  */ 
END  
GO

IF NOT EXISTS(SELECT * FROM WebPais WHERE Region IS NOT NULL)
BEGIN
  UPDATE WebPais SET Region = 1 WHERE Nombre IN('Austria', 'Belgium', 'Bulgaria', 'Finland', 'France', 'Germany', 'Greece', 'Ireland', 'Italy', 'Luxembourg', 'Netherlands', 'Portugal', 'Spain')

END

GO


IF NOT EXISTS(SELECT * FROM WebFormaPagoOmision)
BEGIN
  INSERT WebFormaPagoOmision ( IDForma, Nombre, Prepagado)
  SELECT 'checkout_bankdeposit', 'Deposito Bancario', 0 UNION ALL
  SELECT 'checkout_cheque', 'Cheque', 0 UNION ALL
  SELECT 'checkout_cod', 'Pago contra Entrega', 0 UNION ALL
  SELECT 'checkout_instore', 'Pagar en Tienda', 0 UNION ALL
  SELECT 'checkout_paypal', 'PayPal (Standard)', 1
  
  
  /*SELECT 'checkout_2checkout', '2Checkout', 1 UNION ALL
  SELECT 'checkout_amazonfps', 'Amazon Flexible Payment System', 1 UNION ALL
  SELECT 'checkout_authorizenet', 'Authorize.net', 1 UNION ALL
  SELECT 'checkout_beanstream', 'BeanStream', 1 UNION ALL
  SELECT 'checkout_bpay', 'BPAY', 1 UNION ALL
  SELECT 'checkout_caledon', 'Caledon', 1 UNION ALL
  SELECT 'checkout_chronopayapi', 'ChronoPay API', 1 UNION ALL
  SELECT 'checkout_chronopaypage', 'ChronoPay Page', 1 UNION ALL
  SELECT 'checkout_creditcardmanually', 'Credit Card (Manual)', 0 UNION ALL
  SELECT 'checkout_cybersource', 'CyberSource', 1 UNION ALL
  SELECT 'checkout_cybersourcedirect', 'CyberSource', 1 UNION ALL
  SELECT 'checkout_cynergydata', 'CynergyData', 1 UNION ALL
  SELECT 'checkout_directone', 'DirectOne', 1 UNION ALL
  SELECT 'checkout_eselectplusdp', 'eSELECTplus DirectPost (Canada)', 1 UNION ALL
  SELECT 'checkout_eselectplushp', 'eSELECTplus Hosted PayPage (Canada)', 1 UNION ALL
  SELECT 'checkout_eselectplushpus', 'eSELECTplus Hosted PayPage (US)', 1 UNION ALL
  SELECT 'checkout_eway', 'eWay', 1 UNION ALL
  SELECT 'checkout_ewaynz', 'eWay New Zealand (Hosted)', 1 UNION ALL
  SELECT 'checkout_ewayuk', 'eWay UK (Hosted)', 1 UNION ALL
  SELECT 'checkout_exact', 'E-xact', 1 UNION ALL
  SELECT 'checkout_googlecheckout', 'Google Checkout', 1 UNION ALL
  SELECT 'checkout_hsbc', 'HSBC', 1 UNION ALL
  SELECT 'checkout_ideal', 'iDEAL Professional/Advanced', 1 UNION ALL
  SELECT 'checkout_innovativegateway', 'Innovative Gateway', 1 UNION ALL
  SELECT 'checkout_intellipay', 'IntelliPay', 1 UNION ALL
  SELECT 'checkout_interspiremerchant', 'Secure Payment Gateway', 1 UNION ALL
  SELECT 'checkout_iwsmile', 'IWSmile', 1 UNION ALL
  SELECT 'checkout_linkpointconnect', 'First Data Global Gateway Connect', 1 UNION ALL
  SELECT 'checkout_migs', 'MIGS', 1 UNION ALL
  SELECT 'checkout_migsredir', 'MIGS (Redirect)', 1 UNION ALL
  SELECT 'checkout_moneybookers', 'MoneyBookers', 1 UNION ALL
  SELECT 'checkout_moneyorder', 'Money Order', 0 UNION ALL
  SELECT 'checkout_myvirtualmerchant', 'MyVirtualMerchant', 1 UNION ALL
  SELECT 'checkout_nab', 'NAB', 1 UNION ALL
  SELECT 'checkout_netbilling', 'NetBilling', 1 UNION ALL
  SELECT 'checkout_netregistry', 'NetRegistry', 1 UNION ALL
  SELECT 'checkout_nmi', 'NMI', 1 UNION ALL
  SELECT 'checkout_nochex', 'NoChex', 1 UNION ALL
  SELECT 'checkout_ogone', 'Ogone', 1 UNION ALL
  SELECT 'checkout_payflowlinks', 'PayPal Payflow Links', 1 UNION ALL
  SELECT 'checkout_payflowpro', 'PayPal Payflow Pro', 1 UNION ALL
  SELECT 'checkout_payjunction', 'PayJunction', 1 UNION ALL
  SELECT 'checkout_payleap', 'PayLeap', 1 UNION ALL
  SELECT 'checkout_paymate', 'PayMate', 1 UNION ALL
  SELECT 'checkout_paymentclearing', 'Payment Clearing', 1 UNION ALL
  SELECT 'checkout_paypalexpress', 'PayPal Express Checkout', 1 UNION ALL
  SELECT 'checkout_paypalpaymentsprouk', 'PayPal Website Payments Pro (Payflow Edition)', 1 UNION ALL
  SELECT 'checkout_paypalpaymentsprous', 'PayPal Website Payments Pro', 1 UNION ALL
  SELECT 'checkout_paypoint', 'PayPoint', 1 UNION ALL
  SELECT 'checkout_paysimple', 'PaySimple', 1 UNION ALL
  SELECT 'checkout_paystation', 'PayStation', 1 UNION ALL
  SELECT 'checkout_plugnpay', 'PlugNPay', 1 UNION ALL
  SELECT 'checkout_protx', 'Sage Pay/Protx VSP Form', 1 UNION ALL
  SELECT 'checkout_protxvspdirect', 'Sage Pay/Protx VSP Direct', 1 UNION ALL
  SELECT 'checkout_psigate', 'PSIGate', 1 UNION ALL
  SELECT 'checkout_pxpay', 'PaymentExpress Pay', 1 UNION ALL
  SELECT 'checkout_pxpost', 'PaymentExpress Post', 1 UNION ALL
  SELECT 'checkout_qbms', 'Quick Books Merchant Services', 1 UNION ALL
  SELECT 'checkout_quantumgateway', 'Quantum Gateway', 1 UNION ALL
  SELECT 'checkout_realex', 'Realex', 1 UNION ALL
  SELECT 'checkout_securepay', 'SecurePay', 1 UNION ALL
  SELECT 'checkout_securetrading', 'Secure Trading', 1 UNION ALL
  SELECT 'checkout_simplepay', 'Amazon Simple Pay', 1 UNION ALL
  SELECT 'checkout_usaepay', 'USAePay', 1 UNION ALL
  SELECT 'checkout_valutec', 'Valutec', 1 UNION ALL
  SELECT 'checkout_vcsdivertccform', 'Virtual Card Services', 1 UNION ALL
  SELECT 'checkout_worldpay', 'WorldPay', 1 */
END