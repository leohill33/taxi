#用热力图显示4月22日周五晚6点，7点，8点的空驶率（用中心坐标显示）


#建表
create table tER
(name STRING, date STRING, hour STRING, longt FLOAT, lat FLOAT, d0 FLOAT, d FLOAT, eptR FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#计算
insert overwrite table tER 
select 
name, 
date, 
time, 
avg(longt), 
avg(lat), 
sum(case when status=0 then dist end),
sum(dist),
sum(case when status=0 then dist end)/sum(dist)
from tDist
group by name, date, time
;

#清洗
insert overwrite table tER 
select 
name, date, hour, longt, lat, d0, d, eptR
from tER
where (eptR is not null and eptR < 1 and eptR > 0.00)
;
