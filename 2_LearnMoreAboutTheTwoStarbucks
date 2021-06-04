--- QUERY 2
--- This query compares and contrasts the two Starbucks identified in Query 1.

--- The Duarte Starbucks has visitors travel from much further (distance_from_home = 32km) and stay 
--- much longe (median_dwell = 98 mins) rvs the Orange Starbucks (distance_from_home = 4.7km;
--- median_dwell = 9 mins).

--- If you look up either address on Google StreetView, you'll see that the Duarte Starbucks is located
--- in a hospital while the Orange Starbucks is located near a highway in a strip mall.

--- Requires the Starbucks SafeGraph Sample as a SHARE

SELECT 
    placekey
    ,location_name
    ,street_address
    ,city
    ,region
    ,postal_code
    ,poi_cbg
    ,raw_visit_counts
    ,raw_visitor_counts
    ,distance_from_home
    ,median_dwell
    ,popularity_by_hour
FROM STARBUCKS_PATTERNS_SAMPLE.PUBLIC.PATTERNS
WHERE placekey in ('222-224@5z5-3t2-3wk','zzw-223@5z4-rcm-4gk')