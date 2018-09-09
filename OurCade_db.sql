CREATE DATABASE IF NOT EXISTS ourcade_db;

/** 
	Table CREATE Statements 
**/

CREATE TABLE IF NOT EXISTS genre
(
genre_id TINYINT(3) NOT NULL AUTO_INCREMENT,
genre_name VARCHAR(25) NOT NULL,
PRIMARY KEY (genre_id)
);

CREATE TABLE IF NOT EXISTS country
(
country_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
country_name VARCHAR(50) NOT NULL,
PRIMARY KEY (country_id)
);

CREATE TABLE IF NOT EXISTS vendor
(
vendor_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
vendor_name VARCHAR(255) NOT NULL,
vendor_phone VARCHAR(20) NOT NULL,
vendor_address VARCHAR(255) NOT NULL,
vendor_email VARCHAR(100),
country_id SMALLINT(5) NOT NULL,
PRIMARY KEY (vendor_id),
KEY idx_fk_vendor_name (vendor_name),
CONSTRAINT fk_vendor_country FOREIGN KEY (country_id) REFERENCES country(country_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS game
(
game_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
game_name VARCHAR(255) NOT NULL,
game_year YEAR(4) NOT NULL,
game_price DECIMAL(4, 2) NOT NULL,
genre_id TINYINT(3) NOT NULL,
vendor_id SMALLINT(5) NOT NULL,
PRIMARY KEY (game_id),
KEY idx_fk_game_name (game_name),
CONSTRAINT fk_game_genre FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
ON DELETE CASCADE
ON UPDATE CASCADE,
CONSTRAINT fk_game_vendor FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS invoice
(
invoice_id INT(11) NOT NULL AUTO_INCREMENT,
invoice_date DATE NOT NULL,
vendor_id SMALLINT(5) NOT NULL,
amount DECIMAL(9, 2) NOT NULL,
PRIMARY KEY (invoice_id),
CONSTRAINT fk_invoice_vendor FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id)
ON DELETE CASCADE
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS sale_period
(
period_id INT(11) NOT NULL AUTO_INCREMENT,
period_start DATE NOT NULL,
period_end DATE NOT NULL,
period_week TINYINT(2),
period_month VARCHAR(10) NOT NULL,
period_year YEAR(4),
PRIMARY KEY (period_id)
);

CREATE TABLE IF NOT EXISTS game_sale
(
game_id SMALLINT(5) NOT NULL,
period_id INT(11) NOT NULL,
total DECIMAL(7, 2) NOT NULL,
PRIMARY KEY (game_id, period_id),
CONSTRAINT fk_game_sale_game FOREIGN KEY (game_id) REFERENCES game(game_id)
ON UPDATE CASCADE,
CONSTRAINT fk_game_sale_period FOREIGN KEY (period_id) REFERENCES sale_period(period_id)
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS tournament
(
tournament_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
title VARCHAR(50) NOT NULL,
prize DECIMAL(7, 2) NOT NULL,
fee DECIMAL(5, 2) NOT NULL,
team_size TINYINT(3) NOT NULL,
tournament_description TEXT,
tournament_date DATE,
PRIMARY KEY (tournament_id),
KEY idx_fk_title (title)
); 

CREATE TABLE IF NOT EXISTS tournament_game
(
tournament_id SMALLINT(5) NOT NULL,
game_id SMALLINT(5) NOT NULL,
PRIMARY KEY (tournament_id, game_id),
CONSTRAINT fk_tournament_game_tournament FOREIGN KEY (tournament_id) REFERENCES tournament(tournament_id)
ON UPDATE CASCADE,
CONSTRAINT fk_tournament_game_game FOREIGN KEY (game_id) REFERENCES game(game_id)
ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS joint_event
(
event_id SMALLINT(5) NOT NULL AUTO_INCREMENT,
event_title VARCHAR(25) NOT NULL,
event_description TEXT,
event_date DATE,
PRIMARY KEY (event_id),
KEY idx_fk_event_title (event_title)
);

CREATE TABLE IF NOT EXISTS event_vendor
(
event_id SMALLINT(5) NOT NULL,
vendor_id SMALLINT(5),
PRIMARY KEY (event_id, vendor_id),
CONSTRAINT fk_event_vendor_event FOREIGN KEY (event_id) REFERENCES joint_event(event_id)
ON UPDATE CASCADE,
CONSTRAINT fk_event_vendor_vendor FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id)
ON UPDATE CASCADE
);

/**
	INSERT genre Statements
**/
INSERT INTO genre (genre_name)
VALUES ('Fighting');

INSERT INTO genre (genre_name)
VALUES ('Puzzle');

INSERT INTO genre (genre_name)
VALUES ('Racing');

INSERT INTO genre (genre_name)
VALUES ('Shooting');

INSERT INTO genre (genre_name)
VALUES ('Platform');

INSERT INTO genre (genre_name)
VALUES ('Dancing');

INSERT INTO genre (genre_name)
VALUES ('Sports');

INSERT INTO genre (genre_name)
VALUES ('Rhythm');

INSERT INTO genre (genre_name)
VALUES ('Simulator');

INSERT INTO genre (genre_name)
VALUES ('Adventure');

/**
	INSERT country Statements
**/

INSERT INTO country (country_name)
VALUES ('United States');

INSERT INTO country (country_name)
VALUES ('China');

INSERT INTO country (country_name)
VALUES ('Japan');

INSERT INTO country (country_name)
VALUES ('Germany');

INSERT INTO country (country_name)
VALUES ('United Kingdom');

INSERT INTO country (country_name)
VALUES ('South Korea');

INSERT INTO country (country_name)
VALUES ('France');

INSERT INTO country (country_name)
VALUES ('Canada');

INSERT INTO country (country_name)
VALUES ('Spain');

INSERT INTO country (country_name)
VALUES ('Italy');

INSERT INTO country (country_name)
VALUES ('Russia');

INSERT INTO country (country_name)
VALUES ('Austrailia');

/**
	INSERT vendor Statements
**/

INSERT INTO vendor (vendor_id, vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES (15002, 'Nintendo', '18002553700', 'Kyoto Prefecture', 'nintendogames@nintendo.com', 3);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Capcom', '81669463099', 'Seoul', 'capcomarcade@capcom.com', 6);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Midway', '18002433220', 'London', 'midwaygames@midway.com', 5);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Konami', '3102208100', 'Minato Tokyo', 'konamigamecompany@konami.com', 3);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Namco', '4082352222', 'Paris', 'namcoarcade@namco.com', 7);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Atari', '12127266500', 'New York City, New York', 'atari@atari.com', 1);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Friendship', '234985734489723', 'Frankfurt', 'friendshipgames@friendshipgames.com', 4);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Aboot Games', '479382348792', 'Otawa', 'abootarcade@abootgames.com', 8);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, vendor_email, country_id)
VALUES ('Fair Play', '9324784398278756', 'Moscow', 'classicarcade@fairplay.com', 11);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, country_id)
VALUES ('Mercurios', '4126216220', 'Walnut St.', 1);

INSERT INTO vendor (vendor_name, vendor_phone, vendor_address, country_id)
VALUES ('Happy Berry', '4126220220', 'Walnut St.', 1);

/**
	INSERT game Statements
**/

INSERT INTO game (game_id, game_name, game_year, game_price, genre_id, vendor_id) 
VALUES(11001, 'Pac-Man Plus', 1982, 1.00, 2, 15004);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Donkey Kong', 1981, 1.00, 5, 15002);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Asteroids', 1979, 1.00, 5, 15007);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Street Fighter', 1987, 1.50, 1, 15003);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Dance Dance Revolution', 1998, 2.00, 6, 15005);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Contra', 1987, 1.25, 4, 15005);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Ridge Racer', 1993, 1.25, 3, 15006);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Taiko Drum Master', 2004, 2.00, 8, 15006);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Punch Out', 1984, 1.50, 7, 15002);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('1943', 1987, 1.25, 5, 15003);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Mortal Kombat', 1992, 1.50, 1, 15004);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Sonic Adventures', 1993, 1.25, 5, 15002);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Pokken Tournament', 2015, 2.50, 1, 15002);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Flight Simulator', 2012, 3.00, 9, 15011);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Call of Duty', 2003, 2.00, 4, 15010);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('All Star Basketball', 2009, 2.00, 7, 15009);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Step Mania', 2001, 2.50, 6, 15010);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Super Mario', 1985, 1.00, 10, 15002);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Need for Speed', 2003, 2.00, 3, 15011);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Gold Medalist', 1989, 1.25, 7, 15010);

