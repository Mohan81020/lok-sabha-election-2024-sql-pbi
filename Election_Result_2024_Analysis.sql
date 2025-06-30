/* 
===================================================================
 Project:        Indian Lok Sabha Election 2024 - SQL Analysis
 Author:         Mohan Kumar
 Description:    This script analyzes the 2024 lok sabha election 
                 dataset using various SQL techniques including 
                 basic, intermediate, and advanced SQL queries.

===================================================================
*/

-- Create and use the database

CREATE DATABASE Election_Result;
USE Election_Result;

-- View the raw data

SELECT * FROM election_result_2024;

-- Total number of records

SELECT COUNT(*) AS Total_Records
FROM election_result_2024;

-- Total records with missing candidate names

SELECT COUNT(*) AS Total_Null_Candidate
FROM election_result_2024
WHERE candidate_name IS NULL OR candidate_name = '';

-- Total records with missing EVM votes

SELECT COUNT(*) AS Null_EVM_Votes
FROM election_result_2024
WHERE EVM_votes IS NULL
GROUP BY EVM_votes;

-- Total records with missing Total votes

SELECT COUNT(*) AS Null_Total_Votes
FROM election_result_2024
WHERE total_votes IS NULL
GROUP BY total_votes;

-- Remove duplicate records with NULL vote data

DELETE FROM election_result_2024
WHERE EVM_votes IS NULL AND total_votes IS NULL;

-- Count of unique constituencies

SELECT COUNT(DISTINCT constituency_name) AS Total_Constituencies
FROM election_result_2024;

-- Count of unique political parties

SELECT COUNT(DISTINCT party_name) AS Total_Parties
FROM election_result_2024;

-- State-wise total constituencies

SELECT state_name, COUNT(DISTINCT constituency_name) AS Total_Constituencies
FROM election_result_2024
GROUP BY state_name
ORDER BY Total_Constituencies DESC;

-- State-wise total political parties

SELECT state_name, COUNT(DISTINCT party_name) AS Total_Parties
FROM election_result_2024
GROUP BY state_name
ORDER BY Total_Parties DESC;

-- Constituency-wise count of parties

SELECT state_name, constituency_name, COUNT(DISTINCT party_name) AS Total_Parties
FROM election_result_2024
GROUP BY state_name, constituency_name
ORDER BY Total_Parties DESC;

-- Party-wise count of candidates

SELECT party_name, COUNT(DISTINCT candidate_name) AS Total_Candidates
FROM election_result_2024
GROUP BY party_name
ORDER BY Total_Candidates DESC;

-- Party and State-wise seat count

SELECT party_name, state_name, COUNT(*) AS Total_Seats
FROM election_result_2024
GROUP BY party_name, state_name
ORDER BY party_name, Total_Seats DESC;

-- Party and State-wise seat count 

SELECT party_name, state_name, COUNT(*) AS Total_Seats
FROM election_result_2024
WHERE party_name = 'Bharatiya Janata Party'
GROUP BY party_name, state_name
ORDER BY Total_Seats DESC;

-- Total voting summary

SELECT 
    SUM(EVM_votes) AS Total_EVM_Votes,
    SUM(postal_votes) AS Total_Postal_Votes,
    SUM(total_votes) AS Total_Votes,
    ROUND(SUM(EVM_votes) * 100.0 / SUM(total_votes), 2) AS Percentage_EVM_Voting,
    ROUND(SUM(postal_votes) * 100.0 / SUM(total_votes), 2) AS Percentage_Postal_Voting
FROM election_result_2024;

-- Top 5 parties by seats won

SELECT TOP 5 party_name, COUNT(*) AS Seat_Won
FROM election_result_2024
WHERE rank = 1
GROUP BY party_name
ORDER BY Seat_Won DESC;

-- Count of Independent candidates

SELECT COUNT(*) AS Independent_Candidates
FROM election_result_2024
WHERE party_name = 'Independent';

-- Vote count for key candidates

SELECT candidate_name, SUM(total_votes) AS Total_Votes
FROM election_result_2024
WHERE candidate_name IN ('AMIT SHAH', 'NARENDRA MODI')
GROUP BY candidate_name
ORDER BY Total_Votes DESC;

