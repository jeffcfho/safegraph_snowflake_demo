--- QUERY 1
--- This query finds all Starbucks in California and sorts by those that have the 
--- highest percentage of visitors spending 121-240 minutes.
--- Uncommenting out Line 36 sorts by visitors spending 5-10 minutes.

--- Two specific Starbucks in Los Angeles are identified by placekeys with these queries.

--- Requires the Starbucks SafeGraph Sample as a SHARE

WITH exploded AS (
  SELECT 
      patterns.*
      ,expl.KEY as dwell_time
      ,100 * expl.VALUE / raw_visit_counts as visit_pct
  FROM 
      (SELECT * FROM STARBUCKS_PATTERNS_SAMPLE.PUBLIC.PATTERNS) as patterns, 
      TABLE(FLATTEN(input => PARSE_JSON(patterns.bucketed_dwell_times))) as expl
  )
SELECT placekey, street_address, city, region, distance_from_home, postal_code
       ,raw_visit_counts
       ,"'<5'" as "pct_<5"
       ,"'5-10'" as "pct_5-10"
       ,"'11-20'" as "pct_11-20"
       ,"'21-60'" as "pct_21-60"
       ,"'61-120'" as "pct_61-120"
       ,"'121-240'" as "pct_121-240"
       ,"'>240'" as "pct_>240"
FROM exploded
  PIVOT (
      MAX(visit_pct) 
      FOR dwell_time 
      IN ('<5','5-10','11-20','21-60','61-120','121-240','>240')
  ) 
WHERE raw_visit_counts > 1000
  AND region = 'CA'
ORDER BY "pct_121-240" DESC // LIMIT 1 (in L.A.): 222-224@5z5-3t2-3wk
//ORDER BY "pct_5-10" DESC // 4TH one (in L.A.): zzw-223@5z4-rcm-4gk