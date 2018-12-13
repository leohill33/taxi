create table ac24(name STRING, day STRING, time STRING, avgv DOUBLE) 
row format delimited 
fields terminated by ',' 
lines terminated by '\n' 
stored as textfile;

insert overwrite table ac24 select name,substr(time,9,2),substr(time,12,2),avg(v) from t10 where name="粤B41X39" and substr(time,9,2)="19" group by name,substr(time,9,2),substr(time,12,2);

