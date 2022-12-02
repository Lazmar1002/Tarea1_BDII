-- TAREA #1_U3
-- NOMBRE: INCAIVI BRANDON LAZO MARTINEZ
-- CUENTA: 20191001993.
-- ASIGNATURA - SECCION: BASE DE DATOS II - 0800.
-- DOCENTE: ING. CINDY LOURDES EUCEDA GARCIA.


/*Ejercicio #1:
Construya una consulta de la tabla `bigquery-public-data.usa_names.usa_1910_2013`
agrupe la información por nombre (name) y genero (gender) y muestre una
sumatoria (SUM) del campo numero (number) ordenado de manera descendente.*/

-------------------
--Desarrollo:
-------------------

SELECT name, gender, SUM(number) 
FROM bigquery-public-data.usa_names.usa_1910_2013 
GROUP BY name, gender 
ORDER BY SUM(number) DESC

------------------------------------------------------------------------------------------------------------------


/*Ejercicio #2
Construya un consulta a partir de la tabla `bigquery-publicdata.covid19_covidtracking.summary` 
donde utilizando funciones analiticas muestrela suma total de los test realizados (campo: tests_total)
por estado (State), los campos que se deben mostrarse en la consulta son: date,state, tests_total,
cases_positives_total y suma total (campo a calcular).*/


-------------------
--Desarrollo:
-------------------

SELECT 

    date, 
	state,
	tests_total, 
    cases_positive_total, 

    SUM(tests_total) OVER (PARTITION BY state) as total_tests_per_state 

FROM bigquery-public-data.covid19_covidtracking.summary 


--------------------------------------------------------------------------------------------------------------------


/*Ejercicio #3
Elabore una consulta de la tabla `bigquery-publicdata.google_analytics_sample.ga_sessions_20170801` 
donde se visualice el porcentaje de páginas vistas (pageviews/sum(pageviews)) en relación al total para el
channelGrouping por fechas y el promedio de páginas vistas (pageviews), utilice funciones analíticas.*/


-------------------
--Desarrollo:
-------------------

SELECT  

  date, 
  channelGrouping, 

  AVG(total_page) as prom_page, 
  SUM(total_page) / SUM(SUM(total_page)) OVER () as page_porcentaje 

FROM ( 

    SELECT 
    date, 
    channelGrouping, 
    SUM(totals.pageviews) as total_page 

    FROM bigquery-public-data.google_analytics_sample.ga_sessions_20170801 
    GROUP BY date, channelGrouping 
     
	  )

   GROUP BY date, channelGrouping


---------------------------------------------------------------------------------------------------------------------

/*Ejercicio #4
Cree una tabla nativa a partir del archivo 100 Sales Records.csv proporcionado y
utilizando funciones analíticas realice una clasificación consecutiva del total de
ganancias (total_revenue) por region, ademas nuestre el país.*/


-------------------
--Desarrollo:
-------------------

SELECT 

  Region, 
  Country, 
  Total_Revenue, 

  ROW_NUMBER() OVER (PARTITION BY region ORDER BY total_revenue DESC) AS Rank 
 
  FROM hmw-1-370321.100_sales_records.record_ventas 
  ORDER BY  
  Region, Rank;


