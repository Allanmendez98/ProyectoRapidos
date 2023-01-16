CREATE PROCEDURE sp_buscar_conductores
	@cedula_nombre	VARCHAR (50),
	@disponibilidad	VARCHAR (1)
	WITH ENCRYPTION
AS
	declare @str_select varchar(max) = N'
		SELECT
			C.ID_CONDUCTOR									AS ID, 
			P.CEDULA										AS CEDULA,
			P.NOMBRE_1										AS NOMBRE, 
			CONCAT(P.APELLIDO_1, char(160), P.APELLIDO_2)	AS APELLIDOS,
			D.NOMBRE_DISPONIBILIDAD							AS DISPONIBILIDAD,
			C.FECHA_CONTRATO								AS FECHA_CONTRATO
		FROM CONDUCTOR				AS C
		INNER JOIN PERSONA			AS P ON C.ID_PERSONA		= P.ID_PERSONA
		INNER JOIN DISPONIBILIDAD	AS D ON C.ID_DISPONIBILIDAD	= D.ID_DISPONIBILIDAD
		INNER JOIN ESTADO			AS E ON C.ID_ESTADO			= E.ID_ESTADO'
	declare @str_where varchar(max)
	declare @str_and varchar(max)
	declare @str_consulta varchar(max)

	declare @str_cedula varchar(max)
	declare @str_nombre varchar(max)
	declare @str_disponibilidad varchar(max)

	BEGIN
		set @str_where	= N' WHERE '
		set @str_and	= N' AND '
		set @str_cedula = N' P.CEDULA = '+ @cedula_nombre
		set @str_nombre = N' (
			CONCAT(P.NOMBRE_1, P.NOMBRE_2, P.APELLIDO_1, P.APELLIDO_2)	like ''%'+ @cedula_nombre +'%'' OR 
			CONCAT(P.NOMBRE_1, P.APELLIDO_1, P.APELLIDO_2)				like ''%'+ @cedula_nombre +'%'' OR 
			CONCAT(P.NOMBRE_1, P.APELLIDO_2)							like ''%'+ @cedula_nombre +'%'' OR 
			CONCAT(P.NOMBRE_2, P.APELLIDO_2)							like ''%'+ @cedula_nombre +'%'' )'
		set @str_disponibilidad	= N' C.ID_DISPONIBILIDAD = ' + @disponibilidad
		
		IF (@cedula_nombre IS NOT NULL ) BEGIN 
			IF (ISNUMERIC(@cedula_nombre) = 1) BEGIN
				SET @str_where = CONCAT(@str_where, @str_cedula)
			END ELSE BEGIN
				SET @str_where = CONCAT(@str_where, @str_nombre)
			END
			IF (@disponibilidad IS NOT NULL) BEGIN
				set @str_and = CONCAT(@str_and, @str_disponibilidad)
			END ELSE BEGIN
				set @str_and = N' '
			END
		END ELSE BEGIN
			set @str_and = N' '
			SET @str_where = CONCAT(@str_where, @str_disponibilidad)
		END
		set @str_consulta = CONCAT(@str_select, @str_where, @str_and)
		PRINT @str_consulta
		exec(@str_consulta)
	END
GO