-- TAREA #3
-- NOMBRE: INCAIVI BRANDON LAZO MARTINEZ
-- CUENTA: 20191001993.
-- ASIGNATURA - SECCION: BASE DE DATOS II - 0800.
-- DOCENTE: ING. CINDY LOURDES EUCEDA GARCIA.

--------------------------------------------------------------------------------------------------------------------------------
--1. Bloques Anónimos
--------------------------------------------------------------------------------------------------------------------------------

/*a. Construir un bloque anonimo donde se declare un cursor y que imprima el 
nombre y sueldo de los empleados (utilice la tabla employees). Si durante el 
recorrido aparece el nombre Peter Tucker (el jefe) se debe genera un 
RAISE_APPLICATION_ERROR indicando que no se puede ver el sueldo del jefe.*/
--Desarrollo:
SET SERVEROUTPUT ON;
DECLARE

CURSOR C1
IS SELECT first_name,last_name,salary from EMPLOYEES;

BEGIN

for i IN C1
LOOP
IF i.first_name='Peter' AND i.last_name='Tucker'
THEN
raise_application_error(-20300,'El salario del jefe no puede ser visto');
ELSE
DBMS_OUTPUT.PUT_LINE(i.first_name ||' ' || i.last_name || ': '|| i.salary ||'DLS');
END IF;
END LOOP;

END;

/*b. Crear un cursor con parámetros para el parametro id de departamento e 
imprima el numero de empleados de ese departamento (utilice la claúsula count).*/
--Desarrollo:

SET SERVEROUTPUT ON

DECLARE

CODIGO DEPARTMENTS.DEPARTMENT_ID%TYPE;
CURSOR C1(COD DEPARTMENTS.DEPARTMENT_ID%TYPE ) IS
SELECT COUNT (*) FROM employees
WHERE DEPARTMENT_ID=COD;
NUM_EMPLE NUMBER;