INSERT INTO game (game_name, game_year, game_price, genre_id, vendor_id) 
VALUES('Lumines', 2010, 1.75, 8, 15009);

/**
	INSERT invoice Statements
**/

AlTER TABLE invoice
ADD invoice_description TEXT NOT NULL;

INSERT INTO invoice (invoice_id, invoice_date, vendor_id, amount, invoice_description)
VALUES (90001, '2016-08-25', 15002, 1250.00, 'Bought new machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-09-14', 15003, 1550.00, 'Bought new machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-09-21', 15007, 725.00, 'Machine Repaired');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-10-08', 15012, 2000.00, 'Flood Damage');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-10-25', 15009, 2000.00, 'Returned defective machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2017-11-01', 15011, 1300.00, 'Sold old machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-11-11', 15004, 1000.00, 'Bought used machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-11-25', 15008, 2000.00, 'Bought new machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-12-08', 15012, 1500.00, 'Sold used machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-12-23', 15005, 975.50, 'Bought used machine');

INSERT INTO invoice (invoice_date, vendor_id, amount, invoice_description)
VALUES ('2016-012-29', 15006, 500.00, 'Machine Repaired');

/**
	INSERT sale period Statements
**/

INSERT INTO sale_period (period_id, period_start, period_end, period_week, period_month, period_year)
VALUES (70001, '2017-06-01', '2017-06-08', 1, 'June', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-06-09', '2017-06-15', 2, 'June', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-06-16', '2017-06-22', 3, 'June', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-06-23', '2017-06-29', 4, 'June', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-07-01', '2017-07-07', 5, 'July', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-07-08', '2017-07-15', 6, 'July', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-07-16', '2017-07-22', 7, 'July', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-07-23', '2017-07-29', 8, 'July', 2017);

INSERT INTO sale_period (period_start, period_end, period_month, period_year)
VALUES ('2017-08-01', '2017-08-31', 'August', 2017);

INSERT INTO sale_period (period_start, period_end, period_month, period_year)
VALUES ('2017-09-01', '2017-09-30', 'September', 2017);

INSERT INTO sale_period (period_start, period_end, period_month, period_year)
VALUES ('2017-10-01', '2017-10-31', 'October', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-11-01', '2017-11-14', 22, 'November', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-11-15', '2017-11-29', 24, 'November', 2017);

INSERT INTO sale_period (period_start, period_end, period_week, period_month, period_year)
VALUES ('2017-12-01', '2017-12-08', 26, 'December', 2017);

/**
	INSERT game sale Statements
**/

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70001, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70001, 200.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70001, 250.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70001, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70001, 150.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70001, 305.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70001, 375.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70001, 225.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70001, 175.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70002, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70002, 425.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70002, 380.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70002, 340.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70002, 320.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70002, 420.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70002, 415.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70002, 190.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70002, 240.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70002, 280.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70003, 500.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70003, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70003, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70003, 320.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70003, 545.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70003, 290.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70003, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70003, 550.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70003, 325.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70003, 410.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70003, 390.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70003, 480.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70004, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70004, 420.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70004, 380.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70004, 290.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70004, 310.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70004, 400.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70004, 410.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70004, 510.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70004, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70004, 475.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70004, 320.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70004, 415.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70005, 390.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70005, 370.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70005, 300.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70005, 400.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70005, 300.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70005, 290.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70005, 340.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70005, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70005, 308.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70005, 290.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70005, 250.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70005, 275.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70006, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70006, 500.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70006, 290.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70006, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70006, 500.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70006, 425.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70007, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70007, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70007, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70007, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70007, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70007, 290.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70007, 280.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70007, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70007, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70007, 350.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70007, 310.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70007, 350.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70007, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70008, 425.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70008, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70008, 350.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70008, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70008, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70008, 390.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70008, 325.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70008, 250.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70008, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70008, 285.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70008, 350.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70008, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70008, 310.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70009, 400.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70009, 410.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70009, 400.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70009, 400.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70009, 350.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70009, 290.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70009, 440.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70009, 370.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70009, 300.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70009, 200.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70009, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70009, 450.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70009, 310.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70010, 375.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70010, 305.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70010, 325.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70010, 375.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70010, 395.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70010, 415.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70010, 375.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70010, 475.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70010, 375.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70010, 275.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70010, 375.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70010, 270.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70010, 375.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11014, 70010, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11015, 70010, 250.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11016, 70010, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70011, 325.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70011, 355.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70011, 305.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70011, 455.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70011, 325.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70011, 325.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70011, 325.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70011, 375.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70011, 325.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70011, 425.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70011, 305.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70011, 325.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70011, 325.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11014, 70011, 415.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11015, 70011, 400.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11016, 70011, 390.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11017, 70011, 250.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70012, 405.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70012, 395.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70012, 255.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70012, 405.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70012, 505.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70012, 405.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70012, 405.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70012, 455.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70012, 405.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70012, 405.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70012, 405.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70012, 305.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70012, 295.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11014, 70012, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11015, 70012, 400.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11016, 70012, 350.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11017, 70012, 290.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11018, 70012, 450.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70013, 355.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70013, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70013, 395.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70013, 415.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70013, 355.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70013, 405.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70013, 355.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70013, 555.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70013, 455.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70013, 355.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70013, 355.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70013, 295.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70013, 355.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11014, 70013, 355.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11015, 70013, 300.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11016, 70013, 400.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11017, 70013, 350.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11018, 70013, 405.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11019, 70013, 450.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11001, 70014, 305.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11002, 70014, 425.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11003, 70014, 295.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11004, 70014, 405.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11005, 70014, 375.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11006, 70014, 345.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11007, 70014, 305.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11008, 70014, 405.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11009, 70014, 505.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11010, 70014, 305.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11011, 70014, 355.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11012, 70014, 305.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11013, 70014, 305.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11014, 70014, 415.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11015, 70014, 395.50);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11016, 70014, 250.75);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11017, 70014, 400.25);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11018, 70014, 350.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11019, 70014, 415.00);

