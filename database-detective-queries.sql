/*
SQL Investigation Case Study
Source: Database Detective: Minor Crimes Division player logs

These representative queries were recovered from the user's game logs and
reformatted for readability. One three-table join was normalized to explicit
JOIN clauses without changing its matching keys. Fictional culprit names and final answers are
omitted. The game uses a custom SQL parser; this is educational project evidence.
*/

-- Filter records using multiple clue conditions.
SELECT *
FROM teachers
WHERE date_joined = 19801024
  AND date_of_birth = 19260617;

-- Connect staff records with timesheets and narrow by multiple conditions.
SELECT *
FROM cops AS d1
JOIN timesheet AS d2
  ON d1.badge_number = d2.badge_number
WHERE d1.security_level = 3
  AND d1.guns_issued >= 1
  AND d2.checkout_time >= 2201;

-- Combine three datasets and progressively narrow the evidence.
SELECT *
FROM attendees AS d1
JOIN lampcon AS d2
  ON d1.id = d2.attendee_id
JOIN dumbcon AS d3
  ON d1.id = d3.attendee_id
WHERE d2.lamps_brought = 6
  AND d3.dumbs_brought = 8;

-- Aggregate order value and tips into reusable intermediate results.
SELECT order_number, SUM(price) AS total_harga
FROM orders
GROUP BY order_number;

SELECT order_number, SUM(dollars_tipped) AS total_tipped
FROM tips
GROUP BY order_number;

-- Join intermediate results, calculate a ratio, and rank candidates.
SELECT
    d1.order_number,
    d2.total_tipped / d1.total_harga AS percentage_tips
FROM result_1 AS d1
JOIN result_2 AS d2
  ON d1.order_number = d2.order_number
ORDER BY percentage_tips DESC;

-- Calculate total nutrient quantity after joining item and reference tables.
SELECT
    d2.nutrient,
    SUM(d1.quantity_purchased * d2.nutrient_quantity) AS total_quantity
FROM order_74b8s AS d1
JOIN nutrition_facts AS d2
  ON d1.item_name = d2.item_name
GROUP BY d2.nutrient;

-- Filter textual clues, aggregate payments, and apply a group threshold.
SELECT
    payup_account,
    SUM(amount) AS total_donation
FROM payup_cashboys
WHERE note LIKE '%member%'
   OR note LIKE '%donation%'
GROUP BY payup_account
HAVING SUM(amount) > 75;

-- Join an aggregated result back to membership records.
SELECT *
FROM result_3 AS d1
JOIN members_CASH AS d2
  ON d1.payup_account = d2.player_name;

-- Connect people, driver, and neighborhood evidence.
SELECT *
FROM patriots AS d1
JOIN drivers AS d2
  ON d1.first_name = d2.first_name
JOIN result_2 AS d3
  ON d2.neighborhood = d3.neighborhood;
