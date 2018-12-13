#用热力图显示4月22日周五晚6点，7点，8点的空驶率（用中心坐标显示）


#建表
create table tERdt
(date STRING, hour STRING, longt FLOAT, lat FLOAT, eptR FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#计算
insert overwrite table tERdt 
select 
date, 
time, 
avg(longt), 
avg(lat), 
sum(case when status=0 then dist end)/sum(dist)
from tDist
group by date, time
;

#清洗
insert overwrite table tERdt
select 
date, hour, longt, lat, eptR
from tERdt
where 
(date = '18' or date = '19' or date = '20' or date = '21' or date = '22' or 
date = '23' or date = '24' or date = '25' or date = '26' or date = '27' and 
eptR is not null and eptR < 1 and eptR > 0.00)
;
