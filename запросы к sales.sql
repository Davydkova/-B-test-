1) **Выручка по тарифу gold за 2020**

Есть таблица продаж sales. Посчитайте выручку для тарифа gold по месяцам 2020 года.
Для каждого месяца дополнительно укажите:
выручку за предыдущий месяц (prev);
процент, который составляет выручка текущего месяца от prev (perc).
Процент округлите до целого.

┌──────┬───────┬─────────┬───────┬──────┐
│ year │ month │ revenue │ prev  │ perc │
├──────┼───────┼─────────┼───────┼──────┤
│ 2020 │ 1     │ 14400   │       │      │
│ 2020 │ 2     │ 29040   │ 14400 │ 202  │
│ 2020 │ 3     │ 31200   │ 29040 │ 107  │
│ 2020 │ 4     │ 43200   │ 31200 │ 138  │
│ 2020 │ 5     │ 34560   │ 43200 │ 80   │
│ 2020 │ 6     │ 44880   │ 34560 │ 130  │
│ 2020 │ 7     │ 40320   │ 44880 │ 90   │
│ 2020 │ 8     │ 28800   │ 40320 │ 71   │
│ 2020 │ 9     │ 28800   │ 28800 │ 100  │
│ 2020 │ 10    │ 36000   │ 28800 │ 125  │
│ 2020 │ 11    │ 51840   │ 36000 │ 144  │
│ 2020 │ 12    │ 28800   │ 51840 │ 56   │
└──────┴───────┴─────────┴───────┴──────┘

SELECT year, 
       month, 
       SUM(revenue) OVER (partition by month) AS revenue, 
       LAG(revenue) OVER () AS  prev,
       ROUND(revenue*100.0/lag(revenue) over w) AS perc
FROM sales
WHERE year = 2020 AND plan ='gold'
WINDOW w AS (
 partition BY year)
 
 
2) **Выручка по тарифам за 1 квартал 2020**
 Есть таблица продаж sales. Посчитайте выручку нарастающим итогом по каждому тарифному плану за первые три месяца 2020 года.Сортировка результата: plan, month
 
  plan   │ year │ month │ revenue │ total  │
├──────────┼──────┼───────┼─────────┼────────┤
│ gold     │ 2020 │ 1     │ 14400   │ 14400  │
│ gold     │ 2020 │ 2     │ 29040   │ 43440  │
│ gold     │ 2020 │ 3     │ 31200   │ 74640  │
│ platinum │ 2020 │ 1     │ 7200    │ 7200   │
│ platinum │ 2020 │ 2     │ 13200   │ 20400  │
│ platinum │ 2020 │ 3     │ 16800   │ 37200  │
│ silver   │ 2020 │ 1     │ 27000   │ 27000  │
│ silver   │ 2020 │ 2     │ 61200   │ 88200  │
│ silver   │ 2020 │ 3     │ 42000   │ 130200 │
└──────────┴──────┴───────┴─────────┴─────
 
SELECT plan,
       year, 
       month,
       revenue,
       SUM(revenue) OVER (partition by plan ORDER BY month) AS total
FROM sales
WHERR 1=1 AND 
year= 2020 AND
month IN (1,2,3)


3) **Скользящее среднее по тарифу platinum за 2020**

Есть таблица продаж sales. Посчитайте скользящую среднюю выручку за 3 месяца для тарифа platinum в 2020 году.
Округлите среднюю выручку до целого.

──────┬───────┬─────────┬───────┐
│ year │ month │ revenue │ avg3m │
├──────┼───────┼─────────┼───────┤
│ 2020 │ 1     │ 7200    │ 10200 │
│ 2020 │ 2     │ 13200   │ 12400 │
│ 2020 │ 3     │ 16800   │ 18400 │
│ 2020 │ 4     │ 25200   │ 22000 │
│ 2020 │ 5     │ 24000   │ 27200 │
│ 2020 │ 6     │ 32400   │ 28400 │
│ 2020 │ 7     │ 28800   │ 24800 │
│ 2020 │ 8     │ 13200   │ 18600 │
│ 2020 │ 9     │ 13800   │ 15000 │
│ 2020 │ 10    │ 18000   │ 22600 │
│ 2020 │ 11    │ 36000   │ 25000 │
│ 2020 │ 12    │ 21000   │ 28500 │
└──────┴───────┴─────────┴───────┘

SELECT year,
       month, 
       SUM(revenue) OVER (partition by month) AS revenue, 
       LAG(revenue) OVER () AS prev,
        ROUND(revenue*100.0/lag(revenue) OVER w) AS perc
FROM sales
WHERE year = 2020 AND plan ='gold'
WINDOW w AS (
 partition BY year)