-- Parties contesting in more than 10 constituencies

SELECT party_name, COUNT(*) AS Constituencies_Contested
FROM election_result_2024
GROUP BY party_name
HAVING COUNT(*) > 10
ORDER BY Constituencies_Contested DESC;

-- State-wise seat wins by party

SELECT state_name, party_name, COUNT(*) AS Seat_Won
FROM election_result_2024
WHERE rank = 1
GROUP BY state_name, party_name
ORDER BY Seat_Won DESC;

-- Vote share % of each party

SELECT 
    party_name,
    SUM(total_votes) AS Total_Votes,
    ROUND(SUM(total_votes) * 100.0 / (SELECT SUM(total_votes) FROM election_result_2024), 2) AS Vote_Share_Percentage
FROM election_result_2024
GROUP BY party_name
ORDER BY Vote_Share_Percentage DESC;

-- Top 3 parties by total votes in Andhra Pradesh

SELECT TOP 3 party_name, SUM(total_votes) AS Total_Votes
FROM election_result_2024
WHERE state_name = 'Andhra Pradesh'
GROUP BY party_name
ORDER BY Total_Votes DESC;

-- Top 3 parties by total votes in Bihar

SELECT TOP 3 party_name, SUM(total_votes) AS Total_Votes
FROM election_result_2024
WHERE state_name = 'Bihar'
GROUP BY party_name
ORDER BY Total_Votes DESC;

-- Margin of victory in each constituency

WITH RankedVotes AS (
    SELECT 
        state_name,
        constituency_name,
        total_votes,
        RANK() OVER (PARTITION BY constituency_name ORDER BY total_votes DESC) AS Vote_Rank
    FROM election_result_2024
)
SELECT 
    A.state_name,
    A.constituency_name,
    (A.total_votes - B.total_votes) AS Vote_Margin,
    ROUND((A.total_votes - B.total_votes) * 100.0 / A.total_votes, 2) AS Percentage_Margin
FROM RankedVotes A
JOIN RankedVotes B
    ON A.constituency_name = B.constituency_name
    AND A.Vote_Rank = 1 AND B.Vote_Rank = 2
ORDER BY Percentage_Margin DESC;

-- Candidates with closest victory margins (<1000 votes)

WITH Rank_CTE AS (
    SELECT 
        state_name,
        constituency_name,
        candidate_name,
        total_votes,
        RANK() OVER (PARTITION BY constituency_name ORDER BY total_votes DESC) AS Vote_Rank
    FROM election_result_2024
)
SELECT 
    A.constituency_name,
    A.state_name,
    A.candidate_name AS Winner,
    B.candidate_name AS Runner_Up,
    (A.total_votes - B.total_votes) AS Margin
FROM Rank_CTE A
JOIN Rank_CTE B
    ON A.constituency_name = B.constituency_name
    AND A.Vote_Rank = 1 AND B.Vote_Rank = 2
WHERE (A.total_votes - B.total_votes) < 1000;

-- Election summary table (Winner, Runner-up, Margin)

WITH Election_CTE AS (
    SELECT 
        state_name,
        constituency_name,
        party_name,
        candidate_name,
        total_votes,
        RANK() OVER (PARTITION BY constituency_name ORDER BY total_votes DESC) AS Vote_Rank
    FROM election_result_2024
)
SELECT 
    A.constituency_name,
    A.state_name,
    A.party_name AS Winner_Party,
    B.party_name AS Runner_Up_Party,
    (A.total_votes - B.total_votes) AS Vote_Margin,
    ROUND((A.total_votes - B.total_votes) * 100.0 / A.total_votes, 2) AS Percentage_Margin,
    A.candidate_name AS Winner_Candidate
FROM Election_CTE A
JOIN Election_CTE B
    ON A.constituency_name = B.constituency_name
    AND A.Vote_Rank = 1 AND B.Vote_Rank = 2
ORDER BY Percentage_Margin DESC;

------------------------------- End ------------------------------------
