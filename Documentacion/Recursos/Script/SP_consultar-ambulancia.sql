Drop procedure sp_consultar_ambulancias

CREATE PROCEDURE sp_consultar_ambulancias
	@opcionA int,
	@opcionB int,
	@dato varchar(45),
	@tipo_ambulancia int
AS
	declare @str_select varchar(max) = N'SELECT A.ID_AMBULANCIA as ID, D.NOMBRE_DISPONIBILIDAD as DISPONIBILIDAD, A.PLACA as PLACA, A.MODELO as MODELO,
	T.NOMBRE_TIPO_AMBULANCIA as TIPO_AMBULANCIA, A.CAPACIDAD as CAPACIDAD, A.OBSERVACION as OBSERVACION FROM AMBULANCIA A'
	declare @str_join varchar(max) = N' INNER JOIN DISPONIBILIDAD D ON A.ID_DISPONIBILIDAD = D.ID_DISPONIBILIDAD
							   INNER JOIN TIPO_AMBULANCIA T ON T.ID_TIPO_AMBULANCIA = A.ID_TIPO_AMBULANCIA'
	declare @str_where varchar(max)
	declare @str_and varchar(max)
	declare @str_consulta varchar(max)

BEGIN
	if(@opcionA = 1) 
		BEGIN
			set @str_where = N' WHERE A.ID_ESTADO = 1 AND A.PLACA LIKE UPPER(''%' + @dato + '%'')' 
		END
	else if(@opcionA = 2) 
		BEGIN
			set @str_where = N' WHERE A.ID_ESTADO = 1 AND A.MODELO LIKE ''%'+ @dato +'%''' 
		END

	if(@opcionB = 1)
		BEGIN
			set @str_and = N' AND A.ID_DISPONIBILIDAD = 1' 
		END
	else if(@opcionB = 2)
		BEGIN
			set @str_and = N' AND T.ID_TIPO_AMBULANCIA =  '+ CONVERT(varchar(1), @tipo_ambulancia) 
		END
	else if(@opcionB = 3)
		BEGIN
			set @str_and = N' AND T.ID_TIPO_AMBULANCIA = ' + CONVERT(varchar(1), @tipo_ambulancia) + ' AND A.ID_DISPONIBILIDAD = 1'
		END
	else set @str_and = ''
END

set @str_consulta = CONCAT(@str_select, @str_join, @str_where, @str_and)

PRINT @str_consulta
exec(@str_consulta)
GO	

EXEC sp_consultar_ambulancias
	@opcionA = 1,
	@opcionB = 1,
	@dato = 'A',
	@tipo_ambulancia = 1
GO

SELECT A.ID_AMBULANCIA as ID, D.NOMBRE_DISPONIBILIDAD as DISPONIBILIDAD, A.PLACA as PLACA, 
T.NOMBRE_TIPO_AMBULANCIA as TIPO_AMBULANCIA, A.CAPACIDAD as CAPACIDAD, A.OBSERVACION as OBSERVACION 
FROM AMBULANCIA A 
INNER JOIN DISPONIBILIDAD D ON A.ID_DISPONIBILIDAD = D.ID_DISPONIBILIDAD
INNER JOIN TIPO_AMBULANCIA T ON T.ID_TIPO_AMBULANCIA = A.ID_TIPO_AMBULANCIA 
WHERE A.PLACA LIKE UPPER('%a%') /*AND A.ID_DISPONIBILIDAD = 1*/

/*SELECT A.ID_AMBULANCIA, D.NOMBRE_DISPONIBILIDAD, A.PLACA, T.NOMBRE_TIPO_AMBULANCIA,
A.CAPACIDAD, A.OBSERVACION FROM AMBULANCIAS A 
INNER JOIN DISPONIBILIDAD D ON A.ID_DISPONIBILIDAD = D.ID_DISPONIBILIDAD
INNER JOIN TIPO_AMBULANCIA T ON T.ID_TIPO_AMBULANCIA = A.ID_TIPO_AMBULANCIA
WHERE
PLACA = @placa AND ID_DISPONIBILIDAD = @disponibilidad

USE PYCSLosrapidos;

SELECT A.ID_AMBULANCIA, D.NOMBRE_DISPONIBILIDAD, A.PLACA, T.NOMBRE_TIPO_AMBULANCIA,
A.CAPACIDAD, A.OBSERVACION FROM AMBULANCIA A 
INNER JOIN DISPONIBILIDAD D ON D.ID_DISPONIBILIDAD = A.ID_DISPONIBILIDAD
INNER JOIN TIPO_AMBULANCIA T ON T.ID_TIPO_AMBULANCIA = A.ID_TIPO_AMBULANCIA
WHERE
A.PLACA = 'AAC123' AND A.ID_DISPONIBILIDAD = 1*/

SELECT A.ID_AMBULANCIA FROM AMBULANCIA A