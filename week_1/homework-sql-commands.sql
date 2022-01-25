--question 3
select count(1) from yellow_taxi_data 
where tpep_pickup_datetime>='2021-01-15'
and tpep_pickup_datetime<'2021-01-16'

--question 4
select max(tip_amount) from yellow_taxi_data 
where tpep_pickup_datetime>='2021-01-01'
and tpep_pickup_datetime<'2021-01-31'

select * from yellow_taxi_data
where tip_amount=1140.44

--or
select tpep_pickup_datetime, tip_amount from yellow_taxi_data
order by tip_amount desc limit 1;

--join the two tables
select 
   tpep_pickup_datetime,
   tpep_dropoff_datetime,
   total_amount,
   CONCAT(lpu."Borough", ' / ', lpu."Zone") as "pickup_loc",
   CONCAT(ldo."Borough", ' / ', ldo."Zone") as "dropoff_loc"
from 
  yellow_taxi_data t,
  taxi_zone lpu,
  taxi_zone ldo
where 
   t."PULocationID" = lpu."LocationID" and
   t."DOLocationID" = ldo."LocationID"
limit 25

--question 5
with tz as
(select 
   tpep_pickup_datetime,
   tpep_dropoff_datetime,
   total_amount,
   CONCAT(lpu."Borough", ' / ', lpu."Zone") as "pickup_loc",
   CONCAT(ldo."Borough", ' / ', ldo."Zone") as "dropoff_loc"
from 
  yellow_taxi_data t,
  taxi_zone lpu,
  taxi_zone ldo
where 
   t."PULocationID" = lpu."LocationID" and
   t."DOLocationID" = ldo."LocationID" and
   t.tpep_pickup_datetime>='2021-01-14'and 
   t.tpep_pickup_datetime<'2021-01-15'
)
select * from tz
where tz.pickup_loc='Manthttan / Central Park'

--question 6
with tz as
(select 
   tpep_pickup_datetime,
   tpep_dropoff_datetime,
   total_amount,
   CONCAT(lpu."Borough", ' / ', lpu."Zone") as "pickup_loc",
   CONCAT(ldo."Borough", ' / ', ldo."Zone") as "dropoff_loc"
from 
  yellow_taxi_data t,
  taxi_zone lpu,
  taxi_zone ldo
where 
   t."PULocationID" = lpu."LocationID" and
   t."DOLocationID" = ldo."LocationID"
) 
select 
  avg(total_amount) as avg_total_amount,
  pickup_loc,
  dropoff_loc
from tz
group by pickup_loc, dropoff_loc
order by avg_total_amount desc
