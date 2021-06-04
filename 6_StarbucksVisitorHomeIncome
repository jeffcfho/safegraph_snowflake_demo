--- QUERY 6
--- This query shows the visitor home neighborhoods of the two Starbucks identified in Query 1 
--- and adds a column showing household median income of that home neighborhood.

--- This is used in Query 7 to calculate average household median income of visitors for each location,
--- weighted by the number of visitors from each home neighborhood.
--- See Query 4 for the census column names used to generate the income groupings.

--- Requires the Starbucks SafeGraph Sample and the SafeGraph Open Census Data as SHARES

WITH exploded AS (
  SELECT 
      patterns.placekey
      ,patterns.location_name
      ,patterns.city
      ,expl.KEY as visitor_home_cbg
      ,expl.VALUE as visitor_count
  FROM 
      (SELECT * FROM STARBUCKS_PATTERNS_SAMPLE.PUBLIC.PATTERNS) as patterns, 
      table(flatten(input => PARSE_JSON(patterns.VISITOR_HOME_CBGS))) as expl
  WHERE placekey in ('222-224@5z5-3t2-3wk','zzw-223@5z4-rcm-4gk')
  )
SELECT exploded.*
       ,B19013e1 as hh_median_income
FROM exploded
JOIN CBG.PUBLIC.DATA_CBG_B19 as cbg
  ON exploded.visitor_home_cbg = cbg.census_block_group