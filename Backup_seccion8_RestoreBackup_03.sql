GO
USE master

GO
RESTORE HEADERONLY FROM AdventureWorks2019Device_jcperezz2022
GO

--Rutina para restaurar backups
--Ejemplo con el backup diferencial posicion3 - AWExamenBDII
GO
IF OBJECT_ID('TempDB..#RestoreHeaderOnlyData') IS NOT NULL
DROP TABLE #RestoreHeaderOnlyData

--Crear tabla temporal
GO
CREATE TABLE #RestoreHeaderOnlyData
(
    [BackupName] NVARCHAR(128),
    [BackupDescription] NVARCHAR(255),
    [BackupType] TINYINT,
    [ExpirationDate] DATETIME,
    [Compressed] TINYINT,
    [Position] SMALLINT,
    [DeviceType] TINYINT,
    [UserName] NVARCHAR(128),
    [ServerName] NVARCHAR(128),
    [DatabaseName] NVARCHAR(128),
    [DatabaseVersion] INT,
    [DatabaseCreationDate] DATETIME,
    [BackupSize] BIGINT,
    [FirstLSN] DECIMAL(25, 0),
    [LastLSN] DECIMAL(25, 0),
    [CheckpointLSN] DECIMAL(25, 0),
    [DatabaseBackupLSN] DECIMAL(25, 0),
    [BackupStartDate] DATETIME,
    [BackupFinishDate] DATETIME,
    [SortOrder] SMALLINT,
    [CodePage] SMALLINT,
    [UnicodeLocaleId] INT,
    [UnicodeComparisonStyle] INT,
    [CompatibilityLevel] TINYINT,
    [SoftwareVendorId] INT,
    [SoftwareVersionMajor] INT,
    [SoftwareVersionMinor] INT,
    [SoftwareVersionBuild] INT,
    [MachineName] NVARCHAR(128),
    [Flags] INT,
    [BindingID] UNIQUEIDENTIFIER,
    [RecoveryForkID] UNIQUEIDENTIFIER,
    [Collation] NVARCHAR(128),
    [FamilyGUID] UNIQUEIDENTIFIER,
    [HasBulkLoggedData] BIT,
    [IsSnapshot] BIT,
    [IsReadOnly] BIT,
    [IsSingleUser] BIT,
    [HasBackupChecksums] BIT,
    [IsDamaged] BIT,
    [BeginsLogChain] BIT,
    [HasIncompleteMetaData] BIT,
    [IsForceOffline] BIT,
    [IsCopyOnly] BIT,
    [FirstRecoveryForkID] UNIQUEIDENTIFIER,
    [ForkPointLSN] DECIMAL(25, 0),
    [RecoveryModel] NVARCHAR(60),
    [DifferentialBaseLSN] DECIMAL(25, 0),
    [DifferentialBaseGUID] UNIQUEIDENTIFIER,
    [BackupTypeDescription] NVARCHAR(128),
    [BackupSetGUID] UNIQUEIDENTIFIER,
    [CompressedBackupSize] BIGINT,
    [Containment] TINYINT,
    [KeyAlgorithm] NVARCHAR(32),
    [EncryptorThumbprint] VARBINARY(20),
    [EncryptorType] NVARCHAR(32)
);

--Llenar tabla temporal
GO
INSERT INTO	#RestoreHeaderOnlyData
EXEC ('RESTORE HEADERONLY FROM AdventureWorks2019Device_jcperezz2022');

----Restablecemos la bd Inicial con la opcion NO recovery para restaurar en cualquier diferencial
GO
RESTORE DATABASE AdventureWorks2019
FROM AdventureWorks2019Device_jcperezz2022
WITH FILE = 1, NOUNLOAD, REPLACE, STATS = 10, NORECOVERY

----Restablecemos la bd diferencial
GO
DECLARE @file SMALLINT;
SELECT @file = MAX(Position) FROM #RestoreHeaderOnlyData
WHERE BackupName LIKE N'AWExamenBDII%'
PRINT CONCAT('Position Backup',' ', @file);

RESTORE DATABASE AdventureWorks2019
FROM AdventureWorks2019Device_jcperezz2022
WITH FILE = @file, NOUNLOAD, REPLACE, STATS = 10, NORECOVERY