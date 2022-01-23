GO
USE master

GO
--Crea dispositivo de almacenamiento
EXEC sp_addumpdevice 'disk', 'AdventureWorks2019Device_jcperezz2022',   
N'C:\Base_de_Datos2022\BACKUP\AdventureWorks2019Device_jcperezz2022.bak';  
GO

--Ver los dispositivos de backup del servidor
SELECT      *
FROM        sys.backup_devices

GO
--Crear el primer backup
BACKUP DATABASE AdventureWorks2019   
 TO AdventureWorks2019Device_jcperezz2022  
   WITH FORMAT, INIT, NAME = N'AdventureWorks2019 Full Backup';    

--Elimina el dispositivo de Backup Multiple
--GO
--EXEC sys.sp_dropdevice @logicalname = AdventureWorks2019Device_jcperezz2022, -- sysname
--                       @delfile = 'delfile';                                 -- varchar(7)
