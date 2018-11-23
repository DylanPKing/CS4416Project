--Procedure to insert into the stats table
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

--Trigger to call the statProcedure after inserting into the account table
DELIMITER //
CREATE TRIGGER makeStats
    AFTER INSERT ON Accounts 
    FOR EACH ROW 
BEGIN 
    CALL statProcedure(NEW.username, 0, 0, 0);
END; //

--Function to calculate the total kills and total deaths in the stats table.
--Returns the result of total kills divided by total deaths
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

--Trigger to call the averagekd function after the stats table has been updated
DELIMITER //
CREATE TRIGGER avg_kd
    AFTER UPDATE ON stats
    FOR EACH ROW
BEGIN
    DECLARE averagekills DOUBLE;
    SELECT averagekd() INTO averagekills;
END;
//