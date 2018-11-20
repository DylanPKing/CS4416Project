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

