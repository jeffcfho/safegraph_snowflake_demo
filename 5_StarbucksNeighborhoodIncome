--- QUERY 5
--- This query compares and contrasts the two Starbucks identified in Query 1 by the income
--- information for the census block group each are located in.

--- The Duarte Starbucks is located in a census block group with a lower median household income (57k),
--- with the majority of households making less than (60k)
--- The Orange Starbucks is located in a census block group with a higher median household income (97k),
--- with the majority of households making more than 100k.

--- See Query 4 for the census column names used to generate the income groupings.

--- Requires the Starbucks SafeGraph Sample and the SafeGraph Open Census Data as SHARES

SELECT placekey
       ,location_name
       ,city
       ,poi_cbg
       ,B19013e1 as median_hh_income
       ,B19001e2 + B19001e3 + B19001e4+B19001e5 + B19001e6 + B19001e7 + B19001e8 + B19001e9 + B19001e10 + B19001e11 as hh_income_lt_60k
       ,B19001e12 + B19001e13 as hh_income_60k_to_100k
       ,B19001e14 + B19001e15 + B19001e16 + B19001e17 as hh_income_gte_100k
FROM STARBUCKS_PATTERNS_SAMPLE.PUBLIC.PATTERNS as patterns
JOIN CBG.PUBLIC.DATA_CBG_B19 as cbg
  ON patterns.poi_cbg = cbg.census_block_group
WHERE placekey in ('222-224@5z5-3t2-3wk','zzw-223@5z4-rcm-4gk')