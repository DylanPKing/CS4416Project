DELIMITER //
CREATE FUNCTION averagekd
    RETURNS DOUBLE
READS SQL DATA
BEGIN
    DECLARE average DOUBLE
    SET average =  (SELECT FORMAT(SUM kills)
                    FROM stats)/
                    (SELECT FORMAT(SUM deaths)
                     FROM stats)
    RETURN average
END;//

DELIMITER//
CREATE TRIGGER avg_kd
    AFTER UPDATE ON stats
    FOR EACH ROW
    CALL averagekd
END;//

DELIMITER //
CREATE PROCEDURE statProcedure()
BEGIN
    INSERT INTO stats(username, kills, deaths, assists) 
    VALUES (NEW.username, 0, 0, 0); 
END; //

DELIMITER //
CREATE TRIGGER makeStats
    AFTER INSERT ON Accounts 
    FOR EACH ROW 
BEGIN 
    CALL statProcedure(NEW.username, 0, 0, 0);
END; //




DELIMITER //
CREATE FUNCTION averagekd()
	RETURNS DOUBLE
    DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE average DOUBLE;
    DECLARE total_kills DOUBLE;
    DECLARE total_deaths DOUBLE;
    
    SET total_kills = (SELECT SUM(kills) FROM stats WHERE kills > 0);
    SET total_deaths = (SELECT SUM(deaths) FROM stats);
                 
    SET average = kills/deaths;
    RETURN average;
END;//