INSERT INTO game_sale (game_id, period_id, total)
VALUES (11020, 70014, 550.75);

/**
	INSERT tournament Statements
**/

INSERT INTO tournament (tournament_id, title, prize, fee, team_size, tournament_description, tournament_date)
VALUES (20001, 'Pac-Man Tournament', 50.00, 0.00, 1, 'Who is the best at this classic game?!', '2016-06-15');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Donkey Kong Tournament', 50.00, 0.00, 1, 'Who is the King of the Kongs?!', '2016-06-30');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Street Fighter Tournament', 100.00, 5.00, 1, 'Who is the King of fighters?!', '2016-07-14');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Dance Dance Battle', 100.00, 5.00, 1, 'Try to have the fastest feet!', '2016-07-31');

INSERT INTO tournament (title, prize, fee, team_size, tournament_date)
VALUES ('Asteroids Tournament', 50.00, 1.00, 1, '2016-08-16');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Taiko Takedown', 100.00, 3.00, 1, 'Can you keep the beat?!', '2016-08-31');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Shooting Gallery', 150.00, 5.00, 2, 'Tag-Team. Our biggerst prize yet!', '2016-09-13');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Pokken Tournament', 100.00, 2.50, 2, 'Check out One of our biggest imports!', '2016-09-30');

