# safegraph_snowflake_demo
These are SQL scripts for a demo of SafeGraph's Patterns data in Snowflake

Once you have the Starbucks SafeGraph Sample and the SafeGraph Open Census Data as SHARES in Snowflake, execute the scripts in the following order:

## 1_FindTwoStarbucksByDwellTime

| PLACEKEY | STREET_ADDRESS | CITY | REGION | DISTANCE_FROM_HOME | POSTAL_CODE | RAW_VISIT_COUNTS | pct_<5 | pct_5-10 | pct_11-20 | pct_21-60 | pct_61-120 | pct_121-240 | pct_>240 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 222-224@5z5-3t2-3wk | 1500 Duarte Rd | Duarte | CA | 31793 | 91010 | 1672 | 0.8373205742 | 5.741626794 | 8.971291866 | 20.633971292 | 20.873205742 | 19.078947368 | 23.863636364 |
| 22h-222@5z5-3qr-psq | 1120 W 6th St # 102 | Los Angeles | CA | 3073 | 90017 | 1616 | 1.670792079 | 15.903465347 | 13.551980198 | 18.254950495 | 11.757425743 | 10.51980198 | 28.341584158 |
| zzw-222@5z6-3r6-59f | 1437 E Gage Ave | Los Angeles | CA | 2621 | 90001 | 1121 | 1.873327386 | 23.193577163 | 14.629794826 | 21.855486173 | 9.545049063 | 9.366636931 | 19.536128457 |
| zzw-225@5z4-mws-835 | 7855 Kew Ave | Rancho Cucamonga | CA | 11119 | 91739 | 1111 | 1.530153015 | 11.97119712 | 15.121512151 | 38.883888389 | 13.321332133 | 9.270927093 | 9.900990099 |
| zzy-226@5vh-rxn-vj9 | 3401 Dale Road 244 Vintage Faire Mall | Modesto | CA | 18242 | 95356 | 1556 | 3.084832905 | 17.030848329 | 20.179948586 | 34.061696658 | 10.218508997 | 8.547557841 | 6.876606684 |
| ... |  |  |  |  |  |  |  |  |  |  |  |  |  |

## 2_LearnMoreAboutTheTwoStarbucks

| PLACEKEY | LOCATION_NAME | STREET_ADDRESS | CITY | REGION | POSTAL_CODE | POI_CBG | RAW_VISIT_COUNTS | RAW_VISITOR_COUNTS | DISTANCE_FROM_HOME | MEDIAN_DWELL | POPULARITY_BY_HOUR |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 222-224@5z5-3t2-3wk | Starbucks | 1500 Duarte Rd | Duarte | CA | 91010 | 060374301021 | 1672 | 489 | 31793 | 98 | [    46,    36,    34,    35,    35,    59,    133,    286,    471,    583,    598,    566,    576,    592,    578,    476,    349,    277,    190,    144,    88,    63,    60,    55  ] |
| zzw-223@5z4-rcm-4gk | Starbucks | 2734 N Tustin St | Orange | CA | 92865 | 060590762023 | 1039 | 705 | 4765 | 9 | [    4,    3,    2,    2,    10,    19,    48,    57,    56,    89,    75,    85,    96,    98,    120,    88,    75,    56,    78,    73,    60,    44,    24,    3  ] |

## 3_HourlyVisitRate

| PLACEKEY | LOCATION_NAME | CITY | H0 | H1 | H2 | H3 | H4 | H5 | H6 | H7 | H8 | H9 | H10 | H11 | H12 | H13 | H14 | H15 | H16 | H17 | H18 | H19 | H20 | H21 | H22 | H23 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| zzw-223@5z4-rcm-4gk | Starbucks | Orange | 4 | 3 | 2 | 2 | 10 | 19 | 48 | 57 | 56 | 89 | 75 | 85 | 96 | 98 | 120 | 88 | 75 | 56 | 78 | 73 | 60 | 44 | 24 | 3 |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 46 | 36 | 34 | 35 | 35 | 59 | 133 | 286 | 471 | 583 | 598 | 566 | 576 | 592 | 578 | 476 | 349 | 277 | 190 | 144 | 88 | 63 | 60 | 55 |

