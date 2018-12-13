#建表
create table tpos
(name STRING, date STRING, time STRING, longt FLOAT, lat FLOAT, status INT, dist FLOAT, load INT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#：
insert overwrite table tpos 
select name, substr(time,9,2), substr(time,12,2), jd, wd, status, 0, 9
from tpos;

order by rand() 
limit 700;

#异常值：
insert overwrite table tpos  
select * 
from tpos 
where 
(longt < 117.23 and longt > 109.5) and 
(lat < 25.6 and lat > 20.23)
;
