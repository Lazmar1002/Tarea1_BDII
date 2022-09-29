-- TAREA #2
-- NOMBRE: INCAIVI BRANDON LAZO MARTINEZ
-- CUENTA: 20191001993.
-- ASIGNATURA - SECCION: BASE DE DATOS II - 0800.
-- DOCENTE: ING. CINDY LOURDES EUCEDA GARCIA.

--------------------------------------------------------------------------------------------------------------------------------

--Ejecutar cada ejercicio por separado.

--EJERCICIO #1:

/* Visualizar iniciales de un nombre 
• Crea un bloque PL/SQL con tres variables VARCHAR2: 
o Nombre 
o apellido1 
o apellido2 
• Debes visualizar las iniciales separadas por puntos. 
• Además siempre en mayúscula 
• Por ejemplo alberto pérez García debería aparecer--> A.P.G */

--DESARROLLO:
SET SERVEROUTPUT ON;

declare
Nombre       VARCHAR2(30);
Apellido1    VARCHAR2(30);
Apellido2    VARCHAR2(30);
Iniciales    VARCHAR(10);
begin 
Nombre    := 'incaivi';
Apellido1 := 'lazo';
Apellido2 := 'martinez';


Iniciales := SUBSTR(Nombre,1,1)||'.'|| SUBSTR(Apellido1,1,1)||'.'||SUBSTR(Apellido2,1,1);

dbms_output.put_line(UPPER(Iniciales));

end;

------------------------------------------------------------------------------------------------------------------
-- Ejercicio #2:

/*Debemos hacer un bloque PL/SQL anónimo, donde declaramos una variable 
NUMBER la variable puede tomar cualquier valor. Se debe evaluar el valor y 
determinar si es PAR o IMPAR
• Como pista, recuerda que hay una función en SQL denominada MOD, que 
permite averiguar el resto de una división. Por ejemplo MOD(10,4) nos 
devuelve el resto de dividir 10 por 4. */

--DESARROLLO:

set serveroutput on;

declare
Valor        NUMBER;
Resultado    NUMBER;
begin

Valor := 50;
Resultado := MOD(Valor,2);

if Resultado = 0 then
dbms_output.put_line('PAR');

else
dbms_output.put_line('IMPAR');

end if;

end;

----------------------------------------------------------------------------------------------------------------
--EJERCICIO #3:

/*Crear un bloque PL/SQL que devuelva al salario máximo del departamento 100 y lo 
deje en una variable denominada salario_maximo y la visualice*/

--DESARROLLO:

set serveroutput on;

declare
SALARIO_MAXIMO EMPLOYEES.SALARY%TYPE;
begin

Select Max(SALARY) Into SALARIO_MAXIMO from EMPLOYEES
Where Department_ID = 100;

dbms_output.put_line('El salario máximo del departamento es:'||salario_maximo);
end;

---------------------------------------------------------------------------------------------------------------------
--EJERCICIO #4:

/*Crear una variable de tipo DEPARTMENT_ID y ponerla algún valor, por ejemplo 10. 
Visualizar el nombre de ese departamento y el número de empleados que tiene. 
Crear dos variables para albergar los valores.*/

--DESARROLLO: 

set serveroutput on;

declare
COD_DEPARTAMENTO DEPARTMENTS.DEPARTMENT_ID%TYPE := 10;
NOM_DEPARTAMENTO DEPARTMENTS.DEPARTMENT_NAME%TYPE;
NUM_EMPLE NUMBER;

begin
-- nombre del departamento

select DEPARTMENT_NAME Into NOM_DEPARTAMENTO from DEPARTMENTS 
where DEPARTMENT_ID = COD_DEPARTAMENTO;

-- numero de empleados del departamento

select COUNT(*) into NUM_EMPLE from EMPLOYEES
where DEPARTMENT_ID = COD_DEPARTAMENTO;

dbms_output.put_line('EL Departamento '||NOM_DEPARTAMENTO ||' TIENE '||NUM_EMPLE ||' EMPLEADOS');

end;
--------------------------------------------------------------------------------------------------------------------

--EJERCICIO #5:

/*Mediante dos consultas recuperar el salario máximo y el salario mínimo de la 
empresa e indicar su diferencia*/

--DESARROLLO: 

set serveroutput on;

declare
Maximo       NUMBER;
Minimo       NUMBER;
Diferencia   NUMBER;

begin
Select Max(SALARY), Min(SALARY) into Maximo, Minimo from EMPLOYEES;

dbms_output.put_line('El Salario Maximo es:'||Maximo);
dbms_output.put_line('El Salario Minimo es:'||Minimo);

Diferencia := Maximo - Minimo;

dbms_output.put_line('La diferencia es:'||Diferencia);

end;