INSERT INTO tournament (title, prize, fee, team_size, tournament_date)
VALUES ('Racing Tournament', 75.00, 2.00, 1, '2016-10-14');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Sonic Tournament', 50.00, 1.00, 1, 'Gotta go fast!', '2016-10-29');

INSERT INTO tournament (title, prize, fee, team_size, tournament_description, tournament_date)
VALUES ('Flight Simulator Showdown', 150.00, 5.00, 1, 'Check out our most advanced game!', '2016-11-15');

INSERT INTO tournament (title, prize, fee, team_size, tournament_date)
VALUES ('Puzzle Frenzy', 50.00, 1.00, 2, '2016-12-01');

/**
	INSERT tournament game Statements
**/

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20001, 11001);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20002, 11002);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20003, 11004);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20004, 11005);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20004, 11017);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20005, 11003);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20006, 11008);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20007, 11006);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20007, 11015);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20008, 11013);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20009, 11007);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20009, 11019);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20010, 11012);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20011, 11014);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20012, 11001);

INSERT INTO tournament_game (tournament_id, game_id)
VALUES (20012, 11021);

/**
	INSERT joint event Statements
**/

INSERT INTO joint_event (event_id, event_title, event_description, event_date)
VALUES (30001, 'Ice Cream Social', 'Enjoy some Mercurios Ice Cream!', '2016-06-20');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Happy Berry Day', 'Enjoy some frozen yogurt and games!', '2016-07-07');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Pizza Party', 'Mercurios is back with their famous pizza', '2016-07-21');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Half-Priced Games', 'Enjoy discounts sponsored by Nintendo!', '2016-08-08');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Half-Priced Games', 'Enjoy discounts sponsored by Midway!', '2016-08-28');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Half-Priced Games', 'Enjoy discounts sponsored by our Partners!', '2016-09-09');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Ice Cream Social', 'Mercurios is back!', '2016-09-22');

