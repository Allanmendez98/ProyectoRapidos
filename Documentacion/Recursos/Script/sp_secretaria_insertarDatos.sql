USE PYCSLosrapidos;

GO

-- sp_secretaria_insertarDatos

/*
--*/

/*
DROP PROCEDURE IF EXISTS sp_persona_insertarDatos;
DROP PROCEDURE IF EXISTS sp_usuario_insertarDatos;
DROP PROCEDURE IF EXISTS sp_secretaria_insertarDatos;
--*/

/*
------------------------------------------------ PERSONA
CREATE PROCEDURE sp_persona_insertarDatos
	@cedula VARCHAR (10),
	@nombre_1 VARCHAR (20),
	@nombre_2 VARCHAR (20),
	@apellido_1 VARCHAR (20),
	@apellido_2 VARCHAR (20),
	@sexo VARCHAR(20),
	@fecha_nac DATETIME,
	@telefono VARCHAR (10)
	WITH ENCRYPTION
AS
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM PERSONA WHERE CEDULA = @cedula) BEGIN
			INSERT INTO PERSONA (CEDULA, NOMBRE_1, NOMBRE_2, APELLIDO_1, APELLIDO_2, SEXO, FECHA_NAC, TELEFONO)
			VALUES				(@cedula, @nombre_1, @nombre_2, @apellido_1, @apellido_2, @sexo, @fecha_nac, @telefono)
			-- obtener id_persona
			DECLARE @id_persona INT
			SELECT @id_persona = ID_PERSONA FROM PERSONA WHERE CEDULA = @cedula
			RETURN	@id_persona
		END; ELSE BEGIN
			SET @id_persona = -1
			RETURN	@id_persona
		END;
	END;
GO
------------------------------------------------ USUARIO
CREATE PROCEDURE sp_usuario_insertarDatos
	-- Datos_usuario
	@id_persona INT,
	@nombre_usuario varchar(20),
	@correo varchar(75),
	@contrasenia varchar(20)
	WITH ENCRYPTION
AS
	BEGIN
		IF (@id_persona != -1) BEGIN
			INSERT INTO USUARIO (NOMBRE_USUARIO, CORREO, CONTRASENIA)
			VALUES				(@nombre_usuario, @correo, @contrasenia)
			-- obtener id_usuario
			DECLARE @id_usuario INT
			SELECT @id_usuario = ID_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO = @nombre_usuario
			RETURN	@id_usuario	
		END; ELSE BEGIN
			SET @id_usuario = -1
			RETURN	@id_usuario
		END;
	END;
GO
------------------------------------------------ SECREATARIA
CREATE PROCEDURE sp_secretaria_insertarDatos
	-- Datos_persona
	@cedula VARCHAR (10),
	@nombre_1 VARCHAR (20),
	@nombre_2 VARCHAR (20),
	@apellido_1 VARCHAR (20),
	@apellido_2 VARCHAR (20),
	@sexo VARCHAR(20),
	@fecha_nac DATETIME,
	@telefono VARCHAR (10),
	-- Datos_usuario
	@nombre_usuario VARCHAR (20),
	@correo VARCHAR (75),
	@contrasenia VARCHAR (20),
	-- Datos_secretaria
	@fecha_contrato DATE
	WITH ENCRYPTION
AS 
	BEGIN
		IF NOT EXISTS (SELECT 1 FROM USUARIO WHERE NOMBRE_USUARIO = @nombre_usuario) BEGIN
			IF NOT EXISTS (SELECT 1 FROM USUARIO WHERE CORREO =	@correo) BEGIN
				DECLARE @id_persona INT
				DECLARE @id_usuario INT
				EXEC @id_persona = sp_persona_insertarDatos @cedula, @nombre_1, @nombre_2, @apellido_1, @apellido_2, @sexo, @fecha_nac, @telefono
				EXEC @id_usuario = sp_usuario_insertarDatos @id_persona, @nombre_usuario, @correo, @contrasenia
				IF (@id_persona != -1 AND @id_usuario != -1) BEGIN
					INSERT INTO SECRETARIA (ID_PERSONA, ID_USUARIO, FECHA_CONTRATO)
					VALUES					(@id_persona, @id_usuario, @fecha_contrato)
					-- obtener id_usuario
					DECLARE @id_secretaria INT
					SELECT @id_secretaria = ID_SECRETARIA FROM SECRETARIA WHERE ID_PERSONA = @id_persona AND ID_USUARIO = @id_usuario
					RETURN	@id_secretaria
				END; ELSE BEGIN
					SET @id_secretaria = -1
					RETURN	@id_secretaria
				END;
			END; ELSE BEGIN
				SET @id_secretaria = -1
				RETURN	@id_secretaria
			END;
		END; ELSE BEGIN
			SET @id_secretaria = -1
			RETURN	@id_secretaria
		END;
	END;
GO
--*/

/**/
EXEC sp_secretaria_insertarDatos
	-- Datos_persona
	@cedula			= '4444444444',
	@nombre_1		= 'Pepito4',
	@nombre_2		= 'Pepito4',
	@apellido_1		= 'Pepito4',
	@apellido_2		= 'Pepito4',
	@sexo			= 'Masculino',
	@fecha_nac		= '04/03/2003',
	@telefono		= '4444444444',
	-- Datos_usuario
	@nombre_usuario	= 'Pepito400',
	@correo			= 'pepito4@hotmail.com',
	@contrasenia	= 'pepito4',
	-- Datos_secretaria
	@fecha_contrato	= '04/04/2024';
--*/