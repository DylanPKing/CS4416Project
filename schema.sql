-- -------
-- Database: 'ShoterGame'
-- -------

-- Table Structure for 'Accounts'
CREATE TABLE Accounts (
	email VARCHAR(128) NOT NULL,
	username VARCHAR(128) NOT NULL,
	password VARCHAR(128) NOT NULL,
	level INT(3) DEFAULT 1,

	PRIMARY KEY (email),
	UNIQUE KEY un_username (username)
)	ENGINE = INNODB;

-- Data for table 'Accounts'
INSERT INTO Accounts (email, username, password, level) VALUES
('dylan@notgmail.com', 'DKing1543', 'password12', 1),
('szymon@notyahoo.com', 'SoulsIsGood', 'password12', 5),
('louise@notoutlook.com', 'lmadden518', 'pword456', 10),
('brian@beep.com', 'bmalone100', 'iambrian', 8),
('nik@ul.com', 'nikolanikolov', 'agoodpassword', 6);

-- Table Structure for 'Primary_Weapons'
CREATE TABLE Primary_Weapons (
	primary_weapon_name VARCHAR(128) NOT NULL,
	rate_of_fire DOUBLE DEFAULT 0,
	accuracy DOUBLE DEFAULT 0,

	PRIMARY KEY (primary_weapon_name)
)	ENGINE = INNODB;

-- Data for table 'Primary_Weapons'
INSERT INTO Primary_Weapons (primary_weapon_name, rate_of_fire, accuracy) VALUES
('AK-47', 20, 0.6),
('AR-15', 22, 0.71),
('SPAZ-12', 3, 0.2),
('MP-7', 40, 0.78),
('AW50', 1, 0.92);

-- Table Structure for 'Secondary_Weapons'
CREATE TABLE Secondary_Weapons (
	secondary_weapon_name VARCHAR(128) NOT NULL,
	rate_of_fire DOUBLE DEFAULT 0,
	accuracy DOUBLE DEFAULT 0,

	PRIMARY KEY (secondary_weapon_name)
)	ENGINE = INNODB;

-- Data for table 'Secondary_Weapons'
INSERT INTO Secondary_Weapons (secondary_weapon_name, rate_of_fire, accuracy) VALUES
('P99', 10, 0.68),
('Desert Eagle', 8, 0.75),
('Beretta 92', 12, 0.65),
('P228', 14, 0.55),
('M1911', 10, 0.58);

-- Table Structure for 'Perks'
CREATE TABLE Perks (
	perk_name VARCHAR(128) NOT NULL,
	rate_of_fire_boost DOUBLE DEFAULT 0,
	accuracy_boost DOUBLE DEFAULT 0,

	PRIMARY KEY (perk_name)
)	ENGINE = INNODB;

-- Data for table 'Perks'
INSERT INTO Perks (perk_name, rate_of_fire_boost, accuracy_boost) VALUES
('Sharpshooter', 0, 0.11),
('Quick Trigger', 10, 0),
('Eagle-eye', -5, 0.18),
('Hi-powered weapons', 16, -0.07),
('Superman', 5, 0.06);

-- Table Structure for 'Statistics'
CREATE TABLE Stats (
	username VARCHAR(128) NOT NULL,
	kills INT DEFAULT 0,
	deaths INT DEFAULT 0,
	assists INT DEFAULT 0,

	PRIMARY KEY (username),
	UNIQUE KEY un_username_stats (username),

	FOREIGN KEY fk_username(username)
	REFERENCES Accounts(username)
	ON UPDATE CASCADE
)	ENGINE = INNODB;

-- Data for table 'Statistics'
INSERT INTO Stats (username, kills, deaths, assists) VALUES
('DKing1543', 5, 7, 2),
('SoulsIsGood', 36, 20, 40),
('bmalone100', 16, 7, 6),
('lmadden518', 7, 15, 9),
('nikolanikolov', 24, 1, 19);

-- Table Structure for 'Loadouts'
CREATE TABLE Loadouts (
	username VARCHAR(128) NOT NULL,
	loadout_name VARCHAR(128) NOT NULL,
	primary_weapon_name VARCHAR(128) NOT NULL,
	secondary_weapon_name VARCHAR(128) NOT NULL,
	perk_name VARCHAR(128) NOT NULL,

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

-- Data for table 'Loadouts'
INSERT INTO Loadouts (username, loadout_name, primary_weapon_name, secondary_weapon_name, perk_name) VALUES
('DKing1543', 'Loadout 1', 'AK-47', 'Desert Eagle', 'Sharpshooter'),
('SoulsIsGood', 'Accuracy', 'MP-7', 'Desert Eagle', 'Eagle-Eye'),
('SoulsIsGood', 'DPS', 'MP-7', 'P228', 'Hi-Powered Weapons'),
('Bmalone100', 'win', 'SPAZ-12', 'P99', 'Superman'),
('lmadden518', 'a loadout', 'AK-47', 'P99', 'Sharpshooter'),
('nikolanikolov', 'Loadout 1', 'AW50', 'M1911', 'Quick Trigger');