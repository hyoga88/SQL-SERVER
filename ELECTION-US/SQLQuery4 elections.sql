SELECT * 
FROM dbo.electionus;
---ANNEE DISPONIBLES---
SELECT COUNT(*) AS Total_Lignes
FROM dbo.electionus;
---ETATS DISTINCTS---
SELECT DISTINCT Election_Year
FROM dbo.electionus
ORDER BY Election_Year;

SELECT DISTINCT State
FROM dbo.electionus
ORDER BY State;
---NOMBRE D ELECTIONS PAR ANNEE---
SELECT Election_Year, COUNT(*) AS Nombre_Elections
FROM dbo.electionus
GROUP BY Election_Year
ORDER BY Election_Year;
---NOMBRE D ELECTIONS PAR ETAT---
SELECT State, COUNT(*) AS Nombre
FROM dbo.electionus
GROUP BY State
ORDER BY Nombre DESC;
---REPARTITION HOMME/FEMME---
SELECT Sex, COUNT(*) AS Total
FROM dbo.electionus
GROUP BY Sex;
---REPARTITION AGE---
SELECT Age_Range, COUNT(*) AS Total
FROM dbo.electionus
GROUP BY Age_Range
ORDER BY Total DESC;
---NOMBRE DE FOIS UN CANDIDAT ELU---
SELECT Candidate_Supported, COUNT(*) AS Total
FROM dbo.electionus
GROUP BY Candidate_Supported
ORDER BY Total DESC;
---ETAT FAVORISANT L INCUMBEMENT---
SELECT State, COUNT(*) AS Favorise_Incumbent
FROM dbo.electionus
WHERE Laws_Favored_Incumbent = 'Yes'
GROUP BY State
ORDER BY Favorise_Incumbent DESC;
---MOYENNE ELECTORAL INTEGRITER---
SELECT Election_Year,
       AVG(CAST(Electoral_Authorities_Index AS FLOAT)) AS Moyenne_Index
FROM dbo.electionus
GROUP BY Election_Year
ORDER BY Election_Year;
---MOYENNE VOTE PAR ETAT---
SELECT State,
       AVG(CAST(Voting_Process_Index AS FLOAT)) AS Moyenne_Voting
FROM dbo.electionus
GROUP BY State
ORDER BY Moyenne_Voting DESC;
---ELECTIONS AVEC PROTESTATION---
SELECT Election_Year, State
FROM dbo.electionus
WHERE Protests_Violent = 'Yes';
---RESULTAT CONTESTER---
SELECT *
FROM dbo.electionus
WHERE Results_Challenged = 'Yes';
---TOP 10 ETAT AVEC MEILLEUR VOTE---
SELECT TOP 10 State, Voting_Process_Index
FROM dbo.electionus
ORDER BY CAST(Voting_Process_Index AS FLOAT) DESC;
---TOP 10 ETAT AVEC PIRE INTEGRITER---
SELECT TOP 10 State, Election_Year, Electoral_Authorities_Index
FROM dbo.electionus
ORDER BY CAST(Electoral_Authorities_Index AS FLOAT) ASC;
---CORRELATION MEDIA VS INTEGRITER---
SELECT 
    AVG(CAST(Media_Coverage_Index AS FLOAT)) AS Moyenne_Media,
    AVG(CAST(Electoral_Authorities_Index AS FLOAT)) AS Moyenne_Integrity
FROM dbo.electionus;
---ETATS AVEC LE PLUS DE PROBLEMES--- 
SELECT State,
       SUM(CASE WHEN Protests_Violent = 'Yes' THEN 1 ELSE 0 END) +
       SUM(CASE WHEN Results_Challenged = 'Yes' THEN 1 ELSE 0 END) AS Score_Problemes
FROM dbo.electionus
GROUP BY State
ORDER BY Score_Problemes DESC;
---ETATS AVEC MEILLEURS INDICATEURS ELECTORAUX---
SELECT 
    State,
    AVG(CAST(Voting_Process_Index AS FLOAT)) AS Voting_Index,
    AVG(CAST(Electoral_Authorities_Index AS FLOAT)) AS Authorities_Index,
    AVG(CAST(Media_Coverage_Index AS FLOAT)) AS Media_Index,
    AVG(CAST(Vote_Count_Index AS FLOAT)) AS Count_Index,
    
    (
        AVG(CAST(Voting_Process_Index AS FLOAT)) +
        AVG(CAST(Electoral_Authorities_Index AS FLOAT)) +
        AVG(CAST(Media_Coverage_Index AS FLOAT)) +
        AVG(CAST(Vote_Count_Index AS FLOAT))
    ) / 4 AS Score_Democratie
FROM dbo.electionus
GROUP BY State
ORDER BY Score_Democratie DESC;
---CORRELATION MEDIA VS INTEGRITER---
SELECT 
    AVG(CAST(Media_Coverage_Index AS FLOAT)) AS Moyenne_Media,
    AVG(CAST(Electoral_Authorities_Index AS FLOAT)) AS Moyenne_Integrity
FROM dbo.electionus;
---COMPARE MEDIA VS INTEGRITER--
SELECT 
    State,
    AVG(CAST(Media_Coverage_Index AS FLOAT)) AS Media,
    AVG(CAST(Electoral_Authorities_Index AS FLOAT)) AS Integrity
FROM dbo.electionus
GROUP BY State
ORDER BY Media DESC;
---VIOLENCE VS CONTESTATIONS---
SELECT 
    Protests_Violent,
    Results_Challenged,
    COUNT(*) AS Total
FROM dbo.electionus
GROUP BY Protests_Violent, Results_Challenged
ORDER BY Total DESC;
---NOMBRE DE CONTESTATIONS VS VIOLENCE---
SELECT 
    Protests_Violent,
    SUM(CASE WHEN Results_Challenged = 'Yes' THEN 1 ELSE 0 END) AS Contestations
FROM dbo.electionus
GROUP BY Protests_Violent;
---MARGE DE DEMOCRATIE---
SELECT 
    Election_Year,
    AVG(CAST(Electoral_Authorities_Index AS FLOAT)) AS Moyenne_Integrity
FROM dbo.electionus
GROUP BY Election_Year
ORDER BY Election_Year;
---CITOYEN VS 
SELECT 
    Citizen,
    COUNT(*) AS Total
FROM dbo.electionus
GROUP BY Citizen;