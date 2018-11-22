DELIMITER //
CREATE PROCEDURE statProcedure(
    IN a VARCHAR(128),
    IN b INT(11),
    IN C INT(11),
    IN d INT(11)
)
BEGIN
    INSERT INTO stats(username, kills, deaths, assists) 
    VALUES (a, b, c, d); 
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
    
    
    SELECT SUM(kills) INTO total_kills FROM stats WHERE kills > 0;
    SELECT SUM(deaths) INTO total_deaths FROM stats;
                 
    SET average = total_kills/total_deaths;
    RETURN average;
END;//

DELIMITER //
CREATE TRIGGER avg_kd
    AFTER UPDATE ON stats
    FOR EACH ROW
BEGIN
    DECLARE averagekills DOUBLE;
    SELECT averagekd() INTO averagekills;
END;
//