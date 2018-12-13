#建表
create table avgv
(name STRING, v FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#计算
insert overwrite table avgv 
select name, avg(v) 
from track 
group by name
;
