CREATE INDEX kills
    ON stats(kills);

CREATE INDEX deaths
    ON stats(deaths);

-- query 1 --> contains 2 nested subquerires
-- This query returns the loadout of the player with the highest kills to deaths ratio.
CREATE VIEW optimal_loadout AS
    SELECT primary_weapon_name, secondary_weapon_name, perk_name
    FROM loadouts
    WHERE username IN(
                SELECT username
                FROM stats USE INDEX(kills, deaths)
                WHERE kills/deaths >= ALL(
                            SELECT kills/deaths
                            FROM stats USE INDEX(kills, deaths)
                )
    );

-- query 2 --> contains a subquery and an order by clause
-- This query creates a leaderboard for all players based on the amount of kills they have.
-- Should a player have 0 kills, they will not appear on the leaderboard.
CREATE VIEW generate_leaderboard AS
    SELECT username AS Leaderboard, kills AS kills
    FROM (
            SELECT username, kills
            FROM stats USE INDEX(kills)
            WHERE kills > 0
    ) player_kills
    ORDER BY kills DESC;

-- query 3 --> containg a group by and having clauses
-- This query creates a table of all the users that have more than one loadout.

CREATE VIEW multiple_loadouts AS
    SELECT username, COUNT(*) AS loadout_count
    FROM loadouts
    GROUP BY username
    HAVING COUNT(*) >= 2;