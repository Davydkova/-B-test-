Вам нужно создать оператор выбора, который выдаст первые 90 чисел Фибоначчи.

Имя столбца -number

Последовательность Фиббоначчи:

0, 1, 1, 2, 3, 5, 8, 13, ..., 89, 144, 233, 377, ...

Решение: 

WITH Fibonacci (iter, number, nextnumber) 
AS (

   SELECT  1  AS iter,
           0  AS number,
           1  AS nextnumber
   UNION ALL  -- рекурсивное определение последовательности  
   SELECT a.iter + 1 ,
          a.nextnumber,
          a.number + a.nextnumber 
 FROM Fibonacci a
 WHERE a.iter < 46
)

SELECT  b.iter AS iterashion, 
        b.number,
        b.nextnumber
FROM Fibonacci b;


Данный оператор работает до 46 итераций включительно, далее происходит арифметическое переполнение, когда числовые значения превышают диапазон целых чисел.

Необходимо изменить тип данных для столбцов


WITH Fibonacci (iter, number, nextnumber) 
AS (

   SELECT  1  AS iter,
           CAST(0 AS FLOAT)  AS number,
           CAST(1 AS FLOAT) as nextnumber
   UNION ALL  -- рекурсивное определение последовательности  
   SELECT a.iter + 1 ,
          a.nextnumber,
          a.number + a.nextnumber 
 FROM Fibonacci a
 WHERE a.iter < 90
)

SELECT  b.iter AS iterashion, 
        b.number,
        b.nextnumber
FROM Fibonacci b; 


- Реализовано в MS SQL Server 2017
