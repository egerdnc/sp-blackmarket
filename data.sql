CREATE TABLE essentialmode.blackmarket_weapons (
  `name` VARCHAR(255) NOT NULL DEFAULT '',
  stock INT(11) DEFAULT 0,
  price INT(11) DEFAULT 0,
  display_name VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`name`)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_turkish_ci;

CREATE TABLE IF NOT EXISTS `blackmarket_allowedusers` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;