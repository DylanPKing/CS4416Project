DELIMiTER//
CREATE TRIGGER makeStats
    AFTER INSERT ON Accounts
BEGIN
    INSERT INTO stats(username, kills, deaths, assists) VALUES
    (NEW.username, 0, 0, 0);
END;