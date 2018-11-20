-- query 1 --> contains 2 nested subquerires
-- This query returns the loadout of the player with the highest kills to deaths ratio.
SELECT primary_weapon_name, secondary_weapon_name, perk_name
FROM loadouts
WHERE username IN(
            SELECT username
            FROM stats
            WHERE kills/deaths >= ALL(
                        SELECT kills/deaths
                        FROM stats
            )
)

-- query 2 --> contains a subquery and an order by clause
-- This query creates a leaderboard for all players based on the amount of kills they have.
-- Should a player have 0 kills, they will not appear on the leaderboard.
SELECT username AS Leaderboard, kills AS kills
FROM (
                SELECT username, kills
                FROM stats
                WHERE kills > 0
) player_kills
ORDER BY kills DESC

-- query 3 --> containg a group by and having clauses
-- This query creates a table of the weapons that are currently in any players loadout.
SELECT primary_weapon_name
FROM primary_weapons
GROUP BY primary_weapon_name
HAVING primary_weapon_name IN(
                SELECT primary_weapon_name
                FROM loadouts)
