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
       SUM(revenue) OVER (partition by month) as revenue, 
       LAG(revenue) OVER () as prev,
       ROUND(revenue*100.0/lag(revenue) over w) as perc
FROM sales
WHERE year = 2020 AND plan ='gold'
WINDOW w as (
 partition by year)
 
 
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
       SUM(revenue) OVER (partition by plan order by month) as total
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
       SUM(revenue) OVER (partition by month) as revenue, 
       LAG(revenue) OVER () as prev,
        ROUND(revenue*100.0/lag(revenue) OVER w) as perc
FROM sales
WHERE year = 2020 AND plan ='gold'
WINDOW w as (
 partition by year)

4) 