When plotted, the hourly data should look like this:

![image](https://user-images.githubusercontent.com/12406049/120870089-ff44cd80-c565-11eb-9de4-bc32480339d8.png)
```python
import matplotlib.pyplot as plt
duarte = [ 46, 36, 34, 35, 35, 59, 133, 286, 471, 583, 598, 566, 576, 592, 578, 476, 349, 277, 190, 144, 88, 63, 60, 55 ]
orange = [ 4, 3, 2, 2, 10, 19, 48, 57, 56, 89, 75, 85, 96, 98, 120, 88, 75, 56, 78, 73, 60, 44, 24, 3 ]
plt.plot(range(24),[x/sum(duarte) for x in duarte],label='Duarte')
plt.plot(range(24),[x/sum(orange) for x in orange],label='Orange')
plt.xlabel('Hour of day')
plt.ylabel('Normalized popularity_by_hour')
plt.legend()
plt.show()
```

## 4_LookUpCensusIncomeColumns

| TABLE_ID | FIELD_FULL_NAME | FIELD_LEVEL_1 | FIELD_LEVEL_2 | FIELD_LEVEL_3 |
| --- | --- | --- | --- | --- |
| B19001e1 | HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS): Total: Households -- (Estimate) | Household Income In The Past 12 Months (In 2016 Inflation-Adjusted Dollars) |  Total |  Households -- (Estimate) |
| B19001e10 | HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS): $45,000 to $49,999: Households -- (Estimate) | Household Income In The Past 12 Months (In 2016 Inflation-Adjusted Dollars) |  $45,000 To $49,999 |  Households -- (Estimate) |
| B19001e11 | HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS): $50,000 to $59,999: Households -- (Estimate) | Household Income In The Past 12 Months (In 2016 Inflation-Adjusted Dollars) |  $50,000 To $59,999 |  Households -- (Estimate) |
| B19001e12 | HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS): $60,000 to $74,999: Households -- (Estimate) | Household Income In The Past 12 Months (In 2016 Inflation-Adjusted Dollars) |  $60,000 To $74,999 |  Households -- (Estimate) |
| B19001e13 | HOUSEHOLD INCOME IN THE PAST 12 MONTHS (IN 2016 INFLATION-ADJUSTED DOLLARS): $75,000 to $99,999: Households -- (Estimate) | Household Income In The Past 12 Months (In 2016 Inflation-Adjusted Dollars) |  $75,000 To $99,999 |  Households -- (Estimate) |
| ... |  |  |  |  |

## 5_StarbucksNeighborhoodIncome

| PLACEKEY | LOCATION_NAME | CITY | POI_CBG | MEDIAN_HH_INCOME | HH_INCOME_LT_60K | HH_INCOME_60K_TO_100K | HH_INCOME_GTE_100K |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 060374301021 | 57838 | 285 | 115 | 106 |
| zzw-223@5z4-rcm-4gk | Starbucks | Orange | 060590762023 | 97308 | 197 | 142 | 337 |

## 6_StarbucksVisitorHomeIncome

| PLACEKEY | LOCATION_NAME | CITY | VISITOR_HOME_CBG | VISITOR_COUNT | HH_MEDIAN_INCOME |
| --- | --- | --- | --- | --- | --- |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 060371066452 | 4 | 114205 |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 060371212101 | 4 | 45109 |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 060371243002 | 4 | 51133 |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 060371278063 | 4 | 44071 |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 060371398021 | 4 | 139500 |
| ... |  |  |  |  |  |

## 7_StarbucksWeightedAverageVisitorIncome

| PLACEKEY | LOCATION_NAME | CITY | WEIGHTED_VISITOR_MEDIAN_INCOME |
| --- | --- | --- | --- |
| zzw-223@5z4-rcm-4gk | Starbucks | Orange | 96152.1875 |
| 222-224@5z5-3t2-3wk | Starbucks | Duarte | 78993.694087404 |
