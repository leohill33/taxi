#建表
create table tVLR
(date STRING, hour STRING, mm STRING, cNum INT, v FLOAT, wk INT, avgVh FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#：
insert overwrite table tVLR 
select 
substr(track.time,9,2), 
substr(track.time,12,2), 
substr(track.time,15,2),
cNum.cNum,
track.v,
(case when substr(track.time,9,2) = '23' then 1
      when substr(track.time,9,2) = '24' then 1
      else 0 end),
avgVh.avgV
from track join avgVh 
on ((substr(time,9,2)=avgVh.date) and (substr(time,12,2)=avgVh.hour))
join cNum 
on ((avgVh.date=cNum.date) and (avgVh.hour=cNum.hour) and (substr(time,15,2)=cNum.mm))
where (track.jd > 114.103895 and track.jd < 114.104783 and track.wd > 22.555854 and track.wd < 22.568504)
group by substr(track.time,9,2), substr(track.time,12,2),substr(track.time,15,2),cNum.cNum, v, avgv
;


#Y值均速表
create table avgVh
(date STRING, hour STRING, avgV FLOAT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#计算：
insert overwrite table avgVh
select 
substr(time,9,2), 
substr(time,12,2), 
avg(v)
from track 
where (jd > 114.103895 and jd < 114.104783 and wd > 22.555854 and wd < 22.568504)
group by substr(time,9,2), substr(time,12,2)
;


#每分钟车数量表：
create table cNum
(date STRING, hour STRING, mm STRING, cNum INT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

#计算：
insert overwrite table cNum
select 
substr(time,9,2), 
substr(time,12,2), 
substr(time,15,2), 
count(distinct(name))
from track 
where (jd > 114.103895 and jd < 114.104783 and wd > 22.555854 and wd < 22.568504)
group by substr(time,9,2), substr(time,12,2), substr(time,15,2)
;



#异常值：
insert overwrite table tvlr  
select * 
from tvlr 
where 
v != 0;
