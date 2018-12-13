建表：
create external table allc24(time STRING, v DOUBLE) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

计算：
insert overwrite table allc24 
select substr(time,12,2), avg(v) 
from track 
where (substr(time,9,2) != 23 and substr(time,9,2) != 24)
group by name, substr(time,9,2), substr(time,12,2)
;