4)  **Сравнение с декабрем**

Есть таблица продаж sales. Посчитайте выручку по месяцам для тарифа silver.

Для каждого месяца дополнительно укажите:
выручку за декабрь этого же года (december);
процент, который составляет выручка текущего месяца от december (perc).
Процент округлите до целого.

┌──────┬───────┬─────────┬──────────┬──────┐
│ year │ month │ revenue │ december │ perc │
├──────┼───────┼─────────┼──────────┼──────┤
│ 2019 │ 1     │ 12000   │ 26400    │ 45   │
│ 2019 │ 2     │ 39600   │ 26400    │ 150  │
│ 2019 │ 3     │ 24000   │ 26400    │ 91   │
│ 2019 │ 4     │ 18000   │ 26400    │ 68   │
│ 2019 │ 5     │ 26400   │ 26400    │ 100  │
│ 2019 │ 6     │ 32400   │ 26400    │ 123  │
│ 2019 │ 7     │ 26400   │ 26400    │ 100  │
│ 2019 │ 8     │ 26400   │ 26400    │ 100  │
│ 2019 │ 9     │ 15000   │ 26400    │ 57   │
│ 2019 │ 10    │ 25200   │ 26400    │ 95   │
│ 2019 │ 11    │ 29700   │ 26400    │ 113  │
│ 2019 │ 12    │ 26400   │ 26400    │ 100  │
│ 2020 │ 1     │ 27000   │ 66000    │ 41   │
│ 2020 │ 2     │ 61200   │ 66000    │ 93   │
│ 2020 │ 3     │ 42000   │ 66000    │ 64   │
│ 2020 │ 4     │ 42000   │ 66000    │ 64   │
│ 2020 │ 5     │ 39000   │ 66000    │ 59   │
│ 2020 │ 6     │ 52800   │ 66000    │ 80   │
│ 2020 │ 7     │ 46800   │ 66000    │ 71   │
│ 2020 │ 8     │ 33000   │ 66000    │ 50   │
│ 2020 │ 9     │ 54000   │ 66000    │ 82   │
│ 2020 │ 10    │ 57000   │ 66000    │ 86   │
│ 2020 │ 11    │ 62700   │ 66000    │ 95   │
│ 2020 │ 12    │ 66000   │ 66000    │ 100  │
└──────┴───────┴─────────┴──────────┴──────┘

WITH a AS (
SELECT year,
       month, 
       revenue AS revenue
FROM sales 
WHERE plan = 'silver'
ORDER BY year),
b AS

(
SELECT year,
       SUM(revenue) OVER (ORDER BY year ROWS BETWEEN current row and current row  ) AS december
FROM sales 
WHERE plan = 'silver' AND month=12
ORDER BY year)

SELECT a.year,
       a.month, 
       a.revenue, 
       b.december, 
       round(a.revenue*100.0/december) AS perc
FROM a JOIN b ON a.year=b.year


5) **Вклад тарифов**

Есть таблица продаж sales. Посчитайте, какой вклад (в процентах) внес каждый из тарифов в общую выручку за год.
Процент округлите до целого.

┌──────┬──────────┬─────────┬─────────┬──────┐
│ year │   plan   │ revenue │  total  │ perc │
├──────┼──────────┼─────────┼─────────┼──────┤
│ 2019 │ gold     │ 252960  │ 722460  │ 35   │
│ 2019 │ platinum │ 168000  │ 722460  │ 23   │
│ 2019 │ silver   │ 301500  │ 722460  │ 42   │
│ 2020 │ gold     │ 411840  │ 1244940 │ 33   │
│ 2020 │ platinum │ 249600  │ 1244940 │ 20   │
│ 2020 │ silver   │ 583500  │ 1244940 │ 47   │
└──────┴──────────┴─────────┴─────────┴──────┘

WITH a AS (
SELECT
  year, plan,
  SUM(revenue) AS revenue
FROM sales
GROUP BY plan, year
ORDER BY year),
 b AS  
(SELECT
       year,
       revenue,
       SUM(revenue) OVER (partition BY year) AS total
FROM a
ORDER BY year)

SELECT a.year,
       a.plan,
       a.revenue, 
       b.total, 
       ROUND(a.revenue*100.0/b.total) AS perc
FROM a 
JOIN b ON a.year=b.year
GROUP BY a.plan, a.year,a.revenue,b.total,perc
ORDER BY a.year, a.plan

6)  **Высокая, средняя и низкая выручка**
Есть таблица продаж sales. Разбейте месяцы 2020 года на три группы по выручке:

tile = 1 — высокая,
tile = 2 — средняя,
tile = 3 — низкая.

