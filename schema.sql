CREATE TABLE Accounts (
	email VARCHAR(128) NOT NULL,
	username VARCHAR(128) NOT NULL,
	password VARCHAR(128) NOT NULL,
	level INT(3) NOT NULL,

	PRIMARY KEY (email),
	UNIQUE KEY un_username (username)
)	ENGINE = INNODB;

CREATE TABLE Primary_Weapons (
	primary_weapon_name VARCHAR(128) NOT NULL,
	rate_of_fire DOUBLE NOT NULL,
	accuracy DOUBLE NOT NULL,

	PRIMARY KEY (primary_weapon_name)
)	ENGINE = INNODB;

CREATE TABLE Secondary_Weapons (
	secondary_weapon_name VARCHAR(128) NOT NULL,
	rate_of_fire DOUBLE NOT NULL,
	accuracy DOUBLE NOT NULL,

	PRIMARY KEY (secondary_weapon_name)
)	ENGINE = INNODB;

CREATE TABLE Perks (
	perk_name VARCHAR(128) NOT NULL,
	rate_of_fire DOUBLE NOT NULL,
	accuracy DOUBLE NOT NULL,

	PRIMARY KEY (perk_name)
)	ENGINE = INNODB;

CREATE TABLE Statistics (
	username VARCHAR(128) NOT NULL,
	kills INT NOT NULL,
	death INT NOT NULL,
	assists INT NOT NULL,

	PRIMARY KEY (username),

	FOREIGN KEY fk_username(username)
	REFERENCES Accounts(username)
	ON UPDATE CASCADE
)	ENGINE = INNODB;

CREATE TABLE Loadouts (
	username VARCHAR(128) NOT NULL,
	loadout_name VARCHAR(128) NOT NULL,
	primary_weapon_name VARCHAR(128),
	secondary_weapon_name VARCHAR(128),
	perk_name VARCHAR(128),

	PRIMARY KEY (username, loadout_name),

	FOREIGN KEY fk_ac_username(username)
	REFERENCES Accounts(username)
	ON UPDATE CASCADE
	ON DELETE CASCADE,

	FOREIGN KEY fk_primary_weapon_name (primary_weapon_name)
	REFERENCES Primary_Weapons(primary_weapon_name)
	ON UPDATE CASCADE,

	FOREIGN KEY fk_secondary_weapon_name (secondary_weapon_name)
	REFERENCES Secondary_Weapons(secondary_weapon_name)
	ON UPDATE CASCADE,

	FOREIGN KEY fk_perk_name (perk_name)
	REFERENCES Perks(perk_name)
	ON UPDATE CASCADE
)	ENGINE = INNODB;


-- nah you