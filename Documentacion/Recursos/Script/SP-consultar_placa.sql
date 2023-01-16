DROP PROCEDURE IF EXISTS sp_consultar_placa;

CREATE PROCEDURE sp_consultar_placa
	@placa varchar(7)
AS
SELECT * FROM AMBULANCIA WHERE PLACA = @placa AND ID_ESTADO = 1;
GO

EXEC sp_consultar_placa
	@placa = 'AAC123';

--	DBCC CHECKIDENT(AMBULANCIA, RESEED,99)