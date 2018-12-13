#建表
create table tDBl
(longt FLOAT, lat FLOAT, load INT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#
insert overwrite table tDBl 
select longt, lat, load
from tdist 
where (load = 1 or load = 0)
;

#异常值
insert overwrite table tDBl 
select longt, lat, load
from tDBl
where 
(longt < 117.23 and longt > 109.5) and 
(lat < 25.6 and lat > 20.23)
;

#U
create table tDB0
(longt FLOAT, lat FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

create table tDB1
(longt FLOAT, lat FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#：
insert overwrite table tDB0 
select longt, lat
from tDB0
order by rand() 
limit 10000;


#
insert overwrite table tDB1 
select longt, lat
from tDB1 
order by rand() 
limit 10000;

