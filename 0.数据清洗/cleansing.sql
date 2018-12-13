#建表
create external table track
(name STRING, time STRING, jd DOUBLE, wd DOUBLE, status INT, v DOUBLE, angle INT, dist DOUBLE) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile
LOCATION 'hdfs://localhost:9000/input/track';

#除异常值
insert overwrite table track  
select * 
from track 
where 
(name is not null and name != 'name') and 
(time is not null) and 
(jd < 117.23 and jd > 109.5) and 
(wd < 25.6 and wd > 20.23) and 
(status is not null and (status = 0 or status = 1)) and 
(0 < v and v < 120 and v is not null and v != 0)
;


select name, jd, wd from track
where 
(jd > 117.23 and jd < 109.5) and 
(wd > 25.6 and wd < 20.23)
;

