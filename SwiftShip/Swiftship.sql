create database swiftship;
use swiftship;

create table partner(Pid int(5) primary key,pname varchar(20));
create table shipments(Sid int(5) primary key,Pid int(5),location varchar(15),FOREIGN KEY(Pid) references Partner(Pid));
create table deliveryLog(Did int(5) primary key,Sid int(5),Pid int(5),promised_date date,delivered_date date,status varchar(15),FOREIGN KEY(Pid) references Partner(Pid),FOREIGN KEY(Sid) references Shipments(Sid));

desc partner;
desc shipments;
desc deliveryLog;


select * from shipments s join deliveryLog d on s.sid= d.sid and d.promised_date < d.delivered_date;


select
p.pname,
count(case when d.status = "Sucess" then 0 end) as sucess,
count(case when d.status = "Return" then 0 end) as returned
from partner p join deliverylog d on d.pid = p.pid group by p.pid;


select s.location,count(*) as popular_city from shipments s join deliverylog d on s.sid = d.sid where datediff(curdate(),d.promised_date) <30 group by s.location order by count(*) desc limit 1;


select p.pname,Rank() over(order by count(*))as scores from partner p join deliverylog d on p.pid = d.pid where d.status ="Delay" group by d.pid order by count(*) limit 1;













