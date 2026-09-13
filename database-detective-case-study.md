# SQL Investigation in Database Detective

**Context:** A relational querying case study based on *Database Detective: Minor Crimes Division*, an educational game with fictional cases and data.

## Objective

Use database evidence to identify the responsible party in each simulated case. The work required translating narrative clues into filters, deciding which tables contained relevant evidence, connecting records through keys, and checking intermediate results before reaching a conclusion.

## Evidence reviewed

The game save and four player logs were inspected after completion. They contain success markers for Cases 1 through 7 and 101 distinct logged query strings. The saved state reports the current and maximum unlocked level as 7. Culprit names are omitted here because the game randomizes case data and the portfolio should emphasize the method.

## SQL demonstrated

- Filtering with `WHERE`, comparisons, `AND`, `OR`, and `LIKE`
- Single-table and multi-table `JOIN` operations
- Aggregations with `SUM`, `AVG`, `MAX`, and `COUNT`
- Group-level analysis with `GROUP BY` and `HAVING`
- Calculated fields and result ranking with `ORDER BY`
- Reusing intermediate result tables in later steps
- Iterative debugging of join conditions, column references, thresholds, grouping, and calculation direction

No evidence of CTEs, subqueries, window functions, `UNION`, `INTERSECT`, or `EXCEPT` was found, so these are not claimed.

## Investigation example 1

One case required comparing total order value with tips. The query history shows an iterative path:

1. Aggregate item prices by order.
2. Aggregate tips by order.
3. Join both intermediate results on `order_number`.
4. Calculate a ratio and sort it.
5. Correct the direction of the calculation after inspecting the result.

The final relevant structure was:

```sql
SELECT
    d1.order_number,
    d2.total_tipped / d1.total_harga AS percentage_tips
FROM result_1 AS d1
JOIN result_2 AS d2
    ON d1.order_number = d2.order_number
ORDER BY percentage_tips DESC;
```

This sequence is useful evidence because it shows query revision and validation, rather than only a copied final answer.

## Investigation example 2

Another case combined textual clues, donation totals, membership records, rental information, and driver data. The work included filtering notes with two `LIKE` conditions, grouping payments by account, applying a `HAVING` threshold, and joining the filtered results to membership data. A later query connected three sources:

```sql
SELECT *
FROM patriots AS d1
JOIN drivers AS d2
    ON d1.first_name = d2.first_name
JOIN result_2 AS d3
    ON d2.neighborhood = d3.neighborhood;
```

The query log also records a changed donation threshold and an additional availability condition, demonstrating progressive narrowing based on evidence.

## Validation and limitations

Case completion is supported by the game's own `isCorrect? True` markers for Cases 1–7. The save file records five general hints and zero query hints at the current saved state; this is included as context, not as a performance claim. Logs contain unsuccessful and corrected queries alongside successful ones. The game uses a custom SQL parser, so this project demonstrates relational reasoning and core querying skills but does not establish production database experience or advanced SQL proficiency.

## Portfolio positioning

Present this under Projects as **SQL Investigation Case Study**, with the educational-game context visible. Pair it with the curated query file and this explanation. Do not list it under Employment Experience.