INSERT INTO joint_event (event_title, event_date)
VALUES ('Happy Berry Frozen Yogurt', '2016-10-07');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Half-Priced Games', 'Enjoy discounts sponsored by our Partners!', '2016-11-02');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Half-Priced Games', 'Enjoy discounts sponsored by our Partners!', '2016-12-06');

INSERT INTO joint_event (event_title, event_description, event_date)
VALUES ('Fifty-Cent Games', 'Our end of the year special!', '2016-12-23');

/**
	INSERT event vendor Statements
**/

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30001, 15011);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30002, 15012);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30003, 15011);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30004, 15002);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30005, 15004);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30006, 15006);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30007, 15011);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30008, 15012);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30009, 15007);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30010, 15008);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30010, 15009);

INSERT INTO event_vendor (event_id, vendor_id)
VALUES (30010, 15010);

/**
	SQL Statements
**/

/** Question 1: 	What was the least popular game last month? **/

SELECT game_name, period_month, total
FROM game a JOIN game_sale b
ON a.game_id = b.game_id
JOIN sale_period c
ON c.period_id = b.period_id
WHERE total in (SELECT MIN(total)
				FROM game_sale);
           
           
/** Question 2:    Which country produces most of Ourcade’s games? **/


SELECT vendor_id, country_name
FROM vendor b JOIN country c
ON c.country_id = b.country_id
WHERE vendor_id = (SELECT vendor_id
					FROM game
                    GROUP BY vendor_id
                    ORDER BY COUNT(vendor_id) DESC
                    LIMIT 1);

                    
/** Question 3: 	What is the average price to play a round of a game at OurCade? **/ 


SELECT AVG(game_price)
FROM game;


/** Question 4:		How many machines were added to the roster between June and December? **/


SELECT FLOOR(COUNT(*) - ((SELECT COUNT(*)
					FROM game_sale a JOIN sale_period b
					ON a.period_id = b.period_id
					WHERE period_month = 'June') / 4)) AS Total
FROM game_sale a JOIN sale_period b
ON a.period_id = b.period_id
WHERE period_month = 'December';


/** Question 5:		What were the fees for tournaments with average prizes? **/


SELECT title, prize, tournament_date, fee
FROM tournament
WHERE prize IN (SELECT prize
				FROM tournament
                HAVING AVG(prize));


/** Question 6:		What were the 5 most expensive transactions so far, descending? **/


SELECT invoice_date, vendor_id, amount, invoice_description
FROM invoice
ORDER BY amount DESC
LIMIT 5;


/** Question 7:		Which genre is the most popular? **/


SELECT game_name, genre_name
FROM genre d JOIN game a
ON d.genre_id = a.genre_id
JOIN game_sale b
ON a.game_id = b.game_id
JOIN sale_period c
ON c.period_id = b.period_id
WHERE total in (SELECT MAX(total)
				FROM game_sale);


/** Question 8:		Which vendors have not yet participated in an event? **/


SELECT vendor_name 
FROM vendor
WHERE vendor_name NOT IN (SELECT DISTINCT vendor_name
							FROM vendor a JOIN event_vendor b
							ON a.vendor_id = b.vendor_id
							JOIN  joint_event c
							ON c.event_id = b.event_id);
                            

/** Question 9:		Which game has not yet been featured in a tournament? **/


SELECT game_name 
FROM game
WHERE game_name NOT IN (SELECT DISTINCT game_name
							FROM game a JOIN tournament_game b
							ON a.game_id = b.game_id
							JOIN  tournament c
							ON c.tournament_id = b.tournament_id);
                            

/** Question 10:	What was the most profitable month recorded so far? **/


SELECT period_month, total
FROM game_sale b JOIN sale_period c
ON c.period_id = b.period_id
WHERE total in (SELECT MAX(total)
				FROM game_sale);