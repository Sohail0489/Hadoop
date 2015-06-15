 a = load '/user/smoham3/join_test1' using PigStorage(',') AS(key:chararray,a1:FLOAT,a2:FLOAT,a3:FLOAT);
 b = load '/user/smoham3/join_test' using PigStorage(',') AS(val:chararray,b1:FLOAT,b2:FLOAT,b3:FLOAT);
join_1 = join a by key LEFT, b by val;
foreach_join = foreach join_1 generate a::key as key,
(CASE WHEN a::a1 IS NULL THEN 0.0 ELSE 1.0 END) as a1,
(CASE WHEN a::a2 IS NULL THEN 0.0 ELSE 1.0 END) as a2,
(CASE WHEN a::a3 IS NULL THEN 0.0 ELSE 1.0 END) as a3,
(CASE WHEN b::b1 IS NULL THEN 0.0 ELSE 1.0 END) as b1,
(CASE WHEN b::b2 IS NULL THEN 0.0 ELSE 1.0 END) as b2,
(CASE WHEN b::b3 IS NULL THEN 0.0 ELSE 1.0 END) as b3;

group_1 = group foreach_join by $0;
fore = foreach group_1 generate ROUND((SUM(foreach_join.a1)) * 100f) / 100f,
ROUND((SUM(foreach_join.a2)) * 100f) / 100f,
ROUND((SUM(foreach_join.a3)) * 100f) / 100f,
ROUND((SUM(foreach_join.b3)) * 100f) / 100f,
ROUND((SUM(foreach_join.b2)) * 100f) / 100f,
ROUND((SUM(foreach_join.b1)) * 100f) / 100f;





