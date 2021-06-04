--- QUERY 3
--- This query compares and contrasts the two Starbucks identified in Query 1 by hourly visit rate.

--- The Duarte Starbucks reaches a daily peak at around 9am and stays high until 3pm until declining.
--- The Orange Starbucks doesn't peak until 3pm, and moreover has a second mini-peak around 6-7pm.

--- Requires the Starbucks SafeGraph Sample as a SHARE

WITH patterns AS (
  SELECT * 
  FROM STARBUCKS_PATTERNS_SAMPLE.PUBLIC.PATTERNS 
  WHERE placekey in ('222-224@5z5-3t2-3wk','zzw-223@5z4-rcm-4gk')
  ),
exploded AS (
  SELECT
      patterns.placekey
      ,patterns.location_name
      ,patterns.city
      ,expl.INDEX as hour
      ,expl.VALUE as visits
  FROM 
      patterns,
      TABLE(FLATTEN(input => PARSE_JSON(patterns.popularity_by_hour))) as expl
  )
SELECT *
FROM exploded
PIVOT (
  MAX(visits) 
  FOR hour 
  IN ('0','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23')
) as p (placekey, location_name, city, "H0","H1","H2","H3","H4","H5","H6","H7","H8","H9","H10","H11","H12","H13","H14","H15","H16","H17","H18","H19","H20","H21","H22","H23")