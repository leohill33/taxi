#用热力图显示4月22日周五晚6点，7点，8点的空驶率（用中心坐标显示）


#建表
create table tERpos
(hour STRING, longt FLOAT, lat FLOAT, eptR FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#计算
insert overwrite table tERpos 
select 
hour,
longt, 
lat, 
eptR
from tER
where (date='22' and hour='6' or hour='7' or hour='8')
group by hour, longt, lat, eptr
;
