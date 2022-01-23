GO
USE master

GO
-- Nombre para el backup dinamico
CREATE PROC sp_BackupDinamico(@Name NVARCHAR(100))
AS
BEGIN
SET @Name += CONCAT('_', FORMAT(GETDATE(),'yyyyMMdd_hhmmss'))

BACKUP DATABASE AdventureWorks2019
	TO AdventureWorks2019Device_jcperezz2022
		WITH DIFFERENTIAL, NAME = @Name
END

--Ejecucion del Procedimiento
GO
EXEC dbo.sp_BackupDinamico @Name = N'Adventure' -- nvarchar(100)
GO
EXEC dbo.sp_BackupDinamico @Name = N'AWExamenBDII' -- nvarchar(100)
GO
EXEC dbo.sp_BackupDinamico @Name = N'AdventureII' -- nvarchar(100)
GO
EXEC dbo.sp_BackupDinamico @Name = N'AWII' -- nvarchar(100)

GO
-- Mirar todos los backup de AdventureWorks2019Device
RESTORE HEADERONLY FROM AdventureWorks2019Device_jcperezz2022
GO

-- Lista de archivos que contiene el back
RESTORE FILELISTONLY FROM AdventureWorks2019Device_jcperezz2022
GO