--- QUERY 4
--- This query examines the metadata for SafeGraph's Free Open Census Data.
--- These are used when joining census data to SafeGraph data in queries 5-7.

--- It specifically looks for column names associated with B19, which is the table_id
--- associated with income data in the census.
--- Uncommenting Row 18 will return the census column names for median household income.

--- Requires the SafeGraph Open Census Data as a SHARE

SELECT 
    table_id
    ,field_full_name
    ,field_level_1
    ,field_level_2
    ,field_level_3
FROM CBG.PUBLIC.METADATA_CBG_FIELD_DESCRIPTIONS
WHERE table_id LIKE 'B19%'
//  AND field_full_name LIKE 'MEDIAN%'