#建表
create table tDist
(name STRING, date STRING, time STRING, longt FLOAT, lat FLOAT, status BIGINT, dist FLOAT, load BIGINT) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;




