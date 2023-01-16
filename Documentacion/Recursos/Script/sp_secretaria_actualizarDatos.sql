USE PYCSLosrapidos;

GO

-- sp_secretaria_actualizarDatos

/*
--*/

/*
DROP PROCEDURE IF EXISTS sp_persona_actualizarDatos;
DROP PROCEDURE IF EXISTS sp_usuario_actualizarDatos;
DROP PROCEDURE IF EXISTS sp_secretaria_actualizarDatos;
--*/

/*
------------------------------------------------ PERSONA
CREATE PROCEDURE sp_persona_actualizarDatos
	@cedula		VARCHAR (10),
	@nombre_1	VARCHAR (20),
	@nombre_2	VARCHAR (20),
	@apellido_1 VARCHAR (20),
	@apellido_2	VARCHAR (20),
	@sexo		VARCHAR (20),
	@fecha_nac	DATE,
	@telefono	VARCHAR (10)
	WITH ENCRYPTION
AS
	BEGIN
		IF EXISTS (SELECT 1 FROM PERSONA WHERE CEDULA = @cedula) BEGIN
			UPDATE PERSONA SET
				NOMBRE_1	= @nombre_1, 
				NOMBRE_2	= @nombre_2, 
				APELLIDO_1	= @apellido_1, 
				APELLIDO_2	= @apellido_2, 
				SEXO		= @sexo, 
				FECHA_NAC	= @fecha_nac, 
				TELEFONO	= @telefono
			WHERE CEDULA = @cedula
			-- obtener id_persona
			DECLARE @id_persona INT
			SELECT @id_persona = ID_PERSONA FROM PERSONA WHERE CEDULA = @cedula
			-- cedula existe
			RETURN	@id_persona
		END; ELSE BEGIN
			SET @id_persona = -1
			-- cedula no existe
			RETURN	@id_persona
		END;
	END;
GO
------------------------------------------------ USUARIO
CREATE PROCEDURE sp_usuario_actualizarDatos
	-- Datos_usuario
	@id_persona		INT,
	@nombre_usuario	VARCHAR (20),
	@correo			VARCHAR (75),
	@contrasenia	VARCHAR (20)
	WITH ENCRYPTION
AS
	BEGIN
		IF (@id_persona != -1) BEGIN
			UPDATE USUARIO SET
				CORREO		= @correo, 
				CONTRASENIA	= @contrasenia
			WHERE NOMBRE_USUARIO = @nombre_usuario
			-- obtener id_usuario
			DECLARE @id_usuario INT
			SELECT @id_usuario = ID_USUARIO FROM USUARIO WHERE NOMBRE_USUARIO = @nombre_usuario
			-- 
			RETURN	@id_usuario	
		END; ELSE BEGIN
			SET @id_usuario = -1
			RETURN	@id_usuario
		END;
	END;
GO
------------------------------------------------ SECREATARIA
CREATE PROCEDURE sp_secretaria_actualizarDatos
	-- Datos_persona
	@cedula			VARCHAR (10),
	@nombre_1		VARCHAR (20),
	@nombre_2		VARCHAR (20),
	@apellido_1		VARCHAR (20),
	@apellido_2		VARCHAR (20),
	@sexo			VARCHAR (20),
	@fecha_nac		DATE,
	@telefono		VARCHAR (10),
	-- Datos_usuario
	@nombre_usuario	VARCHAR (20),
	@correo			VARCHAR (75),
	@contrasenia	VARCHAR (20),
	-- Datos_secretaria
	@fecha_contrato	DATE
	WITH ENCRYPTION
AS 
	BEGIN
		IF EXISTS (SELECT 1 FROM USUARIO WHERE NOMBRE_USUARIO = @nombre_usuario) BEGIN
			IF EXISTS (SELECT 1 FROM USUARIO WHERE CORREO =	@correo) BEGIN
				DECLARE @id_persona INT
				DECLARE @id_usuario INT
				EXEC @id_persona = sp_persona_actualizarDatos @cedula, @nombre_1, @nombre_2, @apellido_1, @apellido_2, @sexo, @fecha_nac, @telefono
				EXEC @id_usuario = sp_usuario_actualizarDatos @id_persona, @nombre_usuario, @correo, @contrasenia
				IF (@id_persona != -1 AND @id_usuario != -1) BEGIN
					UPDATE SECRETARIA SET 
						FECHA_CONTRATO	= @fecha_contrato
					WHERE	ID_PERSONA	= @id_persona
					AND		ID_USUARIO	= @id_usuario
					-- obtener id_usuario
					DECLARE @id_secretaria INT
					SELECT @id_secretaria = ID_SECRETARIA FROM SECRETARIA WHERE ID_PERSONA = @id_persona AND ID_USUARIO = @id_usuario
					RETURN	@id_secretaria
				END; ELSE BEGIN
					-- no existe id_persona 0 id_usuario
					SET @id_secretaria = -1
					RETURN	@id_secretaria
				END;
			END; ELSE BEGIN
				-- no existe correo
				SET @id_secretaria = -2
				RETURN	@id_secretaria
			END;
		END; ELSE BEGIN
			-- no existe nombre_usuario
			SET @id_secretaria = -3
			RETURN	@id_secretaria
		END;
		PRINT @id_secretaria
	END;
GO
--*/

/**/
EXEC sp_secretaria_actualizarDatos
	-- Datos_persona
	@cedula			= '4444444444', ----------- NO SE CAMBIA
	@nombre_1		= 'Pepito5',
	@nombre_2		= 'Pepito5',
	@apellido_1		= 'Pepito5',
	@apellido_2		= 'Pepito5',
	@sexo			= 'Femenino',
	@fecha_nac		= '05/05/2005',
	@telefono		= '5555555555',
	-- Datos_usuario
	@nombre_usuario	= 'Pepito400', ------------ NO SE CAMBIA
	@correo			= 'pepito4@hotmail.com', -- NO SE CAMBIA
	@contrasenia	= 'pepito5',
	-- Datos_secretaria
	@fecha_contrato	= '05/05/2025';
--*/