BEGIN
CODIGO:=20;
OPEN C1(CODIGO);
FETCH C1 INTO NUM_EMPLE;
DBMS_OUTPUT.PUT_LINE('numero de empleados de ' ||codigo||' es
'||num_emple);

end;

/*c. Crear un bloque que tenga un cursor de la tabla employees.
i. Por cada fila recuperada, si el salario es mayor de 8000 
incrementamos el salario un 2%
ii. Si es menor de 8000 incrementamos en un 3%*/
--Desarrollo:

SET SERVEROUTPUT ON

DECLARE
CURSOR C1 IS SELECT * FROM EMployees for update;

begin

for EMPLEADO IN C1 LOOP
IF EMPLEADO.SALARY > 8000 THEN
UPDATE EMPLOYEES SET SALARY = SALARY*1.02
WHERE CURRENT OF C1;
ELSE
UPDATE EMPLOYEES SET SALARY = SALARY*1.03
WHERE CURRENT OF C1;
END IF;
END LOOP;
COMMIT;

END ;

--------------------------------------------------------------------------------------------------------------------------------
-- 2. Funciones
--------------------------------------------------------------------------------------------------------------------------------

/* a. Crear una función llamada CREAR_REGION 
 
• A la función se le debe pasar como parámetro un nombre de región y debe devolver un número, que es el código de región que calculamos 
dentro de la función.
• Se debe crear una nueva fila con el nombre de esa REGION 
• El código de la región se debe calcular de forma automática. Para ello se debe averiguar cual es el código de región más alto que tenemos 
en la tabla en ese momento, le sumamos 1 y el resultado lo ponemos como el código para la nueva región que estamos creando 
• Debemos controlar los errores en caso que se genere un problema 
• La función debe devolver el número/ código que ha asignado a la región.
• En el script debe colocar la funcion y el bloque para llamar la función. */


--DESARROLLO:

create or replace FUNCTION CREAR_REGION (nombre varchar2)
RETURN NUMBER IS
regiones NUMBER;
NOM_REGION VARCHAR2(100);

BEGIN
--AVERIGUANDO SI EXISTE LA REGIÓN. 

SELECT REGION_NAME INTO NOM_REGION FROM REGIONS
WHERE REGION_NAME=UPPER(NOMBRE);
raise_application_error(-20321,'Esta región ya existe');

EXCEPTION
-- SI LA REGION NO EXISTE SE INSERTA.

WHEN NO_DATA_FOUND THEN
SELECT MAX(REGION_ID)+1 INTO REGIONES from REGIONS;
INSERT INTO REGIONS (region_id,region_name) VALUES
(regiones,upper(nombre));
RETURN REGIONES;

END;

--PROBANDO LA FUNCIÓN

DECLARE
N_REGION NUMBER;
BEGIN
N_REGION:=crear_region('TEGUCIGALPA');
DBMS_OUTPUT.PUT_LINE('EL NUMERO ASIGNADO ES:'||N_REGION);
END;

--------------------------------------------------------------------------------------------------------------------------------
--3. Procedimientos
--------------------------------------------------------------------------------------------------------------------------------

/*a. Construya un procedimiento almacenado que haga las operaciones de una 
calculadora, por lo que debe recibir tres parametros de entrada, uno que 
contenga la operación a realizar (SUMA, RESTA, MULTIPLICACION, 
DIVISION), num1, num2 y declare un parametro de retorno e imprima el 
resultado de la operación. Maneje posibles excepciones.*/
SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE calculadora (
num1 NUMBER,
num2 NUMBER,
operacion char)

IS
suma NUMBER(6);
resta NUMBER(6);
multiplicacion NUMBER(6);
division NUMBER (6);

BEGIN
suma := num1 + num2;
DBMS_OUTPUT.PUT_LINE('Suma: '|| suma);

resta:= num1 - num2;
DBMS_OUTPUT.PUT_LINE('resta: '|| resta);

multiplicacion:= num1 * num2;
DBMS_OUTPUT.PUT_LINE('multiplicacion: '|| multiplicacion);

division:= num1 - num2;
DBMS_OUTPUT.PUT_LINE('division: '|| division);

END calculadora;



--b. Realice una copia de la tabla employee, utilice el siguiente script:
CREATE TABLE 
EMPLOYEES_COPIA 
(EMPLOYEE_ID NUMBER (6,0) PRIMARY KEY, 
FIRST_NAME VARCHAR2(20 BYTE), 
LAST_NAME VARCHAR2(25 BYTE), 
EMAIL VARCHAR2(25 BYTE), 
PHONE_NUMBER VARCHAR2(20 BYTE), 
HIRE_DATE DATE, 
JOB_ID VARCHAR2(10 BYTE), 
SALARY NUMBER(8,2), 
COMMISSION_PCT NUMBER(2,2), 
MANAGER_ID NUMBER(6,0), 
DEPARTMENT_ID NUMBER(4,0)
 );
 
/*Rellene la tabla employees_copia utilizando un procedimiento almacenado, 
el cual no recibirá parametros unicamente ejecutara los inserts en la nueva 
tabla, imprima el codigo de error en caso de que ocurra y muestre un 
mensaje por pantalla que diga “Carga Finalizada”.*/

USE EMPLOYEES_COPIA

CREATE PROCEDURE EMPLOYEES_C
 
@fIRST_NAME VARCHAR2(20 BYTE), 
@lAST_NAME VARCHAR2(25 BYTE), 
@eMAIL VARCHAR2(25 BYTE), 
@pHONE_NUMBER VARCHAR2(20 BYTE), 
@hIRE_DATE DATE, 
@jOB_ID VARCHAR2(10 BYTE), 
@sALARY NUMBER(8,2), 
@cOMMISSION_PCT NUMBER(2,2), 
@mANAGER_ID NUMBER(6,0), 
@dEPARTMENT_ID NUMBER(4,0)

as 
begin

  insert into EMPLOYEES_COPIA (FIRST_NAME,LAST_NAME,EMAIL,
  PHONE_NUMBER,HIRE_DATE,JOB_ID,SALARY,COMISSION_PCT,MANAGER_ID,DEPARTMENT_ID)
  
  VALUES (@fIRST_NAME,@lAST_NAME,@eMAIL,
  @pHONE_NUMBER,@hIRE_DATE,@jOB_ID,@sALARY,@cOMISSION_PCT,@mANAGER_ID,@dEPARTMENT_ID);
  
end

SELECT*FROM EMPLOYEES_COPIA

EXEC EMPLOYEES_C 'INCAIVI','LAZO','BLIM@GMAIL.COM','12345', 01/10/2022 , '1234','20000',7.1,123.5,1234.0 

--------------------------------------------------------------------------------------------------------------------------------
--4. Triggers
--------------------------------------------------------------------------------------------------------------------------------

/*a. Crear un TRIGGER BEFORE INSERTen la tabla DEPARTMENTS que al insertar 
un departamento compruebe que el código no esté repetido y luego que si 
el LOCATION_ID es NULL actualicé el campo con el valor 1700 y si el 
MANAGER_ID es NULL l actualicé el campo con el valor 200.*/

create or replace Trigger departments_before_insert

before insert on departments
for each row

Begin

if: new.department_id is not null then
   if:new.location_id is NULL then
     :new.location_id := 1700;

       end if;
   
    if:new.manager_id is null then
      :new.manager_id := 200;
       end if;
  
  if :new.department_name is not null then
    
      if:new.department_name like '%' || :new.department_name || '%' then 
       RAISE_APLICATION_ERROR(-20005, 'El departamento ya existe');
        end if;
   
  end if;
   
  end if;
    
end;


--b. Crear una tabla denominada AUDITORIA con las siguientes columnas: 
CREATE TABLE AUDITORIA (
USUARIO VARCHAR(50),
FECHA DATE,
SALARIO_ANTIGUO NUMBER,
SALARIO_NUEVO NUMBER);


/*Crear un TRIGGER BEFORE INSERT de tipo STATEMENT,de forma que cada vez que 
se haga un INSERT en la tabla REGIONS guarde una fila en la tabla AUDITORIA con 
el usuario y la fecha en la que se ha hecho el INSERT (los campos 
SALARIO_ANTIGUO, SALARIO_NUEVO tendran un valor de 0 )*/

CREATE TRIGGER T2 BEFORE INSERT ON REGIONS

BEGIN


INSERT INTO AUDITORIA (usuario, fecha,salario_antiguo,salario_nuevo) VALUES (user,sysdate,0,0);
END;

INSERT INTO REGIONS VALUES (20,'Prueba');
SELECT USER FROM DUAL;
select * from auditoria;

/*c. Crear un trigger BEFORE UPDATE de la columna SALARY de la tabla 
EMPLOYEES de tipo EACH ROW. 
• Si el valor de modificación es menor que el valor actual el TRIGGER 
debe disparar un RAISE_APPLICATION_FAILURE “no se puede modificar
el salario con un valor menor”. 
• Si el salario es mayor debemos insertar un registro en la tabla 
AUDITORIA. (Guardando user, fecha, salario_anterior, salario_nuevo*/

create or replace trigger Auditoria_Update

before update on employees
for each row

begin

 if: new.salary < :old.salary then
 
 RAISE_APLICATION_ERROR(-20006, 'No se puede modificar el salario con un valor menor');
 
 else 
 
  insert into AUDITORIA(USUARIO,FECHA,SALARIO_ANTERIOR,SALARIO_NUEVO)
  values(USER, SYSDATE,:OLD.SALARY,:NEW.SALARY);
  
  
  end if;
  
end;

Update Employees
set salary = 23000 where employee_id = 100;


update Employees
set salary = 25000 where employee_id = 100;















