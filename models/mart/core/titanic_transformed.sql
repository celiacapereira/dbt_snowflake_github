with tita as (
    
    select * from {{ ref('stg_titanic') }}

),
titanic_transformation as(
SELECT passengerid,sex,
  CASE 
    WHEN age is null and sex= 'female' THEN 26
    WHEN age is null and sex= 'male' THEN 29
    ELSE age
  END AS age
FROM tita
)
,
final as (
    select 
    tita.PASSENGERID,
    SURVIVED,
    PCLASS,
    NAME,
    tita.SEX,
    titanic_transformation.AGE,
    SIBSP,
    PARCH,
    FARE,
    EMBARKED
    from tita inner join titanic_transformation on tita.PASSENGERID = titanic_transformation.PASSENGERID
)
select 
    *
from
    final