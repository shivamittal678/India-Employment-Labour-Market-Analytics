CREATE DATABASE India_Emplyment_Analysis;
USE India_Employement_Analysis;

SELECT *
FROM state_labour_2025;

SELECT *
FROM national_trend;

SELECT COUNT(*)
FROM state_labour_2025;
SELECT DISTINCT Age_Group
FROM state_labour_2025;


-- STATE UNEMPLOYMENT
SELECT Unemployment_Rate_Pct,state
FROM state_labour_2025
WHERE Age_Group='All ages'
AND area='Rural+Urban'
AND sex='Persons'
ORDER BY Unemployment_Rate_Pct DESC;

-- STATE WPR
SELECT Worker_Population_Ratio_Pct,state
FROM state_labour_2025
WHERE area='Rural+Urban'
AND sex='Persons'
AND Age_Group='All ages'
ORDER BY Worker_Population_Ratio_Pct DESC;

-- Compare Youth VS Overall
WITH overall AS
(
	SELECT 
		state,
        Unemployment_Rate_Pct AS overall_ur
        FROM state_labour_2025
        WHERE Age_Group='All ages'
        AND area='Rural+Urban'
        AND sex='Persons'
	),
    youth AS
    (
		SELECT 
			state,
            Unemployment_Rate_Pct AS Youth_UR
            FROM state_labour_2025
            WHERE Age_Group='All ages'
            AND sex='Persons'
            AND area='Rural+Urban'
	)
    SELECT 
    o.state,
    o.overall_ur,
    y.Youth_UR,
    ROUND(y.Youth_UR-o.overall_ur,2)
    AS Youth_UR_Gap
FROM overall o
JOIN youth y
ON o.state=y.state

ORDER BY Youth_UR_Gap DESC;

-- Urban VS Rural
SELECT 
state,
MAX(
	CASE
		WHEN area='Rural'
        THEN Unemployment_Rate_Pct
	END
    ) AS Rural_UR,
    MAX(
		CASE
			WHEN Area='Urban'
			THEN Unemployment_Rate_Pct
		END
	) Urban_UR
    FROM state_labour_2025
    WHERE Age_Group='ALL ages'
    AND sex='Persons'
    GROUP BY state
    ORDER BY Urban_UR DESC;

-- Male VS Female UR
SELECT
	state,
		MAX(
			CASE 
				WHEN sex='Male'
				THEN Unemployment_Rate_Pct
			END
            ) Male_UR,
		MAX(
			CASE
				WHEN sex='Female'
                THEN Unemployment_Rate_Pct
			END
		) Female_UR
	FROM state_labour_2025
    WHERE area='Rural+Urban'
    AND Age_Group='All ages'
    GROUP BY state
    ORDER BY Female_UR DESC;
		
    -- Male VS Female WPR
SELECT
	state,
		MAX(
			CASE 
				WHEN sex='Male'
				THEN Worker_Population_Ratio_Pct
			END
            ) Male_WPR,
		MAX(
			CASE
				WHEN sex='Female'
                THEN Worker_Population_Ratio_Pct
			END
		) Female_WPR
	FROM state_labour_2025
    WHERE area='Rural+Urban'
    AND Age_Group='All ages'
    GROUP BY state
    ORDER BY Female_WPR DESC;
    
-- Region Comparison
SELECT
	Region,
    
    ROUND(
		AVG(Unemployment_Rate_Pct),
        2
	) AS Avg_state_UR,
    
    ROUND(
		AVG(Worker_Population_Ratio_Pct),
        2
	) AS Avg_state_WPR
    FROM state_labour_2025
    WHERE area='Rural+Urban'
    AND sex='Persons'
    AND Age_Group='All ages'
    GROUP BY Region
    ORDER BY Avg_state_UR DESC;
    
SELECT * 
FROM national_trend;

-- Nationa Unmeployment trend
SELECT 
 year,
 Unemployment_Rate_Pct,
 Unemployment_Rate_Pct-
 LAG(Unemployment_Rate_Pct) OVER(
	ORDER BY year
) AS previous_year
FROM national_trend;
    
    
	
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