──────┬───────┬─────────┬──────┐
│ year │ month │ revenue │ tile │
├──────┼───────┼─────────┼──────┤
│ 2020 │ 11    │ 150540  │ 1    │
│ 2020 │ 6     │ 130080  │ 1    │
│ 2020 │ 7     │ 115920  │ 1    │
│ 2020 │ 12    │ 115800  │ 1    │
│ 2020 │ 10    │ 111000  │ 2    │
│ 2020 │ 4     │ 110400  │ 2    │
│ 2020 │ 2     │ 103440  │ 2    │
│ 2020 │ 5     │ 97560   │ 2    │
│ 2020 │ 9     │ 96600   │ 3    │
│ 2020 │ 3     │ 90000   │ 3    │
│ 2020 │ 8     │ 75000   │ 3    │
│ 2020 │ 1     │ 48600   │ 3    │
└──────┴───────┴─────────┴──────┘

SELECT year, 
       month, 
       SUM(revenue) AS revenue ,
       NTILE(3) OVER (ORDER BY  SUM(revenue) DESC) AS  tile
FROM sales
WHERE year =2020
GROUP BY month, year
ORDER BY revenue DESC


7) **2020 vs 2019**
Есть таблица продаж sales. Посчитайте выручку по кварталам 2020 года.

Для каждого квартала дополнительно укажите:

выручку за аналогичный квартал 2019 года (prev);
процент, который составляет выручка текущего квартала от prev (perc).
Процент округлите до целого.
──────┬─────────┬─────────┬────────┬──────┐
│ year │ quarter │ revenue │  prev  │ perc │
├──────┼─────────┼─────────┼────────┼──────┤
│ 2020 │ 1       │ 242040  │ 155040 │ 156  │
│ 2020 │ 2       │ 338040  │ 162600 │ 208  │
│ 2020 │ 3       │ 287520  │ 204120 │ 141  │
│ 2020 │ 4       │ 377340  │ 200700 │ 188  │
└──────┴─────────┴─────────┴────────┴──────┘

WITH data AS (
  SELECT
    year, quarter,
    SUM(revenue) AS revenue,
    LAG(sum(revenue), 4) over w AS prev,
    ROUND(
      SUM(revenue) * 100.0 / lag(sum(revenue), 4) over ()
    ) AS perc
  FROM sales
  GROUP BY  year, quarter
  window w AS (
    ORDER BY year, quarter
  )
)
SELECT 
  year, quarter, revenue,
  prev, perc
FROM data
WHERE year = 2020
ORDER BY quarter;

8) **Рейтинг месяцев по количеству продаж в 2020**
Есть таблица продаж sales. Составьте рейтинг месяцев 2020 года с точки зрения количества продаж (quantity) по каждому из тарифов. 
Чем больше подписок тарифа P было продано в месяц M, тем выше место M в рейтинге по тарифу P:
┌──────┬───────┬────────┬──────┬──────────┐
│ year │ month │ silver │ gold │ platinum │
├──────┼───────┼────────┼──────┼──────────┤
│ 2020 │ 1     │ 12     │ 12   │ 12       │
│ 2020 │ 2     │ 3      │ 8    │ 10       │
│ 2020 │ 3     │ 8      │ 7    │ 8        │
│ 2020 │ 4     │ 8      │ 3    │ 4        │
│ 2020 │ 5     │ 10     │ 6    │ 5        │
│ 2020 │ 6     │ 6      │ 2    │ 2        │
│ 2020 │ 7     │ 7      │ 4    │ 3        │
│ 2020 │ 8     │ 11     │ 9    │ 10       │
│ 2020 │ 9     │ 5      │ 9    │ 9        │
│ 2020 │ 10    │ 4      │ 5    │ 7        │
│ 2020 │ 11    │ 2      │ 1    │ 1        │
│ 2020 │ 12    │ 1      │ 9    │ 6        │
└──────┴───────┴────────┴──────┴──────────┘

WITH a as (
       SELECT year, month,
       RANK() over ( ORDER BY quantity DESC) as silver
FROM sales 
WHERE plan='silver' AND year=2020
--group by month
ORDER BY month),
 b AS
 (SELECT year, month, 
 RANK() over ( ORDER BY quantity DESC) AS gold
FROM sales 
WHERE plan='gold' AND year=2020
ORDER BY month),

c AS
(SELECT year, 
       month, 
       rank() over ( ORDER BY quantity DESC) AS platinum
FROM sales 
WHERE plan='platinum' AND year=2020
ORDER BY month)

SELECT a.year,
       a.month,
       a.silver, 
       b.gold,
       c.platinum
FROM a JOIN b ON a.month=b.month 
JOIN c ON b.month=c.month
ORDER BY a.month

