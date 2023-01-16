USE PYCSLosrapidos;

GO
CREATE PROCEDURE sp_insertar_peticion
	@id_cliente int,
	@id_tipo_ambulancia int,
	@n_ambulancias int,
	@punto_origen varchar(45),
	@punto_destino varchar(45),
	@condicion varchar(15)
AS
INSERT INTO PETICION(
	ID_CLIENTE, ID_TIPO_AMBULANCIA, N_AMBULANCIAS, PUNTO_ORIGEN, 
	PUNTO_DESTINO, CONDICION
	)
	VALUES(
	@id_cliente,
	@id_tipo_ambulancia,
	@n_ambulancias,
	@punto_origen,
	@punto_destino,
	@condicion
	)
